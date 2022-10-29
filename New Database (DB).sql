go
drop database YenSao
-- lenh tao database
create database YenSao
go
use YenSao
go
create table customer (
cusID		   varchar(20)   not null primary key, 
cusName        nvarchar(100) not null,
password       nvarchar(200) null, 
email          nvarchar(200) null, 
avatar         nvarchar(MAX) null,
cusPhone       nvarchar(10)  null,
role           nvarchar(10)  not null,  
gender         nvarchar(10)  null,
loc	           nvarchar(200) null,
cumulative     float         null,
balance        float         DEFAULT 10000,
);
go
create table codeStore(
codeID         nvarchar(50)       not null primary key,
keyCode        nvarchar(10)       not null,
description    nvarchar(255)      null,
)
go
create table voucherSystem(
voucherID      nvarchar(10)       not null primary key,
name           nvarchar(100)      not null,
codeID         nvarchar(50)       not null foreign key (codeID) references codeStore(codeID),
)
go
create table orders(
orderID        int identity(1,1)  not null primary key,
cusID          varchar(20)        not null foreign key (cusID) references customer(cusID), 
cusName        nvarchar(200)      null,
cusPhone       nvarchar(20)       not null,
loc            nvarchar(200)      not null,
ordDate        date               not null,
status         int check(status = 1 or status = 2 or status = 3) DEFAULT 1,
-- 1: Processing ,  2: Rate, 3: Complete
voucherID      nvarchar(10)       null foreign key(voucherID)  references voucherSystem(voucherID),
discountAffect   float            DEFAULT 0,
);
go
create table seller (
sellerID       varchar(20)   not null primary key ,
sellerName     nvarchar(100) not null,
password       nvarchar(200) null,
email          nvarchar(200) null,
avatar         nvarchar(MAX) null, 
phone		   nvarchar(10)  null, 
role           nvarchar(10)  not null,    
gender         nvarchar(10)  null,
loc            nvarchar(200) null,
profit        float         DEFAULT 0,
status         int check( status = 1 or status = 2) DEFAULT 1,
-- 1: normal  , 2: In BAN
shipAllow       int check(shipAllow = 1 or shipAllow = 2) DEFAULT 1,
-- 1: Allow  , 2: Not Allow
);
go
create table voucherSeller(
voucherID      nvarchar(10)       not null primary key,
name           nvarchar(100)      not null,
codeID         nvarchar(50)       not null foreign key (codeID) references codeStore(codeID),
sellerID       varchar(20)        not null foreign key (sellerID) references seller(sellerID) ON DELETE CASCADE,
priceAffect    float              not null,
--- Affect when price greater than priceAffect---
)
go
create table category (
cateID        char(6) primary key,
cateName      nvarchar(200) null,
);
go
create table product (
productID     varchar(20)         not null primary key,
cateID        char(6)             not null foreign key (cateID) references category(cateID),
sellerID      varchar(20)         not null foreign key (sellerID) references seller(sellerID) ON DELETE CASCADE,
productName   nvarchar(200)       not null,
cateName      nvarchar(200)       null,
quantity      int                 not null,
cover         nvarchar(MAX)       null,
price         float               not null,
description   nvarchar(350)       null,
sumSold       int                 null,
status        int check(status = 1 or status = 2 or status = 3) DEFAULT 1,
--1: Not Approval  , 2: In Stock ,  3: In Sell
);
go
create table orderDetail(
orderDetailID varchar(20)       not null primary key,
orderID       int               not null foreign key (orderID) references orders(orderID),
sellerID      varchar(20)       not null foreign key (sellerID) references seller(sellerID) ON DELETE CASCADE,
productID     varchar(20)       not null foreign key (productID) references product(productID),
productName   nvarchar(200)     not null,
img           nvarchar(MAX)     not null,
quantity      int DEFAULT 1,
status        int check(status =1 or status=2 or status = 3) DEFAULT 1,
voucherID     nvarchar(10)      null foreign key (voucherID)  references voucherSeller(voucherID),
--1:Not Approval, 2: In Processing , 3: rated
);
go
create table reportProduct (
reportID      int identity(1,1) not null primary key,
cusID         varchar(20)       not null foreign key (cusID) references customer(cusID),
productID     varchar(20)       not null foreign key (productID) references product(productID) ON DELETE CASCADE,
dateReport    date              not null,
description   nvarchar(1000)    null,
img           nvarchar(MAX)     null,
status        int check ( status = 1 or status = 2) DEFAULT 1,
--1: Not Resolve , 2: Have Resolve
);
go
create table comment(
commentID     int identity(1,1)  not null primary key,
cusID         varchar(20)        not null foreign key (cusID) references customer(cusID),
productID     varchar(20)        not null foreign key (productID) references product(productID) ON DELETE CASCADE,
detail        nvarchar(1000)     null,
img           nvarchar(MAX)      null,
rate          int                null,
);
go
create table request(
requestID     int identity(1,1) not null primary key,
cusID         varchar(20)       not null foreign key (cusID) references customer(cusID) unique,
detail        nvarchar(300)     not null,
status        int check (status = 1 or status = 2) DEFAULT 1
--- 1: Not Resolve  ,   2: Have Resolve
);
go
create table wishList(
wishID        int identity(1,1) not null primary key,
cusID         varchar(20)       not null foreign key (cusID) references customer(cusID),
productID     varchar(20)       not null foreign key (productID) references product(productID),
cateID        char(6)           not null, foreign key (cateID) references category(cateID),
sellerID      varchar(20)       not null, foreign key (sellerID) references seller(sellerID),
productName   nvarchar(200)     not null,
quantity      int DEFAULT 1,
cover         nvarchar(MAX)     null,
price         float             not null,
description   nvarchar(1000)    null,
)
go
create table blogList(
blogID       nvarchar(10)      not null primary key,
title        nvarchar(100)     null,
summary      nvarchar(MAX)     null,
detail       nvarchar(MAX)     null,
cover        nvarchar(MAX)     null,
)
go
create table systemHandle(
purchaseTax    float     DEFAULT 0,
shipTax        float     DEFAULT 0,
)
go
CREATE FUNCTION AUTO_ID(@lastId varchar(20), @preFix varchar(3), @size int)
RETURNS VARCHAR(20)
AS
BEGIN
	IF(@lastId = '')
	set @lastId = @preFix + REPLICATE (0, @size - LEN(@preFix))
	declare @nextUser int, @nextId varchar(20)
	set @lastId = LTRIM(RTRIM(@lastId))
	set @nextUser = REPLACE(@lastID, @preFix, '') + 1
	set @size = @size - LEN(@preFix)
	set @nextId = @preFix + REPLICATE(0, @size - LEN(@preFix))
	set @nextId = @preFix + RIGHT(REPLICATE(0, @size) + CONVERT(varchar(MAX), @nextUser), @size)
	return @nextId
