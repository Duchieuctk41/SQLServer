/*Học Phần: Cơ Sở Dữ Liệu
  Ngày: 03/06/2020
  Người thực hiện: Nguyễn Danh
  MSSV: 1812736
  Lớp: CTK42
*/
CREATE DATABASE Lab06_QuanLyHocvien
GO
USE Lab06_QuanLyHocvien
GO
-----------

create table CaHoc
(Ca			tinyint primary key,
GioBatDau	Datetime,
GioKetThuc	Datetime
)
go
create table GiaoVien
(MSGV		char(4) primary key,
HoGV		nvarchar(20),
TenGV		nvarchar(10),
DienThoai	varchar(11)
)
go
create table Lop
(MaLop	char(4) primary key,
TenLop	nvarchar(30),
NgayKG	Datetime,
HocPhi	int,
Ca		tinyint references CaHoc(Ca),
SoTiet	int,
SoHV	int,
MSGV	char(4) references GiaoVien(MSGV)
)
go
create table HocVien
(MSHV		char(4) primary key,
Ho			nvarchar(20),
Ten			nvarchar(10),
NgaySinh	Datetime,
Phai		nvarchar(4),
MaLop		char(4) references Lop(MaLop)
)
go
create table HocPhi
(
SoBL	char(6) primary key,
MSHV	char(4) references HocVien(MSHV),
NgayThu Datetime,
SoTien	int,
NoiDung	nvarchar(50),
NguoiThu nvarchar(30)
)
go
-------------------
select * from CaHoc
select * from GiaoVien
select * from Lop
select * from HocVien
select * from HocPhi

----------XÂY DỰNG CÁC THỦ TỤC NHẬP DỮ LIỆU (Câu 5a) -------------
CREATE PROC usp_ThemCaHoc
	@ca tinyint, @giobd Datetime, @giokt Datetime
As
	If exists(select * from CaHoc where Ca = @ca) --kiểm tra có trùng khóa chính (Ca) 
		print N'Đã có ca học ' +@ca+ N' trong CSDL!'
	Else
		begin
			insert into CaHoc values(@ca, @giobd, @giokt)
			print N'Thêm ca học thành công.'
		end
go
--goi thuc hien thu tuc usp_ThemCaHoc---
exec usp_ThemCaHoc 1,'7:30','10:45'
exec usp_ThemCaHoc 2,'13:30','16:45'
exec usp_ThemCaHoc 3,'17:30','20:45'
---------------------
CREATE PROC usp_ThemGiaoVien
	@msgv char(4), @hogv nvarchar(20), @Tengv nvarchar(10),@dienthoai varchar(11)
As
	If exists(select * from GiaoVien where MSGV = @msgv) --kiểm tra có trùng khóa chính (MSGV) 
		print N'Đã có giáo viên có mã số ' +@msgv+ N' trong CSDL!'
	Else
		begin
			insert into GiaoVien values(@msgv, @hogv, @Tengv, @dienthoai)
			print N'Thêm giáo viên thành công.'
		end
go
--goi thuc hien thu tuc usp_ThemGiaoVien---
exec usp_ThemGiaoVien 'G001',N'Lê Hoàng',N'Anh', '858936'
exec usp_ThemGiaoVien 'G002',N'Nguyễn Ngọc',N'Lan', '845623'
exec usp_ThemGiaoVien 'G003',N'Trần Minh',N'Hùng', '823456'
exec usp_ThemGiaoVien 'G004',N'Võ Thanh',N'Trung', '841256'
---------------------
--drop PROC usp_ThemLopHoc
create PROC usp_ThemLopHoc
@malop char(4), @Tenlop nvarchar(20), 
@NgayKG datetime,@HocPhi int, @Ca tinyint, @sotiet int, @sohv int, 
@msgv char(4)
As
	If exists(select * from CaHoc where Ca = @Ca) and exists(select * from GiaoVien where MSGV=@msgv)--kiểm tra các RBTV khóa ngoại
	  Begin
		if exists(select * from Lop where MaLop = @malop) --kiểm tra có trùng khóa chính của quan hệ Lop 
			print N'Đã có lớp '+ @MaLop +' trong CSDL!'
		else	
			begin
				insert into Lop values(@malop, @Tenlop, @NgayKG, @HocPhi, @Ca, @sotiet, @sohv, @msgv)
				print N'Thêm lớp học thành công.'
			end
	  End
	Else -- Bị vi phạm ràng buộc khóa ngoại
		if not exists(select * from CaHoc where Ca = @Ca)
				print N'Không có ca học '+@Ca+' trong CSDL.'
		else	print N'Không có giáo viên '+@msgv+' trong CSDL.'
