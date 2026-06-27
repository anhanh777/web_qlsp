#!/bin/bash
echo "============================================="
echo "BẮT ĐẦU TIẾN TRÌNH TỰ ĐỘNG CẬP NHẬT ỨNG DỤNG"
echo "============================================="

# 1. Pull code mới từ nhánh develop
git pull origin develop

# 2. Rebuild container
sudo docker compose up -d --build

# 3. Dọn dẹp image rác để giải phóng ổ cứng
sudo docker image prune -f

echo "============================================="
echo "CẬP NHẬT THÀNH CÔNG! HỆ THỐNG SẴN SÀNG."
echo "============================================="