END
go
create trigger nextOrderDetailID on orderDetail
for insert
as
   BEGIN
   declare @lastId varchar(20)
   set @lastId = (SELECT top 1 orderDetailID from orderDetail order by orderDetailID desc)
   UPDATE orderDetail set orderDetailID = dbo.AUTO_ID(@lastId, 'ORD', 5) where orderDetailID = ''
   END
go
create trigger nextCusID on customer
for insert
as
   BEGIN
   declare @lastId varchar(20)
   set @lastId = (SELECT top 1 cusID from customer order by cusID desc)
   UPDATE customer set cusID = dbo.AUTO_ID(@lastId, 'US0', 5) where cusID = ''
   END
go
create trigger nextSellerID on seller
for insert
as
   BEGIN
   declare @lastId varchar(20)
   set @lastId = (SELECT top 1 sellerID from seller order by sellerID desc)
   UPDATE seller set sellerID = dbo.AUTO_ID(@lastId, 'SE0', 5) where sellerID = ''
   END
go
INSERT category (cateID, cateName) VALUES (N'C01', N'Yen Sao')
INSERT category (cateID, cateName) VALUES (N'C02', N'Yen Nuoc')
INSERT category (cateID, cateName) VALUES (N'C03', N'Yen Tinh Che')
INSERT category (cateID, cateName) VALUES (N'C04', N'Huyet Yen')
INSERT category (cateID, cateName) VALUES (N'C05', N'Hong Yen')
INSERT category (cateID, cateName) VALUES (N'C06', N'Bach Yen')
INSERT category (cateID, cateName) VALUES (N'C07', N'Yen Tho')

INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc) VALUES ('', N'therock@gmail.com', '0123456789', '12345', N'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc5NjIyODM0ODM2ODc0Mzc3/dwayne-the-rock-johnson-gettyimages-1061959920.jpg', 'SE', 'TheRock', 'Male','D7 district')
INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc) VALUES ('', N'carib@gmail.com', '0123456789', '12345', N'https://media-cldnry.s-nbcnews.com/image/upload/rockcms/2022-03/cardi-b-kb-2x1-220310-e053cf.jpg', 'SE', 'CariB', 'Female','D8 district')
INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc) VALUES ('', N'rickroll@gmail.com', '0123456789', '12345', N'https://www.irishnews.com/picturesarchive/irishnews/irishnews/2018/04/12/124106785-12a6c443-29fb-4af8-befc-3a3abc19a312.jpg', 'SE', 'RickAstley', 'Male','D9 district')
INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc) VALUES ('', N'taylor@gmail.com', '0123456789', '12345', N'https://vcdn1-giaitri.vnecdn.net/2020/03/06/Taylor-Swift-6612-1583461788.jpg?w=680&h=0&q=100&dpr=1&fit=crop&s=NfVcInHSm7DA3cTJi_MvCQ', 'SE', 'TaylorSwift', 'Female','D10 district')

INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'GigaChad', '12345', 'gigachad@gmail.com', 'https://melmagazine.com/wp-content/uploads/2021/01/66f-1.jpg', '0123456789', 'US', 'Male', 'Q9 D2 district', '')
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'Rosé', '82016', 'blackpink@world.top.com', 'https://en.kepoper.com/wp-content/uploads/2020/11/blackpink-rose-profile-1-e1605241928385.jpg', '0999345899', 'US', 'Female', 'Seoul South Korean', '')
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'JungKook', '122013', 'bts@world.top.com', 'https://media-cdn-v2.laodong.vn/storage/newsportal/2022/7/20/1070792/Jungkook-BTS.jpeg', '0888456988', 'US', 'Male', 'South Korean Debut Area Light', '')
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'LadyGaga', '12345', 'lady@gmail.com', 'https://www.biography.com/.image/t_share/MTgxMDg1MDI3MTkzMzMzMDk2/gettyimages-1127409044.jpg', '0123456789', 'US', 'Female', 'Q12 D2 district', '')
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'Faker', '12345', 'faker@gmail.com', 'https://cdn-img.thethao247.vn/storage/files/duyenhai/2022/01/28/faker-dwg-kia-la-doi-ma-chung-toi-phai-danh-bai-108031.jpeg', '0123456789', 'US', 'Male', 'Q13 D2 district', '')

INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS1' ,N'C01',N'SE001', N'Yen Sao Nha Lam', N'Yen Sao', '100', N'https://thuongyen.com/wp-content/uploads/2019/10/yen-sao-ky-gi-5.jpg', '105.000', N'This is first product', N'1', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YN2' ,N'C02',N'SE002', N'Yen Nuoc Tu Che', N'Yen Nuoc', '50', N'https://images.fpt.shop/unsafe/fit-in/600x600/filters:quality(90):fill(white)/nhathuoclongchau.com/images/product/2021/10/00014062-yen-sao-khanh-hoa-loc-6-kd-3998-6162_large.jpg', '145.000', N'This is Second product', N'3', N'2')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold) VALUES ( N'YTC' ,N'C03',N'SE003', N'Yen Tinh Che Tu Che', N'Yen Tinh Che', '20', N'https://toyenkiengiang.vn/wp-content/uploads/2018/01/psx_20170713_205520_1024x1024.jpg', '255.000', N'This is Third product', N'10')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY1' ,N'C05',N'SE004', N'Hong Yen Mau Hong', N'Hong Yen', '75', N'https://bizweb.dktcdn.net/100/230/772/articles/hong-yen-la-gi.jpg?v=1588213526903', '199.000', N'This is Fourth product', N'5', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY2' ,N'C04',N'SE001', N'Huyet Yen Mau Do', N'Huyet Yen', '30', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', '327.000', N'This is Five product', N'12', N'2')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS2' ,N'C01',N'SE002', N'Yen Sao Nha Nguoi Khac Lam', N'Yen Sao', '100', N'https://thuongyen.com/wp-content/uploads/2019/10/yen-sao-ky-gi-5.jpg', '105.000', N'This is sixth product', N'1', N'2')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold) VALUES ( N'YN3' ,N'C02',N'SE003', N'Yen Nuoc Mua', N'Yen Nuoc', '50', N'https://images.fpt.shop/unsafe/fit-in/600x600/filters:quality(90):fill(white)/nhathuoclongchau.com/images/product/2021/10/00014062-yen-sao-khanh-hoa-loc-6-kd-3998-6162_large.jpg', '145.000', N'This is Seventh product', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YTC1' ,N'C03',N'SE004', N'Yen Tinh Che', N'Yen Tinh Che', '20', N'https://toyenkiengiang.vn/wp-content/uploads/2018/01/psx_20170713_205520_1024x1024.jpg', '255.000', N'This is Eighth product', N'10', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold) VALUES ( N'HY4' ,N'C05',N'SE001', N'Hong Yen Mau Do', N'Hong Yen', '75', N'https://bizweb.dktcdn.net/100/230/772/articles/hong-yen-la-gi.jpg?v=1588213526903', '199.000', N'This is Nineth product', N'5')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY3' ,N'C04',N'SE002', N'Huyet Yen Mau Hong', N'Huyet Yen', '30', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', '327.000', N'This is Tenth product', N'12', N'2')

