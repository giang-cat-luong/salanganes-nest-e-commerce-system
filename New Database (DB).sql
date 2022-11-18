
-- DROP DATABASE YenSao

--USE master
GO
--CREATE DATABASE YenSao
GO
USE YenSao
------------TABLE---------
GO
CREATE TABLE customer (
cusID		   varchar(20)   not null PRIMARY KEY, 
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

GO
CREATE TABLE codeStore(
codeID         nvarchar(50)       not null PRIMARY KEY,
keyCode        nvarchar(10)       not null,
tradingPoint   float              not null,
);

GO
CREATE TABLE voucher(
voucherID      int identity(1,1)  not null PRIMARY KEY,
name           nvarchar(100)      not null,
codeID         nvarchar(50)       not null FOREIGN KEY (codeID) REFERENCES codeStore(codeID),
cusID          varchar(20)        not null FOREIGN KEY (cusID) REFERENCES customer(cusID), 
quantity       int                not null DEFAULT 1,
);

GO
CREATE TABLE orders(
orderID        nvarchar(20)        not null PRIMARY KEY,
cusID          varchar(20)        not null FOREIGN KEY (cusID) REFERENCES customer(cusID), 
cusName        nvarchar(200)      null,
cusPhone       nvarchar(20)       not null,
loc            nvarchar(200)      not null,
ordDate        date               not null,
status         int check(status = 1 or status = 2 or status = 3 or status = 4) DEFAULT 1,
-- 1: Processiong ,  2: Rate, 3: Complete, 4: Cancel
voucherID      int                null foreign key(voucherID)  references voucher(voucherID),
cumulativeUse  float              not null DEFAULT 0,
cumulativeEarn float              not null DEFAULT 0,
total          float              not null DEFAULT 0,
);

GO
CREATE TABLE seller (
sellerID       varchar(20)   not null PRIMARY KEY,
sellerName     nvarchar(100) not null,
password       nvarchar(200) null,
email          nvarchar(200) null,
avatar         nvarchar(MAX) null, 
phone		   nvarchar(10)  null, 
role           nvarchar(10)  not null,    
gender         nvarchar(10)  null,
loc            nvarchar(200) null,
profit        float         DEFAULT 0,
status         int check( status = 1 or status = 2 or status = 3) DEFAULT 1,
-- 1: normal  , 2: In BAN, 3: In Delete
);

GO
CREATE TABLE category (
cateID        char(6) PRIMARY KEY,
cateName      nvarchar(200) null,
);

GO
CREATE TABLE product (
productID     varchar(20)         not null PRIMARY KEY,
cateID        char(6)             not null FOREIGN KEY (cateID) REFERENCES category(cateID),
sellerID      varchar(20)         not null FOREIGN KEY (sellerID) REFERENCES seller(sellerID) ON DELETE CASCADE,
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

GO
CREATE TABLE orderDetail(
orderDetailID nvarchar(20)      not null PRIMARY KEY,
orderID       nvarchar(20)      not null FOREIGN KEY (orderID) REFERENCES orders(orderID),
sellerID      varchar(20)       not null FOREIGN KEY (sellerID) REFERENCES seller(sellerID) ON DELETE CASCADE,
productID     varchar(20)       not null FOREIGN KEY  (productID) REFERENCES product(productID),
productName   nvarchar(200)     not null,
img           nvarchar(MAX)     not null,
quantity      int DEFAULT 1,
status        int check(status =1 or status=2 or status = 3 or status = 4) DEFAULT 1,
--1:Processiong , 2: rate , 3: rated, 4: cancel
);

GO
CREATE TABLE reportProduct (
reportID      int identity(1,1) not null PRIMARY KEY,
cusID         varchar(20)       not null FOREIGN KEY (cusID) REFERENCES customer(cusID),
productID     varchar(20)       not null FOREIGN KEY (productID) REFERENCES product(productID) ON DELETE CASCADE,
dateReport    date              not null,
description   nvarchar(1000)    null,
img           nvarchar(MAX)     null,
);

GO
CREATE TABLE comment(
commentID     int identity(1,1)  not null PRIMARY KEY,
cusID         varchar(20)        not null FOREIGN KEY (cusID) REFERENCES customer(cusID),
productID     varchar(20)        not null FOREIGN KEY (productID) REFERENCES product(productID) ON DELETE CASCADE,
detail        nvarchar(1000)     null,
img           nvarchar(MAX)      null,
rate          int                null,
);

GO
CREATE TABLE request(
requestID     int identity(1,1) not null PRIMARY KEY,
cusID         varchar(20)       not null FOREIGN KEY (cusID) REFERENCES customer(cusID) UNIQUE,
detail        nvarchar(300)     not null,
status        int check (status = 1 or status = 2) DEFAULT 1
--- 1: Not Resolve  ,   2: Have Resolve
);

GO
CREATE TABLE wishList(
wishID        int identity(1,1) not null PRIMARY KEY,
cusID         varchar(20)       not null FOREIGN KEY (cusID) REFERENCES customer(cusID),
productID     varchar(20)       not null FOREIGN KEY (productID) REFERENCES product(productID),
cateID        char(6)           not null FOREIGN KEY (cateID) REFERENCES category(cateID),
sellerID      varchar(20)       not null FOREIGN KEY (sellerID) REFERENCES seller(sellerID),
productName   nvarchar(200)     not null,
quantity      int DEFAULT 1,
cover         nvarchar(MAX)     null,
price         float             not null,
description   nvarchar(1000)    null,
);

GO
CREATE TABLE blogList(
blogID       nvarchar(10)      not null PRIMARY KEY,
title        nvarchar(100)     null,
summary      nvarchar(MAX)     null,
detail       nvarchar(MAX)     null,
cover        nvarchar(MAX)     null,
)

GO
CREATE TABLE bussinessRules(
ruleID      nvarchar(10)       not null PRIMARY KEY,
type        nvarchar(10)       not null,
description nvarchar(300)      not null,
);

GO
CREATE TABLE violation(
violationID   int identity(1,1)  not null PRIMARY KEY,
ruleID        nvarchar(10)       not null FOREIGN KEY (ruleID) REFERENCES bussinessRules(ruleID),
sellerID      varchar(20)        not null FOREIGN KEY (sellerID) REFERENCES seller(sellerID),
)

GO
CREATE TABLE saveCumulative(
saveID      int identity(1,1)   not null PRIMARY KEY,
cusID       varchar(20)         not null FOREIGN KEY (cusID) REFERENCES customer(cusID),
infor       nvarchar(100)       not null,
time        date                not null,
)
------------FUNCTION------------
GO
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
-----------TRIGGER------------
GO
create trigger nextOrderDetailID on orderDetail
for insert
as
   BEGIN
   declare @lastId varchar(20)
   set @lastId = (SELECT top 1 orderDetailID from orderDetail order by orderDetailID desc)
   UPDATE orderDetail set orderDetailID = dbo.AUTO_ID(@lastId, 'ORD', 5) where orderDetailID = ''
   END

GO
create trigger nextCusID on customer
for insert
as
   BEGIN
   declare @lastId varchar(20)
   set @lastId = (SELECT top 1 cusID from customer order by cusID desc)
   UPDATE customer set cusID = dbo.AUTO_ID(@lastId, 'US0', 5) where cusID = ''
   END

GO
create trigger nextSellerID on seller
for insert
as
   BEGIN
   declare @lastId varchar(20)
   set @lastId = (SELECT top 1 sellerID from seller order by sellerID desc)
   UPDATE seller set sellerID = dbo.AUTO_ID(@lastId, 'SE0', 5) where sellerID = ''
   END
--------------INSERT------------
GO
INSERT category (cateID, cateName) VALUES (N'C01', N'Jar')
INSERT category (cateID, cateName) VALUES (N'C02', N'Couple Jar')
INSERT category (cateID, cateName) VALUES (N'C03', N'Box')
INSERT category (cateID, cateName) VALUES (N'C04', N'Round Box')
INSERT category (cateID, cateName) VALUES (N'C05', N'Nest')

GO
----Email number: 3 char: time insert, 1-3 char: number of column insert, 1-3 char: order
INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc, profit) VALUES ('', N'therock1108091@gmail.com', '0123456789', '12345', N'https://www.biography.com/.image/ar_1:1%2Cc_fill%2Ccs_srgb%2Cfl_progressive%2Cq_auto:good%2Cw_1200/MTc5NjIyODM0ODM2ODc0Mzc3/dwayne-the-rock-johnson-gettyimages-1061959920.jpg', 'SE', 'TheRock', 'Male','D7 district', 300000)
INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc, profit) VALUES ('', N'carib1108092@gmail.com', '0123456789', '12345', N'https://i.guim.co.uk/img/media/bcff62d6a0fb01b7c3d4f499f8553d85bdadb37e/0_178_5504_3302/master/5504.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=7c51fa000224790410d7754a8365757c', 'SE', 'CariB', 'Female','D8 district', 300000)
INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc, profit) VALUES ('', N'rickroll1109093@gmail.com', '0123456789', '12345', N'https://static.wikia.nocookie.net/henrystickmin/images/c/cc/RickAstley.jpeg/revision/latest?cb=20210907081549', 'SE', 'RickAstley', 'Male','D9 district', 200000)
INSERT seller (sellerID,email, phone, password, avatar, role, sellerName, gender, loc, profit) VALUES ('', N'taylor1109094@gmail.com', '0123456789', '12345', N'https://i.guim.co.uk/img/media/a48e88b98455a5b118d3c1d34870a1d3aaa1b5c6/0_41_3322_1994/master/3322.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=b95f25e4e31f132166006345fd87b5ae', 'SE', 'TaylorSwift', 'Female','D10 district', 20000)

