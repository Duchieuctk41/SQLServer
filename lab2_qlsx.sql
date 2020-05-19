create database lab2
go
-------------------------------
use lab2
create table tosanxuat
(matsx char(5) primary key,
tentsx nvarchar(10) not null unique
)go
create table congnhan
(macn char(6) primary key,
ho nvarchar(30) not null,
ten nvarchar(10) not null,
phai nvarchar(10) not null,
ngaysinh datetime,
matsx char(5) references tosanxuat(matsx)
)go
create table sanpham
(masp char(6) primary key,
tensp nvarchar(30) not null,
dvt nvarchar(10),
tiencong int
)go
create table thanhpham
(macn char(6) references congnhan(macn),
masp char(6) references sanpham(masp),
ngay datetime,
soluong int
)
---------------------------------
select * from tosanxuat
select * from congnhan
select * from sanpham
select * from thanhpham
---------------------------------------------
insert into tosanxuat values('TS01',N'Tổ 1')
insert into tosanxuat values('TS02',N'Tổ 2')
select * from tosanxuat

set dateformat dmy
go
insert into congnhan values('CN001',N'Nguyễn Trường', N'An',N'Nam','12/05/1981','TS01')
insert into congnhan values('CN002',N'Lê Thị Hồng', N'Gấm',N'Nữ ','04/06/1980','TS01')
insert into congnhan values('CN003',N'Nguyễn Công', N'Thành',N'Nam','04/05/1981','TS02')
insert into congnhan values('CN004',N'Võ Hữu', N'Hạnh',N'Nam','15/02/1980','TS02')
insert into congnhan values('CN005',N'Lý Thanh', N'Hân',N'Nữ ','03/12/1981','TS01')
select * from congnhan

insert into sanpham values('SP001',N'Nồi đất', N'cái',10000)
insert into sanpham values('SP002',N'Chén ', N'cái',2000)
insert into sanpham values('SP003',N'Bình gốm nhỏ', N'cái',20000)
insert into sanpham values('SP004',N'Bình gốm lớn', N'cái',25000)
select * from sanpham

insert into thanhpham values('CN001', 'SP001', '01/02/2007',10)
insert into thanhpham values('CN002', 'SP001', '01/02/2007',5)
insert into thanhpham values('CN003', 'SP002', '10/01/2007',50)
insert into thanhpham values('CN004', 'SP003', '12/01/2007',10)
insert into thanhpham values('CN005', 'SP002', '12/01/2007',100)
insert into thanhpham values('CN002', 'SP004', '13/02/2007',10)
insert into thanhpham values('CN001', 'SP003', '14/02/2007',15)
insert into thanhpham values('CN003', 'SP001', '15/01/2007',20)
insert into thanhpham values('CN003', 'SP004', '14/02/2007',15)
insert into thanhpham values('CN004', 'SP002', '30/01/2007',100)
insert into thanhpham values('CN005', 'SP003', '01/02/2007',50)
insert into thanhpham values('CN002', 'SP001', '20/02/2007',30)
select * from thanhpham

--1) Liệt kê các công nhân theo tổ sản xuất gồm các thông tin: TenTSX, HoTen,
--NgaySinh, Phai (xếp thứ tự tăng dần của tên tổ sản xuất, Tên của công nhân). 
select tentsx, ho + ' ' + ten as hoten, ngaysinh, phai
from tosanxuat, congnhan
where tosanxuat.matsx = congnhan.matsx
order by tentsx, ten

--2) Liệt kê các thành phẩm mà công nhân ‘Nguyễn Trường An’ đã làm được gồm các
--thông tin: TenSP, Ngay, SoLuong, ThanhTien (xếp theo thứ tự tăng dần của ngày). 
select tensp, ngay, soluong, thanhpham.soluong * sanpham.tiencong as thanhtien
from congnhan, sanpham, thanhpham
where congnhan.macn = thanhpham.macn and sanpham.masp = thanhpham.masp 
and ho + ' ' + ten = N'Nguyễn Trường An'

--3) Liệt kê các nhân viên không sản xuất sản phẩm ‘Bình gốm lớn’. 
select ho + ' ' + ten as hoten
from congnhan
where congnhan.macn not in(select thanhpham.macn
from thanhpham, sanpham
where thanhpham.masp = sanpham.masp and tensp = N'Bình gốm lớn')

--4) Liệt kê thông tin các công nhân có sản xuất cả ‘Nồi đất’ và ‘Bình gốm nhỏ’.
select ho + ' ' + ten as hoten
from congnhan a, sanpham b, thanhpham c
where a.macn = c.macn and b.masp = c.masp and tensp = N'Nồi đất'
and a.macn in(select f.macn
from sanpham e, thanhpham f
where e.masp = f.masp and tensp = N'Bình gốm nhỏ')

