<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!doctype html>
<html lang="ko">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>문의 상세 - 관리자</title>
  <link rel="stylesheet" href="/css/adminMain.css">
  <style>
    .detail-container {
      display: grid;
      grid-template-columns: 1fr 1fr;
      gap: 24px;
    }

    .inquiry-section,
    .reply-section {
      background: white;
      padding: 24px;
      border-radius: 8px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
    }

    .section-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 20px;
      padding-bottom: 16px;
      border-bottom: 2px solid #E5E7EB;
    }

    .section-header h2 {
      font-size: 18px;
      color: #111827;
      margin: 0;
    }

    .status-badge {
      display: inline-block;
      padding: 6px 14px;
      border-radius: 12px;
      font-size: 13px;
      font-weight: 600;
    }

    .status-waiting {
      background-color: #FEF3C7;
      color: #92400E;
    }

    .status-completed {
      background-color: #D1FAE5;
      color: #065F46;
    }

    .inquiry-meta {
      display: flex;
      flex-direction: column;
      gap: 8px;
      margin-bottom: 20px;
      color: #6B7280;
      font-size: 14px;
    }

    .inquiry-title {
      font-size: 20px;
      font-weight: 600;
      color: #111827;
      margin-bottom: 16px;
    }

    .inquiry-content {
      color: #374151;
      line-height: 1.8;
      white-space: pre-wrap;
      word-wrap: break-word;
      padding: 16px;
      background-color: #F9FAFB;
      border-radius: 6px;
    }

    .reply-form {
      margin-top: 20px;
    }

    .form-group {
      margin-bottom: 16px;
    }

    .form-group label {
      display: block;
      margin-bottom: 8px;
      font-weight: 600;
      color: #374151;
      font-size: 14px;
    }

    .form-group textarea {
      width: 100%;
      padding: 12px;
      border: 1px solid #D1D5DB;
      border-radius: 6px;
      font-size: 14px;
      font-family: inherit;
      min-height: 150px;
      resize: vertical;
      box-sizing: border-box;
    }

    .form-group textarea:focus {
      outline: none;
      border-color: #4F46E5;
      box-shadow: 0 0 0 3px rgba(79, 70, 229, 0.1);
    }

    .form-actions {
      display: flex;
      gap: 12px;
      justify-content: flex-end;
    }

    .btn {
      padding: 10px 20px;
      border: none;
      border-radius: 6px;
      font-weight: 600;
      cursor: pointer;
      font-size: 14px;
    }

    .btn-primary {
      background-color: #4F46E5;
      color: white;
    }

    .btn-primary:hover {
      background-color: #4338CA;
    }

    .btn-back {
      background-color: #E5E7EB;
      color: #374151;
      padding: 10px 20px;
      border: none;
      border-radius: 6px;
      text-decoration: none;
      font-weight: 600;
      font-size: 14px;
      cursor: pointer;
    }

    .btn-back:hover {
      background-color: #D1D5DB;
    }

    .existing-reply {
      background-color: #F0FDF4;
      border: 1px solid #BBF7D0;
      padding: 16px;
      border-radius: 6px;
      margin-bottom: 20px;
    }

    .existing-reply-content {
      color: #065F46;
      line-height: 1.8;
      white-space: pre-wrap;
      word-wrap: break-word;
      margin-bottom: 12px;
    }

    .existing-reply-meta {
      color: #047857;
      font-size: 13px;
    }

    .msg-alert {
      padding: 12px 16px;
      margin-bottom: 20px;
      border-radius: 6px;
      background-color: #D1FAE5;
      color: #065F46;
      border: 1px solid #A7F3D0;
    }
  </style>
