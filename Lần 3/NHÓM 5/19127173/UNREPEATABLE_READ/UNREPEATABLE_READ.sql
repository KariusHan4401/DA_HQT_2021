﻿USE QLHTChuyenHang
GO

CREATE 
--ALTER
PROC USP_TIMSPTEN
	@TENSP NVARCHAR(100)
AS
BEGIN TRAN
	BEGIN TRY
		IF NOT EXISTS(	SELECT * 
						FROM SAN_PHAM 
						WHERE TENSP = @TENSP)
		BEGIN
			PRINT @TENSP + N' KHÔNG TỒN TẠI'
			ROLLBACK TRAN
			RETURN 
		END
		--ĐỂ TEST
		WAITFOR DELAY '0:0:05'
		---------
		SELECT * FROM SAN_PHAM WHERE TENSP = @TENSP
	END TRY
	BEGIN CATCH
		PRINT N'LỖI HỆ THỐNG ' + ERROR_MESSAGE()
		ROLLBACK TRAN
	END CATCH
COMMIT TRAN
GO

CREATE 
--ALTER
PROC USP_DOITENSP
	@TENCANCAPNHAT NVARCHAR(100),
	@TENCAPNHAT NVARCHAR(100)
AS
BEGIN TRAN
	BEGIN TRY
		IF NOT EXISTS (	SELECT *
						FROM UV_SPDOITAC
						WHERE TENSP = @TENCANCAPNHAT)
		BEGIN
			PRINT  @TENCANCAPNHAT + N'SẢN PHẨM NÀY KHÔNG TỒN TẠI'
			ROLLBACK TRAN
			RETURN 0
		END
		IF @TENCAPNHAT IS NULL
		BEGIN
			PRINT  N'TÊN CẬP NHẬT KHÔNG ĐƯỢC TRỐNG'
			ROLLBACK TRAN
			RETURN 0
		END
		IF @TENCAPNHAT = @TENCANCAPNHAT
		BEGIN
			PRINT  N'TÊN CẬP NHẬT KHÔNG ĐƯỢC TRÙNG VỚI TÊN CŨ'
			ROLLBACK TRAN
			RETURN 0
		END
		UPDATE UV_SPDOITAC SET TENSP = @TENCAPNHAT WHERE @TENCANCAPNHAT = TENSP
	END TRY
	BEGIN CATCH
		PRINT N'LỖI HỆ THỐNG ' + ERROR_MESSAGE()
		ROLLBACK TRAN
		RETURN 0
	END CATCH
COMMIT TRAN
RETURN 1