GO
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'GigaChad', '12345', 'gigachad@gmail.com', 'https://melmagazine.com/wp-content/uploads/2021/01/66f-1.jpg', '0123456789', 'US', 'Male', 'Q9 D2 district', 10000)
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'Rosé', '82016', 'blackpink@world.top.com', 'https://en.kepoper.com/wp-content/uploads/2020/11/blackpink-rose-profile-1-e1605241928385.jpg', '0999345899', 'US', 'Female', 'Seoul South Korean', 10000)
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'JungKook', '122013', 'bts@world.top.com', 'https://media-cdn-v2.laodong.vn/storage/newsportal/2022/7/20/1070792/Jungkook-BTS.jpeg', '0888456988', 'US', 'Male', 'South Korean Debut Area Light', 10000)
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'LadyGaga', '12345', 'lady@gmail.com', 'https://www.biography.com/.image/t_share/MTgxMDg1MDI3MTkzMzMzMDk2/gettyimages-1127409044.jpg', '0123456789', 'US', 'Female', 'Q12 D2 district', '')
INSERT customer (cusID, cusName, password, email, avatar, cusPhone, role, gender, loc, cumulative) VALUES ('', N'Faker', '12345', 'faker@gmail.com', 'https://cdn-img.thethao247.vn/storage/files/duyenhai/2022/01/28/faker-dwg-kia-la-doi-ma-chung-toi-phai-danh-bai-108031.jpeg', '0123456789', 'US', 'Male', 'Q13 D2 district', '')

