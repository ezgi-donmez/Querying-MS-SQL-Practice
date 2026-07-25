-- Customers isimli bir veritabanı ve verilen veri setindeki değişkenleri içerecek FLO isimli bir tablo oluşturunuz.

-- Kaç farklı müşterinin alışveriş yaptığını gösterecek sorguyu yazınız.
select count (master_id) 
  From flo;


-- Toplam yapılan alışveriş sayısı ve ciroyu getirecek sorguyu yazınız.
select 
	sum(order_num_total_ever_online + order_num_total_ever_online) as toplam_alisveris, 
	sum(customer_value_total_ever_online + customer_value_total_ever_offline) as toplam_ciro
From flo;


-- Alışveriş başına ortalama ciroyu getirecek sorguyu yazınız.
select 
	master_id,
	(customer_value_total_ever_online + customer_value_total_ever_offline) / 
	(order_num_total_ever_online + order_num_total_ever_online) as avg_ciro

From flo;


-- En son alışveriş yapılan kanal (last_order_channel) üzerinden yapılan alışverişlerin toplam ciro ve alışveriş sayılarını
-- getirecek sorguyu yazınız.
SELECT 
    last_order_channel,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS toplam_ciro,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS toplam_alisveris
FROM 
    flo
GROUP BY 
    last_order_channel;


-- Store type kırılımında elde edilen toplam ciroyu getiren sorguyu yazınız.
SELECT 
    store_type,
    SUM(customer_value_total_ever_online + customer_value_total_ever_offline) AS toplam_ciro
FROM 
    flo
GROUP BY 
    store_type;

-- Yıl kırılımında alışveriş sayılarını getirecek sorguyu yazınız (Yıl olarak müşterinin ilk alışveriş tarihi (first_order_date) yılını
-- baz alınız)
SELECT 
    datepart(year,first_order_date) as alisveris_yili,
    SUM(order_num_total_ever_online + order_num_total_ever_offline) AS toplam_alisveris
FROM 
    flo
GROUP BY 
    datepart(year,first_order_date)
Order by 1 desc;
