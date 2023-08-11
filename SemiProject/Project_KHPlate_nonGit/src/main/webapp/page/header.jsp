<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
   <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
      <!DOCTYPE html>
      <html>

      <head>
         <meta charset="UTF-8">
         <title>Header</title>
         <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>

         <!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
            rel="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
            integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD" crossorigin="anonymous">
         <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
            integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
            crossorigin="anonymous"></script> -->
         <style>
            @import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

            .nanum-gothic {
               font-family: 'Nanum Gothic', sans-serif;
            }


            * {
               box-sizing: border-box;
            }

            .header {
               max-width: 100%;
               width: 100%;
               background-color: #ED1C16;
               box-shadow: 1px 1px 5px 1px silver;
               padding-top: 10px;
               padding-bottom: 10px;

            }

            .logo {
               text-align: center;
               padding-top: 5px;
               cursor: pointer;
            }

            .logoimage {
               height: 90%;
               width: 25%;
            }

            .searchLine {
               height: 45px;
               width: 100%;
               border-radius: 15px 15px 15px 15px;
               border: 1px solid #ffffff;
               background-color: #ffffff;
               top: 5px;
               z-index: 1;
               margin-top: 12px;
               margin-left: 0%;
               display: flex;
               justify-content: center;
               align-items: center;
            }

            #searchBox {
               width: 100%;
               height: 100%;
               font-size: 15px;
               z-index: 1;
               margin-left: 10px;
               padding-left: 10px;
               border: 1px solid #ffffff;
            }

            #searchBtn {
               width: 60%;
               height: 60%;
               filter: invert(31%) sepia(100%) saturate(6890%) hue-rotate(355deg) brightness(95%) contrast(95%);
               background-color: transparent;
               border: 1px solid transparent;
               cursor: pointer;
            }

            .form {
               width: 100%;
               padding-left: 10px;
            }

            #mypageBtn {
               display: inline-block;
               width: 50px;
               height: 50px;
               font-family: 'Nanum Gothic', sans-serif;
               cursor: pointer;
            }

            .btnBox {
               width: 100%;
               line-height: 76px;
               text-align: center;
            }


            .btnBox>a {
               text-decoration: none;
               font-size: 13px;
               margin-right: 10px;
			   color:white;
               font-weight: 600;
            }

            .btnBox>a:hover {
               opacity: 80%;
            }

            /*       #searchForm{ */
            /*          width:inherit; */
            /*          height:inherit; */
            /*          display:flex; */
            /*          justify-content:center; */
            /*          align-items:center; */
            /*       } */
         </style>
      </head>

      <body>
         <div class="row header m-0" style="margin-bottom:70px;">
            <div class="col-12 col-lg-3 themed-grid-col logo">
               <!--다른 페이지에서도 정상 표시되기 위한 이미지 절대 경로로 지정 -->
               <img src="/page/logowhite.png" class="logoimage">
            </div>
            <div class="col-12 col-lg-6 d-flex search">
               <form id=searchForm action="/searchStoreBySearchBox.store" method="get" class="form d-flex"
                  onsubmit="return false;">
                  <div class="searchLine">
                     <input type="text" name="searchedBy" value="mainSearch" style="display:none;">
                     <div class="search_layout2" style="width:95%; height: 100%;">
                        <input type="search" id="searchBox" name="search">
                     </div>
                     <div class="search_layout3" style="width:5%; height: 100%; display: flex; justify-content: center; align-items: center;">
                        <svg xmlns="http://www.w3.org/2000/svg" id="searchBtn"
                           fill="#ED1C16" class="bi bi-search" viewBox="0 0 16 16">
                           <path
                              d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                        </svg>
                     </div>
                  </div>
               </form>
            </div>
            <div class="col-12 col-lg-3 themed-grid-col d-flex rightMenu">
               <div class="btnBox">
                  <c:choose>
                     <c:when test="${userno==null}">
                        <a href="/login/login.jsp" class="nanum-gothic">로그인 </a>
                        <a href="#null" class="nanum-gothic">｜</a>
                        <a href="/joinform/joinform.jsp" class="nanum-gothic">회원가입</a>
                     </c:when>
                     <c:otherwise>
                        <a href="/logout.members" class="nanum-gothic">로그아웃 </a>
                        <a href="#null" class="nanum-gothic">｜</a>
                        <a href="/mypage.members" class="nanum-gothic">마이페이지</a>
                        <c:if test="${sessionScope.loginIsAdmin}">
                        	<a href="#null" class="nanum-gothic">｜</a>
                        	<a href="/adminPage/adminhomeWithMain.jsp" class="nanum-gothic">관리자 페이지</a>
                        </c:if>
                     </c:otherwise>
                  </c:choose>
               </div>
            </div>
         </div>
         <script>
            // 로고 클릭 시 메인페이지 이동
            $(".logo").on("click", function () {
               location.href = "/page/main.jsp";
            })
            
                        // 실제 검색 함수
            // 맛집 검색과 블로그 검색 구분
            function search(){
            	if ($("#searchCheck option:selected").val() == 1) {
                    $("#searchForm").prop("action", "/searchStoreBySearchBox.store");
                 } else if ($("#searchCheck option:selected").val() == 2) {
                    $("#searchForm").prop("action", "/select.fullreview");
                 }
                 $("#searchForm").prop("onsubmit", true);
                 $("#searchForm").submit();
            }
            
            $("#searchBtn").on("click", function () {
            	search()
            })   
      
		    $("#searchBox").keydown(function (key) {
		        if (key.keyCode == 13) {
		        	search();
		        }
		    });
         </script>
      </body>
      </html>