GO
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS' ,N'C01',N'SE001', N'Refined premium liquid salanganesNest', N'Jar', '100', N'https://product.hstatic.net/1000096857/product/2_e919d8d01d514246b1eb6bdd24c2ca1d.png', '99.000', N'This is first product', N'1', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YN' ,N'C02',N'SE002', N'SalanganesNest Liquid', N'Couple Jar', '50', N'https://kdtrading.ca/wp-content/uploads/2021/12/NUOC-YEN-SAO-SANEST-LO-70ML-x-HOP-6-LO.jpg', '156.000', N'This is Second product', N'3', N'2')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold) VALUES ( N'YTC' ,N'C03',N'SE003', N'Home make bird nest liquid', N'Box', '20', N'https://i.ytimg.com/vi/76uySye33Rc/maxresdefault.jpg', '1790.000', N'This is Third product', N'10')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY' ,N'C04',N'SE004', N'Ruby salanganestNest premium', N'Round Box', '75', N'https://hogiatrang.vn/wp-content/uploads/2019/04/huyet-yen-tho-hop-100-gr-images-01-thuong-hieu-yen-sao-ho-gia-trang-600x600.jpg', '5799.000', N'This is Fourth product', N'5', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY1' ,N'C05',N'SE001', N'Bloody bird nest', N'Nest', '30', N'https://ysnt.com.vn/wp-content/uploads/2019/12/17.png', '327.000', N'This is Fifth product', N'12', N'2')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS1' ,N'C01',N'SE002', N'Bloody salanganesNest premium', N'Jar', '100', N'http://chunggia.com/wp-content/uploads/2020/07/yenhu12.jpg', '75.000', N'This is sixth product', N'1', N'2')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold) VALUES ( N'YN1' ,N'C02',N'SE003', N'Nature bird nest ', N'Couple Jar', '50', N'https://product.hstatic.net/1000283244/product/sup_yen_nguyen_to_chung_duong_phen_nutri_nest_nuoc_yen_gold_bird_3_027c3b86e6e7487db45f2df2fbcd1a43.jpg', '255.000', N'This is Seventh product', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YTC1' ,N'C03',N'SE004', N'Nature quality salanganesNest', N'Box', '20', N'https://cdn.tgdd.vn/Products/Images/4585/267736/bhx/hop-6-hu-to-yen-chung-san-winsnest-khong-duong-70ml-202201211146428686.jpg', '2249', N'This is Eighth product', N'10', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold) VALUES ( N'HY2' ,N'C04',N'SE001', N'Bird nest with chia seed', N'Round Box', '75', N'https://salt.tikicdn.com/ts/product/61/2e/39/cb483f18ee6236db6e6d8c6a6a915cb8.jpg', '7459.000', N'This is Ninth product', N'5')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY3' ,N'C05',N'SE002', N'Collagen salanganesNest', N'Nest', '30', N'http://yensaoyenna.com/upload/images/2-yen-tho-nguyen-chat-cao-cap/yen-tho-nguyen-chat-%20cao-cap-05.jpg', '327.000', N'This is Tenth product', N'12', N'2')