</head>
<body>
  <div class="app">
    <aside class="sidebar" aria-label="사이드바">
      <div class="brand">
        <img src="/img/book_logo.png" class="brand-logo" alt="로고">
        tqShop 관리자
      </div>
      <nav class="nav">
        <div class="nav-section">
          <div class="nav-section-title">문의내역</div>
          <ul class="nav-list">
            <li class="nav-item">
              <button onclick="location.href='<c:url value='/inquiry/admin/list'/>'">문의 리스트</button>
            </li>
          </ul>
        </div>
      </nav>
    </aside>

    <main class="main" role="main">
      <header class="topbar">
        <div class="left">
          <div class="search">문의 관리</div>
        </div>
        <div class="right">
          <div style="font-size:13px;">관리자명</div>
        </div>
      </header>

      <section class="content">
        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 24px;">
          <h1 style="font-size:18px;margin:0;">문의 상세</h1>
          <button onclick="loadPage('/inquiry/admin/list')" class="btn-back">목록으로</button>
        </div>

        <c:if test="${not empty msg}">
          <div class="msg-alert">${msg}</div>
        </c:if>

        <div class="detail-container">
          <div class="inquiry-section">
            <div class="section-header">
              <h2>고객 문의</h2>
              <span class="status-badge ${inquiry.status == '답변완료' ? 'status-completed' : 'status-waiting'}">
                ${inquiry.status}
              </span>
            </div>
            
            <div class="inquiry-meta">
              <span><strong>작성자:</strong> ${inquiry.user_name} (${inquiry.user_id})</span>
              <span><strong>작성일:</strong> <fmt:formatDate value="${inquiry.created_date}" pattern="yyyy-MM-dd HH:mm" /></span>
            </div>

            <div class="inquiry-title">${inquiry.title}</div>
            <div class="inquiry-content">${inquiry.content}</div>
          </div>

          <div class="reply-section">
            <div class="section-header">
              <h2>답변 작성</h2>
            </div>

            <c:if test="${not empty inquiry.reply and not empty inquiry.reply.reply_content}">
              <div class="existing-reply" id="existingReplyBox">
                <div class="existing-reply-content" id="existingReplyContent">${inquiry.reply.reply_content}</div>
                <div class="existing-reply-meta">
                  답변일: <fmt:formatDate value="${inquiry.reply.created_date}" pattern="yyyy-MM-dd HH:mm" />
                </div>
              </div>
            </c:if>

            <form id="replyForm" class="reply-form">
              <input type="hidden" name="inquiry_id" value="${inquiry.inquiry_id}">
              
              <div class="form-group">
                <label for="reply_content">답변 내용 *</label>
                <textarea id="reply_content" name="reply_content" required 
                          placeholder="고객 문의에 대한 답변을 작성해주세요."><c:if test="${not empty inquiry.reply and not empty inquiry.reply.reply_content}">${inquiry.reply.reply_content}</c:if></textarea>
              </div>

              <div class="form-actions">
                <button type="submit" class="btn btn-primary" id="submitBtn">
                  <c:choose>
                    <c:when test="${not empty inquiry.reply and not empty inquiry.reply.reply_content}">답변 수정</c:when>
                    <c:otherwise>답변 등록</c:otherwise>
                  </c:choose>
                </button>
              </div>
            </form>
          </div>
        </div>
      </section>
    </main>
  </div>

  <script>
    // 답변 폼 제출 처리 (AJAX) - 즉시 실행
    (function() {
      function initReplyForm() {
        const form = document.getElementById('replyForm');
        if (!form) {
          console.error('replyForm을 찾을 수 없습니다.');
          return;
        }
        
        // 이미 이벤트 리스너가 등록되어 있으면 제거
        if (form._replyFormHandler) {
          form.removeEventListener('submit', form._replyFormHandler);
        }
        
        // 새 이벤트 핸들러 생성
        form._replyFormHandler = function(e) {
          e.preventDefault();
          e.stopPropagation();
          e.stopImmediatePropagation();
          
          console.log('폼 제출 이벤트 발생');
          
          const formData = new FormData(this);
          const inquiryId = formData.get('inquiry_id');
          const replyContent = formData.get('reply_content');
          
          if (!replyContent || replyContent.trim() === '') {
            alert('답변 내용을 입력해주세요.');
            return false;
          }
          
          console.log('답변 제출:', {
            inquiry_id: inquiryId,
            reply_content: replyContent
          });
          
          fetch('/inquiry/admin/reply', {
            method: 'POST',
            body: formData
          })
          .then(res => {
            console.log('응답 상태:', res.status);
            if (!res.ok) {
              throw new Error('HTTP error! status: ' + res.status);
            }
            return res.text();
          })
          .then(result => {
            console.log('서버 응답: ', result);
            if (result.trim() === 'SUCCESS') {
              alert('답변이 등록되었습니다.');
              // 캐시 방지를 위해 타임스탬프 추가하여 문의 리스트 다시 로드
              if (typeof loadPage === 'function') {
                loadPage('/inquiry/admin/list?t=' + new Date().getTime());
              } else {
                window.location.href = '/inquiry/admin/list';
              }
            } else {
              alert('답변 등록에 실패했습니다. 응답: ' + result);
            }
          })
          .catch(err => {
            console.error('에러:', err);
            alert('오류가 발생했습니다: ' + err.message);
          });
          
          return false;
        };
        
        form.addEventListener('submit', form._replyFormHandler);
        console.log('폼 이벤트 리스너 등록됨');
      }
      
      // 즉시 실행
      initReplyForm();
      
      // 약간의 지연 후에도 실행 (동적 로드 대응)
      setTimeout(initReplyForm, 100);
      setTimeout(initReplyForm, 500);
    })();
  </script>
</body>
</html>
