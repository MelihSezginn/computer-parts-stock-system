USE [master]
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'DbUrunSatis')
BEGIN
    ALTER DATABASE [DbUrunSatis] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [DbUrunSatis];
END
GO

CREATE DATABASE [DbUrunSatis]
GO

USE [DbUrunSatis]
GO


CREATE TABLE [dbo].[TblMusteriler](
	[musteriID] [int] IDENTITY(1,1) NOT NULL,
	[ad] [nvarchar](50) NULL,
	[soyad] [nvarchar](50) NULL,
	[adres] [nvarchar](50) NULL,
	[tel] [nvarchar](50) NULL,
	[durum] [bit] NULL CONSTRAINT [DF_TblMusteriler_durum] DEFAULT ((1)),
 CONSTRAINT [PK_TblMusteriler] PRIMARY KEY CLUSTERED ([musteriID] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TblUrunler](
	[urunID] [int] IDENTITY(1,1) NOT NULL,
	[urunAd] [nvarchar](50) NULL,
	[stok] [int] NULL,
	[alisFiyat] [int] NULL,
	[satisFiyat] [int] NULL,
	[durum] [bit] NULL CONSTRAINT [DF_TblUrunler_durum] DEFAULT ((1)),
 CONSTRAINT [PK_TblUrunler] PRIMARY KEY CLUSTERED ([urunID] ASC)
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[TblSatislar](
	[satisID] [int] IDENTITY(1,1) NOT NULL,
	[urun] [int] NULL,
	[musteri] [int] NULL,
	[adet] [int] NULL,
	[toplamFiyat] [int] NULL,
	[tarih] [smalldatetime] NULL,
 CONSTRAINT [PK_TblSatislar] PRIMARY KEY CLUSTERED ([satisID] ASC)
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TblSatislar] WITH CHECK ADD CONSTRAINT [FK_TblSatislar_TblMusteriler] FOREIGN KEY([musteri])
REFERENCES [dbo].[TblMusteriler] ([musteriID])
GO
ALTER TABLE [dbo].[TblSatislar] CHECK CONSTRAINT [FK_TblSatislar_TblMusteriler]
GO
ALTER TABLE [dbo].[TblSatislar] WITH CHECK ADD CONSTRAINT [FK_TblSatislar_TblUrunler] FOREIGN KEY([urun])
REFERENCES [dbo].[TblUrunler] ([urunID])
GO
ALTER TABLE [dbo].[TblSatislar] CHECK CONSTRAINT [FK_TblSatislar_TblUrunler]
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[satisListesi]
AS
SELECT satisID, TblUrunler.urunAd AS 'Ürün Adı', TblMusteriler.ad + ' ' + TblMusteriler.soyad AS ' Ad Soyad', adet, toplamFiyat AS 'Toplam Fiyat', tarih FROM TblSatislar
INNER JOIN TblUrunler ON TblSatislar.urun = TblUrunler.urunID 
INNER JOIN TblMusteriler ON TblSatislar.musteri = TblMusteriler.musteriID 
GO

CREATE PROCEDURE [dbo].[satisListesi2]
AS
SELECT satisID, TblUrunler.urunAd AS 'Ürün Adı', TblMusteriler.ad + ' ' + TblMusteriler.soyad AS 'Ad Soyad', adet, toplamFiyat AS 'Toplam Fiyat', tarih FROM TblSatislar
INNER JOIN TblUrunler ON TblSatislar.urun = TblUrunler.urunID 
INNER JOIN TblMusteriler ON TblSatislar.musteri = TblMusteriler.musteriID 
GO


SET IDENTITY_INSERT [dbo].[TblMusteriler] ON 
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (1,'Melih','Sezgin','ADANA / SEYHAN','(532)111-1111',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (2,'Samed','Koç','ADANA / SEYHAN','(532)222-2222',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (3,'Ferhat','Çırrık','ŞANLIURFA / SURUÇ','(532)333-3333',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (4,'Serkan','Gökel','ŞANLIURFA / MERKEZ','(532)444-4444',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (5,'Muhammet','Tali','GAZİANTEP / MERKEZ','(532)555-5555',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (6,'Kübra','Bozkurt','ADIYAMAN / MERKEZ','(532)666-6666',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (7,'Efe Doğukan','Tekin','HATAY / DÖRTYOL','(532)777-7777',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (8,'Hasan','Arslan','OSMANİYE / MERKEZ','(532)888-8888',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (9,'İpek','Çelenk','HATAY / DÖRTYOL','(532)999-9999',1)
INSERT [dbo].[TblMusteriler] ([musteriID],[ad],[soyad],[adres],[tel],[durum]) VALUES (10,'Nazım','Gökel','ŞANLIURFA / MERKEZ','(532)101-0101',1)
SET IDENTITY_INSERT [dbo].[TblMusteriler] OFF
GO

SET IDENTITY_INSERT [dbo].[TblUrunler] ON 
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (1, N'İşlemci', 15, 6500, 8000, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (2, N'Anakart', 12, 4500, 5500, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (3, N'RAM 16GB', 20, 1200, 1600, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (4, N'SSD 1TB', 18, 1800, 2500, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (5, N'Ekran Kartı', 8, 12000, 15000, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (6, N'Güç Kaynağı', 10, 1500, 2200, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (7, N'Bilgisayar Kasası', 7, 2000, 3000, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (8, N'İşlemci Soğutucu', 14, 800, 1200, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (9, N'Gaming Mouse', 16, 500, 850, 1)
INSERT [dbo].[TblUrunler] ([urunID], [urunAd], [stok], [alisFiyat], [satisFiyat], [durum]) VALUES (10, N'Mekanik Klavye', 11, 1200, 1800, 1)
SET IDENTITY_INSERT [dbo].[TblUrunler] OFF
GO

SET IDENTITY_INSERT [dbo].[TblSatislar] ON 
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (1, 1, 1, 1, 12000, '2026-01-05')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (2, 2, 2, 1, 5000, '2026-01-06')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (3, 1, 1, 1, 100, '2026-01-07')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (4, 4, 1, 1, 60, '2026-01-08')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (5, 3, 1, 2, 220, '2026-01-09')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (6, 6, 2, 2, 2000, '2026-01-10')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (7, 2, 2, 2, 10000, '2026-01-11')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (8, 7, 1, 5, 150, '2026-01-12')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (9, 1, 1, 1, 12000, '2026-01-13')
INSERT [dbo].[TblSatislar] ([satisID],[urun],[musteri],[adet],[toplamFiyat],[tarih]) VALUES (10, 2, 4, 1, 5000, '2026-01-14')
SET IDENTITY_INSERT [dbo].[TblSatislar] OFF
GO

USE [master]
GO