--5) Thống kê Số luợng công nhân theo từng tổ sản xuất.
select tentsx, count(congnhan.macn) as soluongcn
from tosanxuat, congnhan
where tosanxuat.matsx = congnhan.matsx
group by tentsx

--6) Tổng số lượng thành phẩm theo từng loại mà mỗi nhân viên làm được (Ho,
--Ten, TenSP, TongSLThanhPham, TongThanhTien).
select ho + ' ' + ten as hoten, tensp, sum(soluong) as tongslthanhpham, sum(soluong)*tiencong as tongthanhtien
from congnhan a, sanpham b, thanhpham c
where a.macn = c.macn and b.masp = c.masp
group by ho, ten, tensp, tiencong

--7) Tổng số tiền công đã trả cho công nhân trong tháng 1 năm 2007
select sum(soluong*tiencong) as tongtiencongt7 
from  sanpham b, thanhpham c
where  b.masp = c.masp and MONTH(ngay) = 1  and YEAR(ngay) = 2007

--8) Cho biết sản phẩm được sản xuất nhiều nhất trong tháng 2/2007
select b.masp, tensp, sum(soluong) as tongsoluong 
from thanhpham b, sanpham c
where c.masp = b.masp and MONTH(ngay) = 2 and YEAR(ngay) = 2007
group by b.masp, tensp
having sum(soluong) >= all(select sum(d.soluong)
from thanhpham d
where MONTH(ngay) = 2 and YEAR(ngay) = 2007
group by d.masp)

--9) Cho biết công nhân sản xuất được nhiều ‘Chén’ nhất. 
select a.macn, ho + ' ' + ten as hoten, sum(soluong) as tongso
from congnhan a, thanhpham b, sanpham c
where a.macn = b.macn and b.masp = c.masp and tensp = N'Chén'
group by a.macn, ho, ten
having sum(soluong) >= all(select sum(d.soluong)
from thanhpham d, sanpham e
where d.masp = e.masp and tensp = N'Chén'
group by d.macn)

--10) Tiền công tháng 2/2007 của công nhân viên có mã số ‘CN002’ 
select a.macn, ho + ' ' + ten as hoten, sum(soluong*tiencong) as tongtien
from congnhan a, thanhpham b, sanpham c
where a.macn = b.macn and b.masp = c.masp and a.macn = 'CN002'
and MONTH(ngay) = 2 and year(ngay) = 2007
group by a.macn, ho, ten

--11) Liệt kê các công nhân có sản xuất từ 3 loại sản phẩm trở lên.
select a.macn, ho + ' ' + ten as hoten, count(distinct b.masp)
from congnhan a, thanhpham b, sanpham c
where a.macn = b.macn and b.masp = c.masp
group by a.macn, ho, ten
having count(distinct b.masp) >= 3  --distinct: chỉ đếm 1 lần duy nhất

--12) Cập nhật giá tiền công của các loại bình gốm thêm 1000.
update sanpham
set tiencong = tiencong + 1000
where tensp = N'Bình gốm lớn'

--13) Thêm bộ <’CN006’, ‘Lê Thị’, ‘Lan’, ‘Nữ’,’TS02’ > vào bảng CongNhan.
insert into congnhan values('CN005',N'Lý Thanh', N'Hân',N'Nữ ',null,'TS01')
--tips 2
insert into congnhan(macn,ho,ten,phai,matsx) values('CN006',N'Lê Thị', N'Lan',N'Nữ ','TS02')
select * from congnhan
--III. Thủ tục & Hàm
--A. Viết các hàm sau:
--a. Tính tổng số công nhân của một tổ sản xuất cho trước
create function uf_tong(@matsx char(6))
returns int
as
begin
declare @tong int
select @tong = count(macn)
from tosanxuat a, congnhan b
where a.matsx = b.matsx
group by a.matsx
return @tong
end
go

select matsx, dbo.uf_tong(matsx) as tongsocn from tosanxuat

--b. Tính tổng sản lượng sản xuất trong một tháng của một loại sản phẩm cho trước
create function uf_tongsanluong()
returns int
as
begin
declare @tong int
select @tong = sum(soluong)
from thanhpham a, sanpham b
where a.masp = b.masp
group by b.masp
return @tong
end
go

drop function  uf_tongsanluong

select masp, tensp, dbo.uf_tongsanluong() as tongsanluong
from sanpham

