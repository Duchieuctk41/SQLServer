------------------------------------------------
/* Học phần: Cơ sở dữ liệu
   Ngày: 29/04/2020
   Người thực hiện: Tạ Thị Thu Phượng
   Mã số sinh viên:
   Lab04: Quản lý Đặt Báo
*/
------------------------------------------------
--I. Cài đặt cơ sở dữ liệu trên SQL Server với tên CSDL là Lab04_QLDatBao
--lệnh tạo CSDL
CREATE DATABASE Lab04_QLDatBao
go
--lenh su dyng CSDL
use Lab04_QLDatBao
--lenh tao cac bang
create table Bao_TChi
(MaBaoTC	char(4) primary key, -- khai bao khóa chính
Ten			nvarchar(30) not null,
DinhKy		nvarchar(20), 
SoLuong		int check(SoLuong>0),
GiaBan		int check(GiaBan>0)
)
go
create table PhatHanh
(
MaBaoTC	char(4) references Bao_TChi(MaBaoTC),
SoBaoTC	int,
NgayPH	datetime,
Primary key (MaBaoTC, SoBaoTC) 
)
go
create table KhachHang
(MaKH	char(4) primary key,
TenKH	nvarchar(30) not null,
DiaChi		nvarchar(50)
)
go
create table DatBao
(
MaKH	char(4) references KhachHang(MaKH),
MaBaoTC	char(4) references Bao_TChi(MaBaoTC),
SLMua	int check(SLMua > 0),-- kiểm tra số lượng >0 
NgayDM datetime,
primary key(MaKH, MaBaoTC) --khai báo khóa chính gồm nhiều thuộc tính
)
-----Lệnh xem dữ liệu chứa trong băng------
select * from Bao_TChi
select * from PhatHanh
select * from KhachHang
select * from DatBao
-----------CÁC THỦ TỤC THÊM DỮ LIỆU-------------
CREATE PROC usp_Insert_BaoTChi
@MaBaoTC char(4), @Ten nvarchar(30), @DinhKy nvarchar(20),@sl int, @giaban int
As
if exists(select * from Bao_TChi where MaBaoTC = @MaBaoTC) --kiểm tra có trùng khóa chính (MaBaoTC) 
	print N'Đã có mã báo '+ @MaBaoTC +' trong CSDL!'
Else
	begin
		insert into Bao_TChi values(@MaBaoTC, @Ten, @DinhKy,@sl, @giaban)
		print N'Thêm Báo chí thành công.'
	end
go
--goi thuc hien thu tuc usp_Insert_BaoTChi---
exec usp_Insert_BaoTChi 'TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500
exec usp_Insert_BaoTChi 'KT01',N'Kiến thức ngày nay',N'Bán nguyệt san',3000,6000
exec usp_Insert_BaoTChi 'TN01',N'Thanh niên',N'Nhật báo',1000,2000
exec usp_Insert_BaoTChi 'PN01',N'Phụ nữ',N'Tuần báo',2000,4000
exec usp_Insert_BaoTChi 'PN02',N'Phụ nữ',N'Nhật báo',1000,2000
--xem Bảng Bao_TChi
select * from Bao_TChi
---------------------
CREATE PROC usp_Insert_PhatHanh 
	@MaBaoTC char(4), @SoBaoTC	int, @NgayPH	datetime
As
If exists(select * from Bao_TChi where MaBaoTC = @MaBaoTC) --kiểm tra RBTV khóa ngoại
Begin
if exists(select * from PhatHanh where MaBaoTC = @MaBaoTC and SoBaoTC = @SoBaoTC) --kiểm tra có trùng khóa chính (MaBaoTC, SoBaoTC) 
	print N'Đã có số báo '+ @MaBaoTC +' '+@SoBaoTC+' trong CSDL!'
Else
	begin
		insert into PhatHanh values(@MaBaoTC, @SoBaoTC, @NgayPH)
		print N'Thêm phát hành báo thành công.'
	end
