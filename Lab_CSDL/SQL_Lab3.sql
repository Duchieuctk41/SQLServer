/*Học phần: Cơ Sở Dữ Liệu
Người thực hiện:Võ Thị Hằng
MSSV: 1710167
Ngày: 22/3/2019
*/

Create Database Lab3_QLNhapXuatHangHoa
go
use Lab3_QLNhapXuatHangHoa
go
Create Table HANGHOA
(MAHH char(5) primary key,
TENHH varchar(30) not null,
DVT nchar(4) not null,
SOLUONGTON tinyint
)
go
Create Table DOITAC
(MADT char(5) primary key,
TENDT nvarchar(26) not null,
DIACHI nvarchar(35) not null,
DIENTHOAI char(11) not null
)
go
Create Table KHANANGCC
(MADT char(5) references DOITAC(MADT),
MAHH char(5) references  HANGHOA(MAHH)
)
go
Create Table HOADON
(SOHD char(5) primary key,
NGAYLAPHD datetime,
MADT char(5) not null,
TONGTG tinyint
)
go

Create Table CT_HOADON
(SOHD char(5) references HOADON(SOHD),
MAHH char(5) references HANGHOA(MAHH),
DONGIA int,
SOLUONG int
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

insert into CT_HOADON values('N0001','CPU01',63,10)
insert into CT_HOADON values('N0001','HDD03',97,7)
insert into CT_HOADON values('N0001','KB01',3,5)
insert into CT_HOADON values('N0001','MB02',57,5)
insert into CT_HOADON values('N0001','MNT01',112,3)
insert into CT_HOADON values('N0002','CPU02',115,3)
insert into CT_HOADON values('N0002','KB02',5,7)
insert into CT_HOADON values('N0002','MNT03',111,5)
insert into CT_HOADON values('X0001','CPU01',67,2)
insert into CT_HOADON values('X0001','HDD03',100,2)
insert into CT_HOADON values('X0001','KB01',5,2)
insert into CT_HOADON values('X0001','MB02',62,1)
insert into CT_HOADON values('X0002','CPU01',67,1)
insert into CT_HOADON values('X0002','KB02',7,3)
insert into CT_HOADON values('X0002','MNT01',115,2)
insert into CT_HOADON values('X0003','CPU01',67,1)
insert into CT_HOADON values('X0003','MNT03',115,2)

Select * from CT_HOADON







-------------------------------------TRUY VẤN-------------------------------------
--1.Liệt kê các mặt hàng thuộc loại đĩa cứng
Select MAHH,TENHH,SOLUONGTON
from HANGHOA
where MAHH like 'HDD%'
--2.Liệt kê các mặt hàng có số lượng tồn trên 10
Select MAHH,TENHH,SOLUONGTON
from HANGHOA
where SOLUONGTON> 10
--3.Cho biết thông tin về các nhà cung cấp ở Tp.HCM
SELECT MADT,TENDT,DIACHI,DIENTHOAI
FROM DOITAC
WHERE DIACHI like '%HCM'
--4.Liệt kê các hóa đơn nhập hàng trong 5/2006
SELECT B.SOHD,NGAYLAPHD,TENDT,DIACHI,DIENTHOAI ,COUNT(MAHH)AS SOMH
FROM HOADON B,DOITAC A,KHANANGCC C
WHERE A.MADT=B.MADT AND B.MADT=C.MADT AND MONTH(NGAYLAPHD)=5 AND YEAR(NGAYLAPHD)=2006
GROUP BY C.MADT,B.SOHD,NGAYLAPHD,TENDT,DIACHI,DIENTHOAI
--5.Cho biết tên các nhà cung cấp có cung cấp đĩa cứng
SELECT TENDT
FROM  DOITAC A, KHANANGCC B
WHERE A.MADT=B.MADT AND MAHH LIKE 'HDD%'
GROUP BY B.MADT,TENDT
--6.Cho biết tên các nhà cung cấp có thể cung cấp tất cả các loại đĩa cứng
SELECT TENDT
FROM  DOITAC A, KHANANGCC B
WHERE A.MADT=B.MADT  AND B.MAHH LIKE 'HDD%' 
GROUP BY TENDT
HAVING COUNT( B.MAHH)=(SELECT (COUNT( MAHH))
                        FROM HANGHOA 
                        WHERE MAHH LIKE 'HDD%')

--7 Cho biết tên nhà cung cấp không cung cấp đĩa cứng
SELECT A.MADT, TENDT,DIACHI,DIENTHOAI
FROM DOITAC A, KHANANGCC B
WHERE A.MADT=B.MADT AND B.MADT NOT  IN (select MADT
FROM KHANANGCC 
WHERE MAHH  LIKE 'HDD%')
group by TENDT, A.MADT,DIACHI,DIENTHOAI
--8.Cho biết thông tin của mặt hàng chưa bán được
SELECT SOHD,MAHH,DONGIA,SOLUONG
FROM CT_HOADON
WHERE SOHD LIKE 'N%'
--9.Cho biết tên và tổng số lượng bán của mặt hàng bán chạy nhất
select MAHH, SUM(SOLUONG) AS SOLUONG 
from CT_HOADON
WHERE SOHD LIKE 'X%'
GROUP BY MAHH
HAVING SUM(SOLUONG) >= all(SELECT SUM(SOLUONG)AS SOLUONG 
                              FROM CT_HOADON
                           WHERE SOHD LIKE 'X%'
                           GROUP BY MAHH)

--10.Cho biết tên và tổng số lượng của mặt hàng nhập về ít nhất
SELECT TENHH, SUM(SOLUONG) AS NHAPIT
FROM HANGHOA A, CT_HOADON B
WHERE A.MAHH=B.MAHH AND SOHD LIKE 'N%'
GROUP BY B.MAHH,TENHH
HAVING SUM(SOLUONG)<=ALL
                            (select SUM(SOLUONG)
                             from CT_HOADON
                             where SOHD LIKE 'N%'
                                GROUP BY MAHH )
--11.Cho biết hóa đơn nhập nhiều mặt hàng nhất
select SOHD,SUM(SOLUONG)AS SOLUONG
from CT_HOADON
where SOHD LIKE 'N%'
group by SOHD
HAVING SUM(SOLUONG)>=ALL 
(select SUM(SOLUONG)
from CT_HOADON
where SOHD LIKE 'N%'
group by SOHD)
--12 Cho biết các mặt hàng không được nhập hàng 1/2006

select MAHH
from CT_HOADON A
where A.SOHD IN( SELECT SOHD 
FROM HOADON 
WHERE SOHD LIKE 'N%' AND MONTH(NGAYLAPHD) != 1 AND YEAR(NGAYLAPHD) = 2006 )
--13.Cho biết tên các mặt hàng không bán được trong tháng 6/2006
SELECT MAHH
FROM CT_HOADON
WHERE SOHD IN
(SELECT SOHD 
FROM HOADON 
WHERE SOHD LIKE 'X%' AND MONTH(NGAYLAPHD) != 6 AND YEAR(NGAYLAPHD) = 2006)
--14.Cho biết cửa hàng bán bao nhiêu mặt hàng
SELECT COUNT(TENHH) AS SOHANG_BAN
FROM HANGHOA
--15.Cho biết số mặt hàng mà từng nhà cung cấp có khả năng cung cấp
select A.MADT,TENDT,SUM(SOLUONG)
from DOITAC A,CT_HOADON B,HOADON C
where A.MADT=C.MADT AND B.SOHD=C.SOHD
group by A.MADT,A.TENDT
--16.Cho biết thông tin của khạc hàng có giao dịch với cửa hàng nhiều nhất// GROUP BY MADT CÓ THỂ GIÚP ĐẾM K TRÙNG  MADT ĐÓ
SELECT B.MADT,A.TENDT,DIACHI, count  (B.MADT) AS SODD
FROM DOITAC A,HOADON B
WHERE A.MADT=B.MADT
GROUP BY B.MADT,TENDT,DIACHI
HAVING count  (B.MADT)>= ALL(SELECT count( MADT)
								FROM HOADON 
								GROUP BY MADT)
--17.Tính tổng doanh thu năm 2006// chưa lấy dc giá trị bán- gtri mua để tính thu nhập
select sum(DONGIA*SOLUONG) as TongXuat
from CT_HOADON
where SOHD LIKE 'X%'


select sum(DONGIA*SOLUONG) AS  TONGNHAP
from CT_HOADON
where SOHD LIKE 'N%'
--18.Cho biết loại mặt hàng bán chạy nhất
select TENHH ,SUM(SOLUONG) AS SOLUONG
from HANGHOA A, CT_HOADON B
where A.MAHH=B.MAHH and b.SOHD like 'X%' 
group by B.MAHH,TENHH
HAVING SUM(SOLUONG) >=ALL(select SUM(SOLUONG)
from  CT_HOADON 
where SOHD like 'X%' 
group by MAHH)
--19.Liệt kê thông tin bán hàng của 5/2006 // chưa tính dc giá trị xuất- giá trị nhập để tính TongTT
select A.MAHH,TENHH,DVT, SUM(SOLUONG) AS SL, (DONGIA*SOLUONG) AS TongTT
from HANGHOA A, HOADON B, CT_HOADON C
where A.MAHH=C.MAHH AND B.SOHD=C.SOHD AND MONTH(NGAYLAPHD)=5 AND YEAR(NGAYLAPHD)=2006 --AND C.SOHD LIKE 'X%'
group by A.MAHH, C.MAHH,TENHH,DVT,DONGIA,SOLUONG

--20.Liệt kê thông tin của mặt hàng có nhiều người mua nhất
select A.MAHH,TENHH, sum(SOLUONG) AS SL_MUA
from HANGHOA A,  CT_HOADON B
where A.MAHH=B.MAHH AND B.SOHD LIKE 'X%'
GROUP BY B.MAHH, TENHH,A.MAHH
HAVING SUM(SOLUONG)>=ALL(select sum(SOLUONG)
from HANGHOA A,  CT_HOADON B
where A.MAHH=B.MAHH AND B.SOHD LIKE 'X%'
GROUP BY B.MAHH, TENHH,A.MAHH)
--21.Tính và cập nhật tổng giá trị của các hóa đơn