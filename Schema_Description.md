---

## 1. region 테이블 (지역 정보)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **region_id** | INT | **PRIMARY KEY**, NOT NULL | 지역 고유 ID (PK) |
| **region_name** | VARCHAR | 255, NOT NULL | 지역 이름 |
| **created_at** | TIMESTAMP | NOT NULL | 레코드 생성 시간 |

---

## 2. user 테이블 (사용자 정보)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **user_id** | INT | **PRIMARY KEY**, NOT NULL | 사용자 고유 ID (PK) |
| **username** | VARCHAR | 100, NOT NULL | 사용자 이름 (로그인 ID 또는 닉네임) |
| **phone** | VARCHAR | 20 | 전화번호 |
| **region_id** | INT | **FOREIGN KEY (region)**, NOT NULL | 사용자가 속한 지역 ID (FK) |
| **created_at** | TIMESTAMP | NOT NULL | 계정 생성 시간 |

---

## 3. mission 테이블 (미션 정보)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **mission_id** | INT | **PRIMARY KEY**, NOT NULL | 미션 고유 ID (PK) |
| **mission_name** | VARCHAR | 100, NOT NULL | 미션 제목 |
| **mission_description**| TEXT | - | 미션 상세 설명 |
| **created_at** | TIMESTAMP | NOT NULL | 미션 생성 시간 |

---

## 4. store 테이블 (상점 정보)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **store_id** | INT | **PRIMARY KEY**, NOT NULL | 상점 고유 ID (PK) |
| **store_name** | VARCHAR | 100, NOT NULL | 상점 이름 |
| **address** | VARCHAR | 255, NOT NULL | 상점 주소 |
| **region_id** | INT | **FOREIGN KEY (region)**, NOT NULL | 상점이 위치한 지역 ID (FK) |
| **created_at** | TIMESTAMP | NOT NULL | 레코드 생성 시간 |

---

## 5. terms 테이블 (약관/정책 정보)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **terms_id** | INT | **PRIMARY KEY**, NOT NULL | 약관 고유 ID (PK) |
| **title** | VARCHAR | 100, NOT NULL | 약관 제목 |
| **content** | TEXT | NOT NULL | 약관 내용 |
| **is_required** | TINYINT(1) | NOT NULL | 필수 동의 약관 여부 (0:선택, 1:필수) |
| **created_at** | TIMESTAMP | NOT NULL | 약관 생성 시간 |

---

## 6. user_mission 테이블 (사용자 미션 진행 상황)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **user_mission_id** | INT | **PRIMARY KEY**, NOT NULL | 사용자 미션 고유 ID (PK) |
| **user_id** | INT | **FOREIGN KEY (user)**, NOT NULL | 사용자 ID (FK) |
| **mission_id** | INT | **FOREIGN KEY (mission)**, NOT NULL | 미션 ID (FK) |
| **status** | VARCHAR | 50, NOT NULL | 미션 진행 상태 (예: PENDING, COMPLETED) |
| **created_at** | TIMESTAMP | NOT NULL | 레코드 생성 시간 |
| **updated_at** | TIMESTAMP | NOT NULL | 최종 상태 업데이트 시간 |

---

## 7. user_terms 테이블 (사용자 약관 동의)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **user_terms_id** | INT | **PRIMARY KEY**, NOT NULL | 사용자 약관 동의 고유 ID (PK) |
| **user_id** | INT | **FOREIGN KEY (user)**, NOT NULL | 사용자 ID (FK) |
| **terms_id** | INT | **FOREIGN KEY (terms)**, NOT NULL | 동의한 약관 ID (FK) |
| **agreed_at** | TIMESTAMP | NOT NULL | 동의한 시간 |

---

## 8. review 테이블 (상점 리뷰)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **review_id** | INT | **PRIMARY KEY**, NOT NULL | 리뷰 고유 ID (PK) |
| **user_id** | INT | **FOREIGN KEY (user)**, NOT NULL | 리뷰 작성자 ID (FK) |
| **store_id** | INT | **FOREIGN KEY (store)**, NOT NULL | 리뷰 대상 상점 ID (FK) |
| **rating** | INT | NOT NULL | 평점 (예: 1~5점) |
| **content** | TEXT | - | 리뷰 내용 |
| **created_at** | TIMESTAMP | NOT NULL | 리뷰 작성 시간 |

---

## 9. review_photo 테이블 (리뷰 사진)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **photo_id** | INT | **PRIMARY KEY**, NOT NULL | 사진 고유 ID (PK) |
| **review_id** | INT | **FOREIGN KEY (review)**, NOT NULL | 사진이 속한 리뷰 ID (FK) |
| **photo_url** | VARCHAR | 255, NOT NULL | 사진 저장 경로 (URL) |
| **created_at** | TIMESTAMP | NOT NULL | 사진 업로드 시간 |

---

## 10. review_comment 테이블 (리뷰 댓글)

| 속성명 (Column) | 데이터 타입 (Type) | 제약조건 (Constraint) | 설명 |
| :--- | :--- | :--- | :--- |
| **comment_id** | INT | **PRIMARY KEY**, NOT NULL | 댓글 고유 ID (PK) |
| **review_id** | INT | **FOREIGN KEY (review)**, NOT NULL | 댓글이 속한 리뷰 ID (FK) |
| **user_id** | INT | **FOREIGN KEY (user)**, NOT NULL | 댓글 작성자 ID (FK) |
| **content** | TEXT | NOT NULL | 댓글 내용 |
| **created_at** | TIMESTAMP | NOT NULL | 댓글 작성 시간 |

---
