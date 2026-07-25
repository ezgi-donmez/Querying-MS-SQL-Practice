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

