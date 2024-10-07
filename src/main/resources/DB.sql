CREATE TABLE customer
(
    id        VARCHAR(20) PRIMARY KEY,
    name      VARCHAR(200) NOT NULL,
    email     VARCHAR(200) NOT NULL,
    address   VARCHAR(500) NOT NULL,
    phone     VARCHAR(20)  NOT NULL,
    password  VARCHAR(200) NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE item_category
(
    category_id VARCHAR(20) PRIMARY KEY,
    description VARCHAR(300) NOT NULL,
    is_active   BOOLEAN
);

CREATE TABLE item_sub_category
(
    sub_category_id VARCHAR(20) PRIMARY KEY,
    category_id     VARCHAR(20)  NOT NULL,
    description     VARCHAR(300) NOT NULL,
    is_active       BOOLEAN,
    CONSTRAINT fk_cat FOREIGN KEY (category_id) REFERENCES item_category (category_id)
);

CREATE TABLE portion_size
(
    portion_id  VARCHAR(20) PRIMARY KEY,
    description VARCHAR(300) NOT NULL,
    is_active   BOOLEAN
);

CREATE TABLE supplier
(
    id        VARCHAR(20) PRIMARY KEY,
    name      VARCHAR(200) NOT NULL,
    phone     VARCHAR(20)  NOT NULL,
    address   VARCHAR(500) NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE employee
(
    id        VARCHAR(20) PRIMARY KEY,
    name      VARCHAR(200) NOT NULL,
    phone     VARCHAR(20)  NOT NULL,
    address   VARCHAR(500) NOT NULL,
    job_title VARCHAR(100) NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE user_role
(
    id        VARCHAR(20) PRIMARY KEY,
    name      VARCHAR(50) NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE "user"
(
    username    VARCHAR(100) PRIMARY KEY,
    employee_id VARCHAR(20)  NOT NULL,
    role_id     VARCHAR(20)  NOT NULL REFERENCES user_role (id),
    email       VARCHAR(100) NOT NULL,
    password    VARCHAR(200) NOT NULL,
    is_active   BOOLEAN,
    CONSTRAINT fk_emp FOREIGN KEY (employee_id) REFERENCES employee (id)
);

CREATE TABLE customer_order
(
    id          VARCHAR(20) PRIMARY KEY,
    customer_id VARCHAR(20) REFERENCES customer (id),
    employee_id VARCHAR(20) REFERENCES employee (id),
    date        DATE          NOT NULL,
    discount    DECIMAL(5, 2) NOT NULL,
    is_active   BOOLEAN
);

CREATE TABLE customer_payment
(
    id        VARCHAR(20) PRIMARY KEY,
    order_id  VARCHAR(20) REFERENCES customer_order (id),
    amount    DECIMAL(9, 2) NOT NULL,
    date      DATE          NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE section
(
    id        VARCHAR(20) PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE kot
(
    id          VARCHAR(20) PRIMARY KEY,
    order_id    VARCHAR(20) REFERENCES customer_order (id),
    description VARCHAR(500) NOT NULL,
    section_id  VARCHAR(20) REFERENCES section (id),
    is_active   BOOLEAN
);

CREATE TABLE offer
(
    id          VARCHAR(20) PRIMARY KEY,
    description VARCHAR(200) NOT NULL,
    discount    DECIMAL(9, 2),
    is_active   BOOLEAN
);

CREATE TABLE customer_offer
(
    customer_id VARCHAR(20) NOT NULL REFERENCES customer (id),
    offer_id    VARCHAR(20) NOT NULL REFERENCES offer (id),
    CONSTRAINT pk_co PRIMARY KEY (customer_id, offer_id)
);

CREATE TABLE unit_group
(
    id        VARCHAR(20) PRIMARY KEY,
    name      VARCHAR(100) NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE material
(
    id            VARCHAR(20) PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    unit_group_id VARCHAR(20)  NOT NULL REFERENCES unit_group (id),
    is_active     BOOLEAN
);



CREATE TABLE unit
(
    id            VARCHAR(20) PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    unit_group_id VARCHAR(20)  NOT NULL REFERENCES unit_group (id),
    is_active     BOOLEAN
);

CREATE TABLE stock
(
    material_id VARCHAR(20) PRIMARY KEY,
    qty         DECIMAL(9, 2) NOT NULL,
    unit_id     VARCHAR(10)   NOT NULL REFERENCES unit (id),
    username    VARCHAR(100) REFERENCES "user" (username),
    CONSTRAINT fk_mat FOREIGN KEY (material_id) REFERENCES material (id)
);

CREATE TABLE delivery
(
    order_id       VARCHAR(20) PRIMARY KEY REFERENCES customer_order (id),
    name           VARCHAR(200) NOT NULL,
    phone          VARCHAR(20)  NOT NULL,
    address        VARCHAR(500) NOT NULL,
    payment_option VARCHAR(50)  NOT NULL,
    is_active      BOOLEAN
);

CREATE TABLE dine_in
(
    order_id  VARCHAR(20) PRIMARY KEY REFERENCES customer_order (id),
    table_no  INT NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE take_away
(
    order_id  VARCHAR(20) PRIMARY KEY REFERENCES customer_order (id),
    name      VARCHAR(200) NOT NULL,
    phone     VARCHAR(20)  NOT NULL,
    is_active BOOLEAN
);

CREATE TABLE menu_item
(
    id              VARCHAR(20) PRIMARY KEY,
    name            VARCHAR(100)  NOT NULL,
    food_type       VARCHAR(50)   NOT NULL,
    sub_category_id VARCHAR(20) REFERENCES item_sub_category (sub_category_id),
    portion_id      VARCHAR(20) REFERENCES portion_size (portion_id),
    price           DECIMAL(9, 2) NOT NULL,
    is_active       BOOLEAN
);

CREATE TABLE customer_order_detail
(
    item_id   VARCHAR(20) REFERENCES menu_item (id),
    order_id  VARCHAR(20) REFERENCES customer_order (id),
    qty       INT           NOT NULL,
    price     DECIMAL(9, 2) NOT NULL,
    is_active BOOLEAN,
    CONSTRAINT pk_cod PRIMARY KEY (item_id, order_id)
);

CREATE TABLE item_material
(
    item_id     VARCHAR(20) REFERENCES menu_item (id),
    material_id VARCHAR(20) REFERENCES material (id),
    qty         DECIMAL(9, 2),
    CONSTRAINT pk_imat PRIMARY KEY (item_id, material_id)
);

CREATE TABLE supplier_order
(
    id          VARCHAR(20) PRIMARY KEY,
    supplier_id VARCHAR(20) REFERENCES supplier (id),
    username    VARCHAR(100) REFERENCES "user" (username),
    date        DATE NOT NULL,
    is_active   BOOLEAN
);

CREATE TABLE supplier_order_detail
(
    order_id    VARCHAR(20) REFERENCES supplier_order (id),
    material_id VARCHAR(20) REFERENCES material (id),
    unit_price  DECIMAL(9, 2) NOT NULL,
    qty         DECIMAL(9, 2) NOT NULL,
    CONSTRAINT pk_sod PRIMARY KEY (order_id, material_id)
);

CREATE TABLE grn
(
    id                VARCHAR(20) PRIMARY KEY,
    supplier_order_id VARCHAR(20) REFERENCES supplier_order (id),
    date              DATE,
    is_active         BOOLEAN
);

CREATE TABLE grn_detail
(
    grn_id      VARCHAR(20) REFERENCES grn (id),
    material_id VARCHAR(20) REFERENCES material (id),
    unit_price  DECIMAL(9, 2) NOT NULL,
    qty         DECIMAL(9, 2) NOT NULL,
    CONSTRAINT pk_grnd PRIMARY KEY (grn_id, material_id)
);

CREATE TABLE attendance
(
    id          VARCHAR(20) PRIMARY KEY,
    employee_id VARCHAR(20) NOT NULL REFERENCES employee (id),
    in_time     TIMESTAMP   NOT NULL,
    out_time    TIMESTAMP   NOT NULL,
    is_active   BOOLEAN
);
