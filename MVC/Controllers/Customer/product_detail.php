<?php
// Định nghĩa lớp product_detail kế thừa từ lớp cơ sở controllers_customer trong phân hệ khách hàng
class product_detail extends controllers_customer {
    // Khai báo thuộc tính private để lưu thực thể Model xử lý thông tin chi tiết sản phẩm
    private $product_model;
    // Khai báo thuộc tính private để lưu thực thể Model xử lý danh mục hiển thị trên thanh menu chính
    private $menu_categories;
    
    // Hàm khởi tạo tự động chạy khi đối tượng product_detail được tạo ra
    function __construct() {
        
        // Khởi tạo đối tượng model 'product_detail_m' và gán vào thuộc tính $product_model để tương tác DB sản phẩm
        $this->product_model = $this->model("product_detail_m");
        // Khởi tạo đối tượng model 'master_customer_m' phục vụ việc hiển thị layout chung của trang khách hàng
        $this->menu_categories = $this->model('master_customer_m');
    }
    
    // Hàm xử lý luồng hiển thị giao diện trang chi tiết sản phẩm cho khách hàng
    function Get_data() {
        // Kiểm tra xem session của hệ thống đã được bật chưa, nếu chưa thì tiến hành khởi chạy session
        if (session_status() == PHP_SESSION_NONE) {
            session_start();
        }

        // Kiểm tra và lấy tham số đường dẫn thân thiện 'slug' từ URL qua phương thức GET, xóa khoảng trắng nếu có
        $slug = isset($_GET['slug']) ? trim($_GET['slug']) : '';
        
        // Validate Slug
        // Nếu tham số đường dẫn slug trống, tiến hành điều hướng người dùng quay trở về trang danh sách sản phẩm
        if(empty($slug)) {
            // Thực hiện chuyển hướng trình duyệt đến endpoint trang danh sách sản phẩm
            header('Location: /web_qlsp/product_list_customer');
            // Dừng ngay lập tức việc thực thi các dòng mã lệnh phía sau
            exit;
        }
        
        // Khởi tạo biến chứa thông tin người dùng đăng nhập mặc định ban đầu là null
        $user_info = null;
        // Kiểm tra xem phiên làm việc session có tồn tại mã định danh người dùng 'user_id' hay không
        if (isset($_SESSION['user_id'])) {
            // Gọi model 'profile_m' thực hiện truy vấn thông tin chi tiết của người dùng dựa theo ID lấy từ session
            $user_info = $this->model('profile_m')->user_getById($_SESSION['user_id']);
        }

        // Lấy sản phẩm chính
        // Gọi hàm từ model để lấy thông tin sản phẩm chính trong database thông qua chuỗi ký tự slug
        $product_rs = $this->product_model->product_selectBySlug($slug);
        
        // Kiểm tra kết quả truy vấn, nếu không có dữ liệu hoặc số dòng trả về từ DB bằng 0 thì xử lý lỗi
        if(!$product_rs || mysqli_num_rows($product_rs) == 0) {
            // Lưu thông báo lỗi vào bộ nhớ tạm session để hiển thị cho người dùng ở trang đích
            $_SESSION['error'] = 'Sản phẩm không tồn tại hoặc đã bị ẩn.';
            // Điều hướng người dùng quay lại giao diện danh sách sản phẩm do không tìm thấy sản phẩm yêu cầu
            header('Location: /web_qlsp/product_list_customer');
            // Dừng thực thi luồng chương trình
            exit;
        }
        
        // Chuyển đổi kết quả truy vấn thành một mảng kết hợp để dễ dàng bóc tách thông tin sản phẩm chính
        $product = mysqli_fetch_assoc($product_rs);
        // Lưu trữ mã ID của sản phẩm hiện tại vào biến $product_id để dùng cho các câu lệnh truy vấn con tiếp theo
        $product_id = $product['id'];

        // ==========================================
        // 1. LẤY BIẾN THỂ & ẢNH CHO SẢN PHẨM CHÍNH
        // ==========================================
        // Khởi tạo mảng lưu danh sách tất cả các màu sắc phân biệt của sản phẩm này
        $colors = [];
        // Khởi tạo mảng bản đồ ánh xạ cấu trúc chi tiết của các biến thể (size, kho hàng, ảnh) theo màu sắc
        $variant_map = [];
        // Khởi tạo mảng nhóm riêng danh sách các file ảnh tương ứng theo từng mã màu
        $color_images = [];
        // Khởi tạo mảng chứa toàn bộ các ảnh của tất cả các biến thể thuộc sản phẩm (không trùng lặp)
        $all_images = [];

        // Gọi model truy vấn toàn bộ các dòng biến thể (màu sắc, kích cỡ, kho) thuộc về ID sản phẩm chính này
        $variants_result = $this->product_model->get_variants_by_product($product_id);
        // Kiểm tra nếu kết quả trả về hợp lệ và số lượng dòng biến thể tìm thấy lớn hơn 0
        if($variants_result && mysqli_num_rows($variants_result) > 0){
            // Duyệt qua từng dòng dữ liệu biến thể của sản phẩm lấy từ DB lên
            while($v = mysqli_fetch_assoc($variants_result)){
                // Trích xuất thông tin tên màu sắc của biến thể hiện tại
                $color = $v['color'];
                // Nếu tên màu này chưa tồn tại trong mảng $colors tổng thì thêm tên màu đó vào mảng
                if(!in_array($color, $colors)) $colors[] = $color;
                
                // Gọi model truy vấn danh sách các hình ảnh chi tiết liên kết riêng với mã ID của biến thể này
                $imgs_res = $this->product_model->get_images_by_variant($v['id']);
                // Khởi tạo mảng chứa danh sách đường dẫn ảnh tạm thời của riêng biến thể đang xét
                $imgs = [];
                // Kiểm tra kết quả truy vấn ảnh biến thể nếu có dữ liệu dòng trả về lớn hơn 0
                if($imgs_res && mysqli_num_rows($imgs_res) > 0){
                    // Duyệt qua tập hợp kết quả để lấy ra từng đường dẫn URL của hình ảnh biến thể
                    while($img = mysqli_fetch_assoc($imgs_res)){
                        // Đẩy đường dẫn ảnh vào mảng lưu trữ tạm của biến thể
                        $imgs[] = $img['image_url'];
                    }
                }
                // Nếu biến thể không có ảnh riêng, tự động lấy ảnh đại diện (thumbnail) của sản phẩm chính làm ảnh thay thế
                if(empty($imgs)) $imgs[] = $product['thumbnail'];
                
                // Đóng gói thông tin biến thể (kích cỡ, mã biến thể, tập ảnh, số lượng kho) vào mảng ánh xạ theo key màu sắc
                $variant_map[$color][] = [ 
                    'size' => $v['size'], 
                    'variant_id' => $v['id'], 
                    'images' => $imgs, 
                    'stock' => (int)($v['stock'] ?? 0) // Ép kiểu số lượng tồn kho về dạng số nguyên, mặc định là 0 nếu trống
                ];

                // Nếu mảng nhóm ảnh theo màu này chưa được khởi tạo cho key màu hiện tại thì khởi tạo mảng rỗng
                if(!isset($color_images[$color])) $color_images[$color] = [];
                // Duyệt qua danh sách ảnh vừa tìm được của biến thể để phân loại đưa vào mảng tổng hợp
                foreach($imgs as $iu){
                    // Nếu ảnh chưa tồn tại trong nhóm ảnh của màu này thì tiến hành đẩy ảnh vào nhóm
                    if(!in_array($iu, $color_images[$color])) $color_images[$color][] = $iu;
                    // Nếu ảnh chưa tồn tại trong danh sách tất cả các ảnh của sản phẩm thì thêm vào để làm thư viện ảnh tổng
                    if(!in_array($iu, $all_images)) $all_images[] = $iu;
                }
            }
        }

        // ==========================================
        // 2. LẤY SẢN PHẨM LIÊN QUAN & BIẾN THỂ CỦA CHÚNG
        // ==========================================
        // Khởi tạo mảng chứa danh sách các sản phẩm liên quan (cùng danh mục) phục vụ hiển thị ở đáy trang
        $related_products = [];
        // Gọi model lấy danh sách các sản phẩm cùng nhóm danh mục loại trừ ID sản phẩm chính đang xem
        $related_rs = $this->product_model->products_selectRelated($product['category_id'], $product_id);
        
        // Kiểm tra nếu tồn tại danh sách kết quả trả về của các sản phẩm liên quan liên kết
        if($related_rs && mysqli_num_rows($related_rs) > 0){
            // Vòng lặp duyệt qua thông tin của từng sản phẩm liên quan tìm được
            while($rp = mysqli_fetch_assoc($related_rs)){
                // Khởi tạo mảng chứa danh sách các màu sắc của riêng sản phẩm liên quan đang xét
                $rp_colors = [];
                // Khởi tạo mảng bản đồ cấu trúc ánh xạ biến thể của riêng sản phẩm liên quan đang xét
                $rp_variant_map = [];
                
                // Gọi model truy vấn lấy toàn bộ các dòng biến thể thuộc về mã ID sản phẩm liên quan hiện tại
                $rp_vars = $this->product_model->get_variants_by_product($rp['id']);
                // Kiểm tra nếu sản phẩm liên quan này có tồn tại dữ liệu biến thể trong database
                if($rp_vars && mysqli_num_rows($rp_vars) > 0){
                    // Chạy vòng lặp duyệt qua từng dòng biến thể của sản phẩm liên quan
                    while($rv = mysqli_fetch_assoc($rp_vars)){
                        // Lấy ra tên màu sắc của biến thể sản phẩm liên quan
                        $c = $rv['color'];
                        // Xử lý gom nhóm: Nếu màu này chưa có trong danh sách màu của sản phẩm liên quan thì ghi nhận
                        if(!in_array($c, $rp_colors)){
                            // Đẩy tên màu vào mảng màu sắc của sản phẩm liên quan
                            $rp_colors[] = $c;
                            // Khởi tạo mảng tạm chứa các file hình ảnh cho màu sắc này của sản phẩm liên quan
                            $images = [];
                            // Gọi model truy vấn danh sách ảnh đính kèm theo mã ID biến thể của sản phẩm liên quan
                            $imgs_res = $this->product_model->get_images_by_variant($rv['id']);
                            // Kiểm tra nếu tìm thấy dữ liệu hình ảnh của biến thể sản phẩm liên quan
                            if($imgs_res && mysqli_num_rows($imgs_res) > 0){
                                // Duyệt qua tập hợp kết quả ảnh để lấy ra đường dẫn file hình ảnh cụ thể
                                while($img = mysqli_fetch_assoc($imgs_res)){
                                    // Đẩy đường dẫn ảnh vào mảng lưu trữ hình ảnh tạm thời
                                    $images[] = $img['image_url'];
                                }
                            }
                            // Nếu biến thể của sản phẩm liên quan không có ảnh riêng, lấy ảnh đại diện gốc của nó thay thế
                            if(empty($images)) $images[] = $rp['thumbnail'];
                            
                            // Thiết lập cấu hình mảng ánh xạ thông tin đại diện cho màu sắc đó của sản phẩm liên quan
                            $rp_variant_map[$c] = [
                                'variant_id' => $rv['id'], // Lưu ID biến thể đại diện đầu tiên của màu này
                                'images' => $images, // Lưu mảng hình ảnh tương ứng với màu sắc
                                // Sử dụng mã HEX màu thực tế nếu phương thức tồn tại trong Model, nếu không mặc định trả về mã màu xám '#ccc'
                                'hex' => method_exists($this->product_model, 'get_color_hex') ? $this->product_model->get_color_hex($c) : '#ccc'
                            ];
                        }
                    }
                }
                // Gán mảng danh sách màu sắc bóc tách được thành một thuộc tính động 'colors' nằm trong sản phẩm liên quan
                $rp['colors'] = $rp_colors;
                // Gán mảng bản đồ ánh xạ cấu trúc ảnh/biến thể thành thuộc tính động 'variant_map' trong sản phẩm liên quan
                $rp['variant_map'] = $rp_variant_map;
                // Đẩy toàn bộ thông tin sản phẩm liên quan đã được xử lý dữ liệu biến thể vào mảng tổng $related_products
                $related_products[] = $rp;
            }
        }

        // Tăng view
        // Thực hiện gọi hàm trong model để cập nhật tăng lượt xem (views) của sản phẩm chính lên 1 đơn vị trong DB
        $this->product_model->product_increaseViews($product_id);
        
        // Trả dữ liệu sạch sẽ về cho View
        // Gọi hàm hiển thị view 'Master_customer' từ lớp cha và truyền toàn bộ mảng dữ liệu đã xử lý sang giao diện
        $this->view('Master_customer', [
            'Page' => 'product_details_v', // Xác định file view nội dung chi tiết cần được nhúng vào Master layout
            'menu_categories' => $this->menu_categories->categories_selectAll(), // Truyền toàn bộ danh mục để render thanh menu điều hướng
            'product' => $product, // Truyền mảng dữ liệu thông tin chung của sản phẩm chính
            'colors' => $colors, // Truyền danh sách các màu sắc hiện có của sản phẩm chính
            'variant_map' => $variant_map, // Truyền cấu trúc mảng ánh xạ chi tiết các biến thể sản phẩm chính
            'color_images' => $color_images, // Truyền danh sách hình ảnh đã gom nhóm phân chia theo màu sắc
            'all_images' => $all_images, // Truyền mảng chứa tất cả các ảnh để làm slide trình chiếu tổng hợp
            'related_products' => $related_products, // Truyền danh sách các sản phẩm liên quan đã định dạng cấu trúc biến thể
            'product_model' => $this->product_model, // Truyền thực thể model sang view để hỗ trợ gọi hàm bổ trợ trực tiếp nếu cần
            'user_info' => $user_info // Truyền thông tin hồ sơ của người dùng đang đăng nhập hệ thống hiện tại
        ]);
    }
}
?>