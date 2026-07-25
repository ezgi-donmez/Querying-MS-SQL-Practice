-- Customers isimli bir veritabanı ve verilen veri setindeki değişkenleri içerecek FLO isimli bir tablo oluşturunuz.

-- 2. Kaç farklı müşterinin alışveriş yaptığını gösterecek sorguyu yazınız.
select count (master_id) 
  From flo;


-- 3. Toplam yapılan alışveriş sayısı ve ciroyu getirecek sorguyu yazınız.
select 
	sum(order_num_total_ever_online + order_num_total_ever_online) as toplam_alisveris, 
	sum(customer_value_total_ever_online + customer_value_total_ever_offline) as toplam_ciro
From flo;


-- 4. Alışveriş başına ortalama ciroyu getirecek sorguyu yazınız.
select 
	master_id,
	(customer_value_total_ever_online + customer_value_total_ever_offline) / 
	(order_num_total_ever_online + order_num_total_ever_online) as avg_ciro

From flo;


-- 5. En son alışveriş yapılan kanal (last_order_channel) üzerinden yapılan alışverişlerin toplam ciro ve alışveriş sayılarını
-- getirecek sorguyu yazınız.
SELECT 
    last_order_channel,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS toplam_ciro,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS toplam_alisveris
FROM 
    flo
GROUP BY 
    last_order_channel;


-- 6. Store type kırılımında elde edilen toplam ciroyu getiren sorguyu yazınız.
SELECT 
    store_type,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS toplam_ciro
FROM 
    flo
GROUP BY 
    store_type;

-- 7. Yıl kırılımında alışveriş sayılarını getirecek sorguyu yazınız (Yıl olarak müşterinin ilk alışveriş tarihi (first_order_date) yılını
-- baz alınız)
SELECT 
    datepart(year,first_order_date) as alisveris_yili,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS toplam_alisveris
FROM 
    flo
GROUP BY 
    datepart(year,first_order_date)
Order by 1 desc;


-- 8. En son alışveriş yapılan kanal kırılımında alışveriş başına ortalama ciroyu hesaplayacak sorguyu yazınız.
SELECT 
	last_order_channel,
    sum(customer_value_total_ever_online + customer_value_total_ever_offline) /
    sum(order_num_total_ever_online + order_num_total_ever_offline) AS avg_ciro
FROM 
    flo
GROUP BY 
    last_order_channel
ORDER BY 2 desc;

-- 9. Son 12 ayda en çok ilgi gören kategoriyi getiren sorguyu yazınız.
SELECT TOP 1
    interested_in_categories_12,
    COUNT(*) AS interest
FROM 
    flo
GROUP BY 
    interested_in_categories_12
ORDER BY 
    interest DESC;


-- 10. En çok tercih edilen store_type bilgisini getiren sorguyu yazınız.
SELECT TOP 1
    store_type,
    COUNT(*) AS interest
FROM 
    flo
GROUP BY 
    store_type
ORDER BY 
    interest DESC;


-- 11. En son alışveriş yapılan kanal (last_order_channel) bazında, en çok ilgi gören kategoriyi ve bu kategoriden ne kadarlık
-- alışveriş yapıldığını getiren sorguyu yazınız.
-- Önce kanal ve kategori özeti

WITH kategori AS
(
    SELECT
        last_order_channel,
        interested_in_categories_12,

        -- Bu kategoriyle ilgilenen müşteri sayısı
        COUNT(*) AS adet,

        -- toplam online ve offline alışveriş tutarı
        SUM(
            customer_value_total_ever_online +
            customer_value_total_ever_offline
        ) AS toplam_tutar

    FROM flo

    -- Her kanal ve kategori için ayrı hesaplama
    GROUP BY
        last_order_channel,
        interested_in_categories_12
)

-- kategori özetinden sonuçları getiriyoruz
SELECT *
FROM kategori AS k

-- Her kanal için en yüksek müşteri sayısına sahip kategoriyi seçiyoruz
WHERE adet =
(
    SELECT MAX(adet)
    FROM kategori

    -- Alt sorgudaki kanal ile dış sorgudaki kanal aynı olmalı
    WHERE last_order_channel = k.last_order_channel
)

ORDER BY last_order_channel;
