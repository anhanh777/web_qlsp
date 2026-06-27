-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Máy chủ: 127.0.0.1
-- Thời gian đã tạo: Th6 17, 2026 lúc 04:51 PM
-- Phiên bản máy phục vụ: 10.4.32-MariaDB
-- Phiên bản PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Cơ sở dữ liệu: `quanao`
--

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `banners`
--

CREATE TABLE `banners` (
  `id` int(11) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `image_url` varchar(255) NOT NULL,
  `link_url` varchar(255) DEFAULT '#',
  `display_order` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `banners`
--

INSERT INTO `banners` (`id`, `title`, `image_url`, `link_url`, `display_order`, `status`, `created_at`) VALUES
(7, 'Thể Thao', '1768233299_ban2.avif', 'http://localhost/web_qlsp/product_list_customer?collection=do-the-thao', 2, 1, '2026-01-12 15:54:59'),
(8, 'Phong Cách', '1768233334_ban1.avif', 'http://localhost/web_qlsp/product_list_customer?collection=quan-ao-thu-dong', 1, 0, '2026-01-12 15:55:34');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `status` tinyint(4) DEFAULT 1,
  `thumbnail` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `categories`
--

INSERT INTO `categories` (`id`, `name`, `slug`, `status`, `thumbnail`) VALUES
(61, 'Áo Thun', 'ao-thun', 1, '1767798985_aoThunCat.jpg'),
(74, 'Áo Dài Tay', 'ao-dai-tay', 1, 'aodaitay.jpg'),
(75, 'Áo Khoác', 'ao-khoac', 1, 'aokhoac.jpg'),
(78, 'Quần Short', 'quan-short', 1, 'quanshort.jpg'),
(79, 'Áo Phao', 'ao-phao', 1, '1768050443_aophao.avif'),
(80, 'Quần Jean Nam', 'quan-jean-nam', 1, '1768211703_filter_jeans-hd-2.avif'),
(81, 'Quần Jogger Nam', 'quan-jogger-nam', 1, '1768227859_quan-ut-jogger-da-nang-co-gian-xanh-reu-3.avif'),
(82, 'Quần Kaki Nam', 'quan-kaki-nam', 1, '1768227963_quan-dai-nam-kaki-excool-xam-den_(4).avif');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `collections`
--

CREATE TABLE `collections` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `thumbnail` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1,
  `show_home` tinyint(4) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `collections`
--

INSERT INTO `collections` (`id`, `name`, `slug`, `thumbnail`, `status`, `show_home`) VALUES
(15, 'Quần Áo Mùa Hè', 'quan-ao-mua-he', '1768203416_download (24).jpg', 1, 0),
(16, 'Quần Áo Thu Đông', 'quan-ao-thu-dong', '1768204671_aokhoacthudong.avif', 1, 0),
(17, 'Đồ Thể Thao', 'do-the-thao', '1768204869_quan-short-chay-trail-wildflow-397-den.avif', 1, 0),
(19, 'Quần Dài Nam', 'quan-dai-nam', '1768227878_quan-dai-nam-kaki-excool-xam-den_(4).avif', 1, 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `districts`
--

CREATE TABLE `districts` (
  `code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `province_code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `districts`
--

INSERT INTO `districts` (`code`, `name`, `full_name`, `province_code`) VALUES
('001', 'Ba Đình', 'Quận Ba Đình', '01'),
('002', 'Hoàn Kiếm', 'Quận Hoàn Kiếm', '01'),
('003', 'Tây Hồ', 'Quận Tây Hồ', '01'),
('004', 'Long Biên', 'Quận Long Biên', '01'),
('005', 'Cầu Giấy', 'Quận Cầu Giấy', '01'),
('193', 'Hạ Long', 'Thành phố Hạ Long', '22'),
('194', 'Móng Cái', 'Thành phố Móng Cái', '22'),
('195', 'Cẩm Phả', 'Thành phố Cẩm Phả', '22'),
('196', 'Uông Bí', 'Thành phố Uông Bí', '22'),
('199', 'Đông Triều', 'Thị xã Đông Triều', '22'),
('303', 'Hồng Bàng', 'Quận Hồng Bàng', '31'),
('304', 'Ngô Quyền', 'Quận Ngô Quyền', '31'),
('305', 'Lê Chân', 'Quận Lê Chân', '31'),
('306', 'Hải An', 'Quận Hải An', '31'),
('307', 'Kiến An', 'Quận Kiến An', '31'),
('380', 'Thanh Hóa', 'Thành phố Thanh Hóa', '38'),
('381', 'Bỉm Sơn', 'Thị xã Bỉm Sơn', '38'),
('382', 'Sầm Sơn', 'Thành phố Sầm Sơn', '38'),
('384', 'Mường Lát', 'Huyện Mường Lát', '38'),
('385', 'Quan Hóa', 'Huyện Quan Hóa', '38'),
('412', 'Vinh', 'Thành phố Vinh', '40'),
('413', 'Cửa Lò', 'Thị xã Cửa Lò', '40'),
('414', 'Thái Hoà', 'Thị xã Thái Hoà', '40'),
('415', 'Quế Phong', 'Huyện Quế Phong', '40'),
('416', 'Quỳ Châu', 'Huyện Quỳ Châu', '40'),
('474', 'Huế', 'Thành phố Huế', '46'),
('476', 'Phong Điền', 'Huyện Phong Điền', '46'),
('477', 'Quảng Điền', 'Huyện Quảng Điền', '46'),
('478', 'Phú Vang', 'Huyện Phú Vang', '46'),
('479', 'Hương Thủy', 'Thị xã Hương Thủy', '46'),
('490', 'Liên Chiểu', 'Quận Liên Chiểu', '48'),
('491', 'Thanh Khê', 'Quận Thanh Khê', '48'),
('492', 'Hải Châu', 'Quận Hải Châu', '48'),
('493', 'Sơn Trà', 'Quận Sơn Trà', '48'),
('494', 'Ngũ Hành Sơn', 'Quận Ngũ Hành Sơn', '48'),
('568', 'Nha Trang', 'Thành phố Nha Trang', '56'),
('569', 'Cam Ranh', 'Thành phố Cam Ranh', '56'),
('570', 'Cam Lâm', 'Huyện Cam Lâm', '56'),
('571', 'Vạn Ninh', 'Huyện Vạn Ninh', '56'),
('572', 'Ninh Hòa', 'Thị xã Ninh Hòa', '56'),
('672', 'Đà Lạt', 'Thành phố Đà Lạt', '68'),
('673', 'Bảo Lộc', 'Thành phố Bảo Lộc', '68'),
('674', 'Đam Rông', 'Huyện Đam Rông', '68'),
('675', 'Lạc Dương', 'Huyện Lạc Dương', '68'),
('676', 'Lâm Hà', 'Huyện Lâm Hà', '68'),
('731', 'Biên Hòa', 'Thành phố Biên Hòa', '75'),
('732', 'Long Khánh', 'Thành phố Long Khánh', '75'),
('734', 'Tân Phú', 'Huyện Tân Phú', '75'),
('735', 'Vĩnh Cửu', 'Huyện Vĩnh Cửu', '75'),
('736', 'Định Quán', 'Huyện Định Quán', '75'),
('760', 'Quận 1', 'Quận 1', '79'),
('761', 'Quận 12', 'Quận 12', '79'),
('764', 'Gò Vấp', 'Quận Gò Vấp', '79'),
('765', 'Bình Thạnh', 'Quận Bình Thạnh', '79'),
('766', 'Tân Bình', 'Quận Tân Bình', '79'),
('916', 'Ninh Kiều', 'Quận Ninh Kiều', '92'),
('917', 'Ô Môn', 'Quận Ô Môn', '92'),
('918', 'Bình Thuỷ', 'Quận Bình Thuỷ', '92'),
('919', 'Cái Răng', 'Quận Cái Răng', '92'),
('923', 'Thốt Nốt', 'Quận Thốt Nốt', '92');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `home_sections`
--

CREATE TABLE `home_sections` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `section_type` enum('collection','flash_sale','promo_banner','category_grid','overlay_banner') DEFAULT NULL,
  `collection_id` int(11) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `link_url` varchar(255) DEFAULT NULL,
  `bg_color` varchar(50) DEFAULT '#ffffff',
  `text_color` varchar(50) DEFAULT '#000000',
  `end_time` datetime DEFAULT NULL,
  `display_order` int(11) DEFAULT 0,
  `status` tinyint(4) DEFAULT 1,
  `button_text` varchar(50) DEFAULT 'XEM NGAY',
  `text_position` enum('left','center','right') DEFAULT 'left'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `home_sections`
--

INSERT INTO `home_sections` (`id`, `title`, `section_type`, `collection_id`, `image_url`, `link_url`, `bg_color`, `text_color`, `end_time`, `display_order`, `status`, `button_text`, `text_position`) VALUES
(12, 'Danh Mục Sản Phẩm', 'category_grid', NULL, NULL, NULL, '#ffffff', '#000000', NULL, 2, 0, NULL, NULL),
(19, 'Quần Áo Thu Đông', 'collection', 16, NULL, NULL, '#ffffff', '#000000', NULL, 3, 1, NULL, NULL),
(20, 'Quần Áo Mùa Hè', 'collection', 15, NULL, NULL, '#ffffff', '#000000', NULL, 5, 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_phone` varchar(20) NOT NULL,
  `customer_email` varchar(100) DEFAULT NULL,
  `shipping_province` varchar(100) NOT NULL,
  `shipping_district` varchar(100) NOT NULL,
  `shipping_ward` varchar(100) NOT NULL,
  `shipping_address_detail` varchar(255) NOT NULL,
  `subtotal` decimal(12,0) NOT NULL,
  `shipping_fee` decimal(12,0) DEFAULT 0,
  `voucher_code` varchar(50) DEFAULT NULL,
  `discount_amount` decimal(12,0) DEFAULT 0,
  `points_used` int(11) DEFAULT 0,
  `points_discount` decimal(12,0) DEFAULT 0,
  `total_money` decimal(12,0) NOT NULL,
  `points_earned` int(11) DEFAULT 0,
  `payment_method` varchar(50) DEFAULT 'COD',
  `status` enum('pending','processing','shipped','completed','cancelled','confirmed','shipping') DEFAULT 'pending',
  `note` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `customer_name`, `customer_phone`, `customer_email`, `shipping_province`, `shipping_district`, `shipping_ward`, `shipping_address_detail`, `subtotal`, `shipping_fee`, `voucher_code`, `discount_amount`, `points_used`, `points_discount`, `total_money`, `points_earned`, `payment_method`, `status`, `note`, `created_at`) VALUES
(84, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 1590000, 30000, NULL, 0, 0, 0, 1620000, 1590, 'cod', 'completed', NULL, '2026-03-23 15:12:23'),
(85, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 425000, 30000, NULL, 0, 0, 0, 455000, 4, 'cod', 'pending', NULL, '2026-03-31 10:29:51'),
(86, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 1250000, 30000, NULL, 0, 0, 0, 1280000, 12, 'vnpay', 'completed', NULL, '2026-03-31 15:01:03'),
(88, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 370000, 30000, NULL, 0, 0, 0, 400000, 370, 'vnpay', 'completed', NULL, '2026-04-01 02:27:31'),
(89, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 299000, 30000, NULL, 0, 0, 0, 329000, 2, 'vnpay', 'pending', NULL, '2026-04-01 08:43:28'),
(90, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 898000, 0, NULL, 0, 0, 0, 898000, 8, 'cod', 'pending', NULL, '2026-04-02 06:54:56'),
(91, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 370000, 0, NULL, 0, 0, 0, 370000, 3, 'cod', 'confirmed', NULL, '2026-04-02 07:12:25'),
(92, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 350000, 30000, NULL, 0, 0, 0, 380000, 3, 'cod', 'pending', NULL, '2026-04-07 04:02:55'),
(93, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 740000, 30000, NULL, 0, 0, 0, 770000, 7, 'cod', 'pending', NULL, '2026-04-08 15:36:20'),
(94, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 350000, 30000, NULL, 0, 0, 0, 380000, 3, 'cod', 'completed', NULL, '2026-04-10 08:14:02'),
(95, 35, 'TRAN ANH', '098765432111', 'anh@gmail.com', '01', '005', '00157', 'Số 100', 350000, 30000, NULL, 0, 0, 0, 380000, 3, 'cod', 'completed', NULL, '2026-04-10 08:33:41'),
(96, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 350000, 30000, NULL, 0, 0, 0, 380000, 3, 'vnpay', 'pending', NULL, '2026-04-10 13:27:38'),
(97, 39, 'Nguyễn Thị Mỹ Phương', '093736362171', 'phuong@gmail.com', '46', '478', '19942', 'số 99', 250000, 30000, NULL, 0, 0, 0, 280000, 2, 'cod', 'completed', NULL, '2026-04-22 02:09:56'),
(98, 39, 'Nguyễn Thị Mỹ Phương', '093736362171', 'phuong@gmail.com', '46', '478', '19942', 'số 99', 350000, 30000, 'cnpm', 35000, 0, 0, 345000, 3, 'vnpay', 'pending', NULL, '2026-04-22 02:13:41'),
(99, 35, 'TRAN ANH', '098765432111', 'anh@gmail.com', '01', '005', '00157', 'Số 100', 740000, 30000, 'SALE30', 222000, 0, 0, 548000, 740, 'cod', 'completed', NULL, '2026-05-08 02:00:03'),
(100, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 370000, 30000, NULL, 0, 0, 0, 400000, 3, 'cod', 'completed', NULL, '2026-05-08 06:14:00'),
(101, 35, 'TRAN ANH', '098765432111', 'anh@gmail.com', '01', '005', '00157', 'Số 100', 598000, 30000, 'SALE30', 179400, 0, 0, 448600, 5, 'cod', 'completed', NULL, '2026-05-08 14:02:40'),
(102, 35, 'TRAN ANH', '098765432111', 'anh@gmail.com', '01', '005', '00157', 'Số 100', 325000, 30000, 'SALE30', 97500, 0, 0, 257500, 3, 'cod', 'pending', NULL, '2026-05-08 14:14:40'),
(104, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 713000, 30000, NULL, 0, 1960, 1960, 741040, 7, 'cod', 'completed', NULL, '2026-05-08 15:02:41'),
(105, 35, 'TRAN ANH', '098765432111', 'anh@gmail.com', '01', '005', '00157', 'Số 100', 675000, 30000, 'SALE30', 202500, 0, 0, 502500, 6, 'cod', 'completed', NULL, '2026-05-08 15:13:25'),
(106, 37, 'Nguyễn Hữu Giang', '087363535151', 'giang@gmail.com', '22', '195', '06676', 'số 100', 425000, 30000, 'SALE30', 127500, 700, 700, 326800, 4, 'cod', 'completed', 'ship nhanh nhé', '2026-05-09 13:49:40'),
(107, 35, 'TRAN ANH HUNTER', '098765432111', 'anh@gmail.com', '01', '005', '00157', 'Số 100', 425000, 30000, 'SALE30', 127500, 0, 0, 327500, 4, 'cod', 'cancelled', NULL, '2026-05-09 14:51:24');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `variant_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(12,0) NOT NULL,
  `size` varchar(20) DEFAULT NULL,
  `color` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `variant_id`, `quantity`, `price`, `size`, `color`) VALUES
(1, 84, 244, 369, 2, 370000, 'M', 'Xanh'),
(2, 84, 246, 371, 2, 425000, 'XL', 'Đen'),
(3, 85, 246, 371, 1, 425000, 'XL', 'Đen'),
(4, 86, 242, 347, 3, 250000, 'XS', 'Trắng'),
(5, 86, 235, 263, 2, 250000, 'XS', 'Trắng'),
(7, 88, 244, 369, 1, 370000, 'M', 'Xanh'),
(8, 89, 248, 373, 1, 299000, 'L', 'Cam'),
(9, 90, 235, 269, 2, 250000, 'XS', 'Xanh'),
(10, 90, 236, 275, 2, 199000, 'XS', 'Trắng'),
(11, 91, 244, 369, 1, 370000, 'M', 'Xanh'),
(12, 92, 245, 370, 1, 350000, 'L', 'Đỏ'),
(13, 93, 244, 369, 1, 370000, 'M', 'Xanh'),
(14, 93, 244, 378, 1, 370000, 'L', 'Xám'),
(15, 94, 245, 370, 1, 350000, 'L', 'Đỏ'),
(16, 95, 245, 370, 1, 350000, 'L', 'Đỏ'),
(17, 96, 245, 370, 1, 350000, 'L', 'Đỏ'),
(18, 97, 235, 274, 1, 250000, 'XXL', 'Xanh'),
(19, 98, 245, 370, 1, 350000, 'L', 'Đỏ'),
(20, 99, 244, 369, 1, 370000, 'M', 'Xanh'),
(21, 99, 244, 378, 1, 370000, 'L', 'Xám'),
(22, 100, 244, 369, 1, 370000, 'M', 'Xanh'),
(23, 101, 236, 275, 2, 199000, 'XS', 'Trắng'),
(24, 101, 240, 323, 1, 200000, 'XS', 'Trắng'),
(25, 102, 247, 372, 1, 325000, 'M', 'Đen'),
(27, 104, 268, 486, 1, 713000, 'XL', 'Đen'),
(28, 105, 245, 370, 1, 350000, 'L', 'Đỏ'),
(29, 105, 247, 372, 1, 325000, 'M', 'Đen'),
(30, 106, 246, 371, 1, 425000, 'XL', 'Đen'),
(31, 107, 246, 371, 1, 425000, 'XL', 'Đen');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `point_history`
--

CREATE TABLE `point_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `amount` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `category_id` int(11) DEFAULT NULL,
  `collection_id` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `base_price` decimal(12,0) NOT NULL,
  `is_sale` tinyint(1) NOT NULL,
  `gender` enum('nam','nu','unisex') DEFAULT 'nam',
  `thumbnail` varchar(255) DEFAULT NULL,
  `views` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `products`
--

INSERT INTO `products` (`id`, `category_id`, `collection_id`, `name`, `slug`, `description`, `base_price`, `is_sale`, `gender`, `thumbnail`, `views`, `created_at`) VALUES
(235, 61, 15, 'Áo thun nam Cotton Compact', 'ao-thun-nam-cotton-compact', 'Là item nền tảng trong tủ đồ của mọi chàng trai, Áo thun nam Cotton 220GSM Basics định nghĩa lại sự thoải mái và bền bỉ. Đây không chỉ là một chiếc áo thun nam thông thường, mà là một mảnh ghép thiết yếu trong bộ sưu tập áo nam, sẵn sàng cho mọi hoàn cảnh. Sản phẩm được dệt từ 100% sợi Cotton Úc cao cấp với định lượng 220gsm, tạo nên một chất vải dày dặn, đứng form nhưng vẫn vô cùng thoáng khí và mềm mại. Đặc biệt, đây là dòng sản phẩm \"Ready To Wear\", sản phẩm đã được xử lý giặt, sấy, ủi trước khi đến tay bạn, và bạn có thể sử dụng luôn khi vừa nhận hàng. Cảm giác chắc tay, mịn màng và khả năng thấm hút mồ hôi vượt trội biến chiếc áo này thành lựa chọn hoàn hảo cho mỗi ngày.', 250000, 0, 'nam', 'DataInput/1/ngoai/nguoiden.jpg', 9, '2026-01-12 09:24:03'),
(236, 61, 15, 'Áo mặc trong Essential Brush Poly cổ trung', 'ao-mac-trong-essential-brush-poly-co-trung', 'Là mảnh ghép hoàn hảo cho tủ đồ thu đông, Áo mặc trong Essential Brush Poly cổ trung định nghĩa lại sự thoải mái và phong cách cho lớp áo nền. Đây là một thiết kế áo dài tay nam đa năng, một item không thể thiếu trong bộ sưu tập áo nam của bạn. Sản phẩm được tạo nên từ chất liệu Brush Poly độc đáo với 92% polyester và 8% spandex. Bề mặt vải được chải mịn đặc biệt, tạo ra cảm giác mềm mại như bông khi tiếp xúc với da, đồng thời tăng cường khả năng giữ ấm. Polyester giúp áo thoáng khí, nhanh khô, trong khi spandex mang lại độ co giãn linh hoạt, cho bạn tự do vận động suốt ngày dài.', 199000, 1, 'nam', 'DataInput/2/ngoai/nguoiden.jpg', 5, '2026-01-12 09:24:03'),
(238, 74, 15, 'Áo thun dài tay 100% Cotton Relax fit', 'ao-thun-dai-tay-100-cotton-relax-fit', 'Áo thun dài tay 100% Cotton Relax fit là một item không thể thiếu trong tủ đồ Thu Đông, một mảnh ghép hoàn hảo cho phong cách tối giản và năng động. Đây là chiếc áo dài tay nam nền tảng, dễ dàng kết hợp trong nhiều bản phối khác nhau, đồng thời là sự bổ sung chất lượng cho bộ sưu tập áo thun nam của bạn. Được chế tác hoàn toàn từ chất liệu 100% vải cotton, chiếc áo mang đến sự mềm mại tuyệt đối ngay từ lần chạm đầu tiên. Ưu điểm của chất liệu này là khả năng thấm hút mồ hôi vượt trội và thoáng khí, giúp bạn luôn cảm thấy khô ráo, dễ chịu. Với sự ưu tiên về chất liệu, đây không chỉ là một chiếc áo thun cotton thông thường, mà còn là một lựa chọn đa năng và cần thiết trong danh mục áo nam hàng ngày.', 250000, 1, 'nam', 'DataInput/4/ngoai/nguoiden.jpg', 4, '2026-01-12 09:24:03'),
(239, 61, 15, 'T-shirt thể thao nam FlexLine Active V-neck', 't-shirt-the-thao-nam-flexline-active-v-neck', 'Bứt phá giới hạn trong mọi buổi tập với T-shirt thể thao nam FlexLine Active V-neck, một sản phẩm được thiết kế để trở thành chiếc áo thể thao nam hiệu suất cao trong tủ đồ của bạn. Áo được dệt từ sự kết hợp thông minh giữa 51% Recycled Polyester và 49% vải Polyester, tạo nên một chất liệu siêu nhẹ và bền bỉ. Điểm nổi bật của chiếc áo thun nam này là công nghệ Ex-Dry độc quyền, giúp tối ưu khả năng thấm hút mồ hôi và nhanh khô vượt trội, mang lại cảm giác thoáng mát, khô ráo ngay cả khi vận động cường độ cao. Đây không chỉ là một lựa chọn tuyệt vời cho việc luyện tập mà còn là một item không thể thiếu trong bộ sưu tập áo nam hàng ngày của những người yêu thích sự năng động.', 199000, 1, 'nam', 'DataInput/5/ngoai/nguoiden.jpg', 3, '2026-01-12 09:24:03'),
(240, 61, 15, 'Áo thun nam mặc trong thoáng khí nhanh khô Excool', 'ao-thun-nam-mac-trong-thoang-khi-nhanh-kho-excool', 'Là một thiết kế không thể thiếu trong tủ đồ nam chuyên vận động, Áo dài tay thể thao Logo Active Slim mang đến phong cách mạnh mẽ và hiệu suất vượt trội. Nằm trong bộ sưu tập đồ thể thao nam mới nhất, chiếc áo dài tay nam này được sinh ra để ôm sát cơ thể, hỗ trợ tối đa cho mọi chuyển động. Với chất liệu 100% polyester và kiểu dệt Knit-Interlock, áo có bề mặt vải mịn, co giãn tốt. Công nghệ Ex-Dry giúp thấm hút mồ hôi nhanh chóng, giữ cho cơ thể luôn khô ráo và thoải mái.', 200000, 1, 'nam', 'DataInput/6/ngoai/nguoiden.jpg', 7, '2026-01-12 09:24:03'),
(242, 61, 15, 'Áo thun chạy bộ nam Ventra Gradient', 'ao-thun-chay-bo-nam-ventra-gradient', 'Chinh phục mọi cự ly với áo thun chạy bộ nam Ventra Gradient, một thiết kế đồ thể thao nam đột phá dành riêng cho các runner. Điểm nhấn thị giác mạnh mẽ từ hiệu ứng chuyển màu gradient không chỉ giúp bạn nổi bật mà còn thể hiện tinh thần thể thao không ngừng tiến về phía trước. Nền tảng của hiệu suất vượt trội đến từ chất liệu 100% vải polyester, kết hợp cùng công nghệ Ex-Dry độc quyền. Công nghệ này hoạt động như một hệ thống thoát ẩm thông minh, nhanh chóng kéo mồ hôi ra khỏi bề mặt da và đẩy nhanh quá trình bay hơi, giữ cho cơ thể bạn luôn khô ráo. Cảm giác khi mặc chiếc áo chạy bộ là sự siêu nhẹ, mát mẻ và hoàn toàn không bết dính, giúp bạn tập trung tối đa vào từng sải chân. Đây là mảnh ghép đồ nam hoàn hảo để nâng tầm bộ trang phục quần áo chạy bộ của bạn.', 250000, 0, 'nam', 'DataInput/8/ngoai/nguoiden.jpg', 6, '2026-01-12 09:24:03'),
(244, 79, 16, 'Áo phao nhẹ Ultrawarm - Outlet', 'ao-phao-nhe-ultrawarm-outlet', 'Là một item không thể thiếu trong tủ đồ Thu Đông, Áo phao nhẹ Ultrawarm chính là giải pháp giữ ấm thông minh và gọn nhẹ cho mọi hoạt động của bạn. Đây không chỉ là một chiếc áo khoác nam thông thường mà còn là một item đa năng, dễ dàng nâng tầm phong cách cho bộ sưu tập áo nam của bạn. Sản phẩm ứng dụng công nghệ Ex-Warm độc quyền, với lớp vỏ ngoài làm từ 100% chất liệu vải polyamide, mang lại khả năng chống gió và trượt nước nhẹ. Bên trong là lớp lót bông nhân tạo siêu nhẹ, có cấu trúc giữ nhiệt cơ thể hiệu quả trong điều kiện thời tiết lạnh mà không gây cảm giác cồng kềnh, nặng nề.', 370000, 0, 'nam', 'DataInput/10/ngoai/nguoiden.jpg', 31, '2026-01-12 09:52:55'),
(245, 75, 16, 'Áo nỉ nam All-day Hoodie', 'ao-ni-nam-all-day-hoodie', 'Là một item không thể thiếu trong tủ đồ thu đông, Áo nỉ nam All-day Hoodie mang đến sự thoải mái và phong cách cho mọi hoạt động hàng ngày. Đây là một thiết kế áo khoác nam đa năng, một mảnh ghép hoàn hảo cho tủ đồ nam của bạn. Sản phẩm là sự kết hợp thông minh giữa 66% Cotton và 34% Recycled Polyester. Chất liệu Cotton mang lại khả năng thấm hút tốt và thoáng khí, trong khi Polyester tái chế giúp áo bền màu, giữ form và thể hiện tinh thần thời trang bền vững. Bề mặt vải mềm mại, ấm áp, định nghĩa lại trải nghiệm thoải mái của một chiếc áo hoodie.', 350000, 1, 'nam', 'DataInput/11/ngoai/nguoiden.jpg', 83, '2026-01-12 09:52:55'),
(246, 75, 16, 'Áo Hoodie thể thao nam Vital Active', 'ao-hoodie-the-thao-nam-vital-active', 'Nằm trong bộ sưu tập đồ nam thiết yếu, chiếc Áo Hoodie Vital Active là một item đa năng cho tủ đồ thu đông, vượt qua giới hạn của một chiếc áo khoác nam thông thường. Đây là mẫu áo Hoodie được tạo ra để mang lại sự thoải mái tối đa, dù bạn đang tập luyện hay trong các hoạt động hàng ngày. Sự ưu việt đến từ cấu trúc dệt Double Knit độc đáo: mặt trong là sợi Cotton mềm mại, thoáng khí, trong khi mặt ngoài là Polyester giúp tăng cường khả năng thấm hút ẩm và giữ form áo bền bỉ. Sự kết hợp cùng 5% Spandex mang lại độ co giãn tuyệt vời, cho bạn cảm giác tự do trong từng cử động.', 425000, 1, 'nam', 'DataInput/12/ngoai/nguoireu.jpg', 12, '2026-01-12 09:52:55'),
(247, 75, 16, 'Áo Khoác Nam có mũ Daily Wear', 'ao-khoac-nam-co-mu-daily-wear', 'Áo Khoác Nam có mũ Daily Wear là người bạn đồng hành không thể thiếu trong tủ đồ thể thao, một chiếc áo khoác nam đa năng được thiết kế để bảo vệ bạn trước mọi điều kiện thời tiết thất thường. Sản phẩm được dệt hoàn toàn từ 100% vải polyester, mang đến trọng lượng siêu nhẹ và bề mặt vải mịn mượt, giúp bạn luôn cảm thấy thoải mái khi vận động. Điểm vượt trội của chiếc áo thể thao nam này nằm ở khả năng bảo vệ toàn diện: công nghệ chống tia UV đến 99% giúp ngăn chặn tác hại của ánh nắng mặt trời, trong khi lớp phủ chống thấm nước và nhanh khô đảm bảo bạn luôn khô ráo trong những cơn mưa bất chợt. Đây thực sự là một trong những chiếc áo nam tiện ích nhất, kết hợp hoàn hảo giữa công nghệ và thời trang ứng dụng. Bên cạnh đó, áo còn được ứng dụng công nghệ hiện đại HEIQ VIROBLOCK. Đặc biệt, vải áo được xử lý bằng công nghệ Water Repellent theo tiêu chuẩn AATCC 22-2005, duy trì hiệu quả trượt nước ưu việt lên đến 30 lần giặt, giúp bạn tự tin đối mặt với thời tiết ẩm ướt.', 325000, 0, 'nam', 'DataInput/13/ngoai/nguoitrang.jpg', 4, '2026-01-12 09:52:55'),
(248, 75, 16, 'Áo khoác thể thao Windbreaker Ripstop', 'ao-khoac-the-thao-windbreaker-ripstop', 'Đối mặt với thời tiết thất thường một cách đầy phong cách cùng Áo khoác thể thao Windbreaker Ripstop. Đây là một chiếc áo khoác nam không thể thiếu, được thiết kế chuyên dụng cho những người yêu vận động và luôn dịch chuyển. Sản phẩm này không chỉ là một chiếc áo thể thao nam thông thường, mà còn là một lớp bảo vệ toàn diện, một mảnh ghép hoàn hảo cho tủ đồ áo nam của bạn. Chất liệu 100% từ vải Polyamide được dệt theo cấu trúc Ripstop đặc biệt, tạo thành một bề mặt bền chắc, có khả năng chống sờn rách, cản gió, trượt nước nhẹ và mang lại cảm giác siêu nhẹ, thoáng khí, giúp bạn luôn thoải mái trong mọi hoạt động, từ đó nâng tầm trải nghiệm bộ sưu tập đồ thể thao nam của mình.', 299000, 1, 'nam', 'DataInput/14/ngoai/nguoixanh.jpg', 4, '2026-01-12 09:52:55'),
(249, 75, 16, 'Áo khoác WindBreaker Nylon Taslan', 'ao-khoac-windbreaker-nylon-taslan', 'Nâng cấp phong cách hàng ngày của bạn với chiếc Áo khoác WindBreaker Nylon Taslan, một item không thể thiếu trong bộ sưu tập áo khoác nam đa dụng. Đây là sự lựa chọn hoàn hảo cho mọi chàng trai, kết hợp giữa tính năng và thời trang, dễ dàng trở thành chiếc áo nam yêu thích của bạn. Sản phẩm được chế tác từ 100% vải Polyamide cao cấp, một loại vật liệu nổi bật với các đặc tính ưu việt. Nhờ vào cấu trúc sợi Taslan, chiếc áo thể thao nam này không chỉ có khả năng cản gió và trượt nước hiệu quả, bảo vệ bạn trước những cơn mưa phùn bất chợt, mà còn cực kỳ bền bỉ và giữ form dáng tốt sau nhiều lần giặt. Cảm giác khi mặc rất nhẹ và thoáng mát, không gây bí bách, mang lại sự thoải mái tối đa dù bạn đang di chuyển hay vận động.', 354000, 1, 'nam', 'DataInput/15/ngoai/nguoidenxanh.jpg', 6, '2026-01-12 09:52:55'),
(250, 79, 16, 'Áo phao dày Ultrawarm Puffer có mũ II', 'ao-phao-day-ultrawarm-puffer-co-mu-ii', 'Là trang bị thiết yếu trong tủ đồ nam mỗi khi gió về, Áo Phao Dày Ultrawarm Puffer Có Mũ II là một \"pháo đài\" di động, bảo vệ bạn một cách toàn diện. Đây không chỉ là một chiếc áo khoác nam thông thường, mà là mảnh ghép chủ lực trong bộ sưu tập đồ thu đông, được thiết kế để đối mặt với những cơn gió lạnh nhất. Mẫu áo phao này được trang bị lớp lót chần bông công nghệ Ex-warm dày dặn, cùng lớp vỏ 100% Polyester có khả năng chống gió và trượt nước, mang lại sự ấm áp tối đa mà vẫn giữ được nét gọn gàng, nhẹ tênh.', 790000, 0, 'nam', 'DataInput/16/ngoai/nguoixanh.jpg', 5, '2026-01-12 09:52:55'),
(251, 79, 16, 'Áo Phao Dày Ultrawarm Puffer Gile II', 'ao-phao-day-ultrawarm-puffer-gile-ii', 'Là một item không thể thiếu trong tủ đồ nam khi mùa đông đến, Áo Phao Dày Ultrawarm Puffer Gile II là sự kết hợp hoàn hảo giữa khả năng giữ ấm vượt trội và phong cách linh hoạt. Đây không chỉ là một chiếc áo khoác nam thông thường, mà là một mảnh ghép thiết yếu của bộ sưu tập đồ thu đông, giúp bạn luôn tự tin trong mọi hoạt động. Mẫu áo phao này sử dụng lớp lót chần bông công nghệ Ex-warm dày dặn, cùng bề mặt 100% Polyester có khả năng chống gió và trượt nước hiệu quả, mang lại cảm giác ấm áp mà vẫn siêu nhẹ, không hề cồng kềnh.', 590000, 1, 'nam', 'DataInput/17/ngoai/nguoixam.jpg', 11, '2026-01-12 09:52:55'),
(252, 79, 16, 'Áo phao dày Ultrawarm Puffer', 'ao-phao-day-ultrawarm-puffer', 'Chào mùa đông với chiếc Áo phao dày Ultrawarm Puffer - giải pháp giữ ấm toàn diện và thiết yếu trong mọi tủ đồ quần áo thể thao. Đây là một sự bổ sung không thể thiếu cho bộ sưu tập áo khoác nam của bạn, và là một lựa chọn hàng đầu trong các dòng áo nam khi trời trở lạnh. Sản phẩm được chế tác từ 100% sợi sorona, một loại sợi nhân tạo từ vải polyester, không chỉ mang lại bề mặt trượt nước, chống bẩn hiệu quả mà còn có độ bền màu cực cao. Bên trong là lớp bông dày dặn được ứng dụng công nghệ Ex-Warm tiên tiến, giúp hấp thụ và giữ nhiệt tối ưu, đảm bảo bạn luôn cảm thấy ấm áp. Dù có khả năng giữ ấm vượt trội, chiếc áo vẫn siêu nhẹ và thoải mái, mang lại cảm giác dễ chịu khi mặc, không hề nặng nề hay cồng kềnh. Chiếc áo phao này sẽ là một phần quan trọng trong tủ quần áo thu đông của bạn.', 809000, 1, 'nam', 'DataInput/18/ngoai/nguoireu.jpg', 6, '2026-01-12 09:52:55'),
(253, 78, 17, 'Short thể thao Promax Sideflow', 'short-the-thao-promax-sideflow', 'Là một thiết kế đột phá trong tủ đồ nam, Short thể thao Promax Sideflow được tạo ra để giải phóng dòng chảy năng lượng của bạn. Đây không chỉ là một chiếc quần short nam thông thường, đây là một trang bị hiệu suất cao trong bộ sưu tập đồ thể thao nam Promax. Sản phẩm được dệt từ 100% sợi Polyester với cấu trúc dệt Promesh độc đáo, tích hợp công nghệ ExDry, mang đến một chiếc quần thể thao nam vừa thoáng khí vượt trội, vừa nhanh khô tức thì.', 299000, 0, 'nam', 'DataInput/19/ngoai/nguoiden.jpg', 2, '2026-01-12 14:18:48'),
(254, 78, 17, 'Quần shorts Pickleball Smashshot Essentials', 'quan-shorts-pickleball-smashshot-essentials', 'Chinh phục sân đấu với Quần shorts Pickleball Smashshot Essentials, một thiết kế được tạo ra để đáp ứng mọi nhu cầu của người chơi Pickleball và Tennis hiện đại. Đây không chỉ là một chiếc quần short nam chuyên dụng, Smashshot Essentials còn là một lựa chọn đa năng, nâng tầm cho bộ sưu tập đồ thể thao và quần áo pickleball nam của bạn. Mẫu quần pickleball nam này được dệt từ sự kết hợp tối ưu của 90% Nylon siêu nhẹ và 10% vải Spandex mang lại khả năng co giãn 4 chiều vượt trội. Công nghệ ExDry kết hợp cùng cấu trúc dệt mini-eyelet tạo ra hàng ngàn lỗ thoáng khí siêu nhỏ, giúp thấm hút mồ hôi và làm khô nhanh chóng. Điều này đảm bảo bạn luôn cảm thấy nhẹ tênh, khô thoáng và hoàn toàn tự do trong từng pha di chuyển tốc độ cao, từ những cú smash mạnh mẽ đến các pha cứu bóng quyết định.', 329000, 1, 'nam', 'DataInput/20/ngoai/nguoiden.jpg', 3, '2026-01-12 14:18:48'),
(255, 78, 17, 'Quần Shorts Chạy Bộ 2 lớp Fast & Free III', 'quan-shorts-chay-bo-2-lop-fast-free-iii', 'Được tạo ra cho những runner không ngừng tiến về phía trước, Quần Shorts Chạy Bộ 2 lớp Fast & Free III là một bước tiến về công nghệ và hiệu suất. Lớp quần ngoài được dệt theo kiểu Woven Plain từ sự kết hợp giữa vải Polyester và 55% Vải Recycle Polyester, mang lại bề mặt mềm mịn, trọng lượng siêu nhẹ và góp phần vào thời trang bền vững. Lớp lót bên trong là sự pha trộn giữa Recycle Polyester và 14% vải Spandex, tạo nên sự ôm sát vừa vặn, nâng đỡ cơ bắp và co giãn 4 chiều linh hoạt. Công nghệ Ex-Dry hoạt động mạnh mẽ trên cả hai lớp vải, giúp thấm hút mồ hôi tức thì và đẩy nhanh quá trình khô thoáng, mang đến cảm giác hoàn toàn tự do và tập trung trên mọi dặm đường.', 359000, 1, 'nam', 'DataInput/21/ngoai/nguoiden.jpg', 3, '2026-01-12 14:18:48'),
(256, 78, 17, 'Shorts thể thao nam Promax FlexLine Active', 'shorts-the-thao-nam-promax-flexline-active', 'Nâng tầm trải nghiệm vận động của bạn với Quần Shorts thể thao nam Promax FlexLine Active - một sản phẩm không thể thiếu trong bộ sưu tập đồ thể thao của phái mạnh. Được chế tác từ chất liệu 100% Polyester, chiếc quần này sở hữu những ưu điểm vượt trội như trọng lượng siêu nhẹ, độ bền cao và khả năng co giãn tự nhiên. Bề mặt vải Promesh được dệt kim theo cấu trúc mắt lưới zigzag độc đáo, tạo ra hàng ngàn lỗ thoáng khí, giúp không khí lưu thông tối đa và giữ cho bạn luôn khô ráo. Đặc biệt, sản phẩm được tích hợp công nghệ Ex-Dry, một trong những tính năng thấm hút vượt trội của Coolmate, giúp thấm hút mồ hôi và bay hơi cực nhanh. Mỗi chuyển động đều trở nên nhẹ nhàng, thoải mái, biến nó thành lựa chọn hoàn hảo trong tủ đồ quần nam của mọi chàng trai năng động.', 219000, 0, 'nam', 'DataInput/22/ngoai/nguoiden.jpg', 3, '2026-01-12 14:18:48'),
(257, 78, 17, 'Quần shorts nam chạy bộ CoolFast 5 inch', 'quan-shorts-nam-chay-bo-coolfast-5-inch', 'Quần shorts nam chạy bộ CoolFast 5 inch nằm trong BST Quần áo chạy bộ nam mang đến trải nghiệm chạy bộ đỉnh cao với công nghệ Ex-Dry, giúp sản phẩm siêu nhẹ, nhanh khô, thoáng khí và thấm hút mồ hổi hiệu quả. Chất liệu Polyester pha Spandex siêu nhẹ, siêu bền, kết hợp với công nghệ Tapered (không đường may) mang lại cảm giác mỏng nhẹ, hạn chế ma sát tối đa, giúp bạn thoải mái chinh phục mọi quãng đường.', 314000, 0, 'nam', 'DataInput/23/ngoai/nguoiden.jpg', 2, '2026-01-12 14:18:48'),
(258, 78, 15, 'Quần Shorts Nam Kaki Excool', 'quan-shorts-nam-kaki-excool', 'Quần Shorts Nam Kaki Excool là sự kết hợp hoàn hảo giữa phong cách và công nghệ, mang đến trải nghiệm thoải mái tối ưu. Chất liệu từ sợi Sorona thân thiện với môi trường, kết hợp 57% Polyester và 43% Sorona, tạo nên vải siêu nhẹ, nhanh khô, thấm hút tốt và đặc biệt có khả năng chống tia UV SPF 50+. Với kiểu dáng Kaki hiện đại, chiếc quần này là lựa chọn đa năng cho mọi hoạt động.', 379000, 1, 'nam', 'DataInput/24/ngoai/nguoiden.jpg', 1, '2026-01-12 14:18:48'),
(259, 82, 19, 'Quần shorts ECC Ripstop', 'quan-shorts-ecc-ripstop', 'Được thiết kế với triết lý tối giản và năng động, Quần shorts ECC Ripstop là một mảnh ghép không thể thiếu trong tủ đồ hàng ngày của phái mạnh. Đây là một trong những mẫu quần short nam đa dụng nhất, dễ dàng đồng hành cùng bạn từ không gian thoải mái tại nhà đến những buổi dạo phố hay cà phê cuối tuần. Điểm nhấn làm nên sự khác biệt của sản phẩm chính là chất liệu vải Ripstop với kỹ thuật dệt đặc biệt, tạo ra độ bền vượt trội và khả năng chống xé rách hiệu quả. Bề mặt vải còn được xử lý để có khả năng trượt nước nhẹ, hạn chế bám bẩn và co giãn 4 chiều linh hoạt. Cảm giác khi mặc là sự nhẹ nhàng, thoáng khí và tự do trong từng chuyển động, giúp bạn luôn tự tin và thoải mái suốt cả ngày.', 219000, 1, 'nam', 'DataInput/25/ngoai/nguoiden.jpg', 0, '2026-01-12 14:18:48'),
(260, 80, 16, 'Quần Jeans Nam Basics dáng Straight', 'quan-jeans-nam-basics-dang-straight', 'Là một item kinh điển không thể thiếu, Quần Jeans Nam Basics dáng Straight chính là định nghĩa hoàn hảo cho phong cách vừa cá tính, vừa thoải mái. Quần được làm từ chất liệu vải denim dày dặn, đứng phom nhưng vẫn đảm bảo sự dễ chịu tối đa khi vận động. Điểm nhấn công nghệ đặc biệt của sản phẩm chính là kỹ thuật Laser Marking tiên tiến, sử dụng tia laser để tạo ra các hiệu ứng vệt sờn và râu mèo một cách chuẩn xác, tự nhiên. Công nghệ này không chỉ giúp bề mặt quần có chiều sâu độc đáo mà còn thân thiện hơn với môi trường so với các phương pháp truyền thống. Khoác lên mình chiếc quần này, bạn sẽ cảm nhận ngay sự tự tin, phóng khoáng và một vẻ ngoài bền bỉ với thời gian, sẵn sàng cho mọi hoạt động thường ngày.', 250000, 0, 'nam', 'DataInput/26/ngoai/nguoiden.jpg', 1, '2026-01-12 14:18:48'),
(261, 80, 19, 'Quần Jeans Nam Basics dáng Slim fit', 'quan-jeans-nam-basics-dang-slim-fit', 'Quần Jeans Nam Basics là mảnh ghép không thể thiếu trong tủ đồ của mọi chàng trai hiện đại, một item nền tảng cho sự tự tin và năng động suốt cả ngày. Chiếc quần được chế tác từ chất liệu vải denim cao cấp với thành phần 98% Cotton kết hợp 2% vải Spandex độc đáo. Sự kết hợp này mang lại bề mặt vải mềm mại, thoáng khí của Cotton nhưng vẫn đảm bảo độ co giãn tuyệt vời, giúp bạn thoải mái trong mọi cử động. Đặc biệt, Coolmate ứng dụng công nghệ Laser Marking tiên tiến để tạo ra các hiệu ứng mài (wash), râu mèo một cách tự nhiên và tinh tế, đồng thời giúp sản phẩm bền màu hơn. Cảm giác khi mặc là sự ôm vừa vặn, tôn dáng nhưng không hề gò bó, cho bạn sự linh hoạt tối đa dù đang làm việc hay dạo phố.', 448000, 1, 'nam', 'DataInput/27/ngoai/nguoiden.jpg', 1, '2026-01-12 14:18:48'),
(262, 81, 19, 'Quần dài nam Daily Pants', 'quan-dai-nam-daily-pants', 'Quần dài nam Daily Pants là sự lựa chọn hoàn hảo cho cuộc sống năng động, mang đến sự thoải mái và linh hoạt tối đa. Sản phẩm là sự kết hợp công nghệ giữa 53% Polyester và 47% Polyester Sorona, tạo nên chiếc quần lý tưởng cho mọi hoạt động và dễ dàng phối cùng đồ thể thao. Trong khi Polyester đảm bảo độ bền cao, chống nhăn và giữ phom dáng hiệu quả, thì sợi Sorona (sản xuất một phần từ ngô) mang đến những đặc tính vượt trội: siêu nhẹ, co giãn đàn hồi, thấm hút nhanh và thân thiện với môi trường.', 269000, 0, 'nam', 'DataInput/28/ngoai/nguoiden.jpg', 1, '2026-01-12 14:18:48'),
(263, 82, 19, 'Quần Dài Nam Kaki Excool dáng Straight', 'quan-dai-nam-kaki-excool-dang-straight', 'Nâng tầm phong cách hàng ngày với Quần dài nam Kaki Excool, sự kết hợp hoàn hảo giữa vẻ ngoài thanh lịch của một chiếc quần kaki nam và sự thoải mái của một chiếc quần công nghệ. Sản phẩm được dệt từ sự pha trộn độc đáo giữa 50% Polyester và 50% sợi Sorona có nguồn gốc thực vật, tạo nên một chất liệu vải mềm mịn, thoáng mát và thân thiện với làn da. Đặc biệt, sợi Sorona mang lại khả năng chống tia UV tự nhiên lên đến SPF 50+, bảo vệ bạn khỏi ánh nắng mặt trời. Với khả năng co giãn nhẹ, thấm hút tốt và giữ form dáng, đây là chiếc quần dài nam lý tưởng, một item không thể thiếu trong tủ đồ quần nam của mọi quý ông hiện đại.', 399000, 0, 'nam', 'DataInput/29/ngoai/nguoiden.jpg', 0, '2026-01-12 14:18:48'),
(264, 81, 19, 'Quần Jogger thể thao nam Vital Active', 'quan-jogger-the-thao-nam-vital-active', 'Là một item không thể thiếu trong tủ đồ nam, chiếc quần jogger nam Vital Active này định nghĩa lại sự thoải mái và đa năng, là sự nâng cấp đáng giá cho bộ sưu tập quần nam của bạn. Sự ưu việt đến từ cấu trúc dệt Double Knit độc đáo: mặt trong là 55% Cotton tạo cảm giác mềm mại tự nhiên, trong khi mặt ngoài là 40% Polyester hỗ trợ hút ẩm và giữ form quần bền bỉ. Hoàn thiện với 5% Spandex, chiếc quần mang lại độ co giãn tuyệt vời, giúp bạn tự do trong mọi chuyển động.', 499000, 0, 'nam', 'DataInput/30/ngoai/nguoiden.jpg', 0, '2026-01-12 14:18:48'),
(265, 82, 19, 'Quần Dài Nam Kaki Excool', 'quan-dai-nam-kaki-excool', 'Định nghĩa lại sự thoải mái cho trang phục hàng ngày, Quần Dài Nam Kaki Excool là lựa chọn hoàn hảo cho quý ông hiện đại. Là một sản phẩm nổi bật trong bộ sưu tập quần kaki nam của Coolmate, chiếc quần này được dệt từ chất liệu đột phá với tỷ lệ cân bằng 50% Polyester và 50% sợi Sorona. Sợi Sorona có nguồn gốc thực vật không chỉ thân thiện với môi trường mà còn mang đến những tính năng ưu việt: co giãn tự nhiên, đàn hồi giữ form, siêu nhẹ và đặc biệt là khả năng chống tia UV đến SPF 50+. Sự kết hợp cùng Polyester cao cấp giúp quần thêm bền bỉ, nhanh khô và chống nhăn hiệu quả. Cảm giác khi mặc là sự mềm mại, thoáng mát và co giãn nhẹ theo từng cử động, giúp bạn luôn tự tin và thoải mái dù ở văn phòng hay khi xuống phố.', 499000, 1, 'nam', '1768232503_nguoixanh.jpg', 5, '2026-01-12 15:38:14'),
(266, 81, 19, 'Quần Dài Nam UT Pants V2', 'quan-dai-nam-ut-pants-v2', 'Phiên bản UT Pants V2 là một bản nâng cấp toàn diện, một chiếc quần dài nam đa năng được sinh ra để đối mặt với mọi thử thách của cuộc sống năng động. Điểm khác biệt cốt lõi đến từ chất liệu vải Polyamide Taslan, dày dặn và bền bỉ hơn hẳn so với phiên bản trước, mang lại sự an tâm khi tham gia các hoạt động ngoài trời. Chất vải này còn sở hữu khả năng co giãn 4 chiều và thoáng khí vượt trội, đảm bảo sự thoải mái trong từng cử động. Đặc biệt, công nghệ trượt nước C6 tiên tiến giúp quần kháng nước nhẹ hiệu quả, dễ dàng đối phó với những cơn mưa bất chợt hay những sự cố đổ nước không mong muốn. Cảm giác khi mặc là sự kết hợp giữa bền bỉ, linh hoạt và luôn sẵn sàng cho mọi hành trình.', 690000, 1, 'nam', 'DataInput/46/ngoai/nguoiden.jpg', 0, '2026-01-12 15:38:14'),
(267, 82, 19, 'Quần dài kaki ECC Pants', 'quan-dai-kaki-ecc-pants', 'Quần dài kaki ECC Pants từ Coolmate được thiết kế để mang đến trải nghiệm thoải mái tối đa và sự linh hoạt vượt trội cho mọi hoạt động của bạn và là item không thể thiếu trong tủ quần áo thu đông của bạn. Điểm cốt lõi tạo nên sự khác biệt của chiếc quần này là sự kết hợp thông minh của 58% Cotton, 29% Nylon (Polyamide) và 13% Spandex. ', 529000, 1, 'nam', 'DataInput/47/ngoai/nguoiden.jpg', 1, '2026-01-12 15:38:14'),
(268, 81, 19, 'Quần Dài Nam Tháo Ống UT Pants 2 in 1', 'quan-dai-nam-thao-ong-ut-pants-2-in-1', 'Quần Dài UT Pants 2 in 1 là định nghĩa mới về sự đa năng, một item không thể thiếu cho những tín đồ ưa dịch chuyển và khám phá. Đây không chỉ là một chiếc quần dài nam hay quần short nam đơn thuần, mà là sự kết hợp 2 trong 1 đầy thông minh, sẵn sàng nâng cấp tủ đồ thể thao và bộ sưu tập quần nam của bạn. Chất liệu quần là sự pha trộn giữa 89% Polyamide và 11% Spandex co giãn 4 chiều. Bề mặt vải được dệt theo kiểu Woven-Taslan và xử lý bằng công nghệ trượt nước Water Repellent C6, giúp bạn luôn khô ráo trước những cơn mưa nhẹ và tự tin trong mọi điều kiện thời tiết.', 713000, 1, 'nam', 'DataInput/48/ngoai/nguoiden.jpg', 7, '2026-01-12 15:38:14');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_images`
--

CREATE TABLE `product_images` (
  `id` int(11) NOT NULL,
  `variant_id` int(11) NOT NULL,
  `image_url` varchar(255) NOT NULL,
  `is_thumbnail` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_images`
--

INSERT INTO `product_images` (`id`, `variant_id`, `image_url`, `is_thumbnail`) VALUES
(348, 252, 'DataInput/1/ngoai/nguoiden.jpg', 1),
(356, 260, 'DataInput/1/trong/nau(1).jpg', 1),
(357, 261, 'DataInput/1/trong/nau(2).jpg', 1),
(358, 262, 'DataInput/1/trong/nau(1).jpg', 1),
(359, 263, 'DataInput/1/trong/xam1.jpg', 1),
(360, 264, 'DataInput/1/trong/xam1.jpg', 1),
(361, 265, 'DataInput/1/trong/xam1.jpg', 1),
(362, 266, 'DataInput/1/trong/xam1.jpg', 1),
(363, 267, 'DataInput/1/trong/xam1.jpg', 1),
(364, 268, 'DataInput/1/trong/xam1.jpg', 1),
(365, 269, 'DataInput/1/trong/xanh1.jpg', 1),
(366, 270, 'DataInput/1/trong/xanh1.jpg', 1),
(367, 271, 'DataInput/1/trong/xanh1.jpg', 1),
(368, 272, 'DataInput/1/trong/xanh1.jpg', 1),
(369, 273, 'DataInput/1/trong/xanh1.jpg', 1),
(370, 274, 'DataInput/1/trong/xanh1.jpg', 1),
(371, 275, 'DataInput/2/trong/xam1.jpg', 1),
(372, 276, 'DataInput/2/trong/xam1.jpg', 1),
(373, 277, 'DataInput/2/trong/xam1.jpg', 1),
(374, 278, 'DataInput/2/trong/xam1.jpg', 1),
(375, 279, 'DataInput/2/trong/xam1.jpg', 1),
(376, 280, 'DataInput/2/trong/xam1.jpg', 1),
(377, 281, 'DataInput/2/trong/den2.jpg', 1),
(378, 282, 'DataInput/2/trong/den2.jpg', 1),
(379, 283, 'DataInput/2/trong/den2.jpg', 1),
(380, 284, 'DataInput/2/trong/den2.jpg', 1),
(381, 285, 'DataInput/2/trong/den2.jpg', 1),
(382, 286, 'DataInput/2/trong/den2.jpg', 1),
(395, 299, 'DataInput/4/trong/trang1.jpg', 1),
(396, 300, 'DataInput/4/trong/trang1.jpg', 1),
(397, 301, 'DataInput/4/trong/trang1.jpg', 1),
(398, 302, 'DataInput/4/trong/trang1.jpg', 1),
(399, 303, 'DataInput/4/trong/trang1.jpg', 1),
(400, 304, 'DataInput/4/trong/trang1.jpg', 1),
(401, 305, 'DataInput/4/trong/den1.jpg', 1),
(402, 306, 'DataInput/4/trong/den1.jpg', 1),
(403, 307, 'DataInput/4/trong/den1.jpg', 1),
(404, 308, 'DataInput/4/trong/den1.jpg', 1),
(405, 309, 'DataInput/4/trong/den1.jpg', 1),
(406, 310, 'DataInput/4/trong/den1.jpg', 1),
(407, 311, 'DataInput/5/trong/xam1.jpg', 1),
(408, 312, 'DataInput/5/trong/xam1.jpg', 1),
(409, 313, 'DataInput/5/trong/xam1.jpg', 1),
(410, 314, 'DataInput/5/trong/xam1.jpg', 1),
(411, 315, 'DataInput/5/trong/xam1.jpg', 1),
(412, 316, 'DataInput/5/trong/xam1.jpg', 1),
(413, 317, 'DataInput/5/trong/den1.jpg', 1),
(414, 318, 'DataInput/5/trong/den1.jpg', 1),
(415, 319, 'DataInput/5/trong/den1.jpg', 1),
(416, 320, 'DataInput/5/trong/den1.jpg', 1),
(417, 321, 'DataInput/5/trong/den1.jpg', 1),
(418, 322, 'DataInput/5/trong/den1.jpg', 1),
(419, 323, 'DataInput/6/trong/trang1.jpg', 1),
(420, 324, 'DataInput/6/trong/trang1.jpg', 1),
(421, 325, 'DataInput/6/trong/trang1.jpg', 1),
(422, 326, 'DataInput/6/trong/trang1.jpg', 1),
(423, 327, 'DataInput/6/trong/trang1.jpg', 1),
(424, 328, 'DataInput/6/trong/trang1.jpg', 1),
(425, 329, 'DataInput/6/trong/den1.jpg', 1),
(426, 330, 'DataInput/6/trong/den1.jpg', 1),
(427, 331, 'DataInput/6/trong/den1.jpg', 1),
(428, 332, 'DataInput/6/trong/den1.jpg', 1),
(429, 333, 'DataInput/6/trong/den1.jpg', 1),
(430, 334, 'DataInput/6/trong/den1.jpg', 1),
(443, 347, 'DataInput/8/trong/trang2.jpg', 1),
(444, 348, 'DataInput/8/trong/trang2.jpg', 1),
(445, 349, 'DataInput/8/trong/trang2.jpg', 1),
(446, 350, 'DataInput/8/trong/trang2.jpg', 1),
(447, 351, 'DataInput/8/trong/trang2.jpg', 1),
(448, 352, 'DataInput/8/trong/trang2.jpg', 1),
(449, 353, 'DataInput/8/trong/den3.jpg', 1),
(450, 354, 'DataInput/8/trong/den3.jpg', 1),
(451, 355, 'DataInput/8/trong/den3.jpg', 1),
(452, 356, 'DataInput/8/trong/den3.jpg', 1),
(453, 357, 'DataInput/8/trong/den3.jpg', 1),
(454, 358, 'DataInput/8/trong/den3.jpg', 1),
(494, 398, 'DataInput/30/ngoai/nguoiden.jpg', 1),
(495, 399, 'DataInput/19/trong/trang1.jpg', 1),
(496, 400, 'DataInput/19/trong/den1.jpg', 1),
(497, 401, 'DataInput/19/trong/trang1.jpg', 1),
(498, 402, 'DataInput/19/trong/den1.jpg', 1),
(499, 403, 'DataInput/19/trong/trang1.jpg', 1),
(500, 404, 'DataInput/19/trong/den1.jpg', 1),
(501, 405, 'DataInput/20/trong/trang1.jpg', 1),
(502, 406, 'DataInput/20/trong/den1.jpg', 1),
(503, 407, 'DataInput/20/trong/trang1.jpg', 1),
(504, 408, 'DataInput/20/trong/den1.jpg', 1),
(505, 409, 'DataInput/20/trong/trang1.jpg', 1),
(506, 410, 'DataInput/20/trong/den1.jpg', 1),
(507, 411, 'DataInput/21/trong/xam1.jpg', 1),
(508, 412, 'DataInput/21/trong/den1.jpg', 1),
(509, 413, 'DataInput/21/trong/xam1.jpg', 1),
(510, 414, 'DataInput/21/trong/den1.jpg', 1),
(511, 415, 'DataInput/21/trong/xam1.jpg', 1),
(512, 416, 'DataInput/21/trong/den1.jpg', 1),
(513, 417, 'DataInput/22/trong/xanh1.jpg', 1),
(514, 418, 'DataInput/22/trong/den1.jpg', 1),
(515, 419, 'DataInput/22/trong/xanh1.jpg', 1),
(516, 420, 'DataInput/22/trong/den1.jpg', 1),
(517, 421, 'DataInput/22/trong/xanh1.jpg', 1),
(518, 422, 'DataInput/22/trong/den1.jpg', 1),
(519, 423, 'DataInput/23/trong/xanh1.jpg', 1),
(520, 424, 'DataInput/23/trong/den1.jpg', 1),
(521, 425, 'DataInput/23/trong/xanh1.jpg', 1),
(522, 426, 'DataInput/23/trong/den1.jpg', 1),
(523, 427, 'DataInput/23/trong/xanh1.jpg', 1),
(524, 428, 'DataInput/23/trong/den1.jpg', 1),
(525, 429, 'DataInput/24/trong/xam1.jpg', 1),
(526, 430, 'DataInput/24/trong/den1.jpg', 1),
(527, 431, 'DataInput/24/trong/xam1.jpg', 1),
(528, 432, 'DataInput/24/trong/den1.jpg', 1),
(529, 433, 'DataInput/24/trong/xam1.jpg', 1),
(530, 434, 'DataInput/24/trong/den1.jpg', 1),
(531, 435, 'DataInput/25/trong/xam1.jpg', 1),
(532, 436, 'DataInput/25/trong/den1.jpg', 1),
(533, 437, 'DataInput/25/trong/xam1.jpg', 1),
(534, 438, 'DataInput/25/trong/den1.jpg', 1),
(535, 439, 'DataInput/25/trong/xam1.jpg', 1),
(536, 440, 'DataInput/25/trong/den1.jpg', 1),
(537, 441, 'DataInput/26/trong/xanh1.jpg', 1),
(538, 442, 'DataInput/26/trong/den1.jpg', 1),
(539, 443, 'DataInput/26/trong/xanh1.jpg', 1),
(540, 444, 'DataInput/26/trong/den1.jpg', 1),
(541, 445, 'DataInput/26/trong/xanh1.jpg', 1),
(542, 446, 'DataInput/26/trong/den1.jpg', 1),
(543, 447, 'DataInput/27/trong/xanh1.jpg', 1),
(544, 448, 'DataInput/27/trong/den1.jpg', 1),
(545, 449, 'DataInput/27/trong/xanh1.jpg', 1),
(546, 450, 'DataInput/27/trong/den1.jpg', 1),
(547, 451, 'DataInput/27/trong/xanh1.jpg', 1),
(548, 452, 'DataInput/27/trong/den1.jpg', 1),
(549, 453, 'DataInput/28/trong/xanh1.jpg', 1),
(550, 454, 'DataInput/28/trong/den1.jpg', 1),
(551, 455, 'DataInput/28/trong/xanh1.jpg', 1),
(552, 456, 'DataInput/28/trong/den1.jpg', 1),
(553, 457, 'DataInput/28/trong/xanh1.jpg', 1),
(554, 458, 'DataInput/28/trong/den1.jpg', 1),
(555, 459, 'DataInput/29/trong/xam1.jpg', 1),
(556, 460, 'DataInput/29/trong/den1.jpg', 1),
(557, 461, 'DataInput/29/trong/xam1.jpg', 1),
(558, 462, 'DataInput/29/trong/den1.jpg', 1),
(559, 463, 'DataInput/29/trong/xam1.jpg', 1),
(560, 464, 'DataInput/29/trong/den1.jpg', 1),
(561, 465, 'DataInput/30/trong/be1.jpg', 1),
(562, 466, 'DataInput/30/trong/den1.jpg', 1),
(563, 467, 'DataInput/30/trong/be1.jpg', 1),
(564, 468, 'DataInput/30/trong/den1.jpg', 1),
(565, 469, 'DataInput/30/trong/be1.jpg', 1),
(566, 470, 'DataInput/30/trong/den1.jpg', 1),
(567, 372, '1768228220_0_den1.jpg', 0),
(568, 372, '1768228220_1_den2.jpg', 0),
(569, 381, '1768228243_0_xanh1.jpg', 0),
(570, 381, '1768228243_1_xanh2.jpg', 0),
(571, 376, '1768228291_0_den1.jpg', 0),
(572, 376, '1768228291_1_den2.jpg', 0),
(573, 385, '1768228313_0_xam1.jpg', 0),
(574, 385, '1768228313_1_xam2.jpg', 0),
(575, 385, '1768228313_2_xam3.jpg', 0),
(578, 386, '1768228944_0_xam1.jpg', 0),
(579, 386, '1768228944_1_xam2.jpg', 0),
(580, 377, '1768229097_0_reu1.jpg', 0),
(581, 377, '1768229097_1_reu2.jpg', 0),
(582, 375, '1768229182_0_xam1.jpg', 0),
(583, 375, '1768229182_1_xam2.jpg', 0),
(584, 375, '1768229182_2_xam3.jpg', 0),
(585, 384, '1768229202_0_xanh1.jpg', 0),
(586, 384, '1768229202_1_xanh2.jpg', 0),
(587, 384, '1768229202_2_xanh3.jpg', 0),
(588, 369, '1768229241_0_xanh1.jpg', 0),
(589, 369, '1768229241_1_xanh2.jpg', 0),
(590, 369, '1768229241_2_xanh3.jpg', 0),
(591, 378, '1768229253_0_xam1.jpg', 0),
(592, 378, '1768229253_1_xam3.jpg', 0),
(593, 374, '1768229310_0_xamtrang1.jpg', 0),
(594, 374, '1768229310_1_xamtrang2.jpg', 0),
(595, 374, '1768229310_2_xamtrang3.jpg', 0),
(596, 383, '1768229321_0_navyden1.jpg', 0),
(597, 383, '1768229321_1_navyden2.jpg', 0),
(598, 383, '1768229321_2_navyden3.jpg', 0),
(599, 373, '1768229556_0_cam1.jpg', 0),
(600, 373, '1768229556_1_cam2.jpg', 0),
(601, 373, '1768229556_2_cam3.jpg', 0),
(602, 382, '1768229574_0_xam1.jpg', 0),
(603, 382, '1768229574_1_xam2.jpg', 0),
(604, 382, '1768229574_2_xam3.jpg', 0),
(605, 371, '1768229674_0_den1.jpg', 0),
(606, 371, '1768229674_1_den2.jpg', 0),
(607, 371, '1768229674_2_den3.jpg', 0),
(608, 380, '1768229682_0_reu1.jpg', 0),
(609, 380, '1768229682_1_reu2.jpg', 0),
(610, 380, '1768229682_2_reu3.jpg', 0),
(611, 370, '1768229879_0_do1.jpg', 0),
(612, 370, '1768229879_1_do2.jpg', 0),
(613, 370, '1768229879_2_do3.jpg', 0),
(614, 379, '1768229913_0_trang1.jpg', 0),
(615, 379, '1768229913_1_trang2.jpg', 0),
(616, 379, '1768229913_2_trang3.jpg', 0),
(621, 475, 'DataInput/45/trong/xam1.jpg', 1),
(622, 476, 'DataInput/45/trong/xanh1.jpg', 1),
(623, 477, 'DataInput/45/trong/xanh1.jpg', 1),
(624, 478, 'DataInput/46/trong/den1.jpg', 1),
(625, 479, 'DataInput/46/trong/den1.jpg', 1),
(626, 480, 'DataInput/46/trong/xam1.jpg', 1),
(627, 481, 'DataInput/46/trong/xam1.jpg', 1),
(628, 482, 'DataInput/47/trong/den1.jpg', 1),
(629, 483, 'DataInput/46/trong/den1.jpg', 1),
(632, 486, 'DataInput/47/trong/den1.jpg', 1),
(633, 487, 'DataInput/47/trong/den1.jpg', 1),
(634, 488, 'DataInput/47/trong/den2.jpg', 1),
(635, 489, 'DataInput/47/trong/den2.jpg', 1),
(636, 490, 'DataInput/49/trong/den1.jpg', 1),
(637, 491, 'DataInput/49/trong/den1.jpg', 1),
(638, 492, 'DataInput/49/trong/xam1.jpg', 1),
(639, 493, 'DataInput/49/trong/xam1.jpg', 1),
(666, 484, '1768295349_0_xam1.jpg', 0),
(667, 485, '1768295372_0_xam1.jpg', 0);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `product_variants`
--

CREATE TABLE `product_variants` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `size` varchar(50) NOT NULL,
  `color` varchar(50) NOT NULL,
  `input_price` decimal(12,0) DEFAULT NULL,
  `stock` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `product_variants`
--

INSERT INTO `product_variants` (`id`, `product_id`, `size`, `color`, `input_price`, `stock`) VALUES
(252, 235, 'XS', 'Đen', 175000, 0),
(260, 235, 'M', 'Nâu', 120000, 50),
(261, 235, 'L', 'Nâu', 140000, 30),
(262, 235, 'XL', 'Nâu', 150000, 40),
(263, 235, 'XS', 'Trắng', 120000, 48),
(264, 235, 'S', 'Trắng', 125000, 50),
(265, 235, 'M', 'Trắng', 130000, 50),
(266, 235, 'L', 'Trắng', 135000, 50),
(267, 235, 'XL', 'Trắng', 140000, 50),
(268, 235, 'XXL', 'Trắng', 145000, 50),
(269, 235, 'XS', 'Xanh', 120000, 48),
(270, 235, 'S', 'Xanh', 125000, 50),
(271, 235, 'M', 'Xanh', 130000, 50),
(272, 235, 'L', 'Xanh', 135000, 50),
(273, 235, 'XL', 'Xanh', 140000, 50),
(274, 235, 'XXL', 'Xanh', 145000, 49),
(275, 236, 'XS', 'Trắng', 120000, 46),
(276, 236, 'S', 'Trắng', 125000, 50),
(277, 236, 'M', 'Trắng', 130000, 50),
(278, 236, 'L', 'Trắng', 135000, 50),
(279, 236, 'XL', 'Trắng', 140000, 50),
(280, 236, 'XXL', 'Trắng', 145000, 50),
(281, 236, 'XS', 'Đen', 120000, 50),
(282, 236, 'S', 'Đen', 125000, 50),
(283, 236, 'M', 'Đen', 130000, 50),
(284, 236, 'L', 'Đen', 135000, 50),
(285, 236, 'XL', 'Đen', 140000, 50),
(286, 236, 'XXL', 'Đen', 145000, 50),
(299, 238, 'XS', 'Trắng', 120000, 51),
(300, 238, 'S', 'Trắng', 125000, 48),
(301, 238, 'M', 'Trắng', 130000, 50),
(302, 238, 'L', 'Trắng', 135000, 50),
(303, 238, 'XL', 'Trắng', 140000, 50),
(304, 238, 'XXL', 'Trắng', 145000, 50),
(305, 238, 'XS', 'Đen', 120000, 48),
(306, 238, 'S', 'Đen', 125000, 50),
(307, 238, 'M', 'Đen', 130000, 50),
(308, 238, 'L', 'Đen', 135000, 50),
(309, 238, 'XL', 'Đen', 140000, 50),
(310, 238, 'XXL', 'Đen', 145000, 50),
(311, 239, 'XS', 'Trắng', 120000, 50),
(312, 239, 'S', 'Trắng', 125000, 50),
(313, 239, 'M', 'Trắng', 130000, 50),
(314, 239, 'L', 'Trắng', 135000, 50),
(315, 239, 'XL', 'Trắng', 140000, 50),
(316, 239, 'XXL', 'Trắng', 145000, 50),
(317, 239, 'XS', 'Đen', 120000, 50),
(318, 239, 'S', 'Đen', 125000, 50),
(319, 239, 'M', 'Đen', 130000, 50),
(320, 239, 'L', 'Đen', 135000, 50),
(321, 239, 'XL', 'Đen', 140000, 50),
(322, 239, 'XXL', 'Đen', 145000, 50),
(323, 240, 'XS', 'Trắng', 120000, 49),
(324, 240, 'S', 'Trắng', 125000, 50),
(325, 240, 'M', 'Trắng', 130000, 50),
(326, 240, 'L', 'Trắng', 135000, 50),
(327, 240, 'XL', 'Trắng', 140000, 50),
(328, 240, 'XXL', 'Trắng', 145000, 50),
(329, 240, 'XS', 'Đen', 120000, 48),
(330, 240, 'S', 'Đen', 125000, 50),
(331, 240, 'M', 'Đen', 130000, 50),
(332, 240, 'L', 'Đen', 135000, 49),
(333, 240, 'XL', 'Đen', 140000, 50),
(334, 240, 'XXL', 'Đen', 145000, 50),
(347, 242, 'XS', 'Trắng', 120000, 43),
(348, 242, 'S', 'Trắng', 125000, 50),
(349, 242, 'M', 'Trắng', 130000, 50),
(350, 242, 'L', 'Trắng', 135000, 50),
(351, 242, 'XL', 'Trắng', 140000, 50),
(352, 242, 'XXL', 'Trắng', 145000, 50),
(353, 242, 'XS', 'Đen', 120000, 50),
(354, 242, 'S', 'Đen', 125000, 50),
(355, 242, 'M', 'Đen', 130000, 50),
(356, 242, 'L', 'Đen', 135000, 50),
(357, 242, 'XL', 'Đen', 140000, 50),
(358, 242, 'XXL', 'Đen', 145000, 50),
(369, 244, 'M', 'Xanh', 200000, 38),
(370, 245, 'L', 'Đỏ', 200000, 20),
(371, 246, 'XL', 'Đen', 200000, 25),
(372, 247, 'M', 'Đen', 200000, 47),
(373, 248, 'L', 'Cam', 200000, 39),
(374, 249, 'S', 'Trắng', 200000, 50),
(375, 250, 'M', 'Xám', 200000, 60),
(376, 251, 'L', 'Đen', 200000, 48),
(377, 252, 'XL', 'Đen', 200000, 39),
(378, 244, 'L', 'Xám', 200000, 47),
(379, 245, 'XL', 'Trắng', 200000, 57),
(380, 246, 'M', 'Vàng', 200000, 28),
(381, 247, 'S', 'Xanh', 200000, 39),
(382, 248, 'XL', 'Xám', 200000, 40),
(383, 249, 'XL', 'Đen', 200000, 50),
(384, 250, 'L', 'Xanh', 200000, 60),
(385, 251, 'XL', 'Xám', 200000, 40),
(386, 252, 'M', 'Xám', 200000, 49),
(398, 264, 'XS', 'Đen', 349300, 0),
(399, 253, 'XS', 'Trắng', 150000, 10),
(400, 253, 'XS', 'Đen', 150000, 10),
(401, 253, 'XS', 'Trắng', 150000, 10),
(402, 253, 'L', 'Đen', 150000, 10),
(403, 253, 'XL', 'Trắng', 150000, 10),
(404, 253, 'XL', 'Đen', 150000, 10),
(405, 254, 'XS', 'Trắng', 150000, 7),
(406, 254, 'XS', 'Đen', 150000, 10),
(407, 254, 'XS', 'Trắng', 150000, 10),
(408, 254, 'L', 'Đen', 150000, 10),
(409, 254, 'XL', 'Trắng', 150000, 10),
(410, 254, 'XL', 'Đen', 150000, 10),
(411, 255, 'XS', 'Xám', 150000, 5),
(412, 255, 'M', 'Đen', 150000, 10),
(413, 255, 'L', 'Xám', 150000, 10),
(414, 255, 'L', 'Đen', 150000, 10),
(415, 255, 'XL', 'Xám', 150000, 10),
(416, 255, 'XL', 'Đen', 150000, 10),
(417, 256, 'XS', 'Xanh', 150000, 9),
(418, 256, 'XS', 'Xanh', 150000, 10),
(419, 256, 'L', 'Xanh', 150000, 7),
(420, 256, 'M', 'Xanh', 150000, 10),
(421, 256, 'XL', 'Xanh', 150000, 10),
(422, 256, 'S', 'Xanh', 150000, 10),
(423, 257, 'XS', 'Xanh', 150000, 10),
(424, 257, 'XS', 'Đen', 150000, 10),
(425, 257, 'L', 'Xanh', 150000, 10),
(426, 257, 'L', 'Đen', 150000, 10),
(427, 257, 'XXL', 'Xanh', 150000, 10),
(428, 257, 'XL', 'Đen', 150000, 10),
(429, 258, 'XS', 'Đen', 150000, 10),
(430, 258, 'M', 'Đen', 150000, 10),
(431, 258, 'M', 'Xám', 150000, 10),
(432, 258, 'XL', 'Đen', 150000, 10),
(433, 258, 'XL', 'Xám', 150000, 10),
(434, 258, 'XXL', 'Đen', 150000, 10),
(435, 259, 'XS', 'Xám', 150000, 10),
(436, 259, 'XS', 'Đen', 150000, 10),
(437, 259, 'L', 'Xám', 150000, 10),
(438, 259, 'L', 'Đen', 150000, 10),
(439, 259, 'XXL', 'Xám', 150000, 10),
(440, 259, 'XL', 'Đen', 150000, 10),
(441, 260, 'XS', 'Xanh', 150000, 10),
(442, 260, 'XS', 'Đen', 150000, 10),
(443, 260, 'L', 'Xanh', 150000, 10),
(444, 260, 'L', 'Đen', 150000, 10),
(445, 260, 'XL', 'Xanh', 150000, 10),
(446, 260, 'XL', 'Đen', 150000, 10),
(447, 261, 'XS', 'Đen', 150000, 9),
(448, 261, 'M', 'Đen', 150000, 10),
(449, 261, 'XS', 'Xanh', 150000, 10),
(450, 261, 'XL', 'Đen', 150000, 10),
(451, 261, 'XL', 'Xanh', 150000, 10),
(452, 261, 'S', 'Đen', 150000, 10),
(453, 262, 'XS', 'Đen', 150000, 10),
(454, 262, 'S', 'Đen', 150000, 9),
(455, 262, 'XS', 'Đen', 150000, 10),
(456, 262, 'XS', 'Đen', 150000, 10),
(457, 262, 'XS', 'Đen', 150000, 10),
(458, 262, 'XS', 'Đen', 150000, 10),
(459, 263, 'XS', 'Đen', 150000, 10),
(460, 263, 'XS', 'Đen', 150000, 10),
(461, 263, 'XS', 'Đen', 150000, 10),
(462, 263, 'XS', 'Đen', 150000, 10),
(463, 263, 'XS', 'Đen', 150000, 10),
(464, 263, 'XS', 'Đen', 150000, 10),
(465, 264, 'XS', 'Đen', 150000, 10),
(466, 264, 'XS', 'Đen', 150000, 10),
(467, 264, 'XS', 'Đen', 150000, 10),
(468, 264, 'XS', 'Đen', 150000, 10),
(469, 264, 'XS', 'Đen', 150000, 10),
(470, 264, 'XS', 'Đen', 150000, 10),
(475, 265, 'XXL', 'Xám', 200000, 50),
(476, 265, 'XL', 'Xanh', 200000, 50),
(477, 265, 'XXL', 'Xanh', 200000, 50),
(478, 266, 'XL', 'Đen', 180000, 50),
(479, 266, 'XXL', 'Đen', 180000, 50),
(480, 266, 'XL', 'Xám', 180000, 50),
(481, 266, 'XXL', 'Xám', 180000, 50),
(482, 267, 'XL', 'Đen', 220000, 49),
(483, 267, 'XXL', 'Đen', 220000, 50),
(484, 267, 'XL', 'Xám', 220000, 50),
(485, 267, 'XXL', 'Xám', 220000, 50),
(486, 268, 'XL', 'Đen', 200000, 48),
(487, 268, 'XXL', 'Đen', 200000, 50),
(488, 268, 'XL', 'Xám', 200000, 50),
(489, 268, 'XXL', 'Xám', 200000, 50),
(490, 263, 'XL', 'Đen', 190000, 50),
(491, 263, 'XXL', 'Đen', 190000, 50),
(492, 263, 'XL', 'Xám', 190000, 50),
(493, 263, 'XXL', 'Xám', 190000, 50);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `provinces`
--

CREATE TABLE `provinces` (
  `code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `provinces`
--

INSERT INTO `provinces` (`code`, `name`, `full_name`) VALUES
('01', 'Hà Nội', 'Thành phố Hà Nội'),
('22', 'Quảng Ninh', 'Tỉnh Quảng Ninh'),
('31', 'Hải Phòng', 'Thành phố Hải Phòng'),
('38', 'Thanh Hóa', 'Tỉnh Thanh Hóa'),
('40', 'Nghệ An', 'Tỉnh Nghệ An'),
('46', 'Thừa Thiên Huế', 'Tỉnh Thừa Thiên Huế'),
('48', 'Đà Nẵng', 'Thành phố Đà Nẵng'),
('56', 'Khánh Hòa', 'Tỉnh Khánh Hòa'),
('68', 'Lâm Đồng', 'Tỉnh Lâm Đồng'),
('75', 'Đồng Nai', 'Tỉnh Đồng Nai'),
('79', 'Hồ Chí Minh', 'Thành phố Hồ Chí Minh'),
('92', 'Cần Thơ', 'Thành phố Cần Thơ');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `rating` int(11) DEFAULT 5,
  `comment` text DEFAULT NULL,
  `review_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `status` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `reviews`
--

INSERT INTO `reviews` (`id`, `user_id`, `product_id`, `order_id`, `rating`, `comment`, `review_date`, `status`) VALUES
(1, 35, 245, 95, 4, 'Sản phẩm giao hàng nhanh, chất lượng tốt', '2026-04-10 08:40:06', 1),
(8, 35, 244, 99, 5, 'Sản phẩm giao hàng nhanh, chất lượng', '2026-05-08 02:07:46', 1),
(9, 35, 240, 101, 5, 'Vải tốt , chất lượng nha ok', '2026-05-08 14:13:05', 1),
(10, 35, 247, 105, 5, 'Sản phẩm chất lượng', '2026-05-08 15:14:32', 1),
(11, 37, 246, 84, 5, 'Chất lượng sản phẩm tốt ship nhanh chóng', '2026-05-09 13:51:01', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `role` enum('admin','customer') DEFAULT 'customer',
  `points` int(11) DEFAULT 0,
  `province_code` varchar(20) DEFAULT NULL,
  `district_code` varchar(20) DEFAULT NULL,
  `ward_code` varchar(20) DEFAULT NULL,
  `address_detail` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `phone`, `password`, `google_id`, `avatar`, `role`, `points`, `province_code`, `district_code`, `ward_code`, `address_detail`, `created_at`) VALUES
(14, 'admin', 'admin@gmail.com', '8888', '123456', NULL, '1778206153_X.jpg', 'admin', 0, '01', '003', '00049', '9999', '2025-12-25 03:44:56'),
(35, 'TRAN ANH HUNTER', 'anh@gmail.com', '098765432111', '123456', '', '1778205185_download (24).jpg', 'customer', 2362, '01', '005', '00157', 'Số 100', '2026-01-12 15:05:06'),
(36, 'Lê Đức Minh', 'minh@gmail.com', '098765432111', '123456', '', '1775572192_download (25).jpg', 'customer', 0, '68', '672', '24766', 'số 99', '2026-01-12 15:05:56'),
(37, 'Nguyễn Hữu Giang', 'giang@gmail.com', '087363535151', '1234567', '', '1776610369_videoframe_2915.png', 'customer', 367, '22', '195', '06676', 'số 100', '2026-01-12 15:12:59'),
(38, 'Nguyễn Bá Duy', 'duy@gmail.com', '098765432112', '123456', '', '1768525507_download (7).jpg', 'customer', 5710, '01', '001', '00001', 'số 100', '2026-01-12 15:14:43'),
(39, 'Nguyễn Thị Mỹ Phương', 'phuong@gmail.com', '093736362171', '123456', '', '1768528711_download (9).jpg', 'customer', 0, '46', '478', '19942', 'số 99', '2026-01-12 15:15:27');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount_type` enum('fixed','percent') DEFAULT 'fixed',
  `discount_value` decimal(12,0) NOT NULL,
  `min_order_value` decimal(12,0) DEFAULT 0,
  `max_discount_amount` decimal(12,0) DEFAULT NULL,
  `usage_limit` int(11) DEFAULT 100,
  `used_count` int(11) DEFAULT 0,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `status` tinyint(4) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `vouchers`
--

INSERT INTO `vouchers` (`id`, `code`, `description`, `discount_type`, `discount_value`, `min_order_value`, `max_discount_amount`, `usage_limit`, `used_count`, `start_date`, `end_date`, `status`) VALUES
(13, 'TEXTDATE2', 'Test ngày dạng text 2', 'fixed', 20000, 0, NULL, 50, 0, '2025-02-14 01:00:00', '2025-02-15 01:00:00', 1),
(14, 'NAMEMOI', 'Mã cho khách nữ', 'percent', 15, 500000, 100000, 200, 0, '2025-03-08 08:00:00', '2025-03-09 00:00:00', 1),
(15, 'HETHAN', 'Mã test đã hết hạn', 'fixed', 0, 50000, NULL, 20, 0, '2023-01-01 01:00:00', '2023-01-05 01:00:00', 0),
(20, 'cnpm', 'giảm giá nhé', 'percent', 10, 0, NULL, 10, 1, '2026-04-22 09:12:00', '2026-04-30 09:12:00', 1),
(21, 'SALE30', 'Giảm giá sốc sốc', 'percent', 30, 100000, NULL, 10, 6, '2026-05-08 08:59:00', '2026-05-16 08:59:00', 1),
(27, 'sale10', 'giảm giá 10% cho mọi đơn', 'percent', 10, 200000, NULL, 10, 0, '2026-05-09 21:29:00', '2026-05-10 21:29:00', 1);

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `wards`
--

CREATE TABLE `wards` (
  `code` varchar(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `full_name` varchar(255) NOT NULL,
  `district_code` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Đang đổ dữ liệu cho bảng `wards`
--

INSERT INTO `wards` (`code`, `name`, `full_name`, `district_code`) VALUES
('00001', 'Phúc Xá', 'Phường Phúc Xá', '001'),
('00004', 'Trúc Bạch', 'Phường Trúc Bạch', '001'),
('00037', 'Phúc Tân', 'Phường Phúc Tân', '002'),
('00040', 'Đồng Xuân', 'Phường Đồng Xuân', '002'),
('00046', 'Phú Thượng', 'Phường Phú Thượng', '003'),
('00049', 'Nhật Tân', 'Phường Nhật Tân', '003'),
('00052', 'Thượng Thanh', 'Phường Thượng Thanh', '004'),
('00055', 'Ngọc Thụy', 'Phường Ngọc Thụy', '004'),
('00157', 'Nghĩa Đô', 'Phường Nghĩa Đô', '005'),
('00160', 'Quan Hoa', 'Phường Quan Hoa', '005'),
('06553', 'Hà Khánh', 'Phường Hà Khánh', '193'),
('06556', 'Hà Phong', 'Phường Hà Phong', '193'),
('06622', 'Ka Long', 'Phường Ka Long', '194'),
('06625', 'Trần Phú', 'Phường Trần Phú', '194'),
('06673', 'Quang Hanh', 'Phường Quang Hanh', '195'),
('06676', 'Cẩm Thạch', 'Phường Cẩm Thạch', '195'),
('06730', 'Vàng Danh', 'Phường Vàng Danh', '196'),
('06733', 'Thanh Sơn', 'Phường Thanh Sơn', '196'),
('06763', 'Mạo Khê', 'Phường Mạo Khê', '199'),
('06766', 'Đông Triều', 'Phường Đông Triều', '199'),
('11569', 'Quán Toan', 'Phường Quán Toan', '303'),
('11572', 'Hùng Vương', 'Phường Hùng Vương', '303'),
('11623', 'Máy Chai', 'Phường Máy Chai', '304'),
('11626', 'Máy Tơ', 'Phường Máy Tơ', '304'),
('11689', 'Cát Dài', 'Phường Cát Dài', '305'),
('11692', 'An Biên', 'Phường An Biên', '305'),
('11761', 'Đông Hải 1', 'Phường Đông Hải 1', '306'),
('11764', 'Đông Hải 2', 'Phường Đông Hải 2', '306'),
('11776', 'Bắc Sơn', 'Phường Bắc Sơn', '307'),
('11779', 'Ngọc Sơn', 'Phường Ngọc Sơn', '307'),
('13816', 'Hàm Rồng', 'Phường Hàm Rồng', '380'),
('13819', 'Trường Thi', 'Phường Trường Thi', '380'),
('13894', 'Ba Đình', 'Phường Ba Đình', '381'),
('13897', 'Ngọc Trạo', 'Phường Ngọc Trạo', '381'),
('13921', 'Bắc Sơn', 'Phường Bắc Sơn', '382'),
('13924', 'Trung Sơn', 'Phường Trung Sơn', '382'),
('13954', 'Mường Lát', 'Thị trấn Mường Lát', '384'),
('13957', 'Tam Chung', 'Xã Tam Chung', '384'),
('13987', 'Hồi Xuân', 'Thị trấn Hồi Xuân', '385'),
('13990', 'Hiền Kiệt', 'Xã Hiền Kiệt', '385'),
('16252', 'Lê Mao', 'Phường Lê Mao', '412'),
('16255', 'Lê Lợi', 'Phường Lê Lợi', '412'),
('16309', 'Nghi Tân', 'Phường Nghi Tân', '413'),
('16312', 'Nghi Thu', 'Phường Nghi Thu', '413'),
('16336', 'Hòa Hiếu', 'Phường Hòa Hiếu', '414'),
('16339', 'Quang Tiến', 'Phường Quang Tiến', '414'),
('16369', 'Kim Sơn', 'Thị trấn Kim Sơn', '415'),
('16372', 'Mường Nọc', 'Xã Mường Nọc', '415'),
('16414', 'Tân Lạc', 'Thị trấn Tân Lạc', '416'),
('16417', 'Châu Hạnh', 'Xã Châu Hạnh', '416'),
('19726', 'Phú Hậu', 'Phường Phú Hậu', '474'),
('19729', 'Phú Hiệp', 'Phường Phú Hiệp', '474'),
('19834', 'Phong Điền', 'Thị trấn Phong Điền', '476'),
('19837', 'Phong Hòa', 'Xã Phong Hòa', '476'),
('19888', 'Sịa', 'Thị trấn Sịa', '477'),
('19891', 'Quảng Thái', 'Xã Quảng Thái', '477'),
('19942', 'Phú Đa', 'Thị trấn Phú Đa', '478'),
('19945', 'Vinh Thanh', 'Xã Vinh Thanh', '478'),
('20002', 'Phú Bài', 'Phường Phú Bài', '479'),
('20005', 'Thủy Lương', 'Phường Thủy Lương', '479'),
('20194', 'Hòa Hiệp Bắc', 'Phường Hòa Hiệp Bắc', '490'),
('20197', 'Hòa Hiệp Nam', 'Phường Hòa Hiệp Nam', '490'),
('20227', 'Tam Thuận', 'Phường Tam Thuận', '491'),
('20230', 'Thanh Khê Tây', 'Phường Thanh Khê Tây', '491'),
('20254', 'Hải Châu 1', 'Phường Hải Châu 1', '492'),
('20257', 'Hải Châu 2', 'Phường Hải Châu 2', '492'),
('20284', 'Thọ Quang', 'Phường Thọ Quang', '493'),
('20287', 'Nại Hiên Đông', 'Phường Nại Hiên Đông', '493'),
('20302', 'Mỹ An', 'Phường Mỹ An', '494'),
('20305', 'Khuê Mỹ', 'Phường Khuê Mỹ', '494'),
('22369', 'Vĩnh Thọ', 'Phường Vĩnh Thọ', '568'),
('22372', 'Vĩnh Phước', 'Phường Vĩnh Phước', '568'),
('22462', 'Ba Ngòi', 'Phường Ba Ngòi', '569'),
('22465', 'Cam Linh', 'Phường Cam Linh', '569'),
('22492', 'Cam Đức', 'Thị trấn Cam Đức', '570'),
('22495', 'Cam Hải Đông', 'Xã Cam Hải Đông', '570'),
('22522', 'Vạn Giã', 'Thị trấn Vạn Giã', '571'),
('22525', 'Vạn Thắng', 'Xã Vạn Thắng', '571'),
('22564', 'Ninh Hiệp', 'Phường Ninh Hiệp', '572'),
('22567', 'Ninh Đa', 'Phường Ninh Đa', '572'),
('24766', 'Phường 1', 'Phường 1', '672'),
('24769', 'Phường 2', 'Phường 2', '672'),
('24925', 'Phường 1', 'Phường 1', '673'),
('24928', 'Phường 2', 'Phường 2', '673'),
('24976', 'Đạ Rsal', 'Xã Đạ Rsal', '674'),
('24979', 'Rô Men', 'Xã Rô Men', '674'),
('25006', 'Lạc Dương', 'Thị trấn Lạc Dương', '675'),
('25009', 'Lát', 'Xã Lát', '675'),
('25042', 'Đinh Văn', 'Thị trấn Đinh Văn', '676'),
('25045', 'Đạ Đờn', 'Xã Đạ Đờn', '676'),
('25840', 'Trung Dũng', 'Phường Trung Dũng', '731'),
('25843', 'Thanh Bình', 'Phường Thanh Bình', '731'),
('25906', 'Xuân Trung', 'Phường Xuân Trung', '732'),
('25909', 'Xuân Thanh', 'Phường Xuân Thanh', '732'),
('25969', 'Tân Phú', 'Thị trấn Tân Phú', '734'),
('25972', 'Phú Lộc', 'Xã Phú Lộc', '734'),
('26026', 'Vĩnh An', 'Thị trấn Vĩnh An', '735'),
('26029', 'Trị An', 'Xã Trị An', '735'),
('26065', 'Định Quán', 'Thị trấn Định Quán', '736'),
('26068', 'La Ngà', 'Xã La Ngà', '736'),
('26734', 'Tân Định', 'Phường Tân Định', '760'),
('26737', 'Đa Kao', 'Phường Đa Kao', '760'),
('26740', 'Thạnh Xuân', 'Phường Thạnh Xuân', '761'),
('26743', 'Thạnh Lộc', 'Phường Thạnh Lộc', '761'),
('26863', 'Phường 1', 'Phường 1', '764'),
('26866', 'Phường 3', 'Phường 3', '764'),
('26902', 'Phường 13', 'Phường 13', '765'),
('26905', 'Phường 12', 'Phường 12', '765'),
('26965', 'Phường 2', 'Phường 2', '766'),
('26968', 'Phường 4', 'Phường 4', '766'),
('31063', 'Cái Khế', 'Phường Cái Khế', '916'),
('31066', 'An Hòa', 'Phường An Hòa', '916'),
('31093', 'Châu Văn Liêm', 'Phường Châu Văn Liêm', '917'),
('31096', 'Thới An', 'Phường Thới An', '917'),
('31120', 'Bình Thủy', 'Phường Bình Thủy', '918'),
('31123', 'Trà An', 'Phường Trà An', '918'),
('31147', 'Lê Bình', 'Phường Lê Bình', '919'),
('31150', 'Thường Thạnh', 'Phường Thường Thạnh', '919'),
('31189', 'Thốt Nốt', 'Phường Thốt Nốt', '923'),
('31192', 'Thới Thuận', 'Phường Thới Thuận', '923');

-- --------------------------------------------------------

--
-- Cấu trúc bảng cho bảng `wishlists`
--

CREATE TABLE `wishlists` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Chỉ mục cho các bảng đã đổ
--

--
-- Chỉ mục cho bảng `banners`
--
ALTER TABLE `banners`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Chỉ mục cho bảng `collections`
--
ALTER TABLE `collections`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Chỉ mục cho bảng `districts`
--
ALTER TABLE `districts`
  ADD PRIMARY KEY (`code`),
  ADD KEY `province_code` (`province_code`);

--
-- Chỉ mục cho bảng `home_sections`
--
ALTER TABLE `home_sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `collection_id` (`collection_id`);

--
-- Chỉ mục cho bảng `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Chỉ mục cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `variant_id` (`variant_id`);

--
-- Chỉ mục cho bảng `point_history`
--
ALTER TABLE `point_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `order_id` (`order_id`);

--
-- Chỉ mục cho bảng `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`),
  ADD KEY `category_id` (`category_id`),
  ADD KEY `collection_id` (`collection_id`);

--
-- Chỉ mục cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_images_ibfk_1` (`variant_id`);

--
-- Chỉ mục cho bảng `product_variants`
--
ALTER TABLE `product_variants`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Chỉ mục cho bảng `provinces`
--
ALTER TABLE `provinces`
  ADD PRIMARY KEY (`code`);

--
-- Chỉ mục cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `reviews_ibfk_1` (`user_id`),
  ADD KEY `reviews_ibfk_2` (`product_id`),
  ADD KEY `reviews_ibfk_3` (`order_id`);

--
-- Chỉ mục cho bảng `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_prov` (`province_code`),
  ADD KEY `fk_user_dist` (`district_code`),
  ADD KEY `fk_user_ward` (`ward_code`);

--
-- Chỉ mục cho bảng `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Chỉ mục cho bảng `wards`
--
ALTER TABLE `wards`
  ADD PRIMARY KEY (`code`),
  ADD KEY `fk_ward_dist` (`district_code`);

--
-- Chỉ mục cho bảng `wishlists`
--
ALTER TABLE `wishlists`
  ADD KEY `fk_wish_user` (`user_id`),
  ADD KEY `fk_wish_prod` (`product_id`);

--
-- AUTO_INCREMENT cho các bảng đã đổ
--

--
-- AUTO_INCREMENT cho bảng `banners`
--
ALTER TABLE `banners`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT cho bảng `collections`
--
ALTER TABLE `collections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT cho bảng `home_sections`
--
ALTER TABLE `home_sections`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT cho bảng `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=108;

--
-- AUTO_INCREMENT cho bảng `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT cho bảng `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT cho bảng `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT cho bảng `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- Các ràng buộc cho các bảng đã đổ
--

--
-- Các ràng buộc cho bảng `districts`
--
ALTER TABLE `districts`
  ADD CONSTRAINT `districts_ibfk_1` FOREIGN KEY (`province_code`) REFERENCES `provinces` (`code`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `home_sections`
--
ALTER TABLE `home_sections`
  ADD CONSTRAINT `home_sections_ibfk_1` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `order_items_ibfk_3` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`);

--
-- Các ràng buộc cho bảng `point_history`
--
ALTER TABLE `point_history`
  ADD CONSTRAINT `point_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `point_history_ibfk_2` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE SET NULL,
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`collection_id`) REFERENCES `collections` (`id`) ON DELETE SET NULL;

--
-- Các ràng buộc cho bảng `product_images`
--
ALTER TABLE `product_images`
  ADD CONSTRAINT `product_images_ibfk_1` FOREIGN KEY (`variant_id`) REFERENCES `product_variants` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `product_variants`
--
ALTER TABLE `product_variants`
  ADD CONSTRAINT `product_variants_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_3` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `fk_user_dist` FOREIGN KEY (`district_code`) REFERENCES `districts` (`code`),
  ADD CONSTRAINT `fk_user_prov` FOREIGN KEY (`province_code`) REFERENCES `provinces` (`code`),
  ADD CONSTRAINT `fk_user_ward` FOREIGN KEY (`ward_code`) REFERENCES `wards` (`code`);

--
-- Các ràng buộc cho bảng `wards`
--
ALTER TABLE `wards`
  ADD CONSTRAINT `fk_ward_dist` FOREIGN KEY (`district_code`) REFERENCES `districts` (`code`) ON DELETE CASCADE;

--
-- Các ràng buộc cho bảng `wishlists`
--
ALTER TABLE `wishlists`
  ADD CONSTRAINT `fk_wish_prod` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `fk_wish_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