INSERT blogList (blogID, title, summary, detail, cover) VALUES ( N'BL01' ,N'Tác Dụng Thần Kỳ Của Yến Sào Với Phụ Nữ',N'Tổ yến sào chính là lựa chọn hàng đầu của phái đẹp trong các loại thực phẩm bổ sung dinh dưỡng, giữ gìn vóc dáng và chăm sóc làn da từ thiên nhiên. Cùng Thọ An tìm hiểu tác dụng của yến sào với phụ nữ như thế nào trong bài viết dưới đây nhé!', N'Yến sào tập trung nhiều ở khu vực Đông Nam Á (Malaysia, Indonesia, Việt Nam…). Thông thường, những nơi có trữ lượng yến dồi dào thì sẽ dễ chọn lọc được những tổ yến chất lượng hơn.
Gần đây, giới khoa học cũng bắt đầu đánh giá nghiêm túc hơn về chất lượng của yến nuôi trong nhà. Các nhận định ban đầu đều khẳng định yến nuôi cho chất lượng tương đương với yến đảo, ít lẫn tạp chất, lại có các chỉ số an toàn vệ sinh thực phẩm rõ ràng hơn (như nguồn thức ăn, nước uống,..).
Về yến thành phẩm, người dân thường chuộng săn lùng các loại tổ yến thô để về tự chế biến hoặc mua các loại yến sào đã được chế biến, đóng gói sẵn. Có thể nói, tổ yến thô rất quý giá và chứa nhiều chất bổ dưỡng nhưng vì thường lẫn tạp chất, bụi bẩn và lông chim nên khi chế biến phải làm thật kỹ, sạch sẽ mới có thể dùng được. Thêm vào đó, chất dinh dưỡng 
có thể bị mất dần đi nếu chúng ta sơ chế hoặc bảo quản không đúng cách. Còn nếu mua về và sử dụng hết ngay trong một hai lần thì lại phí quá, vì cơ thể con người không kịp hấp thu hết các dưỡng chất của yến. Yến sào chế biến sẵn ngày càng được nhiều người sử dụng hơn vì tính tiện lợi, có liều lượng vừa đủ cho mỗi lần dùng, thích hợp cho người cần sử dụng lâu dài. Nên lưu ý chọn loại có thương hiệu, có quy trình sản xuất đạt các chuẩn quốc tế như GMP, HACCP, ISO để đảm bảo giữ nguyên được tinh chất yến sau khi chế biến.', N'https://yt.cdnxbvn.com/medias/uploads/131/131694-yen-sao5.jpg')
INSERT  blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL02' ,N'Chân Yến Có Tốt Như Tổ Yến Không? ',N'Đa phần mọi người khi sử dụng yến sào thường mua tổ yến nguyên hay yến bụng để bổ sung dinh dưỡng cho cơ thể mà ít biết đến sản phẩm chân yến. Vậy chân yến có thật sự tốt như tổ yến hay không? Cùng Thọ An Nest tìm hiểu ngay trong bài viết dưới đây nhé!', N'Với giá thành rẻ ai cũng nghĩ chúng chẳng có tác dụng gì cao nhưng thực tế cho thấy phần chân yến còn chứa nhiều chất dinh dưỡng hơn các tổ yến khác vì lượng nước bọt của chim làm hai chân khá nhiều mới có độ chắc chắn ấy. Tuy là những miếng yến nhỏ không được thẩm mỹ nhưng nếu lựa chọn về cho gia đình sử dụng lâu dài sẽ là lựa chọn sáng suốt. 
Trong chân yến chứa một lượng lớn Protein khoảng 55%, hơn 30 nguyên tố vi lượng và 18 loại axit amin mà cơ thể không tự tổng hợp được giúp cải thiện tình trạng biếng ăn, còi xương ở trẻ nhỏ;  nâng cao sức đề kháng và hệ thống miễn dịch, ngăn chặn vi khuẩn, virus.Chân yến chứa nhiều vi chất không thua kém gì tổ yến 
Đối với phụ nữ, chất Threonine trong chân yến hỗ trợ cơ thể sản xuất ra Elastine và Collagen - 2 chất có tác dụng tái tạo lại cấu trúc da, làm chậm quá trình lão hóa da, giúp da hồng hào và mịn màng hơn.
Đối với mẹ bầu, sản phẩm bổ sung hàm lượng dưỡng chất dồi dào tốt cho sức khỏe của mẹ và cả thai nhi. Sử dụng chân yến thường xuyên giúp mẹ bầu giải tỏa mệt mỏi, căng thẳng, cân bằng tâm lý và bớt nhạy cảm hơn. Đặc biệt giúp hình thành và phát triển hoàn chỉnh não bộ của trẻ, giúp trẻ lớn lên thông minh, lanh lợi.
Loại bỏ độc tố dư thừa trong cơ thể, tăng cường sự tập trung cũng như duy trì, phát triển và hoàn thiện các chức năng của hệ thần kinh bình thường.', N'https://yensaothoan.com/media/mageplaza/blog/post/c/h/chan-yen-co-tot-nhu-to-yen-khong.jpg')
INSERT blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL03' ,N'Yến Sào Có Tác Dụng Hiệu Quả Ngay Sau Khi Sử Dụng Không?',N'Yến sào có nhiều công dụng với người dùng, không chỉ trẻ em mà người lớn tuổi hay người trưởng thành đều có thể dùng được. Thế nhưng yến sào có tác dụng thần kỳ ngay sau khi sử dụng? Ăn yến như thế nào mới mang lại hiệu quả tốt nhất? Cùng Yến Sào Thọ An tìm hiểu trong bài viết dưới đây nhé!', N'Yến sào có công dụng lớn đối với người đau ốm dậy. Họ là những đối tượng có hệ tiêu hóa đang cần hồi phục, hệ tuần hoàn và hệ hô hấp yếu, hệ miễn dịch và sức đề kháng cần được nâng cao. Chính vì vậy, người bệnh chỉ cần ăn yến 1 – 2 ngày sẽ cảm nhận rõ cơ thể khỏe mạnh hơn, tinh thần thoải mái hơn.
Yến sào tác dụng hiệu quả ngay sau khi sử dụng với người bệnhKhông những thế, yến sào nguyên chất còn giúp người đau dậy được ngủ ngon hơn, thần kinh tốt hơn và được phục hồi nhanh sau phẫu thuật. Chính nhờ những điều này mà những người thăm đau hay tặng hay biếu những hộp yến nguyên chất Thọ An Nest để Khách hàng có thể dùng cho thấy ngay hiệu quả.', N'https://afamilycdn.com/150157425591193600/2022/3/31/to-yen2-16487221953141072982427.jpg')
INSERT blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL04' ,N'Chưng Yến Bao Lâu Để Đảm Bảo Nguồn Dinh Dưỡng Vàng?',N'Yến sào là thực phẩm có hàm lượng dinh dưỡng vô cùng cao và mang lại nhiều lợi ích cho sức khỏe của người dùng. Thế nên, việc chưng yến bao lâu, chưng yến như thế nào để bảo toàn được các thành phần vi chất là điều rất quan trọng mà không phải ai cũng biết. Nếu người dùng chưa nắm rõ quy tắc chưng yến bao lâu thì hãy tham khảo các thông tin mà Thọ An Nets chia sẻ trong bài viết này.', N'Chưng yến bao lâu là hợp lý? Chưng yến trong 10 phút có được không? Chưng yến 1 tiếng có tốt không?,... Đó là những câu hỏi mà nhiều khách hàng quan tâm nhất hiện nay, bởi trên thực tế, có nhiều tình huống bất ngờ xảy ra khiến người dùng không thể canh chuẩn thời gian khi chưng yến. Tuy nhiên, Quý Khách nên căn chỉnh thời gian chưng yến để bát yến giữ được hương vị và độ dai mềm của tổ yến, vì: 
Chưng yến trong thời gian quá ngắn khiến yến không đạt đủ độ nở, yến không kịp chín.Chưng yến trong thời gian quá lâu sẽ khiến yến mềm, nhũn và mất đi các chất dinh dưỡng.Căn đúng thời gian chưng giúp yến giữ trọn hương vị và độ dai mềmNgoài việc căn chỉnh thời gian chưng yến, Quý Khách cũng cần lưu ý một số vấn đề khi chưng yến. Thực tế, chưng yến sào khá đơn giản nhưng nếu thực hiện không đúng cách, hàm lượng dinh dưỡng của món ăn sẽ bị giảm sút, yến có mùi tanh và món ăn sẽ mất đi hương vị tự nhiên vốn có.Không bỏ đường phèn ngay từ đầu để yến nở to và giữ hương vị nguyên thủy của yến.Không chưng tổ yến chung với các loại nguyên liệu khác vì nó sẽ làm ảnh hưởng tới hương vị và dưỡng chất của yến sào. Người dùng tốt nhất nên chưng riêng tổ yến và chế biến riêng các nguyên liệu, khi nào sử dụng mới trộn chung vào nhau.
Không chưng chung các nguyên liệu cùng với yếnNên sử dụng thố chưng cách thủy, nồi chưng điện thay vì chưng trực tiếp vì người dùng không thể kiểm soát được nhiệt độ chưng.
Chưng yến ở nhiệt độ quá cao hoặc gia nhiệt quá nhanh là 2 nguyên nhân chính  khiến tổ yến mất đi chất dinh dưỡng.
Nên sử dụng nồi có chất liệu làm từ gốm, sứ và có nắp đậy, không sử dụng nồi bằng kim loại, inox hay nhôm vì khi chưng ở nhiệt độ cao dễ tích tụ kim loại vào sợi yến khiến cơ thể người dùng dễ bị nhiễm độc không thể đào thải khi sử dụng.', N'https://thuocdantoc.vn/wp-content/uploads/2022/04/cach-chung-yen-1.jpg')
INSERT blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL05' ,N'Tổ Yến Góc Là Gì? Tác Dụng Của Tổ Yến Góc?',N'Yến sào đã trở thành món ăn quen thuộc đối với mỗi gia đình vì đây là thực phẩm chứa hàm lượng vi chất vô cùng cao và có nhiều tác dụng vượt trội với sức khỏe con người. Ngoài các loại yến phổ biến, hiện nay trên thị trường xuất hiện loại tổ yến góc khiến người dùng thắc mắc về thành phần dinh dưỡng và tác dụng của nó. Vậy yến sào góc là gì? Tác dụng của tổ yến góc với thể trạng con người là như thế nào? Cùng Thọ An Nest tìm hiểu trong bài viết dưới đây nhé!', N'ổ yến góc hay còn được gọi là tổ yến tam giác, thường nằm trong góc nhà nuôi yến. Vì có hình dạng không đẹp như các tổ yến xây ở vị trí khác nên giá thành của tổ yến góc thường thấp hơn. Tuy vậy, giá trị dinh dưỡng và chất lượng của yến sào góc vẫn được đảm bảo nguyên chất chứ không hề thua kém yến tinh chế hay yến sào rút lông khô.tổ yến gócTổ yến góc nằm trong các góc ở nhà nuôi yến ƯU ĐIỂM CỦA YẾN SÀO GÓC Tổ có dạng dẹt mỏng, dễ chia nhỏ khi chế biến Hàm lượng dinh dưỡng tương đương với các loại yến khác Giá thành rẻ Phù hợp với mọi độ tuổi Tiết kiệm thời gian chế biến, làm sạch.Đối với trẻ emKích thích hệ tiêu hóa, hỗ trợ trị biếng ăn: Tổ yến góc chứa nhiều Protein, axit amin và nguyên tố vi lượng giúp thúc đẩy hệ tiêu hóa của trẻ nhỏ. Ngoài ra, nguyên tố Crom làm tăng khả năng hấp thụ dinh dưỡng qua màng ruột của trẻ.
Tăng cường hệ miễn dịch: Yến góc chứa tới 18 loại axit amin mà cơ thể không thể tự tổng hợp được, đặc biệt là nguyên tố N-acetylneuraminic giúp cơ thể tăng khả năng miễn dịch,  đẩy lùi vi khuẩn và virus.', N'https://tacdungcuatoyen.com/wp-content/uploads/2018/03/yen-goc-1.jpg')

INSERT request (cusID, detail, status) VALUES (N'US001', N'Với Kinh nghiêm hơn 20 năm bán yến sào tôi có thể đem lại cho người dùng những sản phẩm tốt nhất và tôi năm nay cũng hơn 70 tuổi chưa gặp trường hợp bán hàng giả bao giờ, nếu tôi mà gặp phải tôi, tôi đấm cho mấy nhát', N'1')
INSERT request (cusID, detail, status) VALUES (N'US002', N'Là một người lành nghề, là professional trong bán hàng cái tầm, cái level của tôi là ko thể count được nên việc bán hàng sure kèo là tôi phải làm , admin cứ do not worrie ờ bao me bởi vì cái uy tính , cái bờ li vơ men của tôi thì ai cũng biết', N'1')
INSERT request (cusID, detail, status) VALUES (N'US003', N'A quất quơ quẹt que , quờ quất quơ quật ngơ, ờ quất nhgoe oặt ngoe mu na si mu na Mosat', N'1')
INSERT request (cusID, detail, status) VALUES (N'US004', N'Sau nhiều lần trải nghiểm và tìm hiểu tôi nhận thấy trang web của mình là một nơi rất thích hợp để tôi có thể kinh doanh mặt hàng của mình, vì vậy tôi muốn một bảng hợp đồng làm ăn lâu dài', N'1')
INSERT request (cusID, detail, status) VALUES (N'US005', N'Ōku no keiken to chōsa no ato, watashi no u~ebusaito wa watashi no seihin o hanbai suru no ni hijō ni tekishita bashodearu koto ni kidzukimashita. Sonotame, chōki no jigyō keiyaku ga hitsuyōdesu.', N'1')

INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US001', N'YS1', N'2022-10-4', N'Sản phẩm không có màu hồng trừ 1 điểm', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US002', N'YN2', N'2022-10-5', N'Thằng bán sản phẩm này nguời iu cũ của em admin ban giúp e cho đỡ tức thanks :3', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US003', N'YTC', N'2022-10-6', N'Yến ngon nhưng thích report chơi v ó', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US004', N'YS2', N'2022-10-6', N'Tại sao trong yến lại có..... YẾN ???', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US005', N'YN3', N'2022-10-6', N'MU vô địch, wibu văn hóa, datvila j5k mãi đỉnh, đáy xã hội muôn năm', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')

INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS1', N'dark bruh lmao', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YN2', N'dark bruh lmao p2', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN2', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YS1', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY1', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'HY1', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YTC', N'Dead is like the wind always by my side kill me you can try hahahahah', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')

--codeID: 4 char num of voucher + 3-9 char name affect + 3-5 char target + for + vse or vsy ---
--KeyCode: 1 char name affect + 3-5 char type affect + sy or se ---
INSERT codeStore(codeID, keyCode, description) VALUES (N'cd01rd10ktoitforvse', N'R10KSE', N'Reduce 10k for items have price over 120k')
INSERT codeStore (codeID, keyCode, description) VALUES (N'cd02rd50pcsptforvsy', N'R50PSY', N'Reduce 50% of shipping tax')
INSERT codeStore (codeID, keyCode, description) VALUES (N'cd03rd10pctoitforvse', N'R10PSE', N'Reduce 10% total of all items')
INSERT codeStore (codeID, keyCode, description) VALUES (N'cd04fr100sptforsvy' , N'F100PSY', N'Free 100% of ship tax')

INSERT voucherSystem(voucherID, name, codeID) VALUES (N'VSY01', N'Free 100% shipping', N'cd04fr100sptforsvy')
INSERT voucherSystem(voucherID, name, codeID) VALUES (N'VSY02', N'Reduce 50% shipping', N'cd02rd50pcsptforvsy')

