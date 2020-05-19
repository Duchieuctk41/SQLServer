/* Học phần: Cơ sở dữ liệu
   Người thực hiện: Nguyễn Đức Hiếu
   MSSV: 1710172
   Lớp: CTK41
*/

Create database Lab08
go

use Lab08
go

create table KHOA
(MSKhoa nchar(2) primary key,
TenKhoa nvarchar(30) not null unique,
TenTat nchar(4) not null unique);

go
create table Lop
(MSLop nchar(4) primary key,
TenLop nvarchar(30) not null unique,
MSKhoa nchar(2) references KHOA(MSKhoa),
NienKhoa nchar(4) not null);

go
create table Tinh
(MSTinh nchar(2) primary key,
TenTinh nvarchar(20) not null unique);

go
create table MonHoc
(MSMH nchar(4) primary key,
TenMH nvarchar(30) not null,
HeSo tinyint not null);

go
create table SinhVien
(MSSV nchar(7) primary key,
Ho nvarchar(20) not null,
Ten nchar(10) not null,
NgaySinh date not null,
MSTinh nchar(2) references TINH(MSTinh),
NgayNhapHoc date not null,
MSLop nchar(4) references LOP(MSLop),
Phai bit not null,
DiaChi nvarchar(30) not null,
DienThoai nchar(10)
	)

go
select * from BANGDIEM

create table BANGDIEM
(MSSV nchar(7) foreign key references SinhVien(MSSV),
MSMH nchar(4) foreign key references MonHoc(MSMH),
LanThi tinyint not null,
Diem float not null,
constraint PK primary key (MSSV, MSMH, LanThi));

Insert into KHOA Values('1','Cong nghe thong tin','CNTT')
Insert into KHOA Values('2','Dien tu vien thong','DTVT')
Insert into KHOA Values('3','Quan tri kinh doanh','QTKD')
Insert into KHOA Values('4','Cong nghe sinh hoc','CNSH')

Insert into Lop Values('98TH','Tin hoc khoa 1998','1','1998')
Insert into Lop Values('98VT','Vien thong khoa 1998','2','1998')
Insert into Lop Values('99QT','Quan tri khoa 1999','3','1999')
Insert into Lop Values('99TH','Tin hoc khoa 1999','1','1999')
Insert into Lop Values('99VT','Vien thong khoa 1999','2','1999')

Insert into Tinh Values('01','An Giang')
Insert into Tinh Values('02','TPHCM')
Insert into Tinh Values('03','Dong Nai')
Insert into Tinh Values('04','Long An')
Insert into Tinh Values('05','Hue')
Insert into Tinh Values('06','Ca Mau')

Insert into MonHoc Values('QA01','Kinh te vi mo','2')
Insert into MonHoc Values('QA02','Quan tri chat luong','3')
Insert into MonHoc Values('TA01','Nhap mon tin hoc','2')
Insert into MonHoc Values('TA02','Lap trinh co ban','3')
Insert into MonHoc Values('TB01','Cau truc du lieu','2')
Insert into MonHoc Values('TB02','Co so du lieu','2')
Insert into MonHoc Values('VA01','Dien tu co ban','2')
Insert into MonHoc Values('VA02','Mach so','3')
Insert into MonHoc Values('VB01','Truyen so lieu','3')
Insert into MonHoc Values('XA01','Vat ly dai cuong','2')

Insert into SinhVien Values('98TH001','Nguyen Van','An','8/6/1980','01','9/3/1998','98TH','1','12 Tran Hung Dao, Q.1','8234512')
Insert into SinhVien Values('98TH002','Le Thi','An','10/17/1979','01','9/3/1998','98TH','0','23 CMT8, Q.Tan Binh','0303234342')
Insert into SinhVien Values('98VT001','Nguyen Duc','Bình','11/25/1981','02','9/3/1998','98VT','1','245 Lac Long Quan, Q.11','8654323')
Insert into SinhVien Values('98VT002','Tran Ngoc','Anh','8/19/1980','02','9/3/1998','98VT','0','242 Tran Hung Dao, Q.1','')
Insert into SinhVien Values('99QT001','Nguyen Thi','Oanh','8/19/1973','04','10/5/1999','99QT','0','76 Hung Vuong, Q.5','0901656324')
Insert into SinhVien Values('99QT002','Le My','Hanh','5/20/1976','04','10/5/1999','99QT','0','12 Pham Ngoc Thach, Q.3','')
Insert into SinhVien Values('99TH001','Ly Van Hung','Dung','9/27/1981','03','10/5/1999','99TH','1','178 CMT8, Q. Tân Bình','7563213')
Insert into SinhVien Values('99TH002','Van Minh','Hoang','1/1/1981','04','10/5/1999','99TH','1','272 Ly Thuong Kiet, Q.10','8341234')
Insert into SinhVien Values('99TH003','Nguyen','Tuan','1/12/1980','03','10/5/1999','99TH','1','162 Tran Hung Dao, Q.5','')
Insert into SinhVien Values('99TH004','Tran Van','Minh','6/25/1981','04','10/5/1999','99TH','1','147 Dien Bien Phu, Q.3','7236754')
Insert into SinhVien Values('99TH005','Nguyen Thai','Minh','1/1/1980','04','10/5/1999','99TH','1','345 Le Dai Hanh, Q.11','')
Insert into SinhVien Values('99VT001','Le Ngoc','Mai','6/21/1982','01','10/5/1999','99VT','0','129 Tran Hung Dao, Q.1','0903124534')


