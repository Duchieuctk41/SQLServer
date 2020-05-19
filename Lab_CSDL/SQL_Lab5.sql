
/*Học phần: Cơ Sở Dữ Liệu
Người thực hiện:
MSSV:
Ngày:
*/

Create Database Lab5_QLHV
go
use Lab5_QLHV
go
Create Table CaHoc
(Ca char(1) primary key,
GioBatDau datetime,
GioKetThuc datetime
)
go
Create Table GiaoVien
(MSGV char(4) primary key,
HoGV nvarchar(15) not null,
TenGV nchar(6) not null,
DienThoai varchar(6)
)
go
Create Table Lop
(MaLop char(4) primary key,
TenLop varchar(15) ,
NgayKG datetime,
HocPhi int,
Ca char(1) references CaHoc(Ca),
SoTiet int,
SoHV tinyint,
MSGV char(4) references GiaoVien(MSGV)
)
go
Create Table HocVien
(MSHV char(6) primary key,
Ho nvarchar(14) not null,
Ten nvarchar(7) not null,
NgaySinh datetime,
Phai nchar(4),
MaLop char(4) references Lop(MaLop)
)
go
Create Table HocPhi
(SoBL char(4) primary key,
MSHV char(6) references HocVien(MSHV),
NgayThu datetime,
SoTien int,
NoiDung varchar(17) not null,
NguoiThu nchar(4) not null 
)
----------NHAP DU LIEU-----------
insert into CaHoc values('1','7:30','10:45')
insert into CaHoc values('2','13:30','16:45')
insert into CaHoc values('3','17:30','20:45')
select * from CaHoc

insert into GiaoVien values('G001',N'Lê Hoàng',N'Anh','858936')
insert into GiaoVien values('G002',N'Nguyễn Ngọc',N'Lan','845623')
insert into GiaoVien values('G003',N'Trần Minh',N'Hùng','823456')
insert into GiaoVien values('G004',N'Võ Thanh',N'Trung','841256')
select * from GiaoVien

insert into Lop values('E114','Excel 3-5-7','01/02/2008',120000,'1',45,3,'G003')
insert into Lop values('E115','Excel 2-4-6','01/22/2008',120000,'3',45,0,'G001')
insert into Lop values('W123','Word 2-4-6','02/18/2008',100000,'3',30,1,'G001')
insert into Lop values('W124','Word 3-5-7','01/03/2008',100000,'1',30,0,'G002')
insert into Lop values('A075','Access 2-4-6','12/18/2008',150000,'3',60,3,'G003')


Select * from Lop

insert into HocVien values('A07501',N'Lê Văn',N'Minh','06/10/1998',N'Nam','A075')
insert into HocVien values('A07502',N'Nguyễn Thị',N'Mai','04/20/1998',N'Nữ','A075')
insert into HocVien values('A07503',N'Lê Ngọc',N'Tuấn','06/10/1994',N'Nam','A075')
insert into HocVien values('E11401',N'Vương Tuấn',N'Vũ','03/25/1999',N'Nam','E114')
insert into HocVien values('E11402',N'Lý Ngọc',N'Hân','12/01/1995',N'Nữ','E114')
insert into HocVien values('E11403',N'Trần Mai',N'Linh','06/04/1990',N'Nữ','E114')
insert into HocVien values('W12301',N'Nguyễn Ngọc',N'Tuyết','05/12/1996',N'Nữ','W123')


select * from HocVien
 insert into HocPhi values('0001','E11401','01/02/2008',120000,'HP Excel 3-5-7',N'Vân')
 insert into HocPhi values('0002','E11402','01/02/2008',120000,'HP Excel 3-5-7',N'Vân')
 insert into HocPhi values('0003','E11403','01/02/2008',80000,'HP Excel 3-5-7',N'Vân')
 insert into HocPhi values('0004','W12301','02/18/2008',100000,'HP Word 2-4-6',N'Lan')
 insert into HocPhi values('0005','A07501','12/16/2008',150000,'HP Access 2-4-6',N'Lan')
 insert into HocPhi values('0006','A07502','02/18/2008',100000,'HP Access 2-4-6',N'Lan')
  insert into HocPhi values('0007','A07503','12/18/2008',150000,'HP Access 2-4-6',N'Vân')
 insert into HocPhi values('0008','A07502','01/15/2009',50000,'HP Access 2-4-6',N'Vân')

 Select * from HocPhi
 
 ------------------------------------CÀI ĐẶT RÀNG BUỘC TOÀN VẸN-----------------------------------
 --Câu a)Giờ kết thúc của một ca học không được trước giờ bắt đầu ca học đó
 create trigger trg_Cahoc_insert_update
 on CaHoc for insert,update
 AS