------------ In Sell------------
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS2' ,N'C01',N'SE001', N'SalanganesNest Liquid', N'Jar', '50', N'https://product.hstatic.net/1000283244/product/yen_chung_duong_phen_hu_don_nutri_nest_nuoc_yen_green_bird_1_37cfede6a897427790f8df7cfae48621_master.jpg', '46.000', N'This is best hight quality of product that we can give to you ', N'1000', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YN2' ,N'C02',N'SE002', N'SlanganesNest origin', N'Couple Jar', '50', N'https://product.hstatic.net/1000283244/product/yen_chung_duong_phen___nutri_nest___nuoc_yen__green_bird_hop_qua_6_hu_2b881dab8b594df4a0f3605e0a131a93.jpg', '175.000', N'A truly origin of salanganesNest it come from nature with growing by professional', N'2450', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YTC2' ,N'C03',N'SE003', N'Home make birds nest', N'Box', '50', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/429/476/products/yen-sao-nguyen-chat-lam-sach-hop-5g.jpg?v=1625159664687', '1899.000', N'Product by home making but still keep a quality in high similar to others product', N'5932', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY4' ,N'C04',N'SE001', N'Foreign Import salanganesNest', N'Round Box', '50', N'https://yensaohoangsa.com/storage/image_uploads/GMld7VCiXSoekG3c.jpg', '9854.000', N'Import product from famous branch out of contry with the best quality', N'796', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'PRY' ,N'C05',N'SE002', N'Refined Birds Nest', N'Nest', '50', N'https://cf.shopee.vn/file/17ccba4e407a895ab535dae22eb26ff9', '3199.000', N'Refined with hight tech make product more fresh and good', N'3213', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'NY' ,N'C01',N'SE003', N'Refined High Quality Birds Nest', N'Jar', '50', N'http://shoptoyennn.com/uploads/shoptoyenn/images/anh-moi/mix_33.jpg', '52.000', N'Refined make product more fresh and good with the hight technology import from foreigner ', N'10293', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS3' ,N'C02',N'SE001', N'High Quality SalanganesNest', N'Couple Jar', '50', N'http://songyen.com/vnt_upload/product/12_2019/colla1.jpg', '219.000', N'Better quality ever make in salanganesNest in trylly nature', N'443', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YN3' ,N'C03',N'SE002', N'Leg salanganesNest', N'Box', '50', N'https://product.hstatic.net/200000210481/product/tra_gao_yen_sao-4_daa3194063414dec83d0b4eb1310d1e4_master.jpg', '1672.000', N'Good Leg SalaganesNest with carefully sellected from nature bird nest', N'7956', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YTC3' ,N'C04',N'SE003', N'Red salanganesNest', N'Round Box', '50', N'https://cf.shopee.vn/file/cf336686485403a00eebe20b9921d1cb', '11377.000', N'A beautifull gift frome nature with many profit , fresh , tasty and quality', N'2049', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY5' ,N'C05',N'SE001', N'Ruby birds nest ', N'Nest', '50', N'https://phuhongthanh.vn/wp-content/uploads/2022/04/yen-sao-rut-long-nguyen-to_6319.jpeg', '3345.000', N'This is Seventh product', N'1438',N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'PRY1' ,N'C01',N'SE002', N'Birds nest with seaweed', N'Jar', '50', N'https://thuongyen.com/wp-content/uploads/2018/03/thuongyen-vietnam-toyen-yennuoc-nuoc-yen-sao.jpg', '68.000', N'This is Seventh product', N'7253', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'NY1' ,N'C02',N'SE003', N'SalanganestNest adding colagen', N'Couple Jar', '50', N'https://cdn.vitapharm.com.vn/static/product/thumb/green_bird_nutrinest_nuoc_yen_sao_va_hat_chia_loc_6_chai_x_185ml_13_62f4e9a7db377_480_keep_ratio.jpg', '255.000', N'This is Seventh product', N'124', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS4' ,N'C03',N'SE001', N'Truly bird nest', N'Box', '50', N'https://bizweb.dktcdn.net/thumb/1024x1024/100/381/450/products/yen-sao-cao-cap-datafa-khong-duong-hop-6-lo.jpg?v=1585558748457', '2137.000', N'This is Seventh product', N'74', N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YN4' ,N'C04',N'SE002', N'Mix salanganestNest ', N'Round Box', '50', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP-ErFSH-Uz8sxfqMvFaUF7lDAlrEJTmZ9HmAppzlGxQNJ2juGdeJW8aS4a9SGZJTBbCM&usqp=CAU', '11990.000', N'This is Seventh product', N'89',N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YTC4' ,N'C05',N'SE003', N'Red bird nest with ginseng', N'Nest', '50', N'http://yensaovanloc.com/upload/product/yentinhche-7932.jpg', '4751.000', N'This is Seventh product', N'256',N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'HY6' ,N'C01',N'SE001', N'Premium salaganestNest', N'Jar', '50', N'https://yensaogfarm.com/image/cache/catalog/yen/yenchung/yen-chung-gfarm-70ml-1024x1024.jpg', '69.000', N'This is Seventh product', N'5875',N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'PRY2' ,N'C02',N'SE002', N'Luxury mixing birds nest', N'Couple Jar', '50', N'https://bizweb.dktcdn.net/thumb/large/100/093/924/products/nuoc-yen-sao-red-nest-co-duong-1-ab20e4c3-85f1-4291-9c8e-d8747f8d84c2.jpg?v=1566199642033', '279.000', N'This is Seventh product', N'1093',N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'NY2' ,N'C03',N'SE003', N'Special salanganestNest', N'Box', '50', N'https://happybox.vn/wp-content/uploads/2021/07/Hop-qua-yen-sao-cao-cap-Happybox-cat-tuong-3761.jpg', '1969.000', N'This is Seventh product', N'9999',N'3')
INSERT product ( productID, cateID, sellerID, productName, cateName, quantity, cover, price, description, sumSold, status) VALUES ( N'YS5' ,N'C04',N'SE001', N'Fully high quality salaganestNest', N'Round Box', '50', N'https://product.hstatic.net/1000360535/product/270_9a22e14f669e4726962319190992928b_master.jpg', '8473.000', N'This is Seventh product', N'2776', N'3')

