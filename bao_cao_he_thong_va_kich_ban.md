# BÁO CÁO TRIỂN KHAI HỆ THỐNG & KỊCH BẢN VẤN ĐÁP
## MÔN: QUY TRÌNH VÀ CÔNG CỤ PHÁT TRIỂN PHẦN MỀM (UTT)

---

## 📑 PHẦN I: BÁO CÁO TRIỂN KHAI HỆ THỐNG CHI TIẾT

### 1. Triển khai máy chủ Linux trên máy ảo (VMware / VirtualBox)
* **Hệ điều hành lựa chọn:** Ubuntu Server 24.04 LTS (hoặc 26.04 LTS) – Bản phân phối Linux phổ biến, có tính ổn định cao và tài liệu phong phú.
* **Cấu hình máy ảo khuyến nghị:**
  * **CPU:** 2 vCPUs
  * **RAM:** 2 GB
  * **Ổ cứng:** 20 GB (chế độ Single File để tăng hiệu năng đọc ghi)
  * **Card mạng (Network Adapter):** Bridge (Cầu nối) để máy ảo nhận IP trực tiếp từ router, cùng dải mạng với các máy Client (máy thật của thành viên nhóm) giúp dễ dàng kết nối SSH, FTP, SVN.

#### Cấu hình IP Tĩnh trên Ubuntu Server (Sử dụng Netplan)
Mở file cấu hình mạng:
```bash
sudo nano /etc/netplan/50-cloud-init.yaml
```
Cấu hình nội dung (thay tên card mạng ví dụ `ens33` bằng card mạng thực tế thu được từ lệnh `ip a`):
```yaml
network:
  ethernets:
    ens33:
      dhcp4: no
      addresses:
        - 192.168.1.100/24 # IP tĩnh gán cho Server
      routes:
        - to: default
          via: 192.168.1.1 # Gateway (IP Router)
      nameservers:
        addresses:
          - 8.8.8.8
          - 1.1.1.1
  version: 2
```
Áp dụng cấu hình mạng mới:
```bash
sudo netplan apply
```

---

### 2. Cài đặt và cấu hình các Dịch vụ (Services)

#### a. Dịch vụ SSH (Secure Shell)
SSH được sử dụng để truy cập và quản trị máy chủ Linux từ xa qua giao diện dòng lệnh bảo mật.
* **Cài đặt:** OpenSSH Server thường được tích hợp sẵn khi cài Ubuntu. Nếu chưa có, chạy lệnh:
  ```bash
  sudo apt update
  sudo apt install openssh-server -y
  ```
* **Kích hoạt dịch vụ:**
  ```bash
  sudo systemctl enable ssh
  sudo systemctl start ssh
  sudo systemctl status ssh
  ```
* **Công cụ kết nối từ Client:** Dùng **PowerShell** (lệnh `ssh user@ip`) hoặc phần mềm đồ họa **Bitvise SSH Client** / **PuTTY**.

#### b. Dịch vụ FTP / SFTP
Dùng để truyền nhận tập tin giữa máy Client (Windows) và Server (Linux).
* **FTP (Vsftpd):** Cài đặt FTP Server truyền thống.
  ```bash
  sudo apt install vsftpd -y
  ```
  Mở file `/etc/vsftpd.conf` và cấu hình cho phép ghi file:
  ```conf
  local_enable=YES
  write_enable=YES
  ```
  Khởi động lại dịch vụ:
  ```bash
  sudo systemctl restart vsftpd
  sudo systemctl enable vsftpd
  ```
* **SFTP (SSH File Transfer Protocol):** Không cần cài thêm phần mềm do chạy trực tiếp trên nền SSH (Cổng 22). Bảo mật hơn FTP vì mọi dữ liệu và mật khẩu đều được mã hóa. Client sử dụng công cụ như **WinSCP** hoặc **FileZilla** để kết nối bằng giao thức SFTP qua tài khoản SSH của Server.

#### c. Dịch vụ Web Server (Môi trường Apache, MySQL, PHP)
Thay vì cài đặt trực tiếp LAMP truyền thống lên OS làm bẩn hệ thống, nhóm triển khai Web Server trực tiếp bằng **Docker Container** (Xem chi tiết ở mục 3) nhằm đảm bảo tính cô lập và đồng nhất môi trường.

#### d. Dịch vụ SVN Server (Subversion)
SVN được sử dụng song song với Git để quản lý các tài nguyên nhị phân lớn của dự án (Mockup thiết kế Figma, file Word Đặc tả, Excel Kế hoạch) tránh làm nặng Git repository.
* **Cài đặt SVN trên Linux:**
  ```bash
  sudo apt install subversion apache2 libapache2-mod-svn -y
  ```
