/* Проект «Яндекс Афиша»
 * Цель проекта: 
 * Провести исследовательский анализ лояльности пользователей Яндекс Афиши с целью формирования профиля пользователей, делающих повторные покупки для:
 * оперативного выявления перспективных клиентов и формирования персонализированных предложений;
 * настройки таргетированной рекламы для аудитории с высокой вероятностью возврата;
 * оптимизировации маркетинговых бюджетов;
 * повышения общего уровня удержания клиентов.
 * 
 * Автор: Дьяченко Юлия
 * Дата: V.1: 15.12.2025
*/
-- 1. Разведочный анализ данных проекта.
-- Выведем названия всех таблиц схемы afisha.
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'afisha';
-- 1.1. Разведочный анализ данных проекта. Таблица purchases.
-- Данные в таблице
SELECT c.table_schema,
       c.table_name,
       c.column_name,
       c.data_type,
       k.constraint_name
FROM information_schema.columns AS c
     LEFT JOIN information_schema.key_column_usage AS k ON
     c.table_name = k.table_name
     AND c.column_name = k.column_name
     AND c.table_schema = k.table_schema
WHERE c.table_schema = 'afisha' AND c.table_name = 'purchases'
   ORDER BY c.table_name;
-- Вывод первых 5 строк таблицы purchases
SELECT *,
COUNT(*) OVER () AS row_count
FROM afisha.purchases
LIMIT 5;
--Проверка пропусков в таблице purchases
SELECT COUNT(*) AS null_count
FROM afisha.purchases
WHERE order_id  IS NULL 
OR user_id IS NULL 
OR created_dt_msk IS NULL 
OR created_ts_msk IS NULL
OR event_id IS NULL
OR cinema_circuit IS NULL
OR age_limit IS NULL
OR currency_code IS NULL
OR device_type_canonical IS NULL
OR revenue IS NULL
OR service_name IS NULL
OR tickets_count IS NULL
OR total IS NULL;

-- Проверка на дубликаты purchases
SELECT order_id,
       COUNT(*) AS count
FROM afisha.purchases
GROUP BY order_id 
HAVING COUNT(*)  > 1;

-- Знакомство с категориальными данными таблицы purchases
SELECT DISTINCT cinema_circuit,
	   COUNT(cinema_circuit)
FROM afisha.purchases
GROUP BY cinema_circuit
ORDER BY COUNT(cinema_circuit) DESC;

SELECT DISTINCT age_limit,
	   COUNT(age_limit)
FROM afisha.purchases
GROUP BY age_limit
ORDER BY COUNT(age_limit) DESC;

SELECT DISTINCT currency_code,
	   COUNT(currency_code)
FROM afisha.purchases
GROUP BY currency_code
ORDER BY COUNT(currency_code) DESC;

SELECT DISTINCT device_type_canonical,
	   COUNT(device_type_canonical)
FROM afisha.purchases
GROUP BY device_type_canonical
ORDER BY COUNT(device_type_canonical) DESC;

SELECT DISTINCT service_name,
	   COUNT(service_name)
FROM afisha.purchases
GROUP BY service_name
ORDER BY COUNT(service_name) DESC;

--Количество заказов
SELECT COUNT(order_id)
FROM afisha.purchases;
--292034 заказа

--Количество пользователей
SELECT COUNT(DISTINCT user_id)
FROM afisha.purchases;
-- 22000 пользователей


-- 1.2. Разведочный анализ данных проекта. Таблица events.
-- Данные в таблице
SELECT c.table_schema,
       c.table_name,
       c.column_name,
       c.data_type,
       k.constraint_name
FROM information_schema.columns AS c
     LEFT JOIN information_schema.key_column_usage AS k ON
     c.table_name = k.table_name
     AND c.column_name = k.column_name
     AND c.table_schema = k.table_schema
WHERE c.table_schema = 'afisha' AND c.table_name = 'events'
   ORDER BY c.table_name;
-- Вывод первых 5 строк таблицы events
SELECT *,
COUNT(*) OVER () AS row_count
FROM afisha.events
LIMIT 5;
--Проверка пропусков в таблице events
SELECT COUNT(*) AS null_count
FROM afisha.events
WHERE event_id  IS NULL 
OR event_name_code IS NULL 
OR event_type_description IS NULL 
OR event_type_main IS NULL
OR organizers IS NULL
OR city_id IS NULL
OR venue_id IS NULL;
-- Проверка на дубликаты events
SELECT event_id,
       COUNT(*) AS count
