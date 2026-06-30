<?php
// Tắt hiển thị các cảnh báo lỗi không dùng nữa (Deprecated) và các thông báo nhỏ (Notice) để tránh làm hỏng định dạng JSON khi phản hồi API
error_reporting(E_ALL & ~E_DEPRECATED & ~E_NOTICE);

// Định nghĩa lớp collections kế thừa từ lớp cơ sở controllers trong mô hình MVC
class collections extends controllers {
    // Khai báo thuộc tính private để lưu trữ thực thể của đối tượng Model xử lý dữ liệu bộ sưu tập
    private $collec;

    // Hàm khởi tạo của lớp, tự động chạy khi đối tượng collections được tạo ra
    public function __construct() {
        // Gọi hàm khởi tạo của lớp cha (controllers) để kế thừa các thiết lập ban đầu
        parent::__construct();

        // Khởi tạo đối tượng model 'collections_m' và gán vào thuộc tính $collec để sử dụng trong toàn bộ class
        $this->collec = $this->model("collections_m");
    }

    // 1. LUỒNG DÀNH CHO TRÌNH DUYỆT WEB (Load giao diện rỗng)
    // Hàm xử lý yêu cầu tải giao diện quản lý bộ sưu tập cho người dùng web
    public function Get_data() {
        // Gọi hàm view từ lớp cha để load file giao diện chính 'Master' và truyền view con 'collections_v' vào bên trong
        $this->view('Master', [
            'Page' => 'collections_v'
        ]);
    }

    // Thiết lập Header cho API
    // Hàm private dùng nội bộ để cấu hình các thuộc tính Header, cho phép gọi dữ liệu qua API dưới dạng JSON
    private function setApiHeader() {
        // Cấu hình CORS cho phép tất cả các nguồn (domain) khác nhau đều có thể gọi tới API này
        header('Access-Control-Allow-Origin: *');
        // Định dạng dữ liệu phản hồi trả về từ API là kiểu JSON với bảng mã ký tự utf-8
        header('Content-Type: application/json; charset=utf-8');
    }

    // 2. LUỒNG API DÀNH CHO JAVASCRIPT (Lấy dữ liệu + Tìm kiếm + Đếm SP)
    // API xử lý việc lấy danh sách bộ sưu tập, hỗ trợ cả tính năng tìm kiếm và đếm số lượng sản phẩm liên quan
    public function api_get_data() {
        // Gọi hàm thiết lập cấu hình Header API ở trên
        $this->setApiHeader();
        
        // Kiểm tra xem có từ khóa tìm kiếm 'q' được gửi lên qua phương thức GET hay không, nếu có thì cắt bỏ khoảng trắng thừa
        $search = isset($_GET['q']) ? trim($_GET['q']) : '';
        
        // Nếu có từ khóa thì tìm kiếm, không thì lấy tất cả
        // Kiểm tra xem biến tìm kiếm có giá trị hay không
        if ($search !== '') {
            // Nếu có từ khóa, gọi hàm trong Model để tìm kiếm bộ sưu tập theo từ khóa đó
            $result = $this->collec->collections_select($search);
        } else {
            // Nếu không có từ khóa, gọi hàm trong Model để lấy toàn bộ danh sách bộ sưu tập
            $result = $this->collec->collections_selectAll();
        }

        // Khởi tạo một mảng rỗng để chứa dữ liệu xử lý sau cùng
        $data = [];
        // Kiểm tra kết quả trả về từ database có tồn tại và số lượng dòng dữ liệu lớn hơn 0 hay không
        if ($result && mysqli_num_rows($result) > 0) {
            // Duyệt qua từng dòng dữ liệu lấy được từ câu lệnh truy vấn SQL dưới dạng mảng kết hợp (Associative Array)
            while ($row = mysqli_fetch_assoc($result)) {
                // Gọi model để đếm số lượng sản phẩm trong bộ sưu tập này
                // Thực hiện gọi hàm đếm số sản phẩm thuộc ID bộ sưu tập hiện tại và gán thêm một key mới 'product_count' vào mảng
                $row['product_count'] = $this->collec->countProductsInCollection($row['id']);
                // Đẩy dòng dữ liệu đã được bổ sung số lượng sản phẩm vào mảng $data tổng
                $data[] = $row;
            }
        }

        // Chuyển đổi mảng dữ liệu thành chuỗi định dạng JSON và in ra màn hình để trả về kết quả thành công cho Client
        echo json_encode(['success' => true, 'data' => $data]);
        // Dừng toàn bộ chương trình ngay lập tức để không chạy thêm các đoạn mã thừa phía sau
        exit;
    }

