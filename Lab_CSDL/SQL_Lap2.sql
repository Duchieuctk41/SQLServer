/*Học phần: Cơ Sở Dữ Liệu
Người thực hiện: Võ Thị Hằng
MSSV:1710167
Ngày: 15/3/2019
*/
CREATE DATABASE Lap02_QLSX
 go
 use Lap02_QLSX
 go

 --Tao bang
 Create Table ToSanXuat
(MaTSX  char(4)  primary key,
TenTSX nvarchar (5)not null unique
)
 Create Table CongNhan
 ( MACN char(5) primary key, 
Ho nvarchar(14) not null,
Ten nvarchar(6) not null,
Phai nvarchar(4) not null,
NgaySinh datetime ,
MaTSX  char(4) references ToSanXuat(MaTSX)
)

Create Table SanPham
(MaSP char(5) primary key,
TenSP nvarchar(14) not null,
DVT nchar(4) not null,
TienCong int 
)
Create Table ThanhPham
(MACN char(5) ,
MaSP char(5) ,
Ngay datetime ,
SoLuong tinyint,
primary key(MACN,MaSP,Ngay)
)

-------------NHAP DU LIEU CHO CAC BANG-----------
--Nhap du lieu cho cac bang
insert into	ToSanXuat values('TS01',N'Tổ 1')
insert into ToSanXuat values('TS02',N'Tổ 2')

select * from ToSanXuat
insert into CongNhan values('CN001',N'Nguyễn Trường',N'An',N'Nam','02/15/1981','TS01')
insert into CongNhan values('CN002',N'Lê Thị Hồng',N'Gấm',N'Nữ','04/06/1980','TS01')
insert into CongNhan values('CN003',N'Nguyễn Công',N'Thanh',N'Nam','05/04/1981','TS02')
insert into CongNhan values('CN004',N'Võ Hữu',N'Hạnh',N'Nam','02/15/1980','TS02')
insert into CongNhan values('CN005',N'Lý Thanh',N'Hân',N'Nữ','12/03/1981','TS01')

select * from CongNhan

insert into SanPham values('SP001',N'Nồi đất',N'Cái',10000)
insert into SanPham values('SP002',N'Chén',N'Cái',2000)
insert into SanPham values('SP003',N'Bình gốm nhỏ',N'Cái',20000)
insert into SanPham values('SP004',N'Bình gốm lớn',N'Cái',25000)

select * from SanPham
insert into ThanhPham values('CN001','SP001','02/01/2007',10)
insert into ThanhPham values('CN002','SP001','02/01/2007',5)
insert into ThanhPham values('CN003','SP002','01/10/2007',50)
insert into ThanhPham values('CN004','SP003','01/12/2007',10)
insert into ThanhPham values('CN005','SP002','01/12/2007',100)
insert into ThanhPham values('CN002','SP004','02/13/2007',10)
insert into ThanhPham values('CN001','SP003','02/14/2007',15)
insert into ThanhPham values('CN003','SP001','01/15/2007',20)
insert into ThanhPham values('CN003','SP004','02/14/2007',15)
insert into ThanhPham values('CN004','SP002','01/30/2007',100)
insert into ThanhPham values('CN005','SP003','02/01/2007',50)
insert into ThanhPham values('CN001','SP001','02/20/2007',30)
select * from ThanhPham
--TRUY VẤN DỮ LIỆU--

----Truy vấn
--1.Liệt kê công nhân theo tổ sản xuất gồm các thông tin : TenTSX,HoTen,NgaySinh,Phai
Select TenTSX, Ho +' '+Ten as Hoten,NgaySinh, Phai
From CongNhan A, ToSanXuat B
Where A.MaTSX=B.MaTSX	
order by TenTSX,Ten	
--2.Liệt kê các thành phẩm mà công nhân 'Nguyễn Trường An' đã làm được
select TenSP,Ngay,SoLuong,SoLuong*TienCong AS ThanhTien
from SanPham A, CongNhan B,ThanhPham C
where	a.MaSP=c.MaSP and c.MACN=b.MACN and B. ho=N'Nguyễn Trường'	and B.Ten=N'An'	
order by Ngay
--3.Liệt kê các nhân viên không sản xuất sản phẩm 'Bình gốm lớn'
select MACN, Ho, ten,Phai, NgaySinh
from CongNhan A
where not exists	
   (select *
	from SanPham B, ThanhPham C 
	where B.MaSP=C.MaSP and C.MaSP  like  'SP004' and A.MACN=C.MACN) --// phải có bảng a liên kết vs C
 --4.Liệt kê nhân viên sản xuất 'Nồi đất' và 'Bình gốm nhỏ'
 Select a.MACN, Ho, ten,Phai, NgaySinh
 from CongNhan a,ThanhPham b,SanPham c
 where a.MACN=b.MACN and b.MaSP=c.MaSP and  b.MaSP like 'SP003' and a.MACN IN 
 ( select d.MACN
   from ThanhPham d,SanPham e
   where   d.MaSP=e.MaSP and d.MaSP like 'SP001' )
