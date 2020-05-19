/*Học phần: Cơ Sở Dữ Liệu
Người thực hiện:
MSSV:
Ngày:
*/
Create database Lab6_QL_Thuvien
go
use Lab6_QL_Thuvien

Create table TheLoai
(MATL char(2) primary key,
TENTL nvarchar(10)
)
go
Create table NhaXuatBan
( MANXB char(4) primary key,
TenNXB nvarchar(20) 
)
go
Create table Sach
(MaSach varchar(6) primary key,
TuaDe nvarchar(35) not null,
MANXB char(4) references NhaXuatBan(MANXB),
TacGia nvarchar(17),
SoLuong tinyint ,
NgayNhap date,
MaTL char(2) references TheLoai(MATL)
)
go
Create table BanDoc
(MaThe char(6) primary key,
TenBanDoc nvarchar(13) not null,
DiaChi nvarchar(17),
SoDT char(6)
)
go
Create table MuonSach
(MaThe char(6) references BanDoc(MaThe),
MaSach varchar(6) references Sach(MaSach),
NgayMuon date ,
NgayTra date null
primary key(MaThe, MaSach, NgayMuon)
)
-----------------NHẬP DỮ LIỆU-------------
insert into TheLoai values ('TH',N'Tin học')
insert into TheLoai values ('HH',N'Hóa học')
insert into TheLoai values ('KT',N'Kinh tế')
insert into TheLoai values ('TN',N'Toán học')

select *from TheLoai
go

insert into NhaXuatBan values('N001',N'Giáo dục')
insert into NhaXuatBan values('N002',N'Khoa học kỹ thuật')
insert into NhaXuatBan values('N003',N'Thống kê')

select *from NhaXuatBan
go

insert into Sach values('TH0001',N'Sử dụng Corel Draw','N002',N'Đậu Quang Tuấn',3,'08/09/2005','TH')
insert into Sach values('TH0002',N'Lập trình mạng','N003',N'Phạm Vĩnh Hưng',2,'03/12/2003','TH')
insert into Sach values('TH0003',N'Thiết kế mạng chuyên nghiệp','N002',N'Phạm Vĩnh Hưng',5,'04/05/2003','TH')
insert into Sach values('TH0004',N'Thực hành mạng','N003',N'Trần Quang',3,'06/05/2004','TH')
insert into Sach values('TH0005',N'3D Studio kỹ xảo hoạt hình T1','N001',N'Trương Bình',2,'05/02/2004','TH')
insert into Sach values('TH0006',N'3D Studio kỹ xảo hoạt hình T2','N001',N'Trương Bình',3,'05/06/2004','TH')
insert into Sach values('TH0007',N'Giáo trình Access 2000','N001',N'Thiện Tâm',5,'11/12/2005','TH')
select *from Sach
go

insert into BanDoc values('050001',N'Trần Xuân',N'17 Yersin','858936')
insert into BanDoc values('050002',N'Lê Nam',N'5 Hai Bà Trưng','845623')
insert into BanDoc values('060001',N'Nguyễn Năm',N'10 Lý Tự Trọng','823456')
insert into BanDoc values('060002',N'Trần Hùng',N'20 Trần Phú','841256')
select * from BanDoc

set dateformat dmy
insert into MuonSach values('050001','TH0006','12/12/2006','01/03/2007')
insert into MuonSach values('050001','TH0007','12/12/2006',null)
insert into MuonSach values('050002','TH0001','08/03/2006','15/04/2007')
insert into MuonSach values('050002','TH0004','04/03/2007',null)
insert into MuonSach values('050002','TH0002','04/03/2007','04/04/2007')
insert into MuonSach values('050002','TH0003','02/04/2007','15/04/2007')
insert into MuonSach values('060002','TH0001','08/04/2007',null)
insert into MuonSach values('060002','TH0007','15/03/2007','15/04/2007')
go
select * from MuonSach
--drop table TheLoai
--drop table NhaXuatBan
--drop table Sach
--drop table BanDoc
--drop table MuonSach

--delete MuonSach
--delete BanDoc
--delete Sach
--delete TheLoai
--delete NhaXuatBan

---------------------------CÀI ĐẶT RÀNG BUỘC ------------------------
--1)Thiết lập  mối quan hệ
--2)Cài đặt ràng buộc
--RB1:Số lượng sách >=0
alter trigger trg_SLSach_insert_update
 on Sach for insert,update
 AS
	if exists(select * from inserted i where i.SoLuong < 0)
	begin
		raiserror (N'Số lượng sách phải >=0',15,1)
		rollback tran 
	end
Go



insert into Sach values('TH0010',N'Sử dụng Corel Draw','N002',N'Đậu Quang Tuấn',-4,'08/09/2005','TH')
--Xóa dòng của bảng
delete from Sach
where SoLuong=-1 or SoLuong=-4 

