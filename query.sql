SELECT
  t.transaction_id,
  t.date,
  c.customer_name,
  p.product_id,
  p.product_name,
  p.actual_price,
  p.discount_percentage,
  b.branch_id,
  b.branch_name,
  b.kota,
  b.provinsi,
  b.rating AS rating_cabang,
  t.rating AS rating_transaksi,

  CASE
    WHEN p.actual_price <= 50000 THEN 0.10
    WHEN p.actual_price > 50000 AND p.actual_price <= 100000 THEN 0.15
    WHEN p.actual_price > 100000 AND p.actual_price <= 300000 THEN 0.20
    WHEN p.actual_price > 300000 AND p.actual_price <= 500000 THEN 0.25
    ELSE 0.30
  END AS persentase_gross_laba,

  (p.actual_price * (1 - p.discount_percentage)) AS nett_sales,

  (p.actual_price * (1 - p.discount_percentage)) *
  CASE
    WHEN p.actual_price <= 50000 THEN 0.10
    WHEN p.actual_price > 50000 AND p.actual_price <= 100000 THEN 0.15
    WHEN p.actual_price > 100000 AND p.actual_price <= 300000 THEN 0.20
    WHEN p.actual_price > 300000 AND p.actual_price <= 500000 THEN 0.25
    ELSE 0.30
  END AS nett_profit

FROM `rakamin-kf-analytics-486901.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-486901.kimia_farma.kf_kantor_cabang` b
  ON t.branch_id = b.branch_id
LEFT JOIN `rakamin-kf-analytics-486901.kimia_farma.kf_product` p
  ON t.product_id = p.product_id
LEFT JOIN `rakamin-kf-analytics-486901.kimia_farma.kf_customer` c
  ON t.customer_id = c.customer_id
