create table my_shop.mission
(
    mission_id          int auto_increment
        primary key,
    mission_name        varchar(100)                        not null,
    mission_description text                                null,
    reward_point        int       default 0                 null,
    created_at          timestamp default CURRENT_TIMESTAMP null
);

create table my_shop.region
(
    region_id   int auto_increment
        primary key,
    region_name varchar(50)                         not null,
    created_at  timestamp default CURRENT_TIMESTAMP null
);

create table my_shop.store
(
    store_id   int auto_increment
        primary key,
    store_name varchar(100)                        not null,
    address    varchar(200)                        null,
    region_id  int                                 null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint store_ibfk_1
        foreign key (region_id) references my_shop.region (region_id)
);

create index region_id
    on my_shop.store (region_id);

create table my_shop.terms
(
    terms_id    int auto_increment
        primary key,
    title       varchar(100)                         not null,
    content     text                                 null,
    is_required tinyint(1) default 1                 null,
    created_at  timestamp  default CURRENT_TIMESTAMP null
);

create table my_shop.user
(
    user_id    int auto_increment
        primary key,
    user_name  varchar(50)                         not null,
    email      varchar(100)                        null,
    phone      varchar(20)                         null,
    region_id  int                                 null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint email
        unique (email),
    constraint user_ibfk_1
        foreign key (region_id) references my_shop.region (region_id)
);

create table my_shop.review
(
    review_id  int auto_increment
        primary key,
    user_id    int                                 null,
    store_id   int                                 null,
    rating     int                                 null,
    content    text                                null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint review_ibfk_1
        foreign key (user_id) references my_shop.user (user_id),
    constraint review_ibfk_2
        foreign key (store_id) references my_shop.store (store_id),
    check ((`rating` >= 1) and (`rating` <= 5))
);

create index store_id
    on my_shop.review (store_id);

create index user_id
    on my_shop.review (user_id);

create table my_shop.review_comment
(
    comment_id int auto_increment
        primary key,
    review_id  int                                 null,
    user_id    int                                 null,
    content    text                                null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint review_comment_ibfk_1
        foreign key (review_id) references my_shop.review (review_id),
    constraint review_comment_ibfk_2
        foreign key (user_id) references my_shop.user (user_id)
);

create index review_id
    on my_shop.review_comment (review_id);

create index user_id
    on my_shop.review_comment (user_id);

create table my_shop.review_photo
(
    photo_id   int auto_increment
        primary key,
    review_id  int                                 null,
    photo_url  varchar(500)                        null,
    created_at timestamp default CURRENT_TIMESTAMP null,
    constraint review_photo_ibfk_1
        foreign key (review_id) references my_shop.review (review_id)
);

create index review_id
    on my_shop.review_photo (review_id);

create index region_id
    on my_shop.user (region_id);

create table my_shop.user_mission
(
    user_mission_id int auto_increment
        primary key,
    user_id         int                                   null,
    mission_id      int                                   null,
    status          varchar(20) default 'PENDING'         null,
    created_at      timestamp   default CURRENT_TIMESTAMP null,
    constraint user_mission_ibfk_1
        foreign key (user_id) references my_shop.user (user_id),
    constraint user_mission_ibfk_2
        foreign key (mission_id) references my_shop.mission (mission_id)
);

create index mission_id
    on my_shop.user_mission (mission_id);

create index user_id
    on my_shop.user_mission (user_id);

create table my_shop.user_terms
(
    user_terms_id int auto_increment
        primary key,
    user_id       int                  null,
    terms_id      int                  null,
    agreed        tinyint(1) default 0 null,
    agreed_at     timestamp            null,
    constraint user_terms_ibfk_1
        foreign key (user_id) references my_shop.user (user_id),
    constraint user_terms_ibfk_2
        foreign key (terms_id) references my_shop.terms (terms_id)
);

create index terms_id
    on my_shop.user_terms (terms_id);

create index user_id
    on my_shop.user_terms (user_id);

