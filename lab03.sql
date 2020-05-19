create database lab3
go
use lab3
go
create table HANGHOA
(MaHH char(5) primary key,
TenHH varchar(30) not null,
DVT nchar(4) not null,
SoLuongTon tinyint 
)
go
create table DOITAC
(MaDT char(5) primary key,
TenDT nvarchar(30) not null,
DiaChi nvarchar(36) not null,
SoDienThoai char(11) not null
)
go
create table KhaNangCC
( MaDT char(5) references DOITAC(MaDT),
MaHH char(5) references HANGHOA(MaHH)
)
go
create table HOADON
(SoHD char(5) primary key,
NgayLaPHD datetime,
MaDT char(5) references DOITAC(MaDT),
TongTG tinyint
)
go
create table CTHOADON
(SoHD char(5) references HOADON(SoHD),
MaHH char(5) references HANGHOA(MaHH),
DonGia int,
SoLuong int
)
go
--NHAP DU LIEU:
insert into HANGHOA values('CPU01','CPU INTEL,CELERON 600 BOX','CÁI',5)
insert into HANGHOA values('CPU02','CPU INTEL,PIII 700','CÁI',10)
insert into HANGHOA values('CPU03','CPU AMD K7 ATHL,ON 600','CÁI',8)
insert into HANGHOA values('HDD01','HDD 10.2 GB QUANTUM','CÁI',10)
insert into HANGHOA values('HDD02','HDD 13.6 GB SEAGATE','CÁI',15)
insert into HANGHOA values('HDD03','HDD 20 GB QUANTUM','CÁI',6)
insert into HANGHOA values('KB01','KB GENIUS','CÁI',12)
insert into HANGHOA values('KB02','KB MITSUMIMI','CÁI',5)
insert into HANGHOA values('MB01','KB GIGABYTE CHIPSET INTEL','CÁI',10)
insert into HANGHOA values('MB02','ACOPR BX CHIPSET VIA','CÁI',10)
insert into HANGHOA values('MB03','INTEL PHI CHIPSET INTEL','CÁI',10)
insert into HANGHOA values('MB04','ESC CHIPSET SIS','CÁI',10)
insert into HANGHOA values('MB05','ESC CHIPSET VIA','CÁI',10)
insert into HANGHOA values('MNT01','SAMSUNG 14" SYNCMASTER','CÁI',5)
insert into HANGHOA values('MNT02','LG 14"','CÁI',5)
insert into HANGHOA values('MNT03','ACER 14"','CÁI',8)
insert into HANGHOA values('MNT04','PHILIPS 14"','CÁI',6)
insert into HANGHOA values('MNT05','VIEWSONIC','CÁI',7)

Select * from HANGHOA


insert into DOITAC values('CC001',N'Cty TNC',N'176 BTX Q1-TPHCM','08.8250259')
insert into DOITAC values('CC002',N'Cty Hoàng Long',N'15A TTT Q1-TPHCM','08.8250898')
insert into DOITAC values('CC003',N'Cty Hợp Nhất',N'152 BTX Q1-TPHCM','08.8252376')
insert into DOITAC values('K0001',N'Nguyễn Minh Hải',N'91 Nguyễn Văn Trỗi Tp.Đà Lạt','063.831129')
insert into DOITAC values('K0002',N'Như Quỳnh',N'21 Điện Biên Phủ.N.Trang','058590270')
insert into DOITAC values('K0003',N'Trần Nhật Duật',N'Lê Lợi TP.Huế','054.848376')
insert into DOITAC values('K0004',N'Phan Nguyễn Hùng Anh',N'11 Nam Kỳ Khởi Nghĩa-TP.Đà Lạt','063.823409')

Select * from DOITAC

insert into KHANANGCC values('CC001','CPU01')
insert into KHANANGCC values('CC001','HDD03')
insert into KHANANGCC values('CC001','KB01')
insert into KHANANGCC values('CC001','MB02')
insert into KHANANGCC values('CC001','MB04')
insert into KHANANGCC values('CC001','MNT01')
insert into KHANANGCC values('CC002','CPU01')
insert into KHANANGCC values('CC002','CPU02')
insert into KHANANGCC values('CC002','CPU03')
insert into KHANANGCC values('CC002','KB02')
insert into KHANANGCC values('CC002','MB01')
insert into KHANANGCC values('CC002','MB05')
insert into KHANANGCC values('CC002','MNT03')
insert into KHANANGCC values('CC003','HDD01')
insert into KHANANGCC values('CC003','HDD02')
insert into KHANANGCC values('CC003','HDD03')
insert into KHANANGCC values('CC003','MB03')