--RB2:Tên nhà xuất bản là duy nhất
create trigger TenXB_DuyNhat
on NhaXuatBan for insert, update
As
	if exists (select * from inserted i where  TenNXB = i.TenNXB )
begin
	raiserror (N'Tên NXB không được trùng nhau',15,1)
	rollback tran
 end
Go

insert into NhaXuatBan values('N006',N'Giáo dục')
--RB3:Tên thể loại là duy nhất
create trigger TenTL_DuyNhat
on TheLoai for update, insert
As
if exists (select * from inserted i where  TENTL = i.TENTL )
begin
	raiserror (N'Tên thể loại không được trùng nhau',15,1)
	rollback tran
 end
Go

insert into TheLoai values ('Tk',N'Toán học')
--RB4.Mã thẻ gồm 6 ký tự, được tạo ra theo quy tắc: hai chữ cuối của năm tạo thẻ ghép với số thứ tự của thẻ trong năm đó(vd 050001 trong đó 05 là năm 2005)
alter function RB4_SinhMaTheoNam()
returns char(6)
As
Begin
declare @max_the varchar(6)
declare @new_the varchar(6)
declare @i int
declare @stt int
declare @Length int
if exists (select *from BanDoc where left(MaThe,2) = (YEAR(GETDATE()) - 2000))
	begin
	select @max_the = MAX(MaThe) from BanDoc
	set @stt= convert(int,right(@max_the,4)) + 1
	end
else set @stt=1
set @new_the = YEAR(GETDATE()) - 2000
set @i=0
set @Length=LEN(convert(char(4),@stt))
while @i <4-@Length
	begin	
	set @new_the=@new_the+'0'
	set @i=@i+1
	end
set @new_the=@new_the+CONVERT(varchar(4),@stt)
return @new_the
End
--Thêm bạn đọc sau khi viết hàm sinh MaThe tự động
create proc ThemBanDoc 
@TenBanDoc nvarchar(13),
@DiaChi nvarchar(17),
@SoDT char(6)
as
begin
declare @MaThe char(6)
set @MaThe = dbo.RB4_SinhMaTheoNam()
insert into BanDoc values (@MaThe,@TenBanDoc,@DiaChi,@SoDT)
print N'Nhập thành công!'
end

exec ThemBanDoc N'Trần Xuân', N'Trần Hưng Đạo','546544'

select * from BanDoc

--RB5.Mã sách gồm 6 ký tự, được tạo theo quy tắc:mã thể loại ghép với số thứ tự của cuốn sách trong thể loại đó.
--
Create function RB5_SinhMaSach()
returns char(6)
As
begin
declare @max_ma char(6)
declare @new_ma char(6)
declare @stt int
declare @i int
declare @length int
 if exists (select MaTL from Sach where MaTL in (select MaTL from TheLoai))
 begin
 if exists ( select left(MaSach,2) from Sach where left(MaSach,2)=Sach.MaTL )
	begin
	
	set @max_ma=  convert (char(6),(select max(right(MaSach,4)) from Sach where left(MaSach,2)=Sach.MaTL))
	set @stt=convert(int,@max_ma)+1
	set @new_ma = (select MaTL from Sach)+ @stt
	end
else 
set @stt=1
set @i=0
set @new_ma= (select * from Sach where left(MaSach,2)=Sach.MaTL )
set @Length=LEN(convert(char(4),@stt))
while @i <4-@Length
	begin	
	set @new_ma=@new_ma+'0'
	set @i=@i+1
	end
set @new_ma=@new_ma+CONVERT(varchar(4),@stt)

end
return @new_ma
end
---------------------------VIẾT CÁC THỦ TỤC -------------
---3)Thêm, xóa, sửa dữ liệu các bản
---Thêm dữ liệu bảng Thể loại
Create proc DL_TheLoai
@MATL char(2),@TENTL nvarchar(10)
As
insert into TheLoai values(@MATL,@TENTL)
Go

exec DL_TheLoai 'MT',N'Mỹ Thuật'

--------------Thêm dữ liệu bảng Nhà Xuất Bản
Create proc DL_NBX
@MANXB char(4) ,@TenNXB nvarchar(20) 
As
insert into NhaXuatBan values(@MANXB,@TenNXB)
Go