go
--goi thuc hien thu tuc usp_ThemLopHoc---
set dateformat dmy
go
exec usp_ThemLopHoc 'A075',N'Access 2-4-6','18/12/2008', 150000,3,60,3,'G003'
exec usp_ThemLopHoc 'E114',N'Excel 3-5-7','02/01/2008', 120000,1,45,3,'G003'
exec usp_ThemLopHoc 'A115',N'Excel 2-4-6','22/01/2008', 120000,3,45,0,'G001'
exec usp_ThemLopHoc 'W123',N'Word 2-4-6','18/02/2008', 100000,3,30,1,'G001'
exec usp_ThemLopHoc 'W124',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'
----------------------
create PROC usp_ThemHocVien
@MSHV char(4), @Ho nvarchar(20), @Ten nvarchar(10),
@NgaySinh Datetime, @Phai	nvarchar(4),@MaLop char(4)
As
	If exists(select * from Lop where MaLop = @MaLop) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có trùng khóa chính (MAHV) 
			print N'Đã có mã số học viên này trong CSDL!'
		else
			begin
				insert into HocVien values(@MSHV,@Ho, @Ten,@NgaySinh,@Phai,@MaLop)
				print N'Thêm học viên thành công.'
			end
	  End
	Else
		print N'Lớp '+ @MaLop + N' không tồn tại trong CSDL nên không thể thêm học viên vào lớp này!'
		
go
----goi thuc hien thu tuc usp_ThemHocVien-------
set dateformat dmy
go
exec usp_ThemHocVien '0001',N'Lê Văn', N'Minh', '10/06/1988',N'Nam', 'A075'
exec usp_ThemHocVien '0002',N'Nguyễn Thị', N'Mai', '20/04/1988',N'Nữ', 'A075'
exec usp_ThemHocVien '0003',N'Lê Ngọc', N'Tuấn', '10/06/1984',N'Nam', 'A075'
exec usp_ThemHocVien '0004',N'Vương Tuấn', N'Vũ', '25/03/1979',N'Nam', 'E114'
exec usp_ThemHocVien '0005',N'Lý Ngọc', N'Hân', '01/12/1985',N'Nữ', 'E114'
exec usp_ThemHocVien '0006',N'Trần Mai', N'Linh', '04/06/1980',N'Nữ', 'E114'
exec usp_ThemHocVien '0007',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'
----------------------------
create PROC usp_ThemHocPhi
@SoBL char(6),
@MSHV char(4),
@NgayThu Datetime,
@SoTien	int,
@NoiDung nvarchar(50),
@NguoiThu nvarchar(30)
As
	If exists(select * from HocVien where MSHV = @MSHV) --kiểm tra có RBTV khóa ngoại
	  Begin
		if exists(select * from HocPhi where SoBL = @SoBL) --kiểm tra có trùng khóa(SoBL) 
			print N'Đã có số biên lai học phí này trong CSDL!'
		else
		 begin
			insert into HocPhi values(@SoBL,@MSHV,@NgayThu, @SoTien, @NoiDung,@NguoiThu)
			print N'Thêm biên lai học phí thành công.'
		 end
	  End
	Else
		print N'Học viên '+ @MSHV + N' không tồn tại trong CSDL nên không thể thêm biên lai học phí của học viên này!'
go
----goi thuc hien thu tuc usp_ThemHocPhi-------
set dateformat dmy
go
exec usp_ThemHocPhi 'A07501','0001','16/12/2008',150000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi 'A07502','0002','16/12/2008',100000,'HP Access 2-4-6', N'Lan'
exec usp_ThemHocPhi 'A07503','0003','18/12/2008',150000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi 'A07504','0002','15/01/2009',50000,'HP Access 2-4-6', N'Vân'
exec usp_ThemHocPhi 'E11401','0004','02/01/2008',120000,'HP Excel 3-5-7', N'Vân'
-- exec usp_ThemHocPhi 'E11402','0005','02/0000','HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'E11403','0006','02/01/2008',80000,'HP Excel 3-5-7', N'Vân'
exec usp_ThemHocPhi 'W12301','0007','18/02/2008',100000,'HP Word 2-4-6', N'Lan'