* **Tạo Repository:**
  ```bash
  sudo mkdir -p /var/svn
  sudo svnadmin create /var/svn/project_docs
  ```
* **Cấu hình Quyền & Tài khoản thành viên:**
  Mở file cấu hình chung `/var/svn/project_docs/conf/svnserve.conf`:
  ```ini
  [general]
  anon-access = none
  auth-access = write
  password-db = passwd
  authz-db = authz
  ```
  Thêm danh sách User/Password trong file `/var/svn/project_docs/conf/passwd`:
  ```ini
  [users]
  admin = matkhau123
  minh_dev = minh456
  giang_dev = giang789
  ```
  Cấp quyền đọc/ghi cho toàn bộ repo trong file `/var/svn/project_docs/conf/authz`:
  ```ini
  [/]
  * = rw
  ```
* **Khởi chạy SVN Server:**
  ```bash
  sudo svnserve -d -r /var/svn
  ```
* **Kết nối từ Client (Windows):** Thành viên tải phần mềm **TortoiseSVN**, nhấp chuột phải chọn **SVN Checkout** và nhập URL: `svn://192.168.1.100/project_docs`. Nhập tài khoản tương ứng để thực hiện commit tài liệu lên server chung.

---

### 3. Triển khai Docker & Docker Compose trên Máy chủ Linux

#### a. Cài đặt Docker & Docker Compose
Thực hiện cài đặt Docker Engine chính thức trên Ubuntu:
```bash
sudo apt update
sudo apt install ca-certificates curl gnupg lsb-release -y
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin -y
```

#### b. Xây dựng Dockerfile cho Ứng dụng Web (web_qlsp)
Đặt file Dockerfile tại thư mục gốc của dự án để đóng gói mã nguồn PHP cùng máy chủ Apache:
```dockerfile
# Sử dụng base image PHP 8.2 có sẵn máy chủ Apache tích hợp
FROM php:8.2-apache

# Cài đặt extension kết nối Database mở rộng của PHP
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Bật URL Rewrite của Apache cho mô hình MVC hoạt động chính xác
RUN a2enmod rewrite

# Thiết lập thư mục làm việc trong container
WORKDIR /var/www/html

# Sao chép toàn bộ mã nguồn vào thư mục web_qlsp trong container
COPY . /var/www/html/web_qlsp/

# Cấu hình tự động redirect từ root (/) vào thư mục /web_qlsp/
RUN echo "RedirectMatch ^/$ /web_qlsp/" > /etc/apache2/conf-available/redirect.conf \
    && a2enconf redirect

# Phân quyền sở hữu thư mục cho Apache
RUN chown -R www-data:www-data /var/www/html/web_qlsp/
RUN chmod -R 775 /var/www/html/web_qlsp/

# Mở cổng kết nối 80 của Apache ra ngoài
EXPOSE 80
```

#### c. Viết Docker Compose Triển khai Đa Container (Web + Database)
File docker-compose.yml kết nối Web App PHP và MySQL Database:
```yaml
version: '3.8'

services:
  web:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: web_qlsp_app
    ports:
      - "8080:80" # Ánh xạ cổng 8080 của máy vật lý vào cổng 80 của container
    environment:
      - DB_HOST=db
      - DB_USER=root
      - DB_PASS=root_password
      - DB_NAME=quanao
      - DB_PORT=3306
    volumes:
      - .:/var/www/html/web_qlsp # Mount thư mục hiện tại để đồng bộ code thời gian thực khi dev
    depends_on:
      - db # Khởi động database trước khi web app chạy

  db:
    image: mysql:8.0
    container_name: web_qlsp_db
    command: --default-authentication-plugin=mysql_native_password
    restart: always
    ports:
      - "3307:3306" # Ánh xạ cổng 3307 của máy vật lý vào cổng 3306 của MySQL
    environment:
      - MYSQL_ROOT_PASSWORD=root_password
      - MYSQL_DATABASE=quanao
    volumes:
      - mysql_data:/var/lib/mysql # Sử dụng Volume để lưu trữ dữ liệu bền vững

volumes:
  mysql_data: # Khai báo Volume
```

#### d. Quản lý vòng đời Container qua dòng lệnh
* **Build image và chạy hệ thống ngầm:** `docker compose up -d --build`
* **Kiểm tra trạng thái các container:** `docker ps`
* **Xem nhật ký hoạt động (logs) của container Web:** `docker logs -f web_qlsp_app`
* **Truy cập vào shell bên trong container Database:** `docker exec -it web_qlsp_db mysql -u root -proot_password`
* **Dừng và xóa bỏ các container:** `docker compose down`