GO
INSERT blogList (blogID, title, summary, detail, cover) VALUES ( N'BL01' ,N'The magical effect of bird neats to woman',N'Bird nest is the first choice of women in nutritional supplements, keeping in shape and taking care of skin from nature. Join Tho An to find out how the benefits of bird nests with women are in the article below!', N'SalanganesNest is concentrated in Southeast Asia (Malaysia, Indonesia, Vietnam...). Usually, places with abundant bird nests will be easier to select quality bird nests.
Recently, the scientific community has also begun to more seriously evaluate the quality of the nests raised in the house. The initial comments all confirmed that the bird nest has the same quality as the island oats, less impurities, and has clearer food safety and hygiene indicators (such as food sources, drinking water, ..) 
Regarding finished products, people often prefer to hunt for raw bird nests to process themselves or buy pre-packaged and processed bird nests. It can be said that raw bird nest is very precious and contains many nutrients, but because it often contains impurities, dust and feathers, it must be processed carefully and cleanly before it can be used. Plus, nutrients
can be gradually lost if we prepare or store it improperly. But if you buy it and use it up in one or two times, it is too much of a waste, because the human body can not absorb all the nutrients of the bird nest. Ready-to-use bird nest is more and more used by more and more people because of its convenience, with just the right dose for each use, suitable for people who need long-term use', N'https://yt.cdnxbvn.com/medias/uploads/131/131694-yen-sao5.jpg')
INSERT  blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL02' ,N'Is leg Bird Nest Good Like Bird Nest? ',N'Most people when using bird nest often buy raw bird nest or belly nest to supplement nutrition for the body, but little is known about bird nest products. So is the leg bird nest really as good as the bird nest? Find out with us', N'With the cheap price, everyone thinks they have no high effect, but in fact, the bird feet contain more nutrients than other nests because the amount of saliva of the bird makes the legs quite a lot to have that certainty. . Although the small pieces of bird nest are not aesthetic, if choosing for long-term family use will be a wise choice.
In bird nest contains a large amount of protein about 55%, more than 30 trace elements and 18 kinds of amino acids that the body cannot synthesize to help improve anorexia, rickets in young children; improve resistance and immune system, prevent bacteria, viruses. Bird nest contains many micronutrients not inferior to bird nest
For women, the Threonine in bird nest supports the body production of Elastine and Collagen - two substances that regenerate the skin structure, slow down the skin aging process, and make the skin more rosy and smooth.
For pregnant women, the product is rich in nutrients that are good for the health of both mother and fetus. Regular use of bird nest helps pregnant women relieve fatigue, stress, balance psychologically and be less sensitive. Especially, it helps form and fully develop the child brain, helping children grow up smart and agile.
Eliminate excess toxins in the body, enhance concentration as well as maintain, develop and perfect the functions of the normal nervous system.', N'https://yensaothoan.com/media/mageplaza/blog/post/c/h/chan-yen-co-tot-nhu-to-yen-khong.jpg')
INSERT blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL03' ,N'Does Bird Nest Effective Immediately After Use?',N'SalanganesNest has many uses for users, not only children but also adults or adults can use it. But does bird nest have a magical effect right after use? How to eat oats to bring the best effect? Let find out ', N'SalanganesNest has great use for sick people getting up. They are subjects with digestive systems in need of recovery, weak circulatory and respiratory systems, and immune and resistance systems that need to be enhanced. Therefore, patients only need to eat oats for 1-2 days, they will clearly feel healthier body, more comfortable spirit.
Not only that, pure bird nest also helps people with pain wake up to sleep better, have better nerves and recover quickly after surgery.', N'https://afamilycdn.com/150157425591193600/2022/3/31/to-yen2-16487221953141072982427.jpg')
INSERT blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL04' ,N'How long does it take to ensure a golden nutritional source?',N'SalanganesNest is a food with extremely high nutritional content and brings many benefits to the health of users. Therefore, how long to cook oats, and how to cook oats to preserve micronutrients is very important that not everyone knows. If users do not know the rules for how long to cook oats, please refer to the information that shared in this article.', N'How long is a reasonable time to cook oats? Is it okay to cook oats for 10 minutes? Is it good to eat a bird nest for 1 hour?,... Those are the questions that many customers are most interested in today, because in fact, there are many unexpected situations that make users unable to properly time the meal. bird nest. However, you should adjust the cooking time of the bird nest to keep the taste and softness of the bird nest, because:
Cooking oats in too short a time causes the oats not to reach full bloom, the oats are not cooked in time. Cooked oats for too long will make the oats soft, mushy and lose nutrients. The right time of distillation helps the bird nests keep the whole bird nest. Taste and softness In addition to aligning the cooking time of oats, you also need to pay attention to some issues when cooking oats. .Do not mix bird nest with other ingredients because it will affect the taste and nutrients of bird nest. It is best for users to separate the bird nest and process the ingredients separately, mix them together when used.
Do not share the same ingredients with oats. Use a water-bath or an electric distiller instead of direct distillation because the user cannot control the distillation temperature..', N'https://thuocdantoc.vn/wp-content/uploads/2022/04/cach-chung-yen-1.jpg')
INSERT blogList ( blogID, title, summary, detail, cover) VALUES ( N'BL05' ,N'What is Corner Nest? Effects of Corner Nests?',N'SalanganesNest has become a familiar dish for every family because this is a food containing extremely high levels of micronutrients and has many outstanding effects on human health. In addition to the popular types of bird nest, currently on the market, there are corner nests that make users wonder about its nutritional composition and effects. So what is the corner nest? What is the effect of bird nest on the human body? Let find out with  in the article below!', 
N'The corner nest, also known as the triangular nest is usually located in the corner of the bird nest house. Because the shape is not as beautiful as the nests built in other locations, the cost of the corner nests is usually lower. However, the nutritional value and quality of the corner swallow nest is still guaranteed to be pure, not inferior to the refined bird nest or the dried feathered bird nest.Angle bird nest Corner nest is located in the corners of the nest house ADVANTAGES OF THE ANGER nests are flat and thin, easy to split when processing. The nutritional content is equivalent to other types of oats. Cheap price. Suitable for all ages. Save time on processing and cleaning. For children Size Stimulates the digestive system, supports anorexia: Angle nest contains a lot of protein, amino acids and trace elements to help promote the digestive system of young children. In addition, the element chromium increases the ability of children to absorb nutrients through the intestinal membrane.', N'https://tacdungcuatoyen.com/wp-content/uploads/2018/03/yen-goc-1.jpg')

GO
INSERT request (cusID, detail, status) VALUES (N'US003', N'Actual committed sales will run out as expected 90% of the quantity. And the only thing stopping me from that happening are unpredictable events and exceptions', N'1')
INSERT request (cusID, detail, status) VALUES (N'US004', N'After much experience and research, I realized that my website is a very suitable place for me to trade my products, so I want a long-term business contract.', N'1')

GO
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US001', N'YS1', N'2022-10-4', N'Product without pink color, negative point', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US002', N'YN2', N'2022-10-5', N'This sales guy is my ex-boyfriend admin, please help me ban him, thanks', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US003', N'YTC', N'2022-10-6', N'Yen is delicious but I like to report it', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US004', N'YS2', N'2022-10-6', N'Why i can not try it 100 time in free it so ridiculous ???', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')
INSERT reportProduct (cusID, productID, dateReport, description, img) VALUES (N'US005', N'YN3', N'2022-10-6', N'Drop it down it so bad, it violation the rules!', N'https://yensaosaigon.com/wp-content/uploads/2018/11/B%E1%BA%ADt-m%C3%AD-b%C3%AD-m%E1%BA%ADt-v%E1%BB%81-h%E1%BB%93ng-y%E1%BA%BFn-v%C3%A0-huy%E1%BA%BFt-y%E1%BA%BFn-2-768x1024.png')

GO
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'HY', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'PRY', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'NY', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YS1', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YN1', N'I like it , it first time i ever try this', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YTC1', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'HY1', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY1', N'Not good as all', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'NY1', N'bring me more two thousan of this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YS2', N'GG WP!', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN2', N'Delivery really fast , well product good job', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YTC2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY2', N'I have order this tomorrow and get product in next day it delivery very fast positive point', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'NY2', N'Bad product, product delyvery not like the information given', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YS3', N'Drop this product down please i so disgusting', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN3', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YTC3', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'HY3', N'Like it but still have some things missed make it not perfect', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'PRY1', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'NY2', N'Absoluly tasty and freshy', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS4', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN4', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC4', N'Worse product ever been selling', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY2', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'PRY2', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'NY2', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YS5', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN1', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YTC1', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'HY1', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'PRY1', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY1', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS2', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN2', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'HY2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY2', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY2', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YS3', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN3', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YTC3', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY3', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'PRY2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'NY2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YS4', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN4', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YTC4', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'HY4', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY1', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'NY1', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC2', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'HY2', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'PRY1', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY1', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YS3', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN3', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YTC3', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY3', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'PRY2', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY2', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS4', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YN4', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YTC4', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY4', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'PRY1', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'NY1', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'HY', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'PRY', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'NY', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YS1', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YN1', N'I like it , it first time i ever try this', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YTC1', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'HY1', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY1', N'Not good as all', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'NY1', N'bring me more two thousan of this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YS2', N'GG WP!', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN2', N'Delivery really fast , well product good job', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YTC2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY2', N'I have order this tomorrow and get product in next day it delivery very fast positive point', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'NY2', N'Bad product, product delyvery not like the information given', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YS3', N'Drop this product down please i so disgusting', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN3', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YTC3', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'HY3', N'Like it but still have some things missed make it not perfect', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'PRY1', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'NY2', N'Absoluly tasty and freshy', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS4', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN4', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC4', N'Worse product ever been selling', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY2', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'PRY2', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'NY2', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YS5', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN1', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YTC1', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'HY1', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'PRY1', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY1', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS2', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN2', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'HY2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY2', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY2', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YS3', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN3', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YTC3', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY3', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'PRY2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'NY2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YS4', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YN4', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YTC4', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'HY4', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'PRY1', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'NY1', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS2', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN2', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YTC2', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'HY2', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'PRY1', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY1', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'YS3', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YN3', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'YTC3', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY3', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'PRY2', N'Good tasty, high quality, valid and best choice', N'https://vuayen.vn/wp-content/uploads/2018/03/Y%E1%BA%BFn-huy%E1%BA%BFt-gi%C3%BAp-ph%C3%B2ng-tr%C3%A1nh-b%E1%BB%87nh-ung-th%C6%B0-hi%E1%BB%87u-qu%E1%BA%A3.jpg', N'5')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'NY2', N'This product is so bad ', N'https://www.yensaodongduong.com/uploads/2020/08/yensaodongduong.com_Huong-dan-cach-chung-yen-don-gian-ma-bo-duong-cach-chung-to-yen-5-1558881424-width600height600.jpg' ,N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YS4', N'This product is like the *** why you all still selling this', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'1')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US001', N'YN4', N'I will buy it 1000 times if i have money', N'https://cdn.tgdd.vn/Files/2019/03/08/1153555/nuoc-yen-sao-la-gi-cong-dung-cua-nuoc-yen-sao-voi-suc-khoe-202112291116077826.jpg', N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'YTC4', N'Great product with the high quality ever i try but it so expensive', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'4')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US003', N'HY4', N'I very like it but i do not want to rate it high =))', N'https://didulichaz.com/wp-content/uploads/an-to-yen-dung-cach.jpg', N'2')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US002', N'PRY1', N'Not good somuch but in this price it the great product you can find', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'3')
INSERT comment ( cusID, productID, detail, img, rate) VALUES (N'US004', N'NY1', N'Truly tasty', N'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUct1Afqx1VW1p6NNDzqGdMVaidiSBloyPTe_M4S_nd3cqHI-Komzn2j7JYN-giT6EA1I&usqp=CAU' ,N'5')

