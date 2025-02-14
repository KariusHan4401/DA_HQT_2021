﻿USE QLHTChuyenHang
GO

--TEST PHÂN QUYỀN --

-- TEST PHÂN HỆ KHÁCH HÀNG --
-- Khách hàng xem danh sách sản phẩm của đối tác, xem tình trạng đơn hàng của mình
SELECT * FROM UV_XEMSP_KH
SELECT * FROM UV_DONHANG_KH
SELECT * FROM UV_TTKHACHHANG
SELECT * FROM UV_GIAOHANG_KH

INSERT dbo.DON_HANG(MADH, MAKH, MADT, PHI_SAN_PHAM, PHI_VAN_CHUYEN, PHI_GIAM, TONG_PHI, TRANG_THAI, HINH_THUC_THANH_TOAN, DUONG, PHUONG, QUAN, THANH_PHO) VALUES ('DH000016', 'KH000001', 'DT000003', 1276139, 75840, 95380, 4186391, N'Đặt hàng', N'Thẻ ghi nợ', N'19/5 Nguyễn Đăng Giai', N'Thạnh Mỹ Lợi', N'Tân An', N'Long An')
INSERT dbo.CHI_TIET_DON_HANG(MADH, MASP, SO_LUONG, THANH_TIEN) VALUES ('DH000016', 'SP000007', 2, 6162125)

--PHÂN HỆ QUẢN TRỊ
SELECT * FROM TAI_KHOAN
SELECT * FROM CRUD_TK_NV_ADMIN

INSERT INTO CRUD_TK_NV_ADMIN VALUES ('TK000041','Cole', 'TK000041','Ketchum936@example.com', N'0929837699', N'55/63 Trương Văn Bang', N'Bến Thành', N'Quảng Uyên',	N'Bà Rịa – Vũng Tàu', N'Đối tác', N'Đã kích hoạt')
INSERT INTO CRUD_TK_NV_ADMIN VALUES ('TK000043','Linh', 'TK000041','linh123@gmail.com', N'0929837699', N'55/63 Trương Văn Bang', N'Bến Thành', N'Quảng Uyên',	N'Bà Rịa – Vũng Tàu', N'Nhân viên', N'Đã kích hoạt')

UPDATE TAI_KHOAN SET EMAIL = 'cole123@gmail.com' WHERE MATK = 'TK000041' 
UPDATE CRUD_TK_NV_ADMIN SET EMAIL = 'linh1234@gmail.com' WHERE MATK = 'TK000043'

DELETE FROM CRUD_TK_NV_ADMIN WHERE MATK = 'TK000043'

--PHÂN HỆ TÀI XẾ
SELECT * FROM UV_TTTAIXE
SELECT * FROM UV_DHTAIXE
SELECT * FROM UV_TNTAIXE
SELECT * FROM UV_TTDHTAIXE

UPDATE UV_TTTAIXE SET EMAIL = 'dta123@gmail.com'
INSERT UV_TTDHTAIXE VALUES (N'Đang giao hàng', 'DH000015', '2021-11-10')
UPDATE UV_TTDHTAIXE SET TEN_TRANG_THAI = N'Đã hủy' WHERE MADH = 'DH000008' AND TEN_TRANG_THAI = N'Đang giao hàng'

--PHÂN HỆ NHÂN VIÊN
SELECT * FROM HOP_DONG
SELECT * FROM LICH_SU_HOP_DONG
SELECT * FROM DOI_TAC

UPDATE HOP_DONG SET HOA_HONG = 0.07 WHERE MAHD = 'HD000001'
insert LICH_SU_HOP_DONG values ('HD000009', 5, '2021-12-26','2022-12-26')
GRANT INSERT ON LICH_SU_HOP_DONG TO NHAN_VIEN

--PHÂN HỆ ĐỐI TÁC
SELECT * FROM UV_TTDHDOITAC
SELECT * FROM UV_DHDOITAC
SELECT * FROM UV_SPDOITAC
SELECT * FROM UV_TTDOITAC
SELECT * FROM UV_CN_DOITAC

UPDATE UV_TTDHDOITAC SET TEN_TRANG_THAI = N'Đang giao hàng' WHERE MADH = 'DH000008' AND TEN_TRANG_THAI = N'Đã hủy'
UPDATE UV_TTDOITAC SET EMAIL = 'Lily12345@gmail.com' WHERE MATK = 'TK000027'
UPDATE UV_SPDOITAC SET MO_TA = N'Bánh quy danisa' WHERE MASP = 'SP000016' AND MACN = 'CN000029'