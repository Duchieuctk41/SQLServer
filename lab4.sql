create database lab4
go
use lab4
go
create table BAO_TCHI
(
MaBaoTC char(4) primary key,
Ten nvarchar(30) not null,
DinhKy nvarchar(30),
SoLuong int check(SoLuong > 0),
GiaBan int check(GiaBan >0)
)
create table PHATTHANH
(
MaBaoTC char(4) references BAO_TCHI(MaBaoTC),
SoBaoTC  int,
NgayPH datetime
primary key(MaBaoTC,SoBaoTC)
)
create table KHACHHANG
(
MaKH char(4) primary key,
TenKH nvarchar(10) not null,
DiaChi varchar(50)
)
create table DATBAO
(
MaKH char(4) references KHACHHANG(MaKH),
MaBaoTC char(4) references Bao_TChi(MaBaoTC),
SLMua int check(SLMua > 0),
NgayDM datetime
primary key(MaKH, MaBaoTC)
)

-----------CÁC THỦ TỤC THÊM DỮ LIỆU-------------
CREATE PROC usp_Insert_BaoTChi
@MaBaoTC char(4), @Ten nvarchar(30), @DinhKy nvarchar(20),@sl int, @giaban int
as
if exists(select * from BAO_TCHI where MaBaoTC = @MaBaoTC)
print N'Da co ma bao '+ @MaBaoTC + 'trong CSDL!'
else
begin
insert into BAO_TCHI values(@MaBaoTC, @Ten, @DinhKy,@sl, @giaban)
print N'Them bao chi thanh cong.'
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
-------------------------------------------------------------------------
CREATE PROC usp_Insert_PhatHanh
@MaBaoTC char(4), @SoBaoTC  int, @NgayPH datetime
as
if exists(select * from BAO_TCHI where MaBaoTC = @MaBaoTC) -- kt rbtv khoa ngoai
begin
if exists(select * from PHATTHANH where MaBaoTC = @MaBaoTC and SoBaoTC = @SoBaoTC)
print N'Da co so bao ' + @MaBaoTC +' ' + @SoBaoTC + ' trong csdl'
else
begin
insert into PHATTHANH values(@MaBaoTC, @SoBaoTC, @NgayPH)
print N'Them phat hanh bao thanh cong.'
end
End
else
print N'vi pham rbtv khoa ngoai: khong ton tai ma bao tap chi' + @MaBaoTC + ' trong csdl.'
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
select * from PHATTHANH
---------------------------------------------------------------------
CREATE PROC usp_Insert_KhachHang
@MaKH char(4), @TenKH nvarchar(10), @DiaChi varchar(50)
as
if exists(select * from KHACHHANG where MaKH = @MaKH)
print N'Da khach hang ' + @MaKH + ' trong CSDL'
else
begin
insert into KHACHHANG values(@MaKH, @TenKH, @DiaChi)
print N'Them Khach hang thanh cong.'
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
select * from DATBAO

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
--1) Cho biết các tờ báo, tạp chí (MABAOTC, TEN, GIABAN) có định kỳ phát hành hàng tuần (Tuần báo).
select MaBaoTC, Ten, GiaBan
from BAO_TCHI
where DinhKy = N'Tuần báo'

--2)Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ ( mã báo tạp chí bắt đầu bằng PN).
select MaBaoTC, Ten, DinhKy, SoLuong, GiaBan
from BAO_TCHI
where MaBaoTC like N'PN%'
--3)Cho biết tên các khách hàng có đặt mua báo phụ nữ(mã báo tạp chí bắt đầu bằng PN),
--không liệt kê khách hàng trùng
select TenKH
from KHACHHANG a, DATBAO b
where a.MaKH = b.MaKH and MaBaoTC like N'PN%'

--III. HÀM & THỦ TỤC
--A.	Viết các hàm sau:
--a.	Tính tổng số tiền mua báo/tạp chí của một khách hàng cho trước.
create function ufn_TongTienBao (@MaKH char(4))
returns int 
as
begin
declare @tong int
select @tong = sum(SLMua*GiaBan)
from DATBAO a, BAO_TCHI b
where A.MaBaoTC = B.MaBaoTC and MaKH = @MaKH
return @tong
end

---Thử nghiệm hàm ufn_TongTienBao
		select dbo.ufn_TongTienBao('KH01') as tongtienbao

		select	A.MaBaoTC, SLMua, GiaBan, SLMua*GiaBan As ThanhTien
	from	DatBao A, Bao_TChi B	
	where	A.MaBaoTC = B.MaBaoTC and MaKH = 'KH01'

--b.	Tính tổng số tiền thu được của một tờ báo/tạp chí cho trước

create function ufn_DoanhThu(@MaBaoTC char(4))
returns int
as
begin
declare @tong int
select @tong = sum(SLMua * GiaBan)
from DATBAO a, BAO_TCHI b
where a.MaBaoTC = b.MaBaoTC and a.MaBaoTC = @MaBaoTC

return @tong
end

select dbo.ufn_DoanhThu('PN01') as thanhtien

--a.	In danh mục báo, tạp chí phải giao cho một khách hàng cho trước.
create proc usp_InDanhMuc_BaoTC
@MaKH char(4)
as
select Ten, DinhKy, SLMua
from DATBAO a, BAO_TCHI b
where a.MaBaoTC = b.MaBaoTC and a.MaKH = @MaKH
go
--gọi thủ tục usp_InDanhMuc_BaoTC
exec usp_InDanhMuc_BaoTC 'KH01'

--b.	In danh sách khách hàng đặt mua báo/tạp chí cho trước.
create proc usp_InDS_BaoTC
@MaBaoTC char(4)
as
select TenKH, DiaChi
from DATBAO a, KHACHHANG b
where a.MaKH = b.MaKH and MaBaoTC = @MaBaoTC
go

exec usp_InDS_BaoTC 'TT01'