---

### 4. Quy trình làm việc nhóm bằng Git & GitHub

#### Luồng làm việc chuẩn của Nhóm:
1. Mỗi thành viên khởi tạo tài khoản GitHub cá nhân và được phân quyền Collaborator trong dự án chung `web_qlsp`.
2. Tạo hai nhánh chính trên Github:
   * `main`: Nhánh ổn định, chứa code đã sẵn sàng để phát hành sản phẩm.
   * `develop`: Nhánh tích hợp liên tục, nơi gom toàn bộ tính năng mới từ các thành viên.
3. Khi phát triển tính năng, mỗi thành viên sẽ tự tạo một nhánh riêng từ `develop` (Ví dụ: `git checkout -b basduy05`), tiến hành commit và push lên nhánh đó.
4. Tạo Pull Request trên GitHub để merge nhánh cá nhân (`basduy05`) vào nhánh chung `develop`.

#### Cách giải quyết xung đột (Merge Conflict):
Khi có xung đột do 2 thành viên cùng sửa đổi một vị trí code trên cùng một file:
1. Chạy lệnh cập nhật code mới nhất: `git pull origin develop`
2. Mở file bị báo xung đột (ví dụ: `docs/conflict_demo.txt`).
3. Git sẽ đánh dấu xung đột bằng ký tự:
   ```text
   <<<<<<< HEAD
   [Đoạn code hiện tại của bạn]
   =======
   [Đoạn code mới được kéo về từ remote]
   >>>>>>> branch_name
   ```
4. Sử dụng trình soạn thảo (VS Code) để thảo luận và lựa chọn:
   * **Accept Current Change:** Giữ lại phiên bản của bạn.
   * **Accept Incoming Change:** Lấy phiên bản mới kéo về.
   * **Accept Both Changes:** Giữ cả hai.
5. Tiến hành xóa bỏ hoàn toàn các dòng ký tự đánh dấu xung đột (`<<<<<<<`, `=======`, `>>>>>>>`).
6. Đánh dấu đã giải quyết và đẩy code lên:
   ```bash
   git add docs/conflict_demo.txt
   git commit -m "fix(conflict): resolve merge conflict in conflict_demo.txt"
   git push origin develop
   ```

---
---

## 🎭 PHẦN II: KỊCH BẢN THUYẾT TRÌNH & HỎI THI VẤN ĐÁP TRỰC TIẾP

> [!NOTE]
> Kịch bản này được thiết kế theo cấu trúc bài hỏi thi vấn đáp, giúp sinh viên tự tin trả lời lưu loát lý thuyết đồng thời thực hành trơn tru trước mặt Giảng viên.

### 🔌 CHỦ ĐỀ 1: SSH VÀ TRUYỀN FILE

#### 💬 Câu hỏi 1: "Em hãy nêu cách SSH vào Server ảo và phân biệt sự khác nhau giữa FTP và SFTP?"
* **Trả lời lý thuyết:**
  * Để kết nối SSH, ta mở terminal Client và dùng lệnh: `ssh username@ip_address` (Ví dụ: `ssh admin@192.168.1.100`). Sau đó nhập mật khẩu để truy cập vào shell của Linux.
  * **Sự khác biệt:**
    * **FTP (Port 21):** Truyền dữ liệu và mật khẩu dưới dạng văn bản thuần (Clear Text), không mã hóa nên rất dễ bị tin tặc đánh cắp gói tin thông qua các công cụ Sniffing (như Wireshark).
    * **SFTP (Port 22):** Chạy trên giao thức SSH, mã hóa toàn bộ phiên truyền tải dữ liệu và thông tin xác thực đăng nhập, do đó vô cùng an toàn và được sử dụng rộng rãi trong các doanh nghiệp hiện nay.
* **Thực hành trực tiếp trước mặt thầy cô:**
  1. Mở PowerShell trên Windows Client.
  2. Gõ lệnh: `ssh admin@192.168.1.100` (Thay đổi IP tương ứng).
  3. Nhập mật khẩu thành công và gõ lệnh kiểm tra hệ thống: `uname -a` hoặc `ip a`.
  4. Mở công cụ WinSCP/FileZilla, thiết lập giao thức kết nối chọn **SFTP (Port 22)**, nhập IP, User và Pass, kết nối thành công rồi thực hiện kéo thả 1 file bất kỳ từ Windows sang thư mục `/home/admin/` trên Linux để thầy cô thấy tốc độ truyền tải an toàn.