------------------XÂY DỰNG CÁC THỦ TỤC SỬA DỮ LIỆU----------
exec usp_ThemHocVien '0008',N'Nguyễn Ngọc', N'Tuyết', '12/05/1986',N'Nữ', 'W123'

UPDATE HocVien 
SET Ho = N'Nguyễn Trọng',
	Ten = N'Hiếu',
	Phai = N'Nam'
WHERE MSHV = '0008';
SELECT * FROM HocVien WHERE MSHV = '0008'

CREATE PROC usp_ChinhSuaHocVien
@MSHV CHAR(4),
@Ho NVARCHAR(20),
@Ten NVARCHAR(10),
@NgaySinh DATETIME,
@Phai NVARCHAR(4),
@MaLop CHAR(4)
AS
	IF NOT EXISTS (SELECT * FROM HocVien WHERE MSHV = @MSHV)
		PRINT N'Không tồn tại học viên!'
	ELSE IF NOT EXISTS (SELECT * FROM Lop WHERE MaLop = @MaLop)
		PRINT N'Không tồn tại lóp học!'
	ELSE
		BEGIN
			UPDATE HocVien
			SET Ho = @Ho,
				Ten = @Ten,
				NgaySinh = @NgaySinh,
				Phai = @Phai,
				MaLop = @MaLop
			WHERE MSHV = @MSHV;
			PRINT N'Cập nhật dữ liệu thành công!'
		END
GO

/*
SET DATEFORMAT dmy;
EXEC usp_ChinhSuaHocVien '0008', N'Nguyễn Văn', N'Tèo', '11/10/2000', 'Nam', 'W123';
SELECT * FROM HocVien WHERE		MSHV = '0008';
*/

------------------XÂY DỰNG CÁC THỦ TỤC XÓA DỮ LIỆU----------
CREATE PROC usp_XoaHocVien 
@MSHV CHAR(4)
AS
	IF NOT EXISTS (SELECT * FROM HocVien WHERE MSHV = @MSHV)
		PRINT N'Không tồn tại mã số học viên!'
	ELSE
		BEGIN
			DELETE HocVien WHERE MSHV = @MSHV
			PRINT N'Xóa dữ liệu thành công!'
		END
GO

EXEC usp_XoaHocVien '0008';

CREATE PROC usp_XoaLopHoc
@MaLop CHAR(4)
AS
	IF NOT EXISTS (SELECT * FROM Lop WHERE MaLop = @MaLop)
		PRINT N'Không tồn tại lớp học!'
	ELSE
		BEGIN
			IF ((SELECT SoHV FROM Lop WHERE MaLop = @MaLop) > 0)
				PRINT N'Lớp học tồn tại học viên!';
			ELSE
				BEGIN
					DELETE Lop WHERE MaLop = @MaLop
					PRINT N'Xóa lớp học thành công!'
				END
		END
GO
-- drop proc usp_XoaLopHoc

exec usp_ThemLopHoc 'W125',N'Word 3-5-7','01/03/2008', 100000,1,30,0,'G002'
SELECT * FROM Lop;
EXEC usp_XoaLopHoc 'W125';

-- Lập danh sách học viên 1 lớp học cho trước
CREATE PROC usp_XuatDSLopHoc
@MaLop CHAR(4)
AS
	IF NOT EXISTS (SELECT * FROM Lop WHERE MaLop = @MaLop)
		PRINT N'Lớp không tồn tại'
	ELSE 
		SELECT * FROM HocVien WHERE MaLop = @MaLop
GO


EXEC usp_XuatDSLopHoc 'A075';

SELECT * FROM HocVien ORDER BY MaLop;