if Update(GioBatDau) or Update(GioKetThuc)
	if exists(select * from inserted i where i.GioKetThuc<= i.GioBatDau)
	begin
		raiserror (N'Giờ kết thúc một ca học không thể nhỏ hơn giờ bắt đầu ca học đó',15,1)
		rollback tran 
	end
Go

select * From CaHoc 
insert into CaHoc values(4,'8:00','7:00')
Update CaHoc set GioBatDau='11:00' where Ca=1
--Câu b)Sĩ số(SoHV) của một lớp học không quá 30 học viên và đúng bằng số học viên thuộc lớp đó
create trigger trg_Lop_insert_update
on Lop for insert,update
 As
if UPDATE(MaLop) or UPDATE(SoHV)
	if exists(select* from inserted i where i.SoHV>30)
	begin 
	raiserror (N'Số học viên không được quá 30',15,1)
	rollback tran
end
	if exists (select * from inserted k where k.SoHV <>  (select COUNT(MSHV)
																from HocVien
																where HocVien.MaLop=k.MaLop))
											
	begin
	raiserror(N'Số học viên không đúng bằng số học viên thuộc lớp đó',15,1)
	rollback tran
	end


insert into Lop values ('C012','Laptrinh',12/8/2008,120000,'2',45,40,'G002')
drop trigger trg_Lop_insert_update
select *from Lop
delete Lop where MaLop='C012'
update Lop set SoHV = 5 where MaLop = 'P001'
update Lop set SoHV = 5 where MaLop = 'E114'
	--Trả giá trị SoHV =3 Cho MaLop E114:	
		update Lop
		set SoHV=3
		where MaLop='E114'
--Câu c)Tổng số tiền thu của một học viên không vượt quá học phí của lớp mà học viên đó đăng ký
create trigger trg_HocPhi_insert_update
on HocPhi for insert,update
As
declare @TongTienThu int
declare @HocPhiLop int
--Tính tổng tiền thu của học viên đối với lớp đang xét
select @TongTienThu = SUM(SoTien)
from HocPhi
where HocPhi.MSHV in (select MSHV
						FROM inserted)
					
--Lấy mức học phí của lớp của của học viên dang xét
SELECT @HocPhiLop  = HocPhi
FROM Lop 
WHERE Lop.MaLop IN (SELECT MaLop
FROM HocVien,INSERTED
WHERE HocVien.MSHV=INSERTED.MSHV)
if @TongTienThu > @HocPhiLop
	begin
	raiserror(N'Số tiền đóng của mỗi học viên không được quá học phí',15,1)
	rollback tran
	end		
	
	 insert into HocPhi values('0009','A07502','01/15/2009',200000,'HP Access 2-4-6',N'Vân')	
	 insert into HocPhi values('0010','E11403','01/15/2009',40000,'HP Excel 3-5-7',N'Vân')	
	 insert into HocPhi values('0009','A07502','01/15/2009',200000,'HP Access 2-4-6',N'Vân')		
	 
	 Update HocPhi set SoTien='160000' where SoBL='0001'	
----------------------------------------------CÀI ĐẶT THỦ TỤC---------------------------------------------------------
--Câu a) Thêm dữ liệu vào bảng


--Câu b) Cập nhật thông tin của một học viên cho trước mã số học viên:
	alter proc usp_Update_ThongTin_HocVien 
@mshv char(6), @Ho nvarchar(14),@Ten nvarchar(7),@NgaySinh datetime,@Phai nchar(4),@Malop char(4)
As
if  EXISTS(SELECT *FROM HocVien where MSHV=@mshv)--Kiểm tra xem đã tồn tại học viên đó chưa
		begin
		Update HocVien
		set MSHV=@mshv,Ho=@Ho,Ten=@Ten,NgaySinh=@NgaySinh,Phai=@Phai,Malop=@Malop
		print N'Đã cập nhật dữ liệu thành công!'
		end
else
	print N'Chưa có học viên '+ @mshv + N' trong cơ sở dữ liệu'