GO
--codeID: 4 char num of voucher + 3-9 char name affect + 3-5 char target + for + vse or vsy ---
--KeyCode: 1 char name affect + 3-5 char type affect + sy or se ---
INSERT codeStore(codeID, keyCode, tradingPoint) VALUES (N'cd01rd10ptforvse', N'RD10PT', 1000)
INSERT codeStore(codeID, keyCode, tradingPoint) VALUES (N'cd02rd20ptforvse', N'RD20PT', 1500)
INSERT codeStore(codeID, keyCode, tradingPoint) VALUES (N'cd03rd30ptforvse', N'RD30PT', 3200)
INSERT codeStore(codeID, keyCode, tradingPoint) VALUES (N'cd04ex15cuforvse', N'EX15CU', 1200)
INSERT codeStore(codeID, keyCode, tradingPoint) VALUES (N'cd05ex20cuforvse', N'EX20CU', 1800)
INSERT codeStore(codeID, keyCode, tradingPoint) VALUES (N'cd06ex30cuforvse', N'EX30CU', 2200)

GO
INSERT voucher(name, codeID, cusID, quantity) VALUES ( N'Reduce 10% for all items', N'cd01rd10ptforvse', N'US001', 3)
INSERT voucher(name, codeID, cusID, quantity) VALUES (N'Extra 1.5 cumulative point', N'cd04ex15cuforvse', N'US001', 2)
INSERT voucher(name, codeID, cusID, quantity) VALUES ( N'Extra 2 cumulative point', N'cd05ex20cuforvse', N'US001', 2)
INSERT voucher(name, codeID, cusID, quantity) VALUES (N'Reduce 30% for all items', N'cd03rd30ptforvse', N'US001', 10)