End
Else
	print N'Vi phạm RBTV khóa ngoại: Không tồn tại mã báo tạp chí '+ @MaBaoTC + ' trong CSDL.' 
go
--goi thuc hien thu tuc usp_Insert_PhatHanh---
set dateformat dmy --khai báo định dạng ngày tháng được nhập là dmy
go
exec usp_Insert_PhatHanh 'TT01',123,'15/12/2005'
exec usp_Insert_PhatHanh 'KT01',70,'15/12/2005'
exec usp_Insert_PhatHanh 'TT01',124,'16/12/2005'
exec usp_Insert_PhatHanh 'TN01',256,'17/12/2005'
exec usp_Insert_PhatHanh 'PN01',45,'23/12/2005'
exec usp_Insert_PhatHanh 'PN02',111,'18/12/2005'
exec usp_Insert_PhatHanh 'PN02',112,'19/12/2005'
exec usp_Insert_PhatHanh 'TT01',125,'17/12/2005'
exec usp_Insert_PhatHanh 'PN01',46,'30/12/2005'
--Xem bảng PhatHanh
select * from PhatHanh
---------------------
create PROC usp_Insert_KhachHang
	@MaKH char(4), @TenKH nvarchar(30), @DiaChi	nvarchar(50)
As
if exists(select * from KhachHang where MaKH = @MaKH) --kiểm tra có trùng khóa chính (MaKH) 
	print N'Đã có khách hàng '+ @MaKH +' trong CSDL!'
Else
	begin
		insert into KhachHang values(@MaKH, @TenKH, @DiaChi)
		print N'Thêm khách hàng thành công.'
	end
go
--goi thuc hien thu tuc usp_Insert_KhachHang---
exec usp_Insert_KhachHang 'KH01',N'LAN',N'2 NCT'
exec usp_Insert_KhachHang 'KH02',N'NAM',N'32 THĐ'
exec usp_Insert_KhachHang 'KH03',N'NGỌC',N'16 LHP'
--xem bảng KhachHang
select * from KhachHang
----------------------
create PROC usp_Insert_DatBao
	@MaKH char(4), @MaBaoTC	char(4), @SLMua	int, @NgayDM datetime
As
If exists(select * from Bao_TChi where MaBaoTC = @MaBaoTC) and exists(select * from KhachHang where MaKH=@MaKH)--kiểm tra RBTV khóa ngoại
Begin
if exists(select * from DatBao where MaKH = @MaKH and MaBaoTC= @MaBaoTC) --kiểm tra có trùng khóa 
	print N'Đã có thông tin đặt báo '+@MaKH + ', '+ @MaBaoTC +' này trong CSDL!'
Else
	begin
		insert into DatBao values(@MaKH, @MaBaoTC, @SLMua, @NgayDM)
		print N'Thêm đặt báo thành công.'
	end
End
Else
	if not exists(select * from Bao_TChi where MaBaoTC = @MaBaoTC)
		print N'Không có báo, tạp chí '+@MaBaoTC+' trong CSDL.'
	else	print N'Không có khách hàng '+@MaKH+' trong CSDL.'
go
----goi thuc hien thu tuc usp_Insert_DatBao-------
set dateformat dmy
go
exec usp_Insert_DatBao 'KH01','TT01',100,'12/01/2000'
exec usp_Insert_DatBao 'KH02','TN01',150,'01/05/2001'
exec usp_Insert_DatBao 'KH01','PN01',200,'25/06/2001'
exec usp_Insert_DatBao 'KH03','KT01',50,'17/03/2002'
exec usp_Insert_DatBao 'KH03','PN02',200,'26/08/2003'
exec usp_Insert_DatBao 'KH02','TT01',250,'15/01/2004'
exec usp_Insert_DatBao 'KH01','KT01',300,'14/10/2004'
--Xem bảng DatBao
select * from DatBao
--TH1: vi phạm RB khóa chính
set dateformat dmy
go
exec usp_Insert_DatBao 'KH01','TT01',150,'29/04/2020'
--TH2: Vi phạm RB khóa ngoại về MaKH
set dateformat dmy
go
exec usp_Insert_DatBao 'KH04','TT01',150,'29/04/2020'
--TH3: Vi phạm RB khóa ngoại về MaBaoTC
set dateformat dmy
go
exec usp_Insert_DatBao 'KH01','CA01',150,'29/04/2020'