-- Xuất danh sách sinh viên chưa đóng đủ học phí của 1 lớp
-- Lop.MaLop, Lop.HocPhi, HocVien.MSHV, HocVien.Ho, HocVien.Ten, HocPhi.SoTien
CREATE PROC usp_XuatDSHocVienChuaDuHocPhi
@MaLop CHAR(4)
AS
	IF NOT EXISTS (SELECT * FROM Lop WHERE MaLop = @MaLop)
		PRINT N'Lớp không tồn tại'
	ELSE 
		BEGIN
			SELECT Lop.MaLop, Lop.HocPhi, HocVien.MSHV, HocVien.Ho, HocVien.Ten, SUM(HocPhi.SoTien) AS TongSoTien FROM Lop
			JOIN HocVien ON HocVien.MaLop = Lop.MaLop
			JOIN HocPhi ON HocVien.MSHV = HocPhi.MSHV
			WHERE Lop.MaLop = @MaLop
			GROUP BY Lop.MaLop, Lop.HocPhi, HocVien.MSHV, HocVien.Ho, HocVien.Ten
			HAVING SUM(HocPhi.SoTien) < Lop.HocPhi
			ORDER BY HocVien.MSHV
		END
GO

EXEC usp_XuatDSHocVienChuaDuHocPhi 'E114';
EXEC usp_XuatDSHocVienChuaDuHocPhi 'A075';

