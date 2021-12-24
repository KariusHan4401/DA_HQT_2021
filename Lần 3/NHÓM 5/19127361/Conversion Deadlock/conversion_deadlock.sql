﻿USE QLHTChuyenHang
GO
--update người đại diện đối tác

CREATE 
--ALTER
PROC USP_DT_NDD
	@NGUOI_DAI_DIEN nvarchar(30)
AS
set tran isolation level Repeatable read 
BEGIN TRAN
	DECLARE @NGUOI_DAI_DIEN_HT nvarchar(30)
	SET @NGUOI_DAI_DIEN_HT = (SELECT NGUOI_DAI_DIEN
	                          FROM UV_TTDOITAC)

	IF (@NGUOI_DAI_DIEN = @NGUOI_DAI_DIEN_HT)
	BEGIN
		PRINT N'Người đại diện muốn đổi trùng với người đại diện hiện tại'
		ROLLBACK TRAN
		RETURN
	END

	WAITFOR DELAY '0:0:05'

	BEGIN TRY
		UPDATE UV_TTDOITAC
		SET NGUOI_DAI_DIEN = @NGUOI_DAI_DIEN
		
	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMsg VARCHAR(2000)
		SELECT @ErrorMsg = N'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMsg, 16,1)
		ROLLBACK TRAN
		RETURN
	END CATCH

COMMIT TRAN

GO
CREATE 
--ALTER
PROC USP_DT_QuanNDD
	@QUAN_NDD nvarchar(20)
AS
set tran isolation level Repeatable read 
BEGIN TRAN
	DECLARE @QUAN nvarchar(30)
	SET @QUAN = (SELECT QUAN_NDD
	             FROM UV_TTDOITAC)
	
	IF (@QUAN_NDD = @QUAN)
	BEGIN
		PRINT N'Tên quận muốn đổi trùng với tên quận hiện tại'
		ROLLBACK TRAN
		RETURN
	END

	WAITFOR DELAY '0:0:05'

	BEGIN TRY
		UPDATE UV_TTDOITAC
		SET QUAN_NDD = @QUAN_NDD
		
	END TRY

	BEGIN CATCH 
		DECLARE @ErrorMsg VARCHAR(2000)
		SELECT @ErrorMsg = N'Lỗi: ' + ERROR_MESSAGE()
		RAISERROR(@ErrorMsg, 16,1)
		ROLLBACK TRAN
		RETURN
	END CATCH

COMMIT TRAN