----------------------------------------------------------------------------------------------
--II.TRUY VẤN DỮ LIỆU:
--1)	Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo).
--2)	Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
--3)	Cho biết tên các khách hàng có đặt mua báo phụ nữ (mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng.
--4)	Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ (mã báo tạp chí bắt đầu bằng PN).
--5)	Cho biết các khách hàng không đặt mua báo thanh niên.
--6)	Cho biết số tờ báo mà mỗi khách hàng đã đặt mua.
--7)	Cho biết số khách hàng đặt mua báo trong năm 2004.
--8)	Cho biết thông tin đặt mua báo của các khách hàng (TenKH, TeN, DinhKy, SLMua, SoTien), trong đó SoTien = SLMua  DonGia. 
--9)	Cho biết các tờ báo, tạp chí (Ten, DinhKy) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
--10)	Cho biết tên các tờ báo dành cho học sinh, sinh viên (mã báo tạp chí bắt đầu bằng HS).
--11)	Cho biết những tờ báo không có người đặt mua.
--12)	Cho biết tên, định kỳ của những tờ báo có nhiều người đặt mua nhất.
--13)	Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất.
--14)	Cho biết các tờ báo phát hành định kỳ một tháng 2 lần.
--15)	Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên.

------------------------------------------------------------------------------------------------
--III. HÀM & THỦ TỤC
--A.	Viết các hàm sau:
--a.	Tính tổng số tiền mua báo/tạp chí của một khách hàng cho trước.
create function ufn_TongTienBao (@MaKH char(4)) 
	returns int
As
Begin
	declare @tong int
	select	@tong = sum(SLMua*GiaBan)
	from	DatBao A, Bao_TChi B	
	where	A.MaBaoTC = B.MaBaoTC and MaKH = @MaKH
	
	return @tong
End
---Thử nghiệm hàm ufn_TongTienBao
		select dbo.ufn_TongTienBao('KH01')
--
	select	A.MaBaoTC, SLMua, GiaBan, SLMua*GiaBan As ThanhTien
	from	DatBao A, Bao_TChi B	
	where	A.MaBaoTC = B.MaBaoTC and MaKH = 'KH01'


--b.	Tính tổng số tiền thu được của một tờ báo/tạp chí cho trước
create function ufn_DoanhThu(@MaBaoTC char(4)) 
	returns int
As
Begin
	declare @tong int
	select	@tong = sum(SLMua*GiaBan)
	from	DatBao A, Bao_TChi B	
	where	A.MaBaoTC = B.MaBaoTC and A.MaBaoTC = @MaBaoTC
	
	return @tong
End
---Thử nghiệm hàm ufn_DoanhThu
select dbo.ufn_DoanhThu('PN01')
--B.	Viết các thủ tục sau:
--a.	In danh mục báo, tạp chí phải giao cho một khách hàng cho trước.
create proc usp_InDanhMuc_BaoTC
	@MaKH char(4)
As
	Select	Ten, DinhKy, SLMua
	From	Bao_TChi A, DatBao B
	Where	A.MaBaoTC = B.MaBaoTC and MaKH = @MaKH
go
--gọi thủ tục usp_InDanhMuc_BaoTC
exec usp_InDanhMuc_BaoTC 'KH01'
--b.	In danh sách khách hàng đặt mua báo/tạp chí cho trước.
create proc usp_InDSKhachHang
	@MaBaoTC char(4)
As
	Select	TenKH, DiaChi
	From	KhachHang A, DatBao B
	Where	A.MaKH = B.MaKH and MaBaoTC = @MaBaoTC
go
--gọi thủ tục usp_InDSKhachHang
exec usp_InDSKhachHang 'TT01'