select * from KHANANGCC

insert into HOADON values('N0001','01/25/2006','CC001',' ')
insert into HOADON values('N0002','05/01/2006','CC002',' ')
insert into HOADON values('X0001','05/12/2006','K0001',' ')
insert into HOADON values('X0002','06/16/2006','K0002', ' ')
insert into HOADON values('X0003','04/20/2006','K0001',' ')

Select * from HOADON

insert into CTHOADON values('N0001','CPU01',63,10)
insert into CTHOADON values('N0001','HDD03',97,7)
insert into CTHOADON values('N0001','KB01',3,5)
insert into CTHOADON values('N0001','MB02',57,5)
insert into CTHOADON values('N0001','MNT01',112,3)
insert into CTHOADON values('N0002','CPU02',115,3)
insert into CTHOADON values('N0002','KB02',5,7)
insert into CTHOADON values('N0002','MNT03',111,5)
insert into CTHOADON values('X0001','CPU01',67,2)
insert into CTHOADON values('X0001','HDD03',100,2)
insert into CTHOADON values('X0001','KB01',5,2)
insert into CTHOADON values('X0001','MB02',62,1)
insert into CTHOADON values('X0002','CPU01',67,1)
insert into CTHOADON values('X0002','KB02',7,3)
insert into CTHOADON values('X0002','MNT01',115,2)
insert into CTHOADON values('X0003','CPU01',67,1)
insert into CTHOADON values('X0003','MNT03',115,2)

Select * from CTHOADON

--1) Liệt kê các mặt hàng thuộc loại đĩa cứng
select MaHH, TenHH, SoLuongTon
from HANGHOA
where HANGHOA.MaHH like 'HDD%'

--2.Liệt kê các mặt hàng có số lượng tồn trên 10
select MaHH, TenHH, SoLuongTon
from HANGHOA
where SoLuongTon >= 10

--3) Cho biết thông tin về các nhà cung cấp ở Thành phố Hồ Chí Minh
select MaDT,TenDT, DiaChi, SoDienThoai
from DOITAC
where DiaChi like N'%TPHCM' -- dấu % là bỏ qua đằng trước hoặc sau

--4) Liệt kê các hóa đơn nhập hàng trong tháng 5/2006, thông tin hiển thị gồm: sohd;
-- ngaylaphd; tên, địa chỉ, và điện thoại của nhà cung cấp; số mặt hàng
select SoHD, NgayLaPHD, TenDT, DiaChi, SoDienThoai, count(MaHH) as SoMH
from HOADON a, DOITAC b, KhaNangCC c
where a.MaDT = b.MaDT and b.MaDT = c.MaDT
and MONTH(NgayLaPHD) = 5 and YEAR(NgayLaPHD) = 2006
group by SoHD,NgayLaPHD, TenDT, DiaChi, SoDienThoai

--5) Cho biết tên các nhà cung cấp có cung cấp đĩa cứng.
select a.MaDT, TenDT, DiaChi, SoDienThoai
from DOITAC a, KhaNangCC b
where a.MaDT = b.MaDT and b.MaHH like 'HDD%'
group by a.MaDT, TenDT, DiaChi, SoDienThoai

--6) Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng.
select a.MaDT, TenDT, DiaChi, SoDienThoai
from DOITAC a, KhaNangCC b
where a.MaDT = b.MaDT and b.MaHH like 'HDD%'
group by a.MaDT, TenDT, DiaChi, SoDienThoai
having COUNT(b.MaHH) = (select COUNT(c.MaHH)
from HANGHOA c
where c.MaHH like 'HDD%'
)

--7) Cho biết tên nhà cung cấp không cung cấp đĩa cứng.
select a.MaDT, TenDT, DiaChi, SoDienThoai
from DOITAC a, KhaNangCC b
where a.MaDT = b.MaDT and a.MaDT not in(select MaDT
from KhaNangCC
where MaHH like 'HDD%'
)
group by a.MaDT, TenDT, DiaChi, SoDienThoai

--8) Cho biết thông tin của mặt hàng chưa bán được.
SELECT SOHD,a.MaHH,DONGIA,SOLUONG
FROM HANGHOA a, CTHOADON b
WHERE a.MaHH = b.MaHH and b.MaHH not in(select c.MaHH
from HANGHOA d, KhaNangCC c
where d.MaHH = c.MaHH
)
group by SOHD,a.MaHH,DONGIA,SOLUONG



