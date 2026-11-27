# AGENTS.md — Quy định làm việc chung

Tài liệu này nằm trong `.agents/AGENTS.md` để định hướng chung khi làm việc với repository. Toàn bộ cấu hình dự án được quản lý tập trung tại `.cline/`, còn MCP được quản lý tập trung tại `.mcp/`.

---

## 1. Quản lý môi trường & phiên bản công cụ bằng `mise`

* **Bắt buộc dùng `mise`**: Mọi runtime và công cụ CLI như **Node.js**, **npm** (hoặc trình quản lý gói khác nếu khai báo), **Python**, v.v. phải tuân theo phiên bản quy định trong `mise.toml`.
* **Không tự ý dùng phiên bản toàn cục (global) lệch chuẩn** khi công cụ đã được `mise` quản lý; ưu tiên chạy lệnh qua môi trường `mise` (ví dụ: `mise exec -- ...` hoặc sau khi đã kích hoạt môi trường dự án).
* **Khi cần thêm/đổi phiên bản công cụ**:
  * Cập nhật `mise.toml` thay vì cài đặt tay rời rạc ngoài dự án.
  * Báo rõ sự thay đổi phiên bản để người dùng xác nhận và đồng bộ.
* **Môi trường & chứng chỉ**:
  * Tôn trọng script kích hoạt môi trường (`cline-activate.ps1`) và file chứng chỉ `.cline/cli-node-extra-ca-certs.pem`.
  * Không tự ý xóa, ghi đè hoặc làm lộ thông tin nhạy cảm/chứng chỉ cục bộ.

---

## 2. Cấu hình tập trung trong `.cline/`, MCP tại `.mcp/` và vai trò của `.agents/`

* **`.cline/` quản lý toàn bộ tài nguyên cấu hình của dự án**:
  * `.cline/rules/`: Quy tắc dự án (project rules).
  * `.cline/workflows/`: Luồng quy trình làm việc (project workflows).
  * `.cline/skills/`: Kỹ năng của dự án (project skills).
  * `.cline/hooks/`: Lifecycle hooks.
  * `.cline/agents/`: Định nghĩa agent của dự án (project agent definitions).
  * `.cline/plugins/`: Plugins của dự án.
  * Luôn đọc và tuân theo `.cline/rules/` cùng các cấu hình liên quan trong `.cline/` trước khi lên kế hoạch hoặc sửa mã. Khi thêm mới hoặc chỉnh sửa các mục trên, đặt trực tiếp vào thư mục tương ứng bên trong `.cline/`.
* **`.mcp/` quản lý tập trung toàn bộ MCP**:
  * Các file cấu hình MCP và mọi repository MCP cần `git clone` về đều phải đặt trong `.mcp/` (ví dụ `.mcp/<ten-mcp>/`) để quản lý tập trung.
  * Không `git clone` mã nguồn MCP rải rác ở thư mục gốc hoặc ngoài dự án nếu thuộc phạm vi MCP của repo này.
  * Giữ cấu hình MCP hợp lệ, không ghi hardcode secret/token/API key vào file cấu hình hoặc mã nguồn.
* **Vai trò của `.agents/`**:
  * Thư mục `.agents/` chỉ chứa file hướng dẫn này (`AGENTS.md`); không đưa skills, cấu hình riêng hoặc MCP vào `.agents/`.
* **Tôn trọng Git**:
  * Không chỉnh sửa lịch sử Git nguy hiểm hoặc commit file tạm/nhạy cảm/thư mục con bị bỏ qua trong `.gitignore`.

---

## 3. Quy tắc chung khi thực thi tác vụ

* **Sửa đúng phạm vi**: Chỉ thay đổi phần liên quan đến yêu cầu; không sửa lan man ngoài phạm vi nếu không được yêu cầu.
* **Kiểm tra trước khi bàn giao**: Chạy lint, test, build hoặc kiểm tra cú pháp phù hợp với dự án bằng môi trường `mise` và báo cáo rõ kết quả.
* **Ngôn ngữ**: Trả lời súc tích, rõ ràng bằng tiếng Việt (trừ khi mã nguồn, comment kỹ thuật hoặc yêu cầu cụ thể dùng ngôn ngữ khác).