FROM afisha.events
GROUP BY event_id 
HAVING COUNT(*)  > 1;
-- Знакомство с категориальными данными таблицы events
SELECT DISTINCT event_type_main,
	   COUNT(event_type_main)
FROM afisha.events
GROUP BY event_type_main
ORDER BY COUNT(event_type_main) DESC;

--Количество событий
SELECT COUNT(DISTINCT event_id)
FROM afisha.events;
SELECT COUNT(DISTINCT event_name_code)
FROM afisha.events;

-- 1.3. Разведочный анализ данных проекта. Таблица venues.
-- Данные в таблице
SELECT c.table_schema,
       c.table_name,
       c.column_name,
       c.data_type,
       k.constraint_name
FROM information_schema.columns AS c
     LEFT JOIN information_schema.key_column_usage AS k ON
     c.table_name = k.table_name
     AND c.column_name = k.column_name
     AND c.table_schema = k.table_schema
WHERE c.table_schema = 'afisha' AND c.table_name = 'venues'
   ORDER BY c.table_name;
-- Вывод первых 5 строк таблицы venues
SELECT *,
COUNT(*) OVER () AS row_count
FROM afisha.venues
LIMIT 5;
--Проверка пропусков в таблице venues
SELECT COUNT(*) AS null_count
FROM afisha.venues
WHERE venue_id  IS NULL 
OR venue_name IS NULL 
OR address IS NULL;
-- Проверка на дубликаты venues
SELECT venue_id,
       COUNT(*) AS count
FROM afisha.venues
GROUP BY venue_id 
HAVING COUNT(*)  > 1;

-- 1.4. Разведочный анализ данных проекта. Таблица city.
-- Данные в таблице
SELECT c.table_schema,
       c.table_name,
       c.column_name,
       c.data_type,
       k.constraint_name
FROM information_schema.columns AS c
     LEFT JOIN information_schema.key_column_usage AS k ON
     c.table_name = k.table_name
     AND c.column_name = k.column_name
     AND c.table_schema = k.table_schema
WHERE c.table_schema = 'afisha' AND c.table_name = 'city'
   ORDER BY c.table_name;
-- Вывод первых 5 строк таблицы city
SELECT *,
COUNT(*) OVER () AS row_count
FROM afisha.city
LIMIT 5;
--Проверка пропусков в таблице city
SELECT COUNT(*) AS null_count
FROM afisha.city
WHERE city_id IS NULL 
OR city_name IS NULL 
OR region_id IS NULL;
-- Проверка на дубликаты city
SELECT city_id ,
       COUNT(*) AS count
FROM afisha.city
GROUP BY city_id  
HAVING COUNT(*)  > 1;
-- Знакомство с категориальными данными таблицы city
SELECT COUNT (DISTINCT city_id)
FROM afisha.city;
SELECT COUNT (DISTINCT city_name)
FROM afisha.city;
--353 города по id и 352 по названию

-- 1.5. Разведочный анализ данных проекта. Таблица regions.
-- Данные в таблице
SELECT c.table_schema,
       c.table_name,
       c.column_name,
       c.data_type,
       k.constraint_name
FROM information_schema.columns AS c
     LEFT JOIN information_schema.key_column_usage AS k ON
     c.table_name = k.table_name
     AND c.column_name = k.column_name
     AND c.table_schema = k.table_schema
WHERE c.table_schema = 'afisha' AND c.table_name = 'regions'
   ORDER BY c.table_name;
-- Вывод первых 5 строк таблицы regions
SELECT *,
COUNT(*) OVER () AS row_count
FROM afisha.regions
LIMIT 5;
--Проверка пропусков в таблице regions
SELECT COUNT(*) AS null_count
FROM afisha.regions
WHERE region_id IS NULL 
OR region_name IS NULL;
-- Проверка на дубликаты regions
SELECT region_id ,
       COUNT(*) AS count
FROM afisha.regions
GROUP BY region_id  
HAVING COUNT(*)  > 1;
-- Знакомство с категориальными данными таблицы regions
SELECT DISTINCT region_name,
	   COUNT(region_name)
FROM afisha.regions
GROUP BY region_name 
ORDER BY region_name;

SELECT COUNT (DISTINCT region_name)
FROM afisha.regions;
--Представлен 81 регион.

