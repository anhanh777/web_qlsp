<?php
// Định nghĩa lớp overview kế thừa từ lớp cơ sở controllers trong mô hình MVC
class overview extends controllers {
    // Khai báo thuộc tính private để lưu trữ thực thể của đối tượng Model xử lý dữ liệu tổng quan
    private $ov;
    
    // Hàm khởi tạo của lớp, tự động chạy khi đối tượng overview được tạo ra
    function __construct() {
        // Gọi hàm khởi tạo của lớp cha (controllers) để kế thừa các thiết lập ban đầu
        parent::__construct();

        // Khởi tạo đối tượng model 'overview_m' và gán vào thuộc tính $ov để sử dụng trong toàn bộ class
        $this->ov = $this->model("overview_m");
    }
    
    // 1. LUỒNG DÀNH CHO TRÌNH DUYỆT WEB (Chỉ tải giao diện rỗng)
    // Hàm xử lý yêu cầu tải giao diện tổng quan (dashboard) cho người dùng web
    function Get_data() {
        // Gọi hàm view từ lớp cha để load file giao diện chính 'Master' và truyền view con 'overview_v' vào bên trong
        $this->view('Master', [
            'Page' => 'overview_v'
        ]);
    }
    
    // Thiết lập Header dùng chung cho API
    // Hàm private dùng nội bộ để cấu hình các thuộc tính Header, cho phép gọi dữ liệu qua API dưới dạng JSON
    private function setApiHeader() {
        // Cấu hình CORS cho phép tất cả các nguồn (domain) khác nhau đều có thể gọi tới API này
        header('Access-Control-Allow-Origin: *');
        // Định dạng dữ liệu phản hồi trả về từ API là kiểu JSON với bảng mã ký tự utf-8
        header('Content-Type: application/json; charset=utf-8');
    }

    // 2. API LẤY SỐ LIỆU TỔNG QUAN VÀ BIỂU ĐỒ TRÒN
    // API xử lý việc lấy các số liệu thống kê tổng hợp và số lượng trạng thái đơn hàng để vẽ biểu đồ tròn
    function api_get_summary() {
        // Gọi hàm thiết lập cấu hình Header API ở trên
        $this->setApiHeader();
        
        // Gọi hàm từ Model để lấy mảng thống kê số lượng đơn hàng phân loại theo từng trạng thái cụ thể
        $status_counts = $this->ov->getOrderStatusCounts();
        
        // Chuyển đổi mảng số liệu tổng hợp thành chuỗi định dạng JSON và in ra màn hình để trả về cho Client
        echo json_encode([
            'success' => true,
            'data' => [
                'total_orders' => $this->ov->countOrders(), // Gọi Model đếm tổng số lượng đơn hàng trên hệ thống
                'pending_orders' => $this->ov->countPendingOrders(), // Gọi Model đếm số lượng đơn hàng đang chờ xử lý
                'total_customers' => $this->ov->countCustomers(), // Gọi Model đếm tổng số lượng khách hàng hiện có
                'total_products' => $this->ov->countProducts(), // Gọi Model đếm tổng số lượng sản phẩm trong kho
                'monthly_revenue' => $this->ov->getMonthlyRevenue(), // Gọi Model tính toán tổng doanh thu của tháng hiện tại
                'status_counts' => array_values($status_counts) // Chỉ lấy các giá trị số lượng (bỏ key chữ) chuyển thành mảng index tuần tự để khớp với cấu trúc Chart.js
            ]
        ]);
        // Dừng toàn bộ chương trình ngay lập tức để không chạy thêm các đoạn mã thừa phía sau
        exit;
    }
    
    // 3. API LẤY DỮ LIỆU BIỂU ĐỒ DOANH THU (Có hỗ trợ lọc)
    // API xử lý lấy dữ liệu doanh thu theo thời gian phục vụ cho việc vẽ biểu đồ cột/đường, hỗ trợ bộ lọc linh hoạt
    function api_get_revenue() {
        // Gọi hàm thiết lập cấu hình Header API ở trên
        $this->setApiHeader();
        
        // Ưu tiên lọc theo khoảng ngày nếu có from/to
        // Kiểm tra và lấy ngày bắt đầu (from) từ tham số GET truyền lên, mặc định là chuỗi rỗng nếu không có
        $from = isset($_GET['from']) ? trim($_GET['from']) : '';
        // Kiểm tra và lấy ngày kết thúc (to) từ tham số GET truyền lên, mặc định là chuỗi rỗng nếu không có
        $to = isset($_GET['to']) ? trim($_GET['to']) : '';
        
        // Kiểm tra nếu có đủ tham số ngày và cả hai đều phải khớp chính xác định dạng chuẩn YYYY-MM-DD (qua biểu thức chính quy Regex)
        if (!empty($from) && !empty($to) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $from) && preg_match('/^\d{4}-\d{2}-\d{2}$/', $to)) {
            // Nếu ngày bắt đầu lớn hơn ngày kết thúc (người dùng chọn ngược), tiến hành hoán vị hai giá trị này cho nhau để tránh lỗi logic
            if (strtotime($from) > strtotime($to)) { 
                $tmp = $from; $from = $to; $to = $tmp; 
            }
            // Gọi hàm trong Model để lấy dữ liệu doanh thu chi tiết trong khoảng ngày đã được lọc hợp lệ
            $revenue_data = $this->ov->getRevenueRange($from, $to);
        } else {
            // Trường hợp không lọc theo khoảng ngày, kiểm tra tham số số ngày 'days' truyền lên, mặc định nếu không truyền là 7 ngày
            $days = isset($_GET['days']) ? intval($_GET['days']) : 7;
            // Gọi hàm trong Model để lấy dữ liệu doanh thu của số ngày gần nhất vừa thiết lập
            $revenue_data = $this->ov->getRevenueLast7Days($days);
        }
        
        // Khởi tạo hai mảng rỗng để bóc tách dữ liệu phục vụ riêng cho các trục của biểu đồ
        $labels = []; // Mảng chứa các nhãn thời gian hiển thị ở trục hoành (X)
        $values = []; // Mảng chứa các giá trị doanh thu tương ứng hiển thị ở trục tung (Y)
        
        // Vòng lặp duyệt qua mảng dữ liệu doanh thu với key là chuỗi ngày (YYYY-MM-DD) và value là số tiền doanh thu
        foreach ($revenue_data as $date => $revenue) {
            // Định dạng lại chuỗi ngày từ năm-tháng-ngày thành ngày/tháng (d/m) để hiển thị ngắn gọn, đẹp mắt trên biểu đồ
            $labels[] = date('d/m', strtotime($date));
            // Đẩy giá trị doanh thu của ngày đó vào mảng giá trị
            $values[] = $revenue;
        }
        
        // Chuyển đổi mảng nhãn và mảng giá trị thành chuỗi định dạng JSON và in ra màn hình để phản hồi về cho JavaScript xử lý vẽ đồ thị
        echo json_encode([
            'success' => true,
            'labels' => $labels,
            'values' => $values
        ]);
        // Dừng thực thi chương trình
        exit;
    }
}
?>