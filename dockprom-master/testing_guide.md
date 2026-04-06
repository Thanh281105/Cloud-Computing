# 🧪 Hướng dẫn kiểm tra 10 yêu cầu MyMiniCloud

Sau khi chạy `docker-compose up -d`, hãy kiểm tra từng phần theo hướng dẫn sau:

---

### 1. Web – Bài viết blog
- **Yêu cầu:** Thêm blog1, blog2, blog3.html và cập nhật trang chủ.
- **Cách test:** Truy cập các link sau:
  - [http://localhost:8080/blog1.html](http://localhost:8080/blog1.html)
  - [http://localhost:8080/blog2.html](http://localhost:8080/blog2.html)
  - [http://localhost:8080/blog3.html](http://localhost:8080/blog3.html)

---

### 2. Backend API – Sinh viên
- **Yêu cầu:** API `GET /student` trả về JSON dữ liệu sinh viên.
- **Cách test:** Dùng trình duyệt hoặc lệnh:
  ```bash
  curl http://localhost:8085/student
  ```
- **Kết quả mong đợi:** Danh sách 5 sinh viên dạng JSON.

---

### 3. Database – Cơ sở dữ liệu sinh viên
- **Yêu cầu:** Tạo `studentdb` và bảng [students](file:///c:/Users/admin/Downloads/dockprom-master/application-backend-server/app.py#17-57).
- **Cách test:** Chạy lệnh kiểm tra trực tiếp trong container:
  ```bash
  docker exec -it relational-database-server mysql -uroot -prootpassword -e "USE studentdb; SELECT * FROM students;"
  ```

---

### 4. Keycloak – Xác thực
- **Yêu cầu:** Tạo Realm theo mã sinh viên (VD: `realm_sv001`), 2 Users (`sv01`, `sv02`), 1 Client (`flask-app`).
- **Cách test:** 
  1. Truy cập [http://localhost:8081](http://localhost:8081).
  2. Đăng nhập: `admin` / `admin`.
  3. Chọn Realm **realm_svxxx** ở bên trái.
  4. Kiểm tra menu **Users** để thấy `sv01` và `sv02`.
  5. Lấy URL Token Endpoint và truy cập thử route bảo mật `/secure` trong app backend.

---

### 5. MinIO – Lưu trữ file
- **Yêu cầu:** Tạo bucket `profile-pics` (để up ảnh cá nhân), `documents` (để up file PDF báo cáo) và thiết lập public policy.
- **Cách test:**
  1. Truy cập [http://localhost:9001](http://localhost:9001).
  2. Đăng nhập: `minioadmin` / `minioadmin`.
  3. Kiểm tra menu **Buckets** ở bên trái, xem đã có 2 bucket chưa.
  4. Upload ảnh đại diện vào `profile-pics`, lấy URL public và mở trên trình duyệt.
  5. Upload file báo cáo PDF vào `documents`.

---

### 6. DNS – Phân giải tên miền nội bộ
- **Yêu cầu:** Thêm records `app-backend.cloud.local` (IN A 10.10.10.20), `minio.cloud.local`, `keycloak.cloud.local`.
- **Cách test:** Chạy lệnh `nslookup` hoặc `dig` trong container DNS:
  ```bash
  docker exec -it internal-dns-server dig app-backend.cloud.local @127.0.0.1
  docker exec -it internal-dns-server nslookup minio.cloud.local 127.0.0.1
  ```

---

### 7. Prometheus – Giám sát Web Server
- **Yêu cầu:** Thêm job monitor web server.
- **Cách test:**
  1. Truy cập [http://localhost:9090/targets](http://localhost:9090/targets).
  2. Tìm job **web**. Bạn sẽ thấy `web-1` và `web-2` ở trạng thái **UP**.

---

### 8. Grafana – Dashboard giám sát
- **Yêu cầu:** Tạo dashboard cá nhân tên `System Health of <MSSV>` với ít nhất 3 biểu đồ (CPU, RAM, Network).
- **Cách test:**
  1. Truy cập [http://localhost:3000](http://localhost:3000).
  2. Đăng nhập: `admin` / `admin`.
  3. Vào menu **Dashboards** → tìm **System Health of <MSSV>**.
  4. Kiểm tra xem các hàm PromQL đã đúng chưa: `node_cpu_seconds_total`, `node_memory_MemAvailable_bytes`, `node_network_receive_bytes_total`.

---

### 9. Proxy – Định tuyến /student/
- **Yêu cầu:** Thêm route `/student/` vào API Gateway.
- **Cách test:** Truy cập trực qua Gateway:
  - [http://localhost/student/](http://localhost/student/)
- **Kết quả:** Trình duyệt hiện dữ liệu sinh viên (được proxy từ backend).

---

### 10. Load Balancer – Cân bằng tải Web
- **Yêu cầu:** Cluster `web-1`, `web-2` và config upstream.
- **Cách test:**
  1. Truy cập [http://localhost/](http://localhost/) (trang chủ).
  2. F5 nhiều lần.
  3. Kiểm tra log của proxy để thấy traffic chia cho 2 server:
     ```bash
     docker logs api-gateway-proxy-server
     ```