--Статистические данные о выручке
SELECT
    COUNT(*) AS orders_count,
    MIN(revenue) AS revenue_min,
    MAX(revenue) AS revenue_max,
    AVG(revenue) AS revenue_avg,
    MAX(revenue) - MIN(revenue) AS r,
    STDDEV(revenue) AS std,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY revenue) AS revenue_median,
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) AS p25,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) AS p75,
    PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY revenue) AS p90,
    PERCENTILE_CONT(0.99) WITHIN GROUP (ORDER BY revenue) AS p99
FROM afisha.purchases
    GROUP BY currency_code;

-- Проверка на выбросы
WITH stats AS (
    SELECT
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY revenue) AS q1,
        PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY revenue) AS q3
    FROM afisha.purchases
),
bounds AS (
    SELECT
        q1,
        q3,
        (q3 - q1) AS iqr,
        q1 - 1.5 * (q3 - q1) AS lower_bound,
        q3 + 1.5 * (q3 - q1) AS upper_bound
    FROM stats
)
SELECT
    p.order_id,
    p.revenue,
    b.lower_bound,
    b.upper_bound
FROM afisha.purchases AS p
CROSS JOIN bounds AS b
WHERE p.revenue < b.lower_bound
   OR p.revenue > b.upper_bound
ORDER BY p.revenue DESC
LIMIT 10;

--Период данных
SELECT
    MIN(created_ts_msk) AS first_date,
    MAX(created_ts_msk) AS last_date,
    MAX(created_ts_msk) - MIN(created_ts_msk) AS total_period
FROM afisha.purchases;
--Распределение по месяцам
SELECT
    DATE_TRUNC('month', created_ts_msk) AS month,
    COUNT(*) AS orders_count,
    SUM(revenue) AS revenue_sum
FROM afisha.purchases
GROUP BY month
ORDER BY month;
--Распределение по дням недели (0 — воскресенье, 1 — понедельник)
SELECT
    EXTRACT(DOW FROM created_ts_msk) AS day_of_week,
    COUNT(*) AS orders_count,
    SUM(revenue) AS revenue_sum
FROM afisha.purchases
GROUP BY day_of_week
ORDER BY day_of_week;
-- Сезонность по типам событий
SELECT
    DATE_TRUNC('month', p.created_ts_msk) AS month,
    e.event_type_main,
    COUNT(*) AS orders_count,
    SUM(p.revenue) AS revenue_sum
FROM afisha.purchases p
JOIN afisha.events e ON p.event_id = e.event_id
GROUP BY month, e.event_type_main
ORDER BY month, orders_count DESC;

-- Популярность по типам событий
SELECT
    e.event_type_main,
    COUNT(*) AS orders_count,
    SUM(p.revenue) AS revenue_sum
FROM afisha.purchases AS p
JOIN afisha.events e ON p.event_id = e.event_id
GROUP BY e.event_type_main
ORDER BY orders_count DESC;

-- Выгрузка данных с помощью SQL:
-- Настройка параметра synchronize_seqscans важна для проверки
WITH set_config_precode AS (
  SELECT set_config('synchronize_seqscans', 'off', true)
),

filtered_purchases AS (
    SELECT
        *
    FROM afisha.purchases
    WHERE device_type_canonical IN ('mobile', 'desktop')
),
calc_days AS (
    SELECT
        p.*,
        (p.created_dt_msk::date - LAG(p.created_dt_msk::date) 
            OVER(PARTITION BY p.user_id ORDER BY p.created_dt_msk)
        )    AS days_since_prev
    FROM filtered_purchases AS p
)
SELECT c.user_id, 
    c.device_type_canonical, 
    c.order_id, 
    c.created_dt_msk AS order_dt, 
    c.created_ts_msk AS order_ts, 
    c.currency_code, 
    c.revenue, 
    c.tickets_count, 
    c.days_since_prev, 
    c.event_id, 
    e.event_name_code AS event_name,
    c.service_name, 
    e.event_type_main, 
    r.region_name, 
    ct.city_name 
FROM calc_days AS c 
INNER JOIN afisha.events AS e ON c.event_id = e.event_id 
LEFT JOIN afisha.city AS ct ON e.city_id = ct.city_id 
LEFT JOIN afisha.regions AS r ON ct.region_id = r.region_id 
WHERE e.event_type_main != 'фильм' 
ORDER BY c.user_id
LIMIT 10;