Go	
--cập nhật lại học viên A07501
	exec  usp_Update_ThongTin_HocVien 'A07501',N'Lê Văn',N'Minh','06/10/1998',N'Nam','A075' 
	select * from HocVien
--Cập nhật với học viên chưa có mã số học viên trong dữ liệu
	exec  usp_Update_ThongTin_HocVien 'B07501',N'Lê Văn',N'Minh','06/10/1998',N'Nam','A075' 


--Câu c)Xóa một học viên cho trước (cho trước mã số học viên)
ALTER PROC Xoa_HocVien_ChoTruoc 
@mshv char(6)
As
if exists (select * from HocVien Where MSHV=@mshv)
	begin
	delete from HocPhi where MSHV=@mshv
	delete from HocVien where MSHV=@mshv
	
	print N'Đã xóa thành công'
	end
else
	print N'Không tồn tại '+ @mshv+ N' trong cơ sở dữ liệu'
Go

exec Xoa_HocVien_ChoTruoc 'E11401'
select * from HocVien
--Câu d)Cập nhật thông tin của một lớp học cho trước MÃ LỚP.Cập nhật tất cả
ALTER PROC usp_CapNhat_Lop
@malop char(4),@tenlop varchar(15),@ngaykg datetime,@hp int,@ca char(1),@sotiet int, @sohv tinyint,@msgv char(4)
As
if exists (select *from Lop where MaLop=@malop)
 Begin
 update Lop
 set TenLop=@tenlop,NgayKG=@ngaykg,HocPhi=@hp,Ca=@ca,SoHV=@sohv,MSGV=@msgv
 where MaLop=@malop
 print N'Đã cập nhật thành công!'
 end
else 
print N'Không tồn tại '+@malop +N' trong cơ sở dữ liệu'
Go

exec usp_CapNhat_Lop 'E114','Excel 2-3-7','01/02/2008',120000,'1',45,7,'G003'
select *from Lop

drop table HocPhi
drop table HocVien
drop table Lop
--Câu e) Xóa một lớp học cho trước nếu lớp học này không có học viên
CREATE PROC usp_XoaLopHoc_KhongCoHV
As
if exists (select * from Lop where SoHV=0)
	begin
	delete from Lop where SoHV=0
	print N'Đã xóa thành công!'
	end
else 
	print N'Không tồn tại lớp không có học viên trong cơ sở dữ liệu'
Go
exec usp_XoaLopHoc_KhongCoHV

select *from Lop
--Câu f)Lập danh sách học viên của một lớp cho trước: theo mã lớp
ALTER PROC usp_LapDS_HOCVIEN 
@malop char(4)
AS
if exists (select * from Lop where MaLop=@malop)
 begin
 select MSHV,Ho,Ten,NgaySinh,Phai
 from HocVien A,Lop B
 where A.Malop=B.Malop AND B.Malop=@malop
 
 end
 else
 print N'Không tồn tại lớp có mã lớp ' +@malop+ N' trong cơ sở dữ liệu'
 Go
 
 exec usp_LapDS_HOCVIEN 'A075'
 exec usp_LapDS_HOCVIEN 'A175'
 exec usp_LapDS_HOCVIEN 'W123'
 exec usp_LapDS_HOCVIEN 'W124'
--Câu g)Lập danh sách học viên chưa đóng đủ học phí của một lớp cho trước khi biết mã lớp
---------------------------------------CÀI ĐẶT HÀM---------------------------------------
--Câu a)Tính tổng số học phí đã thu được của một lớp khi biết mã lớp
CREATE FUNCTION TongHP1Lop( @ml char(4))
returns int
As
Begin
declare @TongTien int
select @TongTien=sum(SoTien)
from HocPhi A,HocVien B
where A.MSHV=B.MSHV and B.Malop=@ml
return @TongTien
End

select dbo.TongHP1Lop( 'W123')
select dbo.TongHP1Lop( 'A075')
print dbo.TongHP1Lop( 'W123')
--Câu b)Tính tổng số học phí thu được trong một khoảng thời gian cho trước: cho trước ngày thu
alter FUNCTION TongTien_TheoNgayThu (@ngaythu datetime)
returns int
As
Begin
declare @TT int
select @TT= sum(SoTien)
from HocPhi A
where A.NgayThu=@ngaythu 

return @TT
End

select dbo.TongTien_TheoNgayThu ('01/02/2008')
--Câu c)Cho biết một học viên cho trước đã nộp đủ học phí hay chưa




    
 
 
 