INSERT voucherSeller(voucherID, name, codeID, sellerID, priceAffect) VALUES (N'VSE01', N'Reduce 10k for all items over 120k', N'cd01rd10ktoitforvse', N'SE001', N'120.000')
INSERT voucherSeller(voucherID, name, codeID, sellerID, priceAffect) VALUES (N'VSE02', N'Reduce 10% for all items', N'cd03rd10pctoitforvse', N'SE001', N'0')

INSERT orders( cusID, cusName, cusPhone, loc, ordDate, voucherID) VALUES (N'US001', N'GigaChad', N'0123456789', N'Q9 D2 district', N'2022-10-6', N'VSY01')
INSERT orders( cusID, cusName, cusPhone, loc, ordDate, voucherID) VALUES (N'US002', N'Rosé', N'0999345899', N'Seoul South Koreant', N'2022-10-6', N'VSY02')

INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, voucherID) VALUES ('', N'1',N'SE001', N'YS1', N'Yen Sao Nha Lam',N'https://thuongyen.com/wp-content/uploads/2019/10/yen-sao-ky-gi-5.jpg', N'10', N'VSE01')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'1',N'SE001', N'HY2', N'Huyet Yen Mau Do',N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'1',N'SE001', N'YS1', N'Yen Sao Nha Lam',N'https://thuongyen.com/wp-content/uploads/2019/10/yen-sao-ky-gi-5.jpg', N'9')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, voucherID) VALUES ('', N'1',N'SE001', N'HY4', N'Hong Yen Mau Do',N'https://bizweb.dktcdn.net/100/230/772/articles/hong-yen-la-gi.jpg?v=1588213526903', N'69', N'VSE02')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'1',N'SE001', N'HY2', N'Huyet Yen Mau Do',N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'12')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, voucherID) VALUES ('', N'2',N'SE001', N'YS1', N'Yen Sao Nha Lam',N'https://thuongyen.com/wp-content/uploads/2019/10/yen-sao-ky-gi-5.jpg', N'10', N'VSE01')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'2',N'SE001', N'HY2', N'Huyet Yen Mau Do',N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'2',N'SE001', N'YS1', N'Yen Sao Nha Lam',N'https://thuongyen.com/wp-content/uploads/2019/10/yen-sao-ky-gi-5.jpg', N'9')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, voucherID) VALUES ('', N'2',N'SE001', N'HY4', N'Hong Yen Mau Do',N'https://bizweb.dktcdn.net/100/230/772/articles/hong-yen-la-gi.jpg?v=1588213526903', N'69', N'VSE02')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'2',N'SE001', N'HY2', N'Huyet Yen Mau Do',N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'12')
      