--5.Thống kê số lượng công nhân theo từng tổ sản xuất
select TenTSX, count(MACN) as SoCN
from ToSanXuat a, CongNhan b
where a.MaTSX=b.MaTSX
group by TenTSX
--6.Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được
select b.TenSP, Ho, Ten, sum(SoLuong) as TongSLThanhPham, SoLuong*TienCong as TongThanhTien
from CongNhan a, SanPham b, ThanhPham c
where a.MACN=c.MACN and b.MaSP=c.MaSP
group by b.TenSP,Ho,Ten,TienCong,SoLuong
--7.Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007
select sum(a.SoLuong) as TongSP,SUM(SoLuong*TienCong) as TongTien
from ThanhPham a, SanPham b
where a.MaSP=b.MaSP and MONTH(Ngay)=1 and YEAR(Ngay)=2007

--8.Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2 năm 2007
select TenSP,sum(SoLuong) as SXNhieu
from ThanhPham a, SanPham b
where a.MaSP=b.MaSP and MONTH(ngay)=2 and year(ngay)=2007
group by TenSP
having sum(SoLuong)>=all(select sum(d.SoLuong)
from SanPham c,ThanhPham d
where d.MaSP=c.MaSP and MONTH(ngay)=2 and year(ngay)=2007
group by TenSP--// Phải có group by Tensp vì k thì nó tính tổng 415 hết nên k lấy >= dc
)
--9.Cho biết công nhân sản xuất được nhiều chén nhất
select a.MACN, Ho+ ' '+Ten as HoTen, Phai, NgaySinh, MaTSX ,sum(SoLuong) as SoChen
from CongNhan a,SanPham b,ThanhPham c
where a.MACN=c.MACN and b.MaSP=c.MaSP and b.MaSP='SP002'
group by a.MACN, Ho,Ten,Phai,NgaySinh,MaTSX
having sum(SoLuong)>=all (select sum(d.SoLuong)
from ThanhPham d
where  d.MaSP='SP002'
group by MACN
)

--10.Tiền công tháng 2/2006 của công nhân có mã số CN002
select a.MACN, Ho+ ' '+Ten as HoTen, Phai, NgaySinh, MaTSX , sum(TienCong*SoLuong) as TienCongThang2
from CongNhan a,SanPham b,ThanhPham c
where a.MACN =c.MACN and b.MaSP=c.MaSP and a.MACN='CN002'and month(Ngay)=2 and year(ngay)=2007-- cho l nam 2007 hay 2006?
group by a.MACN,Ho,Ten,Phai,NgaySinh,MaTSX
--11.Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên
select a.MACN, Ho+ ' '+Ten as HoTen, Phai, NgaySinh, MaTSX , count (distinct(c.MaSP)) as SoSPLam
from CongNhan a,SanPham b,ThanhPham c
where a.MACN =c.MACN and b.MaSP=c.MaSP
group by a.MACN,Ho,Ten , Phai, NgaySinh, MaTSX 
having count(distinct(C.MaSP))>= all( select count(distinct(d.MaSP))
from ThanhPham d
group by d.MACN )
--12.Cập nhật giá tiền công của các loại bình gốm thêm 1000
select *from SanPham
update SanPham 
set TienCong += 1000
where TenSP like N'Bình gốm %'

--13 Thêm bộ<'CN006','Lê Thị','Lan','Nữ','TS02'>vào bảng nhân viên
insert into CongNhan (MACN,Ho,Ten,Phai,MaTSX)
values ('CN006',N'Lê Thị',N'Lan',N'Nữ','TS02')
 select * from CongNhan






