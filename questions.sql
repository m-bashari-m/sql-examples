-- Q1
-1می خواهیم قیمت محصولاتی که میزان فروش آنها کم بوده است، کاهش دهیم . منظور  list_priceدر  productاست.
در صورتی که مجموع هزینه فروش محصولی کمتر از  0.002مجموع هزینه فروش در دسته بندی همان محصول بود،
قیمت را  %50کاهش دهید. (به روزرسانی) یعنی در صورتی که محصول  aدر حال بررسی هست و categoryآن  2است، باید میزان فروش آن را با
میزان فروش در  2 categoryمورد مقایسه قرار دهیم.
WITH 
CategoryTotalSale AS (
	SELECT 
		ca.category_id, 
		sum(oi.list_price * oi.quantity) AS totalCategorySale 
		FROM categories ca
			INNER JOIN products pr ON pr.category_id = ca.category_id
			INNER JOIN order_items oi ON oi.product_id = pr.product_id
			GROUP BY ca.category_id
),
ProductTotalSale AS (
	SELECT
		pr.product_id,
		SUM(oi.quantity * oi.list_price) AS totalProductSale
		FROM products pr
			INNER JOIN order_items oi ON pr.product_id = oi.product_id
		GROUP BY pr.product_id
)

UPDATE products
SET products.list_price = products.list_price * 0.5
FROM products
INNER JOIN ProductTotalSale prt ON prt.product_id = products. product_id
INNER JOIN CategoryTotalSale cat ON cat.category_id = products.category_id
WHERE cat.totalCategorySale * 0.002 > prt.totalProductSale


-- Q2
  -2فروشگاه میخواهد به مشتریان خود جوایزی اهدا کند. جوایز مشتریان بر اساس بیشترین میزان خرید انجام شده توسط یک مشتری در آن
شهر می باشد.
به طور مثال علی مشتری از شهر تهران است. برای تعیین میزان جایزه اون باید بیشترین خرید انجام شده در شهر تهران یافت شود. به عنوان نمونه
محمد سه محصول به مبالغ  5( 10تا شیر  2دلاری) و  3( 15روغن  5دلاری) و  5( 35تا بسته گوشت 7دلاری) داشته که مجموع آن  60دلار خواهد
شد که در شهر تهران
WITH CustomerPurchases AS (
    SELECT 
        c.customer_id, 
        c.city, 
        SUM(oi.quantity * oi.list_price) AS total_purchase
    FROM 
        customers c
    JOIN 
        orders o ON c.customer_id = o.customer_id
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        c.customer_id, c.city
-- max city purchace
), MaxPurchaseInCity AS (
    SELECT 
        city, 
        MAX(total_purchase) AS max_purchase
    FROM 
        CustomerPurchases
    GROUP BY 
        city
), CustomerRewards AS (
    SELECT 
        cp.customer_id, 
        cp.city, 
        cp.total_purchase, 
        CASE 
            WHEN cp.total_purchase < 0.5 * mpc.max_purchase THEN 10
            ELSE 20
        END AS reward
    FROM 
        CustomerPurchases cp
    JOIN 
        MaxPurchaseInCity mpc ON cp.city = mpc.city
)

SELECT 
    cu.first_name, 
    cu.last_name, 
    cr.city, 
    cr.total_purchase, 
    cr.reward
FROM 
    CustomerRewards cr
JOIN 
    customers cu ON cr.customer_id = cu.customer_id
GROUP BY cr.city, cu.first_name, cu.last_name, cr.total_purchase, cr.reward;

-- Q3
-3کوئری بنویسید که نام هر فروشگاه ) (store_nameبه همراه مجموع فروش آنها در ماه ژانویه ) (order_dateرا نمایش دهد .
تعداد فروخته شده از هر محصول توسط فیلد  quantityمشخص شده است و قیمت آن توسط  list_priceمشخص شده است.
SELECT SUM(oi.quantity * oi.list_price)
FROM stores st
INNER JOIN orders ord ON ord.store_id = st.store_id
INNER JOIN order_items oi ON oi.order_id = ord.order_id
WHERE month(ord.order_date) = 01
GROUP BY st.store_id;


-- Q4
-4مشتریان در سال های مختلف از فروشگاه خرید انجام دادند هم چنین یک مشتری ممکن است در یک سال چندین بار خرید انجام دهد.
میخواهیم برای تمام مشتریان  3سالی که بیشترین خرید را انجام دادند نمایش داده شود.
WITH CustomerYearlyPurchases AS (
    SELECT 
        o.customer_id,
        YEAR(o.order_date) AS order_year,
        SUM(oi.quantity * oi.list_price) AS total_purchase
    FROM 
        orders o
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    GROUP BY 
        o.customer_id, YEAR(o.order_date)
), CustomerRankedPurchases AS (
    SELECT 
        customer_id,
        order_year,
        total_purchase,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY total_purchase DESC) AS rn
    FROM 
        CustomerYearlyPurchases
)

SELECT 
    customer_id,
    order_year,
    total_purchase
FROM 
    CustomerRankedPurchases
WHERE 
    rn <= 3;


-- Q5
-5می خواهیم در هر شعبه بر روی محصولات تخفیفاتی اعمال کنیم.
در صورتی که هر محصول جز سه گروه برتر ( )category_idمحصولات باشد قیمتش  %20و در غیر این صورت  %10کاهش دهد. گروهای برتر را
باید در هر شعبه بیابید ( یعنی گروهای برتر در هر شعبه با شعبه دیگر متفاوت هستند).
سه گروه برتر گروه هایی هستند که بیشترین میزان فروش را در شعبه مورد نظر داشته اند.
کوئری بنویسید که  product_id, store_idو قیمت جدید محصولات را در هر شعبه نمایش دهد.
در این سوال نیاز به به روزرسانی قیمت ها وجود ندارد فقط نمایش دهید.
  
WITH CategorySales AS (
    SELECT 
        s.store_id,
        p.category_id,
        SUM(oi.quantity * oi.list_price) AS total_sales
    FROM 
        stores s
    JOIN 
        orders o ON s.store_id = o.store_id
    JOIN 
        order_items oi ON o.order_id = oi.order_id
    JOIN 
        products p ON oi.product_id = p.product_id
    GROUP BY 
        s.store_id, p.category_id
), TopCategories AS (
    SELECT 
        cs1.store_id,
        cs1.category_id
    FROM 
        CategorySales cs1
    WHERE 
        (SELECT COUNT(DISTINCT cs2.category_id) 
         FROM CategorySales cs2
         WHERE cs2.store_id = cs1.store_id AND cs2.total_sales > cs1.total_sales) < 3
)
SELECT 
    p.product_id,
    s.store_id,
    p.list_price * CASE 
                       WHEN p.category_id IN (SELECT category_id FROM TopCategories WHERE store_id = s.store_id) THEN 0.8
                       ELSE 0.9 
                   END AS new_price
FROM 
    products p
JOIN 
    stocks st ON p.product_id = st.product_id
JOIN 
    stores s ON st.store_id = s.store_id;