Insert into BANGDIEM Values('98TH001','TA01','1','8.5')
Insert into BANGDIEM Values('98TH001','TA02','1','8')
Insert into BANGDIEM Values('98TH001','TB01','1','7')
Insert into BANGDIEM Values('98TH002','TA01','1','4')
Insert into BANGDIEM Values('98TH002','TA01','2','5.5')
Insert into BANGDIEM Values('98TH002','TB01','1','7.5')
Insert into BANGDIEM Values('98VT001','VA01','1','4')
Insert into BANGDIEM Values('98VT001','VA01','2','5')
Insert into BANGDIEM Values('98VT002','VA02','1','7.5')
Insert into BANGDIEM Values('99QT001','QA01','1','7')
Insert into BANGDIEM Values('99QT001','QA02','1','6.5')
Insert into BANGDIEM Values('99QT002','QA01','1','8.5')
Insert into BANGDIEM Values('99QT002','QA02','1','9')
Insert into BANGDIEM Values('99TH001','TA01','1','4')
Insert into BANGDIEM Values('99TH001','TA01','2','6')
Insert into BANGDIEM Values('99TH001','TB01','1','6.5')
Insert into BANGDIEM Values('99TH002','TB01','1','10')
Insert into BANGDIEM Values('99TH002','TB02','1','9')
Insert into BANGDIEM Values('99TH003','TA02','1','7.5')
Insert into BANGDIEM Values('99TH003','TB01','1','3')
Insert into BANGDIEM Values('99TH003','TB01','2','6')
Insert into BANGDIEM Values('99TH003','TB02','1','8')
Insert into BANGDIEM Values('99TH004','TB02','1','2')
Insert into BANGDIEM Values('99TH004','TB02','2','4')
Insert into BANGDIEM Values('99TH004','TB02','3','3')

select *from KHOA

select *from Lop

select *from Tinh

select *from MonHoc

select *from SinhVien

select *from BANGDIEM

---------------------Truy Van Du Lieu---------------------
--câu 1) Liệt kê MSSV, Họ, Tên, Địa chỉ của tất cả các sinh viên
select MSSV,Ho+''+Ten as HoTen,Diachi
from SinhVien

--câu 2) Liệt kê MSSV, Họ, Tên, MS Tỉnh của tất cả các sinh viên. Sắp xếp kết quả theo MS tỉnh, trong cùng tỉnh sắp xếp theo họ tên của sinh viên.
select MSSV,Ho+''+Ten as HoTen,MSTinh
from SinhVien
order by MSTinh,HoTen

--câu 3) Liệt kê các sinh viên nữ của tỉnh Long An
select MSSV,Ho+''+Ten as HoTen,MSTinh,Phai
from SinhVien
where MSTinh='04'and Phai='0'

--4) Liệt kê các sinh viên có sinh nhật trong tháng giêng. 
select MSSV, Ho+ ' ' + Ten as HoTen, NgaySinh
from SinhVien
where MONTH(NgaySinh) = 1

--5) Liệt kê các sinh viên có sinh nhật nhằm ngày 1/1. 
select MSSV, Ho+ ' ' + Ten as HoTen, NgaySinh
from SinhVien
where MONTH(NgaySinh) = 1 and Day(NgaySinh) = 1

--6) Liệt kê các sinh viên có số điện thoại. 
select MSSV, Ho+ ' ' + Ten as HoTen, DienThoai
from SinhVien
where DienThoai != ' '