exec DL_NBX 'N006',N'Sự Thật'
select * from NhaXuatBan
--------------Thêm dữ liệu bảng Sach
Create proc DL_Sach
@MaSach varchar(6),@TuaDe nvarchar(35),@MANXB char(4),@TacGia nvarchar(17),@SoLuong tinyint ,@NgayNhap date,@MaTL char(2)
As
Insert into Sach values(@MaSach,@TuaDe,@MANXB,@TacGia,@SoLuong ,@NgayNhap,@MaTL)
Go
exec  DL_Sach 'TH0009',N'Giáo trình','N001',N'Anh Tuyet',5,'11/12/2005','TH'
select  * from Sach
-------Thêm dữ liệu vào bảng bạn đọc
Create proc DL_BanDoc
@MaThe char(6),@TenBanDoc nvarchar(13),@DiaChi nvarchar(17),@SoDT char(6)
As
insert into BanDoc values(@MaThe,@TenBanDoc,@DiaChi,@SoDT)
Go
select  * from Sach
exec  DL_BanDoc'050001',N'Trần Xuân',N'17 Yersin','858936'
-------Thêm dữ liệu vào bảng Mượn sách
Create proc DL_MuonSach
@MaThe char(6),@MaSach varchar(6),@NgayMuon date ,@NgayTra date
As
insert into MuonSach values(@MaThe,@MaSach,@NgayMuon,@NgayTra)
Go
---------Xóa dữ liệu các bảng
create proc Xoa_TheLoai
@MATL char(2)
As
if exists (select * from TheLoai where @MATL= MATL)
begin
delete TheLoai where  @MATL= MATL
end
else
print N'Không có mã thể loại đó tồn tại trong csdl'
Go
exec Xoa_TheLoai'HH'
exec Xoa_TheLoai'Tk'
------Sửa dữ liệu
Create proc Update_TheLoai
@MATL char(2),@TENTL nvarchar(10)
As
if exists(select *from TheLoai where @MATL=MATL)
begin
update  TheLoai  
set TENTL=@TENTL where @MATL=MATL
end
else
print N'Không có mã thể loại đó tồn tại trong csdl'
Go

exec Update_TheLoai 'TN',N'Thí Nghiệm'
SELECT * FROM TheLoai
--4)
--5)Thủ tục lập danh sách các quyển sách thuộc về một tên thể loại cho trước
alter proc DS_Sach_CungTL
@TENTL nvarchar(10)
As
if exists (select *from TheLoai where @TENTL=TENTL)
begin
	Select MaSach,TuaDe,MANXB,TacGia,SoLuong,NgayNhap,MaTL
	from Sach
	where MaTL in(select MATL from TheLoai where @TENTL=TENTL)
end
else
print N'Không có tên thể loại đó tồn tại trong csdl'
Go
exec DS_Sach_CungTL 'TH' 
exec DS_Sach_CungTL N'Tin học' 
exec DS_Sach_CungTL N'Toán học' 
--6)Viết thủ tục liệt kê những thông tin của tất cả đọc giả còn đang nợ sách
alter proc NoSach
As
if exists (select * from MuonSach where NgayTra is NULL)
begin
select MaThe,TenBanDoc,DiaChi,SoDT
from BanDoc
where MaThe in (select MaThe from MuonSach where NgayTra is NULL)
end
else
print N'Không có bạn đọc nào còn nợ sách trong csdl'
Go
exec NoSach
select * from MuonSach
--7)Viết thủ tục lập danh sách các quyển mà một đọc giả cho trước đã mượn
alter proc Sach_DocGiaMuon
@MaThe char(6)
As
	if exists (select * from MuonSach where MaThe= @MaThe)
begin
	Select TuaDe,MANXB,TacGia
	from Sach a, MuonSach b
	where a.MaSach=B.MaSach and b.MaThe=@MaThe
end
else
print N'bạn đọc có mã thẻ'+@MaThe+ N'chưa mượn sách'
Go
exec Sach_DocGiaMuon '050001'
exec  Sach_DocGiaMuon '060001'
exec  Sach_DocGiaMuon '060002'
--8)Viết thủ tục lập danh sách các quyển sách chưa được mượn
create proc Sach_ChuaMuon
As
select TuaDe,MANXB,TacGia
from Sach a,MuonSach b
where a.MaSach not in (select b.MaSach from MuonSach b)
Go
exec Sach_ChuaMuon
---9)Phát biểu các truy vấn
--a)Cho biết bạn đọc mượn sách nhưng chưa trả gồm:MaThe,TenBanDoc,TuaDe,NgayMuon
select a.MaThe,TenBanDoc,TuaDe,NgayMuon
from BanDoc a,MuonSach b,Sach c
where a.MaThe=b.MaThe and b.NgayTra is null and b.MaSach=c.MaSach
--b)Tìm bạn đọc  mượn nhiều sách nhất:MaThe,TenBanDoc, SoLuong

select a.MaThe,TenBanDoc,COUNT(a.MaThe) as SoLuong
from BanDoc a, MuonSach b
where a.MaThe=b.MaThe
GROUP BY a.MaThe,TenBanDoc
having COUNT(a.MaThe) >=all
							(select count(MaThe)
							from MuonSach
							GROUP BY MaThe)

--c)Cho biết tựa đề những cuốn sách không có bạn đọc mượn
select a.MaSach, TuaDe,MANXB,TacGia
from Sach a, MuonSach b
where a.MaSach not in (select b.MaSach from MuonSach b)
