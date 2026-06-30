<?php
class users_m extends connectDB {
    function __construct() {
        parent::__construct();
    }
    function users_selectAll() {
        $sql = "SELECT * FROM users WHERE role != 'admin' ORDER BY id ASC";
        return mysqli_query($this->con, $sql);
    }
    
    function users_searchByName($q) {
        $q = mysqli_real_escape_string($this->con, $q);
        $sql = "SELECT * FROM users WHERE role != 'admin' AND full_name LIKE '%$q%' ORDER BY id ASC";
        return mysqli_query($this->con, $sql);
    }
    
    function users_delete($id) {
        // Huu Giang: Dung Prepared Statement tranh SQL Injection cho lenh xoa
        $stmt = $this->con->prepare("DELETE FROM users WHERE id = ?");
        $stmt->bind_param("i", $id);
        return $stmt->execute();
    }
    
    public function users_insert_default($full_name, $email, $phone, $password, $google_id, $avatar, $province, $district, $ward, $address) {
        // Huu Giang: Ma hoa mat khau bang bcrypt truoc khi luu vao CSDL
        $hashed_password = password_hash($password, PASSWORD_BCRYPT);

        // Huu Giang: Kiem tra trung email bang Prepared Statement
        $check_email = $this->con->prepare("SELECT id FROM users WHERE email = ? LIMIT 1");
        $check_email->bind_param("s", $email);
        $check_email->execute();
        if ($check_email->get_result()->num_rows > 0) return "EMAIL_EXISTED";

        // Huu Giang: Kiem tra trung so dien thoai bang Prepared Statement
        $check_phone = $this->con->prepare("SELECT id FROM users WHERE phone = ? LIMIT 1");
        $check_phone->bind_param("s", $phone);
        $check_phone->execute();
        if ($check_phone->get_result()->num_rows > 0) return "PHONE_EXISTED";

        // Huu Giang: INSERT dung Prepared Statement - an toan tuyet doi khoi SQL Injection
        $stmt = $this->con->prepare(
            "INSERT INTO users (full_name, email, phone, password, google_id, avatar, province_code, district_code, ward_code, address_detail)
             VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)"
        );
        $stmt->bind_param("ssssssssss",
            $full_name, $email, $phone, $hashed_password,
            $google_id, $avatar, $province, $district, $ward, $address
        );
        return $stmt->execute() ? true : false;
    }
    function users_checkLogin($email) {
        // Truy vấn lấy thông tin người dùng theo email
        $sql = "SELECT * FROM users WHERE email = '$email' ";
        $result = mysqli_query($this->con, $sql);
        return mysqli_fetch_assoc($result); // Trả về mảng thông tin người dùng hoặc null
    }
    public function getUserByEmail($email) {
        $sql = "SELECT * FROM users WHERE email = '$email'";
        $result = mysqli_query($this->con, $sql);
        return mysqli_fetch_assoc($result);
    }
    
    public function getUserById($id) {
        $id = mysqli_real_escape_string($this->con, $id);
        $sql = "SELECT * FROM users WHERE id = '$id'";
        $result = mysqli_query($this->con, $sql);
        return mysqli_fetch_assoc($result);
    }
    // Thêm hàm này vào file users_m.php (bên dưới các hàm đã có)
    public function users_getOrderHistory($user_id) {
        $user_id = mysqli_real_escape_string($this->con, $user_id);
        // Lấy các thông tin cơ bản của đơn hàng
        $sql = "SELECT id, total_money, payment_method, status, created_at 
                FROM orders 
                WHERE user_id = '$user_id' 
                ORDER BY created_at DESC";
        return mysqli_query($this->con, $sql);
    }
}