--7) Liệt kê các sinh viên có số điện thoại di động. 
select MSSV, Ho+ ' ' + Ten as HoTen, DienThoai
from SinhVien
where DienThoai like '0%'

--8) Liệt kê các sinh viên tên ‘Minh’ học lớp ’99TH’
select MSSV, Ho+ ' ' + Ten as HoTen, NgaySinh, Phai
from SinhVien a, Lop b
where a.MSLop = b.MSLop and Ten = 'Minh' and b.MSLop = '99TH'

--9) Liệt kê các sinh viên có địa chỉ ở đường ‘Tran Hung Dao’ 
select MSSV, Ho+ ' ' + Ten as HoTen, DiaChi
from SinhVien a
where DiaChi like '%Tran Hung Dao%'

--10) Liệt kê các sinh viên có tên lót chữ ‘Van’ (không liệt kê người họ ‘Van’) 
select MSSV, Ho+ ' ' + Ten as HoTen
from SinhVien a
where Ho like '%Van'

--11) Liệt kê MSSV, Họ Ten (ghép họ và tên thành một cột), Tuổi của các sinh viên ở tỉnh Long An. 
select MSSV, Ho+ ' ' + Ten as HoTen
from SinhVien a, Tinh b
where a.MSTinh = b.MSTinh and b.MSTinh = '04'

--12) Liệt kê các sinh viên nam từ 23 đến 28 tuổi. 
select MSSV, Ho+ ' ' + Ten as HoTen, 2020 - YEAR(NgaySinh) as tuoi
from SinhVien a
where Phai = 1 and  2020 - YEAR(NgaySinh) between 23 and 28
--13) Liệt kê các sinh viên nam từ 32 tuổi trở lên và các sinh viên nữ từ 27 tuổi trở lên. 
select MSSV, Ho+ ' ' + Ten as HoTen, 2020 - YEAR(NgaySinh) as tuoi
from SinhVien a
where Phai = 1 and  2020 - YEAR(NgaySinh) >= 32 or Phai = 0 and  2020 - YEAR(NgaySinh) >= 27

--14) Liệt kê các sinh viên khi nhập học còn dưới 18 tuổi, hoặc đã trên 25 tuổi. 
select MSSV, Ho+ ' ' + Ten as HoTen, Year(NgayNhapHoc) - Year(NgaySinh) as tuoi
from SinhVien a
where Year(NgayNhapHoc) - YEAR(NgaySinh) <= 18 or Year(NgayNhapHoc) - YEAR(NgaySinh) > 25

--15) Liệt kê danh sách các sinh viên của khóa 99 (MSSV có 2 ký tự đầu là ‘99’). 
select MSSV, Ho+ ' ' + Ten as HoTen, NgayNhapHoc
from SinhVien a
where year(NgayNhapHoc) = 1999

--16) Liệt kê MSSV, Điểm thi lần 1 môn ‘Co so du lieu’ của lớp ’99TH’ 
select a.MSSV, Ho+ ' ' + Ten as HoTen,LanThi, NgayNhapHoc
from SinhVien a, BANGDIEM b
where a.MSSV = b.MSSV and LanThi = 1 and year(NgayNhapHoc) = 1999

--17) Liệt kê MSSV, Họ tên của các sinh viên lớp ’99TH’ thi không đạt lần 1 môn ‘Co so du lieu’
select a.MSSV, Ho+ ' ' + Ten as HoTen, b.MSLop
from SinhVien a, Lop b
where a.MSLop = b.MSLop and b.MSLop like '99TH'

--18) Liệt kê tất cả các điểm thi của sinh viên có mã số ’99TH001’ theo mẫu sau: 
select a.MSMH, TenMH, LanThi, Diem
from MonHoc a, BANGDIEM b
where a.MSMH = b.MSMH

--19) Liệt kê MSSV, họ tên, MSLop của các sinh viên có điểm thi lần 1 môn ‘Co so du lieu’ từ 8 điểm trở lên
select a.MSSV, Ho+ ' ' + Ten as HoTen, b.MSLop, LanThi, Diem
from SinhVien a, Lop b, BANGDIEM c
where a.MSLop = b.MSLop and a.MSSV = c.MSSV and LanThi = 1 and Diem >= 8

--20) Liệt kê các tỉnh không có sinh viên theo học 
select b.MSTinh, TenTinh
from Tinh b
where b.MSTinh not in(select MSTinh
from SinhVien a
where a.MSTinh = B.MSTinh)