GO
INSERT orders(orderID ,cusID, cusName, cusPhone, loc, ordDate, voucherID, cumulativeUse, cumulativeEarn, total) VALUES (N'US001CK0',N'US001', N'GigaChad', N'0123456789', N'Q9 D2 district', N'2022-10-6', 1, 0, 1000, 2500)
INSERT orders(orderID ,cusID, cusName, cusPhone, loc, ordDate, cumulativeUse, cumulativeEarn, total, status) VALUES (N'US001CK1' ,N'US002', N'Rosé', N'0999345899', N'Seoul South Koreant', N'2022-10-6', 0, 1000, 2500, 2)
INSERT orders(orderID ,cusID, cusName, cusPhone, loc, ordDate, cumulativeUse, cumulativeEarn, total, status) VALUES (N'US001CK2',N'US001', N'GigaChad', N'0123456789', N'Q9 D2 district', N'2022-10-6', 0, 0, 2500, 3)
INSERT orders(orderID ,cusID, cusName, cusPhone, loc, ordDate, cumulativeUse, cumulativeEarn, total, status) VALUES (N'US001CK3' ,N'US002', N'Rosé', N'0999345899', N'Seoul South Koreant', N'2022-10-6', 0, 0, 2500, 4)

GO
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'US001CK0',N'SE001', N'YS', N'Refined premium liquid salanganesNest',N'https://product.hstatic.net/1000096857/product/2_e919d8d01d514246b1eb6bdd24c2ca1d.png', N'10')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'US001CK0',N'SE001', N'HY1', N'Bloody bird nest',N'https://ysnt.com.vn/wp-content/uploads/2019/12/17.png', N'5')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'US001CK0',N'SE002', N'YN2', N'SalanganesNest origin',N'https://product.hstatic.net/1000283244/product/yen_chung_duong_phen___nutri_nest___nuoc_yen__green_bird_hop_qua_6_hu_2b881dab8b594df4a0f3605e0a131a93.jpg', N'9')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity) VALUES ('', N'US001CK0',N'SE003', N'YTC2', N'Home make birds nest',N'https://bizweb.dktcdn.net/thumb/1024x1024/100/429/476/products/yen-sao-nguyen-chat-lam-sach-hop-5g.jpg?v=1625159664687', N'69')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK1',N'SE001', N'YS', N'Refined premium liquid salanganesNest',N'https://product.hstatic.net/1000096857/product/2_e919d8d01d514246b1eb6bdd24c2ca1d.png', N'10', N'2')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK1',N'SE001', N'HY1', N'Bloody bird nest',N'https://ysnt.com.vn/wp-content/uploads/2019/12/17.png', N'5', N'2')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK1',N'SE002', N'YN2', N'SlanganesNest origin',N'https://product.hstatic.net/1000283244/product/yen_chung_duong_phen___nutri_nest___nuoc_yen__green_bird_hop_qua_6_hu_2b881dab8b594df4a0f3605e0a131a93.jpg', N'9', N'2')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK1',N'SE003', N'YTC2', N'Home make birds nest',N'https://bizweb.dktcdn.net/thumb/1024x1024/100/429/476/products/yen-sao-nguyen-chat-lam-sach-hop-5g.jpg?v=1625159664687', N'69', N'3')

INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK2',N'SE001', N'YS', N'Refined premium liquid salanganesNest',N'https://product.hstatic.net/1000096857/product/2_e919d8d01d514246b1eb6bdd24c2ca1d.png', N'10', N'3')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK2',N'SE001', N'HY1', N'Bloody bird nest',N'https://ysnt.com.vn/wp-content/uploads/2019/12/17.png', N'5', N'3')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK2',N'SE002', N'YN2', N'SalanganesNest origin',N'https://product.hstatic.net/1000283244/product/yen_chung_duong_phen___nutri_nest___nuoc_yen__green_bird_hop_qua_6_hu_2b881dab8b594df4a0f3605e0a131a93.jpg', N'9', N'3')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK2',N'SE003', N'YTC2', N'Home make birds nest',N'https://bizweb.dktcdn.net/thumb/1024x1024/100/429/476/products/yen-sao-nguyen-chat-lam-sach-hop-5g.jpg?v=1625159664687', N'69', N'3')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK3',N'SE001', N'YS', N'Refined premium liquid salanganesNest',N'https://product.hstatic.net/1000096857/product/2_e919d8d01d514246b1eb6bdd24c2ca1d.png', N'10', N'4')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK3',N'SE001', N'HY1', N'Bloody bird nest',N'https://ysnt.com.vn/wp-content/uploads/2019/12/17.png', N'5', N'4')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK3',N'SE002', N'YN2', N'SlanganesNest origin',N'https://product.hstatic.net/1000283244/product/yen_chung_duong_phen___nutri_nest___nuoc_yen__green_bird_hop_qua_6_hu_2b881dab8b594df4a0f3605e0a131a93.jpg', N'9', N'4')
INSERT orderDetail (orderDetailID, orderID,sellerID, productID, productName, img, quantity, status) VALUES ('', N'US001CK3',N'SE003', N'YTC2', N'Home make birds nest',N'https://bizweb.dktcdn.net/thumb/1024x1024/100/429/476/products/yen-sao-nguyen-chat-lam-sach-hop-5g.jpg?v=1625159664687', N'69', N'4')

GO
INSERT saveCumulative(cusID, infor, time) VALUES(N'US001', N'100', N'2002-10-31')
INSERT saveCumulative(cusID, infor, time) VALUES(N'US001', N'200', N'2002-10-31')
INSERT saveCumulative(cusID, infor, time) VALUES(N'US001', N'300', N'2002-10-31')

GO
INSERT bussinessRules (ruleID, type, description) VALUES (N'RL01', N'RPUS', N'Sorry this account has been banned due to too many people reporting, Your account will be open in 7 days')
INSERT bussinessRules (ruleID, type, description) VALUES (N'RL02', N'SPV', N'Sorry this account has been banned for selling shoddy products, we will unlock once you solve the problem on our site')
INSERT bussinessRules (ruleID, type, description) VALUES (N'RL03', N'VBR', N'Sorry this account has been banned due to violation of certain terms, the account will be unlocked after we resolve the issue it will take about 30 days')
INSERT bussinessRules (ruleID, type, description) VALUES (N'RL04', N'DRPUS', N'Attention! this account has been deleted due to too many reports by customer, if this is our fault please feedback via our email')
INSERT bussinessRules (ruleID, type, description) VALUES (N'RL05', N'DVBR', N'Attention this account has been deleted due to serious violation of business law,  if this is not your fault please respond via our email')
INSERT bussinessRules (ruleID, type, description) VALUES (N'RL06', N'DNOL', N'Attention this account has been deleted due to inactivity and order response, if you have a good reason or respond via our email')


