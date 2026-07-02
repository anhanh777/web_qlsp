#!/bin/bash
# Thiết lập dừng script ngay lập tức nếu bất kỳ lệnh nào bị lỗi
set -e

# Đặt biến nhánh mặc định là develop, cho phép ghi đè khi truyền tham số
BRANCH=${1:-develop}

echo "=========================================================="
echo "BẮT ĐẦU TIẾN TRÌNH TỰ ĐỘNG CẬP NHẬT ỨNG DỤNG (Branch: $BRANCH)"
echo "=========================================================="

# 1. Kéo code mới từ kho chứa Git
echo "-> Đang kéo mã nguồn mới..."
git pull origin "$BRANCH"

# 2. Xây dựng lại và khởi chạy Container
echo "-> Đang biên dịch và khởi động Container..."
docker compose up -d --build

# 3. Thực hiện kiểm tra sức khỏe hệ thống sau khi deploy
echo "-> Đang kiểm tra sức khỏe ứng dụng sau triển khai..."
sleep 5
if curl -f http://localhost:8080/web_qlsp/ > /dev/null 2>&1; then
    echo "✔ Kiểm tra sức khỏe THÀNH CÔNG: Website phản hồi tốt!"
else
    echo "❌ Kiểm tra sức khỏe THẤT BẠI: Website không phản hồi!"
    exit 1
fi

# 4. Dọn dẹp các Docker image rác không còn sử dụng để tiết kiệm ổ cứng
echo "-> Đang dọn dẹp các Docker image thừa..."
docker image prune -f

echo "=========================================================="
echo "CẬP NHẬT THÀNH CÔNG! HỆ THỐNG SẴN SÀNG."
echo "=========================================================="