--21) Liệt kê các sinh viên hiện chưa có điểm môn thi nào
select a.MSSV, Ho+ ' ' + Ten as HoTen
from SinhVien a
where a.MSSV not in(select MSSV
from BANGDIEM b
where a.MSSV = b.MSSV)

--23) Thống kê số lượng sinh viên ở mỗi tỉnh theo mẫu sau: 
select Tinh.MSTinh, Tinh.TenTinh,
count(case Phai when 1 then 1 else null end) as SVNam,
count(case Phai when 0 then 1 else null end) as SVNu,
count(*) as tongcong
from SinhVien
join Tinh
on Tinh.MSTinh = SinhVien.MSTinh
group by Tinh.MSTinh, Tinh.TenTinh

--24) Thống kê kết quả thi lần 1 môn ‘Co so du lieu’ ở các lớp, theo mẫu sau
select Lop.MSLop, Lop.TenLop,
count(case when BANGDIEM.Diem >= 4 then 1 else null end) as svdat,
(count(case when BANGDIEM.Diem >= 4 then 1 else null end) * 100 / COUNT(*)) AS percentDAT,
COUNT(case when BANGDIEM.Diem < 4 then 1 else null end) as svkodat,
(count(case when BANGDIEM.Diem < 4 then 1 else null end) * 100/ COUNT(*)) as percentkodat,
count(*) as tongso
from BANGDIEM
join MonHoc
on MonHoc.TenMH = BANGDIEM.MSMH
join SinhVien
on BANGDIEM.MSSV = SinhVien.MSSV
join Lop
on SinhVien.MSLop = Lop.MSLop
where LanThi = 1
and MonHoc.TenMH = ‘Co so du lieu’
group by Lop.MSLop, Lop.TenLop;

--25) Lọc ra điểm cao nhất trong các lần thi cho các sinh viên theo mẫu sau
--(điểm in ra của mỗi môn là điểm cao nhất trong các lần thi của môn đó): 
select MSSV, MonHoc.MSMH,TenMH,HeSo, MAX(Diem) as diem
from BangDiem
join MonHoc 
on MonHoc.MSMH = BangDiem.MSMH
group by MSSV, MonHoc.MSMH, TenMH, HeSo;

-- 26) Lập bảng tổng kết theo mẫu
select SinhVien.MSSV,Ho+ ' ' + Ten as HoTen, round(SUM(Diem * HeSo) / SUM(HeSo), 1) as Diemtrungbinh
from BangDiem
JOIN SinhVien 
on SinhVien.MSSV = BangDiem.MSSV
JOIN MonHoc 
on MonHoc.MSMH = BangDiem.MSMH
group by SinhVien.MSSV, Ho, Ten

-- 27) Thống kê số lượng sinh viên tỉnh ‘Long An’ đang theo học ở các khoa, theo mẫu sau:
select Lop.NienKhoa, Khoa.MSKhoa,TenKhoa, COUNT(*) as N'soluongsv'
from SinhVien
join Tinh 
on SinhVien.MSTinh = Tinh.MSTinh
join Lop 
on SinhVien.MSLop = Lop.MSLop
join Khoa 
on Lop.MSKhoa = Khoa.MSKhoa
where Tinh.TenTinh like 'Long An'
group by Lop.nienKhoa, Khoa.MSKhoa, TenKhoa


-- 28) Nhập vào MSSV, in ra bảng điểm của sinh viên đó theo mẫu sau (điểm in ra lấy điểm cao nhất trong các lần thi)
create proc usp_Get_Diem @MSSV char(7)
as
  if not exists (select * from BANGDIEM where MSSV = @MSSV)
    print N'mã số sinh viên: ' + @MSSV + N' không tồn tại trong CSDL! lêu lêu'
  else
  begin
    select MonHoc.MSMH , TenMH, HeSo,
      MAX(Diem) as N'Điểm'
    from BANGDIEM
    join MonHoc
      on MonHoc.MSMH = BANGDIEM.MSMH
    where MSSV = @MSSV
    group by MonHoc.MSMH, TenMH, HeSo
  end;

exec usp_Get_Diem '98TH001';
exec usp_Get_Diem '98TH002';
exec usp_Get_Diem '98TH003';