---

### 📂 CHỦ ĐỀ 2: SVN (SUBVERSION)

#### 💬 Câu hỏi 2: "Tại sao nhóm đã dùng Git rồi vẫn cài thêm SVN? Hãy thực hiện khởi tạo và commit file lên SVN Server?"
* **Trả lời lý thuyết:**
  * **Lý do sử dụng song song:** Git lưu lịch sử phân tán, mỗi lần clone sẽ tải toàn bộ lịch sử phiên bản về máy nên nếu lưu trữ các file tài liệu thiết kế đồ họa nặng (.psd, .fig, .pdf, word/excel), Git repo sẽ bị phình to cực kỳ nhanh. SVN quản lý tập trung (Centralized), cho phép lấy một thư mục con và chỉ cập nhật file cần thiết, rất phù hợp để quản lý và chia sẻ các tài liệu dự án của các thành viên.
* **Thực hành trực tiếp trước mặt thầy cô:**
  1. Trên Server SSH, chỉ ra thư mục lưu trữ Repo SVN và cách cấu hình phân quyền user:
     `cat /var/svn/project_docs/conf/svnserve.conf`
     `cat /var/svn/project_docs/conf/passwd` (Chỉ ra các User nhóm đã tạo).
  2. Trên Windows Client, click chuột phải vào một thư mục trống -> Chọn **SVN Checkout** -> điền địa chỉ `svn://192.168.1.100/project_docs` -> Checkout thành công.
  3. Tạo 1 file Word mới đặt tên `bao_cao_nhom.docx` -> Click chuột phải chọn **TortoiseSVN -> Add**.
  4. Tiếp tục click chuột phải chọn **SVN Commit...** -> Gõ thông điệp commit -> Nhấn OK và điền tài khoản mật khẩu SVN. Cho thầy cô thấy file đã được đẩy lên lưu trữ tập trung trên Server thành công.

---

### 🐙 CHỦ ĐỀ 3: GIT & GITHUB

#### 💬 Câu hỏi 3: "Hãy thực hiện giải thích quy trình xử lý xung đột (conflict) mã nguồn trực tiếp trên máy của em?"
* **Trả lời lý thuyết:**
  * Xung đột xảy ra khi 2 lập trình viên cùng sửa đổi trên một dòng code của một file trên local và cùng đẩy lên nhánh chung. Git sẽ chặn người push sau và yêu cầu pull về giải quyết xung đột. Để xử lý, ta phải mở file bị conflict, chọn giữ lại code của mình, của đối tác hoặc gộp cả hai, xóa bỏ các ký tự đánh dấu xung đột (`<<<<<<<`, `=======`, `>>>>>>>`), sau đó thực hiện `git add`, `git commit` để kết thúc quá trình merge.
* **Thực hành trực tiếp trước mặt thầy cô:**
  1. Chạy lệnh: `git status` để hiển thị nhánh làm việc hiện tại (Ví dụ: `basduy05`).
  2. Chạy lệnh: `git pull origin develop` để lấy code mới nhất.
  3. Sửa đổi file `docs/conflict_demo.txt` và lưu lại.
  4. Giải thích các ký hiệu xung đột: chỉ rõ phần mã nguồn cục bộ nằm giữa `<<<<<<< HEAD` và `=======`, phần mã nguồn remote nằm giữa `=======` và `>>>>>>>`.
  5. Thao tác trên VS Code: Bấm nút **Accept Current Change** (hoặc chỉnh sửa thủ công để giữ lại dòng code tối ưu nhất).
  6. Lưu file lại và chạy chuỗi lệnh:
     ```bash
     git add docs/conflict_demo.txt
     git commit -m "fix(conflict): resolve merge conflict in conflict_demo.txt"
     git push origin basduy05
     ```

---

### 🐳 CHỦ ĐỀ 4: DOCKER & CONTAINERIZATION

