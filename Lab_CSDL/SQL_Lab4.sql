/*Học phần: Cơ Sở Dữ Liệu
Người thực hiện: Võ Thị Hằng
MSSV: 1710167
Ngày:29/3/2019
*/

Create Database Lab4_QLDatBao
go
use Lab4_QLDatBao
go
Create Table KH_HANG
(MAKH char(4) primary key,
TENKH nchar(6) not null,
DC_KH char(7) not null
)
go
Create Table BAO_TCHI
(MA_BAO_TC char(4) primary key,
TEN nvarchar(20) not null,
DINHKY nvarchar(17) not null,
SOLUONG int,
GIABAN int
)
go
Create Table DATBAO
(MAKH char(4) references KH_HANG(MAKH),
MA_BAO_TC char(4) references BAO_TCHI(MA_BAO_TC),
SL_MUA int,
NGAY_DM datetime
)
go
Create Table PHATHANH_BAO
(MA_BAO_TC char(4) references BAO_TCHI(MA_BAO_TC),
SO_BAO_TC int primary key,
NGAY_PH datetime
)
go
----------NHAP DU LIEU-----------
insert into KH_HANG values('KH01',N'LAN','2 NCT')
insert into KH_HANG values('KH02',N'NAM','32 THĐ')
insert into KH_HANG values('KH03',N'NGỌC','16 LHP')
select * from KH_HANG

insert into BAO_TCHI values('TT01',N'Tuổi trẻ',N'Nhật báo',1000,1500)
insert into BAO_TCHI values('KT01',N'Kiến thức ngày nay',N'Bán nguyệt san',3000,6000)
insert into BAO_TCHI values('TN01',N'Thanh niên',N'Nhật báo',1000,2000)
insert into BAO_TCHI values('PN01',N'Phụ nữ',N'Tuần báo',2000,4000)
insert into BAO_TCHI values('PN02',N'Phụ nữ',N'Nhật báo',1000,2000)

select * from BAO_TCHI

insert into DATBAO values('KH01','TT01',100,'01/12/2000')
insert into DATBAO values('KH02','TN01',150,'05/01/2001')
insert into DATBAO values('KH01','PN01',200,'06/25/2001')
insert into DATBAO values('KH03','KT01',50,'03/17/2002')
insert into DATBAO values('KH03','PN02',200,'08/26/2003')
insert into DATBAO values('KH02','TT01',250,'01/15/2004')
insert into DATBAO values('KH01','KT01',300,'10/14/2004')

Select * from DATBAO

insert into PHATHANH_BAO values('TT01','132','12/15/2005')
insert into PHATHANH_BAO values('KT01','70','12/15/2005')
insert into PHATHANH_BAO values('TT01','124','12/16/2005')
insert into PHATHANH_BAO values('TN01','256','12/17/2005')
insert into PHATHANH_BAO values('PN01','45','12/23/2005')
insert into PHATHANH_BAO values('PN02','111','12/18/2005')
insert into PHATHANH_BAO values('PN02','112','12/19/2005')
insert into PHATHANH_BAO values('TT01','125','12/17/2005')
insert into PHATHANH_BAO values('PN01','46','12/30/2005')


select * from PHATHANH_BAO
-------------------TRUY VẤN-----------------
--1)Cho biết các tờ báo, tạp chí(MABAOTC,TEN,GIABAN) có định kỳ phát hành hàng tuần(Tuần báo).
select MA_BAO_TC,TEN,GIABAN
from BAO_TCHI
where DINHKY=N'Tuần báo'
--2)Cho biết thông tin về các tờ báo thuộc loại báo phụ nữ ( mã báo tạp chí bắt đầu bằng PN).
select MA_BAO_TC,TEN,DINHKY, SOLUONG,GIABAN
from BAO_TCHI
where MA_BAO_TC LIKE 'PN%'
--3)Cho biết tên các khách hàng có đặt mua báo phụ nữ(mã báo tạp chí bắt đầu bằng PN), không liệt kê khách hàng trùng
select DISTINCT a.MAKH,a.TENKH,a.DC_KH
from KH_HANG a, DATBAO b
where a.MAKH=b.MAKH and b.MA_BAO_TC like 'PN%'
--4)Cho biết tên các khách hàng có đặt mua tất cả các báo phụ nữ( mã báo tạp chí bắt đầu bằng PN). 
select A.TENKH
from KH_HANG a,DATBAO b
where a.MAKH=b.MAKH and b.MA_BAO_TC like 'PN%'
group by a.TENKH
having COUNT (b.MA_BAO_TC)=(select COUNT (MA_BAO_TC)
							from BAO_TCHI
							where MA_BAO_TC LIKE 'pn%')