-- 29) Nhập vào MSSV, in ra bảng tổng kết của lớp đó, theo mẫu sau:
create proc usp_Get_XepLoai @MSSV char(7)
as
  if not exists (select * from BANGDIEM where MSSV = @MSSV)
    print N'mã số sinh viên: ' + @MSSV + N' không tồn tại trong CSDL! lêu lêu'
  else
  begin
    select SinhVien.MSSV, Ho, Ten,
      round(SUM(diem * heSo) / SUM(heSo), 1) as N'diemtrunbinh',
      case
        when SUM(diem * heSo) / SUM(heSo) >= 8.0 then N'Giỏi'
        when SUM(diem * heSo) / SUM(heSo) >= 6.5 then N'Khá'
        when SUM(diem * heSo) / SUM(heSo) >= 5.0 then N'TB'
        else N'Yếuvl'
      end as N'Xếp loại'
    from BANGDIEM
    join SinhVien
      on BANGDIEM.MSSV = SinhVien.MSSV
    join MonHoc
      on BangDiem.MSMH = MonHoc.MSMH
    where SinhVien.MSSV = @MSSV
    group by SinhVien.MSSV, Ho, Ten
  end;

exec usp_Get_XepLoai '98TH001';
exec usp_Get_XepLoai '98TH002';
exec usp_Get_XepLoai '98TH003';


-- 30) Tạo bảng SinhVienTinh trong đó chứa hồ sơ của các sinh viên  (lấy từ table SinhVien)
--có quê quán không phải ở TPHCM. Thêm thuộc tính HBONG (học bổng) cho table SinhVienTinh.
create table SinhVienTinh
(
	MS char(7) primary key,
	ho varchar(50),
	ten varchar(30),
	ngaySinh date,
	MSTinh nchar(2) references Tinh(MSTinh) on delete cascade,
	ngayNhapHoc date,
	MSLop nchar(4) references Lop(MSLop),
	phai varchar(5),
	diaChi varchar(100),
	dienThoai varchar(13),
	HocBong int
);

SET DATEFORMAT dmy;
INSERT INTO SinhVienTinh(MS, ho, ten, ngaySinh, MSTinh, ngayNhapHoc, MSLop, phai, diaChi, dienThoai)
VALUES 
	('98TH001', 'Nguyen Van', 'An', '06/08/80', '01', '03/09/98', '98TH', 'Yes', '12 Tran Hung Dao, Q.1', '8234512'),
	('98TH002', 'Le Thi', 'An', '17/10/79', '01', '03/09/98', '98TH', 'No', '23 CMT8, Q. Tan Binh', '0303234342'),
	('99TH001', 'Ly Van Hung', 'Dung', '27/09/81', '03', '05/10/99', '99TH', 'Yes', '178 CMT8, Q. Tan Binh', '7563213'),
	('99TH002', 'Van Minh', 'Hoang', '01/01/81', '04', '05/10/99', '99TH', 'Yes', '272 Ly Thuong Kiet, Q.10', '8341234'),
	('99TH003', 'Nguyen', 'Tuan', '12/01/80', '03', '05/10/99', '99TH', 'Yes', '162 Tran Hung Dao, Q.5', NULL),
	('99TH004', 'Tran Van', 'Minh', '25/06/81', '04', '05/10/99', '99TH', 'Yes', '147 Dien Bien Phu, Q.3', '7236754'),
	('99TH005', 'Nguyen Thai', 'Minh', '01/01/80', '04', '05/10/99', '99TH', 'Yes', '345 Le Dai Hanh, Q.11', NULL),
	('99VT001', 'Le Ngoc', 'Mai', '21/06/82', '01', '05/10/99', '99VT', 'No', '129 Tran Hung Dao, Q.1', '0903124534'),
	('99QT001', 'Nguyen Thi', 'Oanh', '19/08/73', '04', '05/10/99', '99QT', 'No', '76 Hung Vuong, Q.5', '0901656324'),
	('99QT002', 'Le My', 'Hanh', '20/05/76', '04', '05/10/99', '99QT', 'No', '12 Pham Ngoc Thach, Q.3', NULL);

	select * from SinhVienTinh

-- 31) Cập nhật thuộc tính HBONG trong table SinhVienThanh 10000 cho tất cả các sinh viên.
UPDATE SinhVienTinh
set HocBong = 10000;
select * from SinhVienTinh;

-- 32) Tăng HBONG lên 10% cho các sinh viên nữ.
UPDATE SinhVienTinh
set hocBong = hocBong * 1.1
where phai = 'No';

select * from SinhVienTinh
order by phai;


-- 33) Xóa tất cả các sinh viên có quê quán ở Long An ra khỏi table SinhVienTinh.
delete
from SinhVienTinh
where MSTinh =(select MS
     from Tinh
     where TenTinh like 'Long An');

select *
from SinhVienTinh;











