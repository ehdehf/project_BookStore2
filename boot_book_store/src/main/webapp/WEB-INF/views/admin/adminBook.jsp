<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<div class="page-header">
    <h2>도서 관리</h2>
    <button class="btn-blue" onclick="loadPage('/admin/book/add')">+ 도서 등록</button>
</div>

<div class="card">
    <table class="nice-table">
        <thead>
            <tr>
                <th style="width:60px;">ID</th>
                <th>제목</th>
                <th>저자</th>
                <th style="width:100px;">가격</th>
                <th style="width:80px;">장르</th>
                <th style="width:120px;">관리</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach var="b" items="${books}">
                <tr>
                    <td>${b.book_id}</td>
                    <td>${b.book_title}</td>
                    <td>${b.book_writer}</td>
                    <td>${b.book_price}</td>
                    <td>${b.genre_id}</td>
                    <td class="actions">
                        <button class="btn-dark" onclick="loadPage('/admin/book/edit?id=${b.book_id}')">수정</button>
                        <button class="btn-red" onclick="deleteBook(${b.book_id})">삭제</button>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>
<c:set var="totalPage" value="${(totalCount / pageSize) + (totalCount % pageSize > 0 ? 1 : 0)}" />

<div class="pagination">
  <c:forEach begin="1" end="${totalPage}" var="p">
    <button class="${p == currentPage ? 'active' : ''}"
            onclick="loadPage('/admin/book/list?page=${p}')">
        ${p}
    </button>
  </c:forEach>
</div>

<script>
function deleteBook(id) {
    if (!confirm("정말 삭제하시겠습니까?")) return;

    fetch('/admin/book/delete?id=' + id, { method: 'POST' })
        .then(res => res.text())
        .then(txt => {
            if (txt.trim() === 'OK') {
                alert('삭제되었습니다.');
                loadPage('/admin/book/list');
            } else {
                alert('삭제 실패: ' + txt);
            }
        });
}
</script>
