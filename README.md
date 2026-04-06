# ☁️ MyMiniCloud - 2026 Cloud-Native Edition

Hệ thống Cloud Computing thu nhỏ gồm **9 server** chạy trên Docker containers. 
Phiên bản 2026 được nâng cấp với giao diện Light Mode Glassmorphism và tối ưu hóa hạ tầng để sẵn sàng hoạt động trên nền tảng AWS EC2.

## 📋 Kiến trúc hệ thống 2026

```
User (Internet) → AWS EC2 Public IP → API Gateway (Nginx Reverse Proxy, port 80)
         ├── /       → Cụm Web Frontend Cluster (Nginx x2, port 8080)
         ├── /api    → Application Backend (Flask, port 8085)
         ├── /auth   → Authentication (Keycloak, port 8081)
         └── /student→ Backend API (Lấy dữ liệu sinh viên)

Hỗ trợ Vận Hành (Backend Infrastructure):
  ├── Database: MariaDB (port 3306)
  ├── Object Storage: MinIO (port 9000/9001)
  ├── DNS: Bind9 (port 1053) giải quyết tên miền mây nội bộ
  ├── Monitoring: Prometheus (port 9090)
  └── Dashboard: Grafana (port 3000)
```

## 🚀 Cài đặt & Khởi chạy (Local + Cloud)

### Yêu cầu
- Máy chủ Local hoặc AWS EC2 (Ubuntu 22.04 LTS, cấu hình RAM >= 2GB).
- Docker Engine >= 20.10 & Docker Compose.

### Khởi chạy System-wide

```bash
# Clone hoặc tải thư mục về máy tính/AWS
cd dockprom-master
# Khởi động toàn bộ cụm 9 microservices
docker compose up -d
```

### Giám sát quá trình tạo Cloud
```bash
docker compose ps
docker compose logs -f api-gateway-proxy-server
```

## 🌐 Bảng Điều Khiển (Access Matrix & Live Demo)

Hệ thống đã được **Live Demo** trực tiếp trên Đám mây AWS. Truy cập ngay vào các đường link bên dưới để chấm điểm:

| Tên Dịch Vụ | Link Trực Tiếp trên AWS EC2 ☁️ | Địa chỉ Local | Tài khoản |
|---------|-----|-----------|-----------|
| 🎨 Web Frontend | [http://54.224.79.30:8080/](http://54.224.79.30:8080/) | `http://localhost:8080` | Tự do |
| 🐍 App API Backend | [http://54.224.79.30/api/hello](http://54.224.79.30/api/hello) | `http://localhost:8085/hello` | Tự do |
| 🛡 Keycloak IAM SSO | [http://54.224.79.30:8081](http://54.224.79.30:8081) | `http://localhost:8081` | `admin` / `admin` |
| 📦 MinIO Object Storage | [http://54.224.79.30:9001](http://54.224.79.30:9001) | `http://localhost:9001` | `minioadmin` / `minioadmin` |
| 🛰 Prometheus Metrics | [http://54.224.79.30:9090](http://54.224.79.30:9090) | `http://localhost:9090` | Tự do |
| 📈 Grafana Dashboard | [http://54.224.79.30:3000](http://54.224.79.30:3000) | `http://localhost:3000` | `admin` / `admin` |

## 🧪 Các Phương Pháp Unit Test Nhanh (Terminal)
Xác thực hệ thống đã hoạt động đúng qua dòng lệnh:

```bash
# 1. Test Cụm Web
curl http://localhost:8080

# 2. Test Chức năng Bypass Gateway tới App
curl http://localhost/api/hello

# 3. Test Chức Năng Phân Giải DNS Nội Bộ (Bind9)
docker exec -it internal-dns-server nslookup minio.cloud.local 127.0.0.1

# 4. Test Lệnh Móc Dữ Liệu SQL
docker exec -it relational-database-server mysql -uroot -prootpassword -e "USE minicloud; SELECT * FROM notes;"
```

## 🔥 Các Yêu Cầu Kỹ Thuật Đặc Biệt (Phase 2 - Hoàn Thành)
Dự án đã vượt qua bài đánh giá khắc nghiệt Phase 2 với các module tinh hoa:
1. ✅ **UI/UX 2026**: Thiết kế giao diện Light-Mode Responsive trên toàn bộ HTML tĩnh.
2. ✅ **Load Balancing Cluster**: Chạy song song `web-1` và `web-2` có phân tải mượt mà.
3. ✅ **Custom Side-car Exporters**: Xử lý triệt để lỗi Prometheus không đọc được file dữ liệu HTTP Raw của Nginx bằng các module dãn cách. 
4. ✅ **Docker Hub CI/CD**: Upload Frontend Image lên Kho Docker Public cá nhân (`thanh281105/myminicloud-web:latest`).
5. ✅ **Cloud Deployment**: Đưa ứng dụng thành công tuyệt đối lên mạng máy ảo AWS EC2 Public.

## 📝 Bản quyền Đồ Án
© 2026 MyMiniCloud. Dự án tốt nghiệp môn học Điện toán Đám mây. Phát hành dưới giấy phép MIT License.
