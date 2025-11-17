<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>주문 상세보기</title>

<style>
    body {
        font-family: 'Noto Sans KR', sans-serif;
        background: #f6f7f9;
        margin: 0;
        padding: 0;
    }

    .page-title {
        font-size: 26px;
        font-weight: 700;
        margin: 30px 0 10px 40px;
        color: #333;
    }

    .wrapper {
        width: 90%;
        margin: 0 auto;
    }

    /* 상단 요약 카드 영역 */
    .summary-grid {
        display: flex;
        gap: 20px;
        margin-top: 20px;
    }

    .summary-card {
        flex: 1;
        background: white;
        padding: 22px 28px;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.07);
    }

    .summary-title {
        font-size: 14px;
        color: #777;
    }

    .summary-value {
        font-size: 24px;
        font-weight: 600;
        color: #333;
        margin-top: 4px;
    }

    /* 세부 박스 */
    .section-box {
        background: #fff;
        margin-top: 25px;
        padding: 25px 35px;
        border-radius: 12px;
        box-shadow: 0 5px 15px rgba(0,0,0,0.08);
    }

    .section-title {
        font-size: 18px;
        font-weight: 600;
        margin-bottom: 18px;
        color: #333;
    }

    .info-row {
        display: flex;
        margin-bottom: 12px;
    }

    .info-label {
        width: 150px;
        font-weight: 600;
        color: #555;
    }

    .info-value {
        flex: 1;
        color: #222;
    }

    /* 도서 목록 */
    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 10px;
    }

    table th {
        background: #fafafa;
        padding: 12px;
        font-size: 14px;
        color: #555;
        border-bottom: 1px solid #e3e3e3;
    }

    table td {
        padding: 12px;
        border-bottom: 1px solid #ececec;
        font-size: 14px;
        color: #333;
    }

    .book-img {
        width: 65px;
        height: 85px;
        border-radius: 6px;
        object-fit: cover;
        border: 1px solid #ddd;
    }

    /* 버튼 */
    .btn-back {
        margin-top: 25px;
        padding: 10px 20px;
        background: #4a6fa5;
        border: none;
        color: white;
        font-size: 14px;
        border-radius: 6px;
        cursor: pointer;
    }

    .btn-back:hover {
        background: #3d5e8e;
    }
	/* 이미지 열: 가운데 */
	table td:nth-child(1),
	table th:nth-child(1) {
	    text-align: center;
	}

	/* 도서명: 왼쪽 */
	table td:nth-child(2),
	table th:nth-child(2) {
	    text-align: left;
	}

	/* 저자: 가운데 */
	table td:nth-child(3),
	table th:nth-child(3) {
	    text-align: center;
	}

	/* 수량: 가운데 */
	table td:nth-child(4),
	table th:nth-child(4) {
	    text-align: center;
	}

	/* 판매가: 오른쪽 출력이 자연스럽다 */
	table td:nth-child(5),
	table th:nth-child(5) {
	    text-align: right;
	}

	/* 배송비: 오른쪽 */
	table td:nth-child(6),
	table th:nth-child(6) {
	    text-align: right;
	}
</style>
</head>

<body>

<div class="page-title">주문 상세보기</div>

<div class="wrapper">

    <!-- 주문 상단 요약 -->
    <div class="summary-grid">
        <div class="summary-card">
            <div class="summary-title">주문번호</div>
            <div class="summary-value">${order.order_id}</div>
        </div>

        <div class="summary-card">
            <div class="summary-title">총 수량</div>
            <div class="summary-value">${order.total_quantity}</div>
        </div>

        <div class="summary-card">
            <div class="summary-title">총 금액</div>
            <div class="summary-value"><fmt:formatNumber value="${order.total_price}" /></div>
        </div>

        <div class="summary-card">
            <div class="summary-title">주문일</div>
            <div class="summary-value">${order.order_date}</div>
        </div>
    </div>


    <!-- 주문자 정보 -->
    <div class="section-box">
        <div class="section-title">주문자 정보</div>

        <div class="info-row">
            <div class="info-label">회원 ID</div>
            <div class="info-value">${order.user_id}</div>
        </div>

        <div class="info-row">
            <div class="info-label">회원명</div>
            <div class="info-value">${order.user_name}</div>
        </div>

        <div class="info-row">
            <div class="info-label">이메일</div>
            <div class="info-value">${order.user_email}</div>
        </div>

        <div class="info-row">
            <div class="info-label">전화번호</div>
            <div class="info-value">${order.user_phone_num}</div>
        </div>

        <div class="info-row">
            <div class="info-label">주소</div>
            <div class="info-value">${order.user_address}</div>
        </div>

        <div class="info-row">
            <div class="info-label">상세 주소</div>
            <div class="info-value">${order.user_detail_address}</div>
        </div>
		<div class="info-row">
		    <div class="info-label">배송비</div>
		    <div class="info-value">
		        <c:choose>
		            <c:when test="${order.shipping_fee == 0}">
		                무료배송
		            </c:when>
		            <c:otherwise>
		                <fmt:formatNumber value="${order.shipping_fee}" /> 원
		            </c:otherwise>
		        </c:choose>
		    </div>
		</div>
    </div>


    <!-- 도서 목록 -->
    <div class="section-box">
        <div class="section-title">주문 도서 목록</div>

        <table>
            <thead>
                <tr>
                    <th>이미지</th>
                    <th>도서명</th>
                    <th>저자</th>
                    <th>수량</th>
                    <th>판매가</th>
                </tr>
            </thead>

            <tbody>
            <c:forEach var="item" items="${order.items}">
                <tr>
                    <td><img src="${item.book_image_path}" class="book-img"></td>
                    <td>${item.book_title}</td>
                    <td>${item.book_writer}</td>
                    <td>${item.quantity}</td>
                    <td><fmt:formatNumber value="${item.purchase_price}" /></td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
    </div>


    <!-- 뒤로가기 -->
    <button class="btn-back" onclick="loadPage('/admin/order/list')">← 주문 목록으로</button>

</div>

</body>
</html>