-------------------------------------------------------------------------------
--------------------HÀM SINH MÃ & CÁCH SỬ DỤNG----------------
---1. Viết hàm sinh mã cho giáo viên mới---
create function SinhMaGV() returns char(4)
As
Begin
	declare @MaxMaGV char(4)
	declare @NewMaGV varchar(4)
	declare @stt	int
	declare @i	int	
	declare @sokyso	int

	if exists(select * from GiaoVien)---Nếu bảng giáo viên có dữ liệu
	 begin
		--Lấy mã giáo viên lớn nhất hiện có
		select @MaxMaGV = max(MSGV) 
		from GiaoVien
		--Trích phần ký số của mã lớn nhất và chuyển thành số 
		set @stt=convert(int, right(@MaxMaGV,3)) + 1 --Số thứ tự của giáo viên mới
	 end
	else--Nếu bảng giáo viên đang rỗng (nghĩa là chưa có giáo viên nào được lưu trữ trong CSDL.
	 set @stt= 1 -- Số thứ tự của giáo viên trong trường hợp chưa có gv nào trong CSDL
	--Kiểm tra và bổ sung chữ số 0 để đủ 3 ký số trong mã gv.
	set @sokyso = len(convert(varchar(3), @stt))
	set @NewMaGV='G'
	set @i = 0
	while @i < 3 -@sokyso
		begin
			set @NewMaGV = @NewMaGV + '0'
			set @i = @i + 1
		end	
	set @NewMaGV = @NewMaGV + convert(varchar(3), @stt)

return @NewMaGV	
End
--Thử hàm sinh mã
print dbo.SinhMaGV()
----2. Thủ  tục thêm giáo viên với mã giáo viên được sinh tự động----
CREATE PROC usp_ThemGiaoVien2
@hogv nvarchar(20), @tengv nvarchar(10), @dthoai varchar(10)
As
	declare @Magv char(4)
	
 if not exists(select * from GiaoVien 
				where HoGV = @hogv and TenGV = @tengv and DienThoai = @dthoai)
	Begin
		
		--sinh mã cho giáo viên mới
		set @Magv = dbo.SinhMaGV()
		insert into GiaoVien values(@Magv, @hogv, @tengv,@dthoai)
		print N'Đã thêm giáo viên thành công'
	End
else
	print N'Đã có giáo viên ' + @hogv +' ' + @tengv + ' trong CSDL'
Go
---Sử dụng thủ tục thêm giáo viên
exec usp_ThemGiaoVien2 N'Trần Ngọc Bảo', N'Hân', '0123456789'
exec usp_ThemGiaoVien2 N'Vũ Minh', N'Triết', '0123456788'
select * from GiaoVien




------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN----------------
/*4a) Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó 
(RBTV liên thuộc tính)*/
Create trigger tr_CaHoc_ins_upd_GioBD_GioKT
On CaHoc  for insert, update
As
if  update(GioBatDau) or update (GioKetThuc)
	     if exists(select * from inserted i where i.GioKetThuc<i.GioBatDau)	
	      begin
	    	     raiserror (N'Giờ kết thúc ca học không thể nhỏ hơn giờ bắt đầu',15,1)
		     rollback tran
	      end
go	
-----thử nghiệm hoạt động của trigger tr_CaHoc_ins_upd_GioBD_GioKT----
--insert into CaHoc values(4,'17:00','15:30')
--Update CaHoc set GioKetThuc = '5:45' where ca = 1
/* 4b): Số học viên của 1 lớp không quá 30 và đúng bằng số học viên thuộc lớp đó. 
(RBTV do thuộc tính tổng hợp)*/
create trigger trg_Lop_ins_upd
on Lop for insert,update
AS
if Update(MaLop) or Update(SoHV)
Begin
	if exists(select * from inserted i where i.SOHV>30) 
	begin
		raiserror (N'Số học viên của một lớp không quá 30',15,1)--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
	if exists (select * from inserted l 
	              where l.SOHV <> (select count(MSHV) 
									from HocVien 
									where HocVien.Malop = l.Malop))
	begin
		raiserror (N'Số học viên của một lớp không bằng số lượng học viên tại lớp đó',15,1)
		--Thông báo lỗi cho người dùng
		rollback tran --hủy bỏ thao tác thêm lớp học
	end
End
	
Go
-- Thử nghiệm 
select * from Lop
Set dateformat dmy
go
insert into Lop values('P001',N'Photoshop','1/11/2018',250000,1,100,0,'G004')
update Lop set SoHV = 5 where MaLop = 'P001'
/*4b): Cài đặt trigger cho bảng HocVien*/

/*4c) Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký học*/
CREATE TRIGGER trg_HocPhi
ON HocPhi FOR INSERT, UPDATE
AS
	IF UPDATE(SoTien)
	BEGIN
		IF EXISTS (
			SELECT * FROM Lop
			JOIN HocVien ON HocVien.MaLop = Lop.MaLop
			JOIN HocPhi ON HocVien.MSHV = HocPhi.MSHV
			
			GROUP BY Lop.MaLop, Lop.HocPhi, HocVien.MSHV, HocVien.Ho, HocVien.Ten
			HAVING SUM(HocPhi.SoTien) > Lop.HocPhi
		)
			PRINT N'Tổng tiền thu 1 học viên vượt quá học phí của lớp!'
	END
GO

SELECT * FROM HocPhi
UPDATE HocPhi
SET SoTien = 200000
WHERE MSHV = '0001'

			SELECT * FROM Lop
			JOIN HocVien ON HocVien.MaLop = Lop.MaLop
			JOIN HocPhi ON HocVien.MSHV = HocPhi.MSHV

--5a) Hàm tính tổng số học phí đã thu được của một lớp khi biết mã lớp. 
create function fn_TongHocPhi1Lop(@malop char(4)) returns int
As
Begin
	declare @TongTien int
	if exists (select * from Lop where MaLop = @MaLop) ---Nếu tồn tại lớp @malop trong CSDL
		Begin
			--Tính tổng số học phí thu được trên 1 lớp
			select @TongTien = sum(SoTien)
			from	HocPhi A
			JOIN    HocVien B ON A.MSHV = B.MSHV
			where	B.Malop = @malop
		End	
	 	
return @TongTien
End
--- thu nghiem ham-------
print dbo.fn_TongHocPhi1Lop('A075')
--5b) Hàm tính tổng số học phí thu được trong một khoảng thời gian cho trước. 
create function fn_TongHocPhi(@bd datetime,@kt datetime) returns int
As
Begin
	declare @TongTien int
	--Tính tổng số học phí thu được trong khoảng thời gian từ bắt đầu đến kết thúc
	select @TongTien = sum(SoTien)
	from	HocPhi 	
	where	NgayThu between @bd and @kt
return @TongTien
End
--- thu nghiem ham-------
set dateformat dmy
print dbo.fn_TongHocPhi('1/1/2008','15/1/2008')
--5c) Cho biết một học viên cho trước đã nộp đủ học phí hay chưa. 


--5d) Hàm sinh mã số học viên theo quy tắc mã số học viên gồm mã lớp của học viên kết hợp với số thứ tự của học viên trong lớp đó. 