--5)Cho biết các khách hàng không đặt mua báo thanh niên.
SELECT DISTINCT A.MAKH ,A.TENKH
FROM KH_HANG A, DATBAO B
WHERE A.MAKH=B.MAKH AND B.MAKH NOT IN(SELECT  MAKH
							FROM DATBAO
							WHERE MA_BAO_TC  LIKE 'TN%')
--6)Cho biết số tờ báo mà mỗi khách hàng đã đặt mua.
SELECT A.MAKH,A.TENKH, SUM(SL_MUA) AS SOLUONG
FROM KH_HANG A, DATBAO B
WHERE A.MAKH=B.MAKH 
GROUP BY A.MAKH,A.TENKH
--7)Cho biết số khách hàng đặt mua báo trong năm 2004
SELECT COUNT (MAKH) AS SOLUONKH
FROM DATBAO
WHERE YEAR(NGAY_DM)=2004
--8)Cho biết thông tin đặt đặt mua báo của các khách hàng(TENKH,TEN,DINH_KY,SL_MUA,SOTIEN) trong đó SOTIEN=SL_MUA*DONGIA.
SELECT B.TENKH,A.TEN,A.DINHKY,C.SL_MUA, C.SL_MUA*A.GIABAN AS SOTIEN
FROM BAO_TCHI A, KH_HANG B, DATBAO C
WHERE A.MA_BAO_TC=C.MA_BAO_TC AND B.MAKH=C.MAKH
--9)Cho biết các tờ báo,tạp chí(TEN,DINH_KY) và tổng số lượng đặt mua của các khách hàng đối với tờ báo, tạp chí đó.
SELECT  A.TEN, A.DINHKY, SUM(B.SL_MUA)AS TONGSLMUA
FROM BAO_TCHI A,DATBAO B
WHERE A.MA_BAO_TC=B.MA_BAO_TC
GROUP BY A.TEN, A.DINHKY
--10)Cho biết tên các tờ báo dành cho học sinh, sinh viên(mã báo tạp chí bắt đầu bằng HS).
SELECT MA_BAO_TC, TEN 
FROM BAO_TCHI
WHERE MA_BAO_TC LIKE 'HS%'
--11)Cho biết những tờ báo không có người đặt mua
SELECT DISTINCT MA_BAO_TC
FROM BAO_TCHI
WHERE MA_BAO_TC NOT IN(SELECT DISTINCT MA_BAO_TC
							FROM DATBAO
							WHERE MAKH LIKE 'KH%')
--12)Cho biết tên,định kỳ của những tờ báo có nhiều người đặt mua nhất
SELECT A.TEN,A.DINHKY
FROM BAO_TCHI A,DATBAO B
WHERE A.MA_BAO_TC=B.MA_BAO_TC 
GROUP BY A.TEN,A.DINHKY
HAVING  SUM(B.SL_MUA) >= ALL (SELECT  SUM(SL_MUA)AS SOBAO
							FROM DATBAO 
							GROUP BY MA_BAO_TC)
--13)Cho biết khách hàng đặt mua nhiều báo, tạp chí nhất
SELECT B.MAKH,C.TENKH,SUM(SL_MUA) AS SOLUONGBAO
FROM DATBAO B,KH_HANG C
WHERE  B.MAKH=C.MAKH
GROUP BY B.MAKH,C.TENKH
HAVING  SUM(B.SL_MUA) >= ALL (SELECT  SUM(SL_MUA)AS SOBAO
							FROM DATBAO 
							GROUP BY MAKH)
--14)Cho biết các tờ báo phát hành định kỳ một tháng 2 lần
select  A.MA_BAO_TC
from BAO_TCHI A, PHATHANH_BAO B
where A.MA_BAO_TC=B.MA_BAO_TC 
GROUP BY A.MA_BAO_TC
HAVING COUNT(B.MA_BAO_TC)=2
--15)Cho biết các tờ báo, tạp chí có từ 3 khách hàng đặt mua trở lên
SELECT TEN
FROM BAO_TCHI B,DATBAO C
WHERE B.MA_BAO_TC=C.MA_BAO_TC
GROUP BY C.MA_BAO_TC,TEN
HAVING COUNT(C.MA_BAO_TC)>=3