#### 💬 Câu hỏi 4: "Phân biệt sự khác nhau giữa Container và Máy ảo (VM)? Ưu điểm vượt trội của Docker là gì?"
* **Trả lời lý thuyết:**
  * **Máy ảo (Virtual Machine - VM):** Chạy trên một phần mềm giám sát (Hypervisor). Mỗi máy ảo bắt buộc phải cài đặt một hệ điều hành khách (Guest OS) riêng biệt hoàn chỉnh. Do đó khởi động rất chậm (vài phút), chiếm dụng dung lượng đĩa lớn (hàng chục GB) và tiêu tốn nhiều tài nguyên RAM/CPU.
  * **Container (Docker):** Chạy trực tiếp trên nhân hệ điều hành của máy chủ vật lý (Host OS kernel) thông qua Docker Engine. Các container chia sẻ chung nhân hệ điều hành và chỉ chứa ứng dụng cùng các thư viện cần thiết để chạy. Do đó, khởi động siêu nhanh (vài mili giây), cực kỳ nhẹ (chỉ vài MB đến vài trăm MB) và hiệu năng gần như máy thật.
  * **Ưu điểm của Docker:** Giải quyết triệt để bài toán *"Code chạy tốt trên máy em nhưng lỗi trên server/máy bạn"* nhờ đóng gói đồng nhất toàn bộ môi trường chạy ứng dụng.

#### 💬 Câu hỏi 5: "Hãy giải thích cấu trúc Dockerfile và docker-compose.yml của nhóm? Ý nghĩa của Ánh xạ cổng (Port Mapping) và Volume?"
* **Trả lời lý thuyết:**
  * **Dockerfile:** Là file kịch bản tự động hóa quá trình đóng gói ứng dụng. Bao gồm base image (`FROM php:8.2-apache`), cài thư viện bổ sung (`RUN docker-php-ext-install`), copy mã nguồn (`COPY`), phân quyền và cổng giao tiếp (`EXPOSE`).
  * **Docker Compose:** Dùng để định nghĩa và chạy đồng thời nhiều service container liên quan. Ở đây là service `web` (chạy PHP app) và service `db` (chạy MySQL database).
  * **Port Mapping (Ánh xạ cổng - Ví dụ `8080:80`):** Máy chủ vật lý không thể đọc trực tiếp cổng bên trong Container biệt lập. Ta phải map cổng `8080` của máy vật lý vào cổng `80` của Web Container. Khi người dùng truy cập `http://ip_server:8080`, Docker sẽ chuyển hướng luồng traffic vào cổng `80` của container để phản hồi dữ liệu.
  * **Volume (Ví dụ `mysql_data:/var/lib/mysql`):** Mặc định, dữ liệu bên trong container mang tính tạm thời (Ephemeral) – nếu container bị xóa, toàn bộ dữ liệu MySQL sẽ mất sạch. Việc gắn Volume giúp liên kết thư mục chứa data của MySQL trong container ra ổ cứng thực tế của Server Linux, giúp dữ liệu luôn được an toàn và bền vững kể cả khi nâng cấp hoặc xóa container.

* **Thực hành trực tiếp trước mặt thầy cô:**
  1. Trên SSH Terminal, chạy lệnh tắt hệ thống:
     ```bash
     docker compose down
     ```
  2. Mở trình duyệt máy Client truy cập `http://192.168.1.100:8080` để chứng minh trang web đã sập và không truy cập được.
  3. Khởi chạy lại hệ thống bằng lệnh:
     ```bash
     docker compose up -d
     ```
  4. F5 trình duyệt để chứng minh trang web đã tải lại bình thường.
  5. Đăng ký một tài khoản mới trên trang web bán hàng (ví dụ: tạo tài khoản khách hàng `giang_utt`).
  6. Chứng minh tính bền vững của Volume: Chạy lệnh `docker compose down` một lần nữa để xóa container cũ đi. Sau đó chạy `docker compose up -d` tạo container mới.
  7. Quay lại trình duyệt F5 trang web và đăng nhập bằng tài khoản `giang_utt` vừa tạo -> Đăng nhập thành công! Giải thích cho giảng viên: *"Mặc dù container chứa MySQL đã bị hủy hoàn toàn và tạo mới, thông tin tài khoản của khách hàng không hề bị mất đi nhờ cơ chế lưu dữ liệu bền vững của Named Volume `mysql_data`."*

---

## 🏆 TIÊU CHÍ ĐỂ ĐẠT ĐIỂM TỐI ĐA (ĐIỂM 10) TRƯỚC HỘI ĐỒNG
1. **Thao tác chuyên nghiệp:** Luôn sử dụng phím tắt, tab để autocomplete lệnh Linux, tránh gõ chậm chạp.
2. **Hiểu rõ bản chất:** Khi gõ bất kỳ lệnh nào (`git pull`, `docker ps`, `svn update`), hãy giải thích ngay hành động đó có ý nghĩa gì đối với hệ thống.
3. **Phối hợp nhóm ăn ý:** Phân chia rõ ràng vai trò của từng thành viên trong kịch bản demo để hội đồng thấy rõ tinh thần làm việc nhóm chuyên nghiệp.