    // API: Thêm Bộ sưu tập
    // API tiếp nhận yêu cầu thêm mới một bộ sưu tập vào cơ sở dữ liệu
    public function add() {
        // Thiết lập cấu hình Header cho API JSON
        $this->setApiHeader();
        // Kiểm tra phương thức gửi lên, nếu không phải là POST thì từ chối xử lý
        if($_SERVER['REQUEST_METHOD'] !== 'POST'){
            // Trả về chuỗi JSON thông báo lỗi sai phương thức và dừng chương trình
            echo json_encode(['success' => false, 'message' => 'Lỗi phương thức']); exit;
        }

        // Lấy giá trị 'name' gửi lên từ form POST, nếu không có thì mặc định là chuỗi rỗng
        $name = $_POST['name'] ?? '';
        // Lấy giá trị 'slug' gửi lên từ form POST, nếu không có thì mặc định là chuỗi rỗng
        $slug = $_POST['slug'] ?? '';

        // Kiểm tra tính hợp lệ của dữ liệu đầu vào, nếu tên bộ sưu tập trống thì báo lỗi
        if (empty($name)) {
            // Trả về JSON thông báo lỗi không được để trống tên và dừng chương trình
            echo json_encode(['success' => false, 'message' => 'Tên bộ sưu tập không được để trống']); exit;
        }

        // Khởi tạo biến lưu tên file ảnh mặc định ban đầu là chuỗi rỗng
        $thumbnail = '';
        // Kiểm tra xem có file hình ảnh mang tên 'image' được tải lên không và file đó không gặp lỗi khi upload
        if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
            // Xác định đường dẫn thư mục tuyệt đối trên máy chủ để lưu ảnh bộ sưu tập
            $target_dir = $_SERVER['DOCUMENT_ROOT'] . "/web_qlsp/Public/Picture/collections/";
            // Nếu thư mục lưu trữ ảnh chưa tồn tại thì tiến hành tạo mới thư mục với toàn quyền 0777 (bao gồm cả thư mục con)
            if (!is_dir($target_dir)) mkdir($target_dir, 0777, true);
            // Tạo tên file duy nhất bằng cách nối mốc thời gian hiện tại (timestamp) với tên gốc của file tải lên
            $file_name  = time() . '_' . basename($_FILES["image"]["name"]);
            // Thực hiện di chuyển file từ thư mục tạm thời của hệ thống sang thư mục lưu trữ chính thức đã thiết lập
            if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_dir . $file_name)) {
                // Nếu di chuyển file thành công thì gán tên file mới vào biến $thumbnail để chuẩn bị lưu vào DB
                $thumbnail = $file_name;
            }
        }

        // Gọi hàm trong Model thực hiện chèn dữ liệu (tên, slug, ảnh) mới vào bảng bộ sưu tập trong cơ sở dữ liệu
        $kq = $this->collec->collections_insert($name, $slug, $thumbnail);
        // Kiểm tra biến kết quả $kq và trả về chuỗi JSON phản hồi trạng thái thành công hoặc thất bại tương ứng
        echo json_encode(['success' => $kq, 'message' => $kq ? 'Thêm thành công' : 'Lỗi thêm dữ liệu']);
        // Dừng thực thi chương trình
        exit;
    }

    // API: Sửa Bộ sưu tập
    // API tiếp nhận yêu cầu cập nhật lại thông tin của một bộ sưu tập hiện có
    public function update() {
        // Thiết lập cấu hình Header cho API JSON
        $this->setApiHeader();
        // Kiểm tra phương thức gửi lên, yêu cầu bắt buộc phải là phương thức POST
        if($_SERVER['REQUEST_METHOD'] !== 'POST'){
            // Trả về JSON thông báo lỗi sai phương thức và dừng chương trình
            echo json_encode(['success' => false, 'message' => 'Lỗi phương thức']); exit;
        }

        // Tiếp nhận các thông tin cập nhật gửi từ Form POST lên hệ thống
        $id        = $_POST['id'];
        $name      = $_POST['name'];
        $slug      = $_POST['slug'];
        // Lấy tên file ảnh cũ được gửi kèm để giữ lại trong trường hợp người dùng không upload ảnh mới
        $old_image = $_POST['old_image'] ?? '';

        // Kiểm tra nếu tên bộ sưu tập bị sửa thành rỗng thì từ chối cập nhật
        if (empty($name)) {
            // Trả về JSON thông báo lỗi tên không được để trống và dừng chương trình
            echo json_encode(['success' => false, 'message' => 'Tên bộ sưu tập không được để trống']); exit;
        }

        // Mặc định gán ảnh đại diện bằng ảnh cũ, phòng trường hợp không tải lên ảnh mới
        $thumbnail = $old_image; 
        // Kiểm tra nếu người dùng có chọn file ảnh mới và file tải lên không xảy ra lỗi
        if (isset($_FILES['image']) && $_FILES['image']['error'] == 0) {
            // Thiết lập đường dẫn thư mục đích để lưu trữ file ảnh trên server
            $target_dir = $_SERVER['DOCUMENT_ROOT'] . "/web_qlsp/Public/Picture/collections/";
            // Tạo tên file mới dựa trên timestamp để tránh bị trùng lặp tên file đã có trên hệ thống
            $file_name  = time() . '_' . basename($_FILES["image"]["name"]);
            // Di chuyển file từ thư mục tạm của server về thư mục lưu trữ chính thức
            if (move_uploaded_file($_FILES["image"]["tmp_name"], $target_dir . $file_name)) {
                // Nếu tải file thành công, cập nhật lại biến $thumbnail bằng tên file mới này
                $thumbnail = $file_name;
            }
        }

        // Gọi hàm trong Model thực hiện cập nhật lại dữ liệu bộ sưu tập trong DB theo ID truyền vào
        $kq = $this->collec->collections_update($id, $name, $slug, $thumbnail);
        // Phản hồi kết quả xử lý cập nhật dưới dạng JSON cho Client và kết thúc
        echo json_encode(['success' => $kq, 'message' => $kq ? 'Cập nhật thành công' : 'Lỗi cập nhật']);
        // Dừng thực thi chương trình
        exit;
    }

    // API: Xóa Bộ sưu tập
    // API tiếp nhận yêu cầu xóa một bộ sưu tập theo mã ID cụ thể được truyền trên URL
    public function delete($id) {
        // Thiết lập cấu hình Header cho API JSON
        $this->setApiHeader();
        // Gọi hàm xóa dữ liệu bộ sưu tập trong Model bằng ID được cung cấp
        $kq = $this->collec->collections_delete($id);
        // Xuất ra chuỗi JSON báo trạng thái xóa thành công hoặc thất bại cho phía client nhận diện
        echo json_encode(['success' => $kq, 'message' => $kq ? 'Đã xóa thành công' : 'Lỗi khi xóa']);
        // Dừng toàn bộ chương trình
        exit;
    }

    // API: Xuất Excel (Tải trực tiếp)
    // API kết xuất toàn bộ dữ liệu hoặc dữ liệu tìm kiếm ra file Excel định dạng .xlsx cho người dùng tải xuống
    public function export() {
        // Khởi tạo một đối tượng làm việc với file Excel mới từ thư viện PHPExcel
        $objExcel = new PHPExcel();
        // Thiết lập sheet làm việc đầu tiên (index 0) làm sheet hoạt động hiện tại
        $objExcel->setActiveSheetIndex(0);
        // Đặt tên tiêu đề cho sheet hiện tại là 'Bo_Suu_Tap'
        $sheet = $objExcel->getActiveSheet()->setTitle('Bo_Suu_Tap');

        // Biến đếm số dòng trong file Excel, bắt đầu khởi tạo từ dòng số 1
        $rowCount = 1;
        // Điền nội dung tiêu đề các cột cho dòng đầu tiên trong file Excel
        $sheet->setCellValue('A' . $rowCount, 'ID');
        $sheet->setCellValue('B' . $rowCount, 'TÊN BỘ SƯU TẬP');
        $sheet->setCellValue('C' . $rowCount, 'SLUG');
        $sheet->setCellValue('D' . $rowCount, 'HÌNH ẢNH');
        // Định dạng in đậm chữ (Bold) cho tất cả các ô tiêu đề từ cột A1 đến D1
        $sheet->getStyle('A1:D1')->getFont()->setBold(true);

        // Kiểm tra từ khóa tìm kiếm 'q' gửi lên từ tham số URL, nếu không có gán bằng chuỗi rỗng
        $search = $_GET['q'] ?? '';
        // Kiểm tra xem luồng xuất file Excel có chứa từ khóa lọc tìm kiếm hay không
        if ($search !== '') {
            // Lấy dữ liệu các bộ sưu tập phù hợp với từ khóa tìm kiếm từ cơ sở dữ liệu
            $data = $this->collec->collections_select($search);
        } else {
            // Lấy toàn bộ danh sách bộ sưu tập có trong hệ thống dữ liệu
            $data = $this->collec->collections_selectAll();
        }

        // Nếu dữ liệu tồn tại và có kết quả trả về từ database
        if ($data) {
            // Lặp qua từng bản ghi dữ liệu trả về theo kiểu mảng thông thường/mảng kết hợp
            while ($row = mysqli_fetch_array($data)) {
                // Tăng biến dòng lên 1 đơn vị để ghi tiếp dữ liệu vào dòng tiếp theo trong Excel
                $rowCount++;
                // Điền thông tin giá trị tương ứng của bộ sưu tập vào các ô cột A, B, C, D của dòng hiện tại
                $sheet->setCellValue('A' . $rowCount, $row['id']);
                $sheet->setCellValue('B' . $rowCount, $row['name']);
                $sheet->setCellValue('C' . $rowCount, $row['slug']);
                $sheet->setCellValue('D' . $rowCount, $row['thumbnail']);
            }
        }

        // Vòng lặp duyệt qua các cột từ A đến D để thiết lập chế độ tự động căn chỉnh độ rộng của cột theo nội dung chữ
        foreach (range('A', 'D') as $col) {
            $sheet->getColumnDimension($col)->setAutoSize(true);
        }

        // Định nghĩa tên file Excel tải về bao gồm hậu tố mốc thời gian hiện tại để không trùng lặp
        $filename = "Bo_Suu_Tap_" . time() . ".xlsx";
        // Kiểm tra và xóa bỏ toàn bộ dữ liệu rác trong bộ đệm đầu ra (Output Buffer) tránh làm lỗi định dạng file Excel khi tải về
        if (ob_get_length()) ob_end_clean();

        // Thiết lập header thông báo cho trình duyệt biết đây là file stream dạng bảng tính Microsoft Excel (.xlsx)
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        // Thiết lập header buộc trình duyệt phải tải file về dưới dạng file đính kèm với tên file đã định nghĩa ở trên
        header('Content-Disposition: attachment; filename="' . $filename . '"');
        // Khởi tạo một đối tượng Writer để tiến hành biên dịch và xuất dữ liệu Excel theo cấu trúc phiên bản Excel2007
        $objWriter = PHPExcel_IOFactory::createWriter($objExcel, 'Excel2007');
        // Lưu và đẩy toàn bộ dữ liệu file Excel trực tiếp ra cổng output của luồng xử lý php để tải xuống
        $objWriter->save('php://output');
        // Kết thúc chương trình
        exit;
    }

    // API: Nhập Excel
    // API tiếp nhận file Excel tải lên, đọc và phân tích dữ liệu để thêm số lượng lớn bộ sưu tập vào DB
    public function importExcelCollections() {
        // Thiết lập cấu hình Header cho API JSON
        $this->setApiHeader();

        // Kiểm tra sự tồn tại của file Excel được đẩy lên, nếu trống hoặc lỗi thì thông báo ngay cho người dùng
        if (!isset($_FILES['import_file_collection']) || empty($_FILES['import_file_collection']['tmp_name'])) {
            // Trả về JSON lỗi chưa chọn file và dừng thực thi
            echo json_encode(['success' => false, 'message' => 'Vui lòng chọn file!']); exit;
        }

        // Lấy đường dẫn lưu trữ file tạm thời của file Excel vừa mới upload lên máy chủ
        $file = $_FILES['import_file_collection']['tmp_name'];

        // Khối lệnh try-catch để bắt và xử lý mọi ngoại lệ/lỗi phát sinh trong quá trình đọc file Excel
        try {
            // Yêu cầu bắt buộc nạp file mã nguồn thư viện IOFactory của PHPExcel phục vụ việc đọc tệp tin
            require_once __DIR__ . '/../../Public/Classes/PHPExcel/IOFactory.php';
            // Tạo đối tượng Reader tự động nhận diện định dạng cấu trúc tệp tin Excel được đưa vào
            $objReader = PHPExcel_IOFactory::createReaderForFile($file);
            // Tiến hành nạp dữ liệu từ file tạm thời vào đối tượng lưu trữ của PHPExcel
            $objExcel  = $objReader->load($file);
            // Lấy dữ liệu của trang tính (sheet) đầu tiên có trong file Excel tải lên (index 0)
            $sheet     = $objExcel->getSheet(0);
            // Chuyển đổi toàn bộ cấu trúc dữ liệu của sheet đó về thành dạng mảng PHP đa chiều dễ xử lý
            $sheetData = $sheet->toArray(null, true, true, true);

            // Xác định thư mục tuyệt đối đích để chuẩn bị lưu trữ các tệp tin ảnh của bộ sưu tập
            $absPath = $_SERVER['DOCUMENT_ROOT'] . '/web_qlsp/Public/Picture/collections/';
            // Kiểm tra thư mục lưu ảnh, nếu chưa có thì tự động tạo mới với phân quyền 0777
            if (!is_dir($absPath)) mkdir($absPath, 0777, true);

            // Khởi tạo biến đếm số lượng bản ghi bộ sưu tập được thêm vào cơ sở dữ liệu thành công
            $countSuccess = 0;

            // Vòng lặp duyệt qua các dòng dữ liệu trong mảng bắt đầu từ dòng thứ 2 (bỏ qua dòng tiêu đề số 1)
            for ($i = 2; $i <= count($sheetData); $i++) {
                // Lấy tên bộ sưu tập tại cột A của dòng hiện tại và loại bỏ khoảng trắng thừa ở hai đầu chuỗi
                $name = trim($sheetData[$i]["A"] ?? '');
                // Nếu tên bộ sưu tập trống, bỏ qua dòng hiện tại và chuyển sang dòng dữ liệu kế tiếp
                if (empty($name)) continue;

                // Tự động tạo chuỗi slug (đường dẫn thân thiện) từ tên bộ sưu tập vừa lấy được bằng hàm tiện ích
                $slug = $this->create_slug($name);
                // Lấy thông tin ảnh tại cột B của dòng hiện tại (có thể là tên file hoặc đường dẫn liên kết URL)
                $rawImg = trim($sheetData[$i]["B"] ?? '');
                // Gán tên ảnh mặc định ban đầu là 'no-image.jpg' phòng khi không có thông tin ảnh hợp lệ
                $thumbnail = 'no-image.jpg';

                // Nếu cột thông tin ảnh không bị trống thì tiến hành phân tích để lấy ảnh về hệ thống
                if (!empty($rawImg)) {
                    // Kiểm tra xem dữ liệu ảnh tại cột B có phải là một đường dẫn URL hợp lệ hay không
                    if (filter_var($rawImg, FILTER_VALIDATE_URL)) {
                        // Gọi hàm tải hình ảnh trực tiếp từ đường dẫn Internet về lưu trong thư mục cục bộ của server
                        $savedPath = $this->download_image_from_url($rawImg, $absPath);
                        // Nếu tải ảnh thành công và trả về đường dẫn cục bộ, bóc tách lấy riêng tên file ảnh gán vào $thumbnail
                        if ($savedPath) $thumbnail = basename($savedPath); 
                    } else {
                        // Nếu không phải URL thì đó là tên file ảnh cục bộ, kiểm tra xem file ảnh đó đã tồn tại sẵn trong thư mục chưa
                        if (file_exists($absPath . $rawImg)) {
                            // Nếu tệp tin ảnh tồn tại sẵn, gán trực tiếp tên file ảnh đó vào cấu trúc lưu trữ
                            $thumbnail = $rawImg; 
                        }
                    }
                }

                // Gọi hàm chèn dữ liệu bộ sưu tập mới vào DB, nhận kết quả đúng/sai (true/false) trả về
                $insertResult = $this->collec->collections_insert($name, $slug, $thumbnail);
                // Nếu chèn dữ liệu thành công vào Database, thực hiện tăng biến đếm số lượng thành công lên 1 đơn vị
                if ($insertResult) $countSuccess++;
            }

            // Gửi dữ liệu JSON trả về client thông báo việc đọc file và import số lượng dữ liệu thành công
            echo json_encode(['success' => true, 'message' => "Đã nhập thành công $countSuccess bộ sưu tập."]);
            // Thoát chương trình
            exit;

        } catch (Exception $e) {
            // Khi xảy ra bất cứ lỗi hệ thống nào trong khối try, trả về chuỗi JSON thông báo chi tiết lỗi ngoại lệ đó
            echo json_encode(['success' => false, 'message' => 'Lỗi: ' . $e->getMessage()]);
            // Kết thúc chương trình
            exit;
        }
    }

    // Các hàm tiện ích
    // Hàm tiện ích chuyển đổi chuỗi tiếng Việt có dấu thành chuỗi dạng Slug không dấu, viết thường, phân cách bởi dấu gạch ngang
    private function create_slug($string) {
        // Định nghĩa mảng các biểu thức chính quy (Regex) tìm kiếm tập hợp các ký tự chữ tiếng Việt có dấu và các ký tự đặc biệt
        $search = ['#(à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ)#', '#(è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ)#', '#(ì|í|ị|ỉ|ĩ)#', '#(ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ)#', '#(ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ)#', '#(ỳ|ý|ỵ|ỷ|ỹ)#', '#(đ)#', '#(À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ)#', '#(È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ)#', '#(Ì|Í|Ị|Ỉ|Ĩ)#', '#(Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ)#', '#(Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ)#', '#(Ỳ|Ý|Ỵ|Ỷ|Ỹ)#', '#(Đ)#', "/[^a-zA-Z0-9\-\_]/"];
        // Định nghĩa mảng chứa các ký tự không dấu tương ứng dùng để thay thế cho mảng tìm kiếm ở trên, ký tự lạ biến thành dấu '-'
        $replace = ['a', 'e', 'i', 'o', 'u', 'y', 'd', 'A', 'E', 'I', 'O', 'U', 'Y', 'D', '-'];
        // Tiến hành thay thế hàng loạt ký tự có dấu thành không dấu dựa theo hai mảng quy tắc đã chuẩn bị
        $string = preg_replace($search, $replace, $string);
        // Thay thế các chuỗi chứa nhiều dấu gạch ngang liên tiếp thành một dấu gạch ngang duy nhất (ví dụ: '---' thành '-')
        $string = preg_replace('/(-)+/', '-', $string);
        // Chuyển đổi toàn bộ chuỗi ký tự sau xử lý về định dạng chữ viết thường và trả về kết quả
        return strtolower($string);
    }

    // Hàm tiện ích hỗ trợ tải dữ liệu một file ảnh từ một liên kết URL trên Internet về lưu trữ tại thư mục cục bộ của máy chủ
    private function download_image_from_url($url, $saveFolder) {
        // Kiểm tra tính hợp lệ của đường dẫn URL truyền vào, nếu không phải URL đúng chuẩn thì trả về chuỗi rỗng lập tức
        if (!filter_var($url, FILTER_VALIDATE_URL)) return '';
        // Khối try-catch bắt lỗi khi xử lý các thao tác tương tác đọc ghi luồng file từ internet và ổ cứng
        try {
            // Sử dụng hàm lấy nội dung file từ URL, dùng ký tự '@' trước hàm để ẩn đi các cảnh báo lỗi hệ thống nếu URL chết
            $imageContent = @file_get_contents($url); 
            // Nếu không thể đọc hoặc lấy được nội dung dữ liệu từ đường dẫn URL này thì trả về chuỗi rỗng
            if ($imageContent === false) return '';

            // Phân tích cú pháp đường dẫn URL để bóc tách lấy thông tin phần mở rộng (đuôi file) của tập tin hình ảnh
            $pathInfo = pathinfo(parse_url($url, PHP_URL_PATH));
            // Kiểm tra xem đuôi file có tồn tại hay không, nếu có thì lấy, ngược lại mặc định gán đuôi file là 'jpg'
            $ext = isset($pathInfo['extension']) ? $pathInfo['extension'] : 'jpg';
            // Kiểm tra đuôi file có thuộc định dạng ảnh hợp lệ cho phép không, nếu lạ thì ép về đuôi file định dạng chuẩn là 'jpg'
            if (!in_array(strtolower($ext), ['jpg', 'jpeg', 'png', 'gif', 'webp'])) $ext = 'jpg';

            // Tạo tên file mới duy nhất ngẫu nhiên để lưu trữ tránh trùng lặp: col_ + timestamp hiện tại + số ngẫu nhiên + đuôi file
            $newFileName = 'col_' . time() . '_' . rand(1000, 9999) . '.' . $ext;
            // Tổ hợp đường dẫn tuyệt đối đầy đủ bao gồm thư mục lưu trữ và tên file mới của hình ảnh trên máy chủ
            $savePath = $saveFolder . $newFileName;
            // Thực hiện ghi nội dung chuỗi byte hình ảnh đã lấy được từ internet vào file đích trên ổ cứng máy chủ
            file_put_contents($savePath, $imageContent);
            // Trả về chuỗi chứa đường dẫn tuyệt đối của file ảnh sau khi đã tải và lưu thành công
            return $savePath; 
        } catch (Exception $e) {
            // Trả về chuỗi rỗng nếu xuất hiện bất kỳ lỗi ngoại lệ nào trong quá trình thực thi nghiệp vụ tải ảnh
            return '';
        }
    }
}
?>