<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>storeSearchResult</title>

<!-- 부트 스트랩 -->
<!-- <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet"
    integrity="sha384-GLhlTQ8iRABdZLl6O3oVMWSktQOp6b7In1Zl3/Jr59b6EGGoI1aFkw7cmDA6j6gD"
    crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"
    integrity="sha384-w76AqPfDkMBDXo30jS1Sgez6pr3x5MlQ1ZAGC+nuZB+EYdgRZgiwxhTBTkF7CXvN"
    crossorigin="anonymous"></script> -->

<!-- FontAwesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />

<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

* {
    box-sizing: border-box;
    font-family: 'Nanum Gothic', sans-serif;
}

hr {
    border: 1px solid silver;
    width: 95%;
    margin : 10px;
}

a {
    text-decoration: none;
}

.container_searchResult {
    position: relative;
    width: 100%;
    margin: 0;
    padding-top: 30px;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}

.store_searchResult_layout {
    width: 100%;
    margin-bottom: 50px;
}

.blog_searchResult_layout {
    width: 100%;
}

.main_layout {
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    margin-bottom: 30px;
}

.search_category_layout {
    width: 100%;
}

.search_category_title_layout {
    width: 80%;
    height: 100%;
    float: left;
}

.search_category_title {
    padding-left: 50px;
    text-align: left;
    font-size: 25px;
    font-weight: bolder;
    color: #57b846;
}

.show_filterForm_layout {
    width: 20%;
    height: 100%;
    float: left;
    display: flex;
    justify-content: center;
    align-items: center;
}

#show_filterForm_btn {
    width: 75%;
    height: 50px;
    border: 2px solid silver;
    border-radius: 30px;
    font-size: 18px;
}

.outer_layout {
    width: 100%;
    margin: 20px 0;
    display: flex;
    justify-content: left;
    align-items: center;
}

.inner_cover_layout {
    /* 	width: 33%; */
    height: 250px;
    display: flex;
    justify-content: center;
    align-items: center;
    margin-bottom: 30px;
}

.inner_layout {
    width: 300px;
    height: 100%;
    float: left;
    margin: 0;
}

.inner_layout:hover {
    cursor: pointer;
}

.inner_layout>div {
    width: 100%;
}

.img_layout {
    height: 75%;
    position: relative;
}

.img_layout>img {
	height:100%;
	object-fit:cover;
}


.restaurant_img {
    width: 100%;
    height: 100%;
    border: 1px solid silver;
    border-radius: 20px;
}

.restaurant_addFavorite {
    position: absolute;
    top: 10px;
    right: 12px;
    width: 40px;
    height: 40px;
    border-radius: 1.5rem;
    z-index: 1px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.addFavorite_btn {
    width: 70%;
    height: 70%;
    font-size: 20px;
}

.info_layout {
    height: 25%;
}

.info_layout>div {
    width: 100%;
}

.info_title_layout {
    height: 60%;
}

.info_title {
    width: 60%;
    height: 100%;
    float: left;
    line-height: 35px;
    font-size: 19px;
    color: #fe001a;
    overflow: hidden;
}

.info_score {
    width: 40%;
    height: 100%;
    float: right;
    font-size: 15px;
    text-align: right;
    padding-right: 5px;
    display: flex;
    justify-content: center;
    align-items: center;
}

:root {
    box-sizing: border-box;
}

/* 별점 영역 */
.stars {
    padding: 0;
    margin: 0;
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
}

.stars__link {
    text-decoration: none;
    padding: 2px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.stars__icon {
    color: #b2b2b2;
    display: inline-block;
}

.js-clear {
    color: #b2b2b2;
}

.js-fill {
    color: gold;
}

@media (max-width : 27em) {
    .stars__icon {
        font-size: 2.5em;
    }

    .stars-phrase {
        font-size: 1em;
    }
}

.info_address {
    height: 40%;
    font-size: 15px;
    overflow: hidden;
}

/* 검색 결과가 없을 때*/
.search_none_layout {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 네비게이터 영역 */
.navigator {
    border: 1px solid black;
    height: 60px;
    width: 100%;
    text-align: center;
    margin: 20px auto 0;
    padding: 10px 0;
    background-color: rgba(255, 255, 255, 0.9);
    position: fixed;
    bottom: 0;
    left: 0;
    border-top: 1px solid #fff;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    justify-content: center;
}

.navigator_list {
    list-style-type: none;
    padding-right: 50px;
    margin: 0;
    display: flex;
    justify-content: right;
    align-items: center;
}

.navigator_list_item {
    width: 30px;
    height: 30px;
    float: left;
    margin-left: 5px;
    margin-right: 5px;
}

.navigator_list_item_btn_layout {
    border: 1px solid rgb(178, 178, 178);
    width: 30px;
    height: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.navigator_list_item_btn_layout>a {
    width: 100%;
    height: 100%;
}

.item {
    font-size: 15px;
    text-decoration: none;
    color: black;
}

.naviItem:hover {
    color: #ED1C16;
}

.navigator_direction_btn {
    position: relative;
    width: 100%;
    height: 100%;
    right: 0;
    font-size: 15px;
    background-color: white;
    border: 0;
    display: flex;
    justify-content: center;
    align-items: center;
}

/* 정렬 필터 영역 */

#offcanvasNavbar {
    width: 470px;
    display:flex;
    align-items:center;
}

.offcanvas-header{
    width:100%;
}
.offcanvas-body{
    width:100%;
    overflow:hidden;
}
#searchFilterForm>li{
    width: 100%;
    line-height:0px;
}

.print_searchResult_layout {
    position: relative;
    width: 100%;
    height:100%;
}
.customUl{
    width: 100%;
    height:100%;
}

.filterNav1{
    height:13%;
}
.filterNav2{
    height:25%;
}
.filterNav3{
    height:42%;
}
.filterNav4{
    height:20%;
}

#searchFilterForm{
    width:100%;
    height:100%;
}
#sort_layout {
    position: absolute;
    z-index: 1;
    top: -18px;
    width: 1000px;
    height: 700px;
    background-color: white;
    border: 1px solid silver;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
}

.sort_title {
    margin: 10px auto 20px;
    padding-left: 10px;
    font-size: 18px;
}

.search_filter {
    width: 100%;
    height: 100%;
    display:flex;
    flex-direction: column;
    justify-content: space-evenly;
    align-items: center;
}

.filter_sort {
    width: 100%;
    height: 55%;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
}

.filter_options {
    width: 22%;
    height: 70%;
    border-radius: 30px;
}

.filter_option_btn {
    width: 100%;
    height:100%;
    border-radius: 30px;
    font-size: 14px;
    background-color: white;
    border: 2px solid silver;
}

.cost_average {
    width: 100%;
    height: 100%;
    display : flex;
    flex-direction : column;
    justify-content:center;
}

.filter_cost {
    width: 100%;
    height: 60%;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
    align-items: center;
}

input[type="range"] {
    -webkit-appearance: none;
    width: 90%;
    height: 7px;
    background: rgba(255, 255, 255, 0.6);
    border: 1px solid silver;
    border-radius: 5px;
    background-image: linear-gradient(#ff4500, #ff4500);
    background-size: 70% 100%;
    background-repeat: no-repeat;
}

/* Input Thumb */
input[type="range"]::-webkit-slider-thumb {
    -webkit-appearance: none;
    height: 20px;
    width: 20px;
    border-radius: 50%;
    background: #ff4500;
    box-shadow: 0 0 2px 0 #555;
    transition: background 0.3s ease-in-out;
}

input[type="range"]::-moz-range-thumb {
    -webkit-appearance: none;
    height: 20px;
    width: 20px;
    border-radius: 50%;
    background: #ff4500;
    box-shadow: 0 0 2px 0 #555;
    transition: background 0.3s ease-in-out;
}

input[type="range"]::-ms-thumb {
    -webkit-appearance: none;
    height: 20px;
    width: 20px;
    border-radius: 50%;
    background: #ff4500;
    box-shadow: 0 0 2px 0 #555;
    transition: background 0.3s ease-in-out;
}

input[type="range"]::-webkit-slider-thumb:hover {
    background: #ff0200;
}

input[type="range"]::-moz-range-thumb:hover {
    background: #ff0200;
}

input[type="range"]::-ms-thumb:hover {
    background: #ff0200;
}

/* Input Track */
input[type=range]::-webkit-slider-runnable-track {
    -webkit-appearance: none;
    box-shadow: none;
    border: none;
    background: transparent;
}

input[type=range]::-moz-range-track {
    -webkit-appearance: none;
    box-shadow: none;
    border: none;
    background: transparent;
}

input[type="range"]::-ms-track {
    -webkit-appearance: none;
    box-shadow: none;
    border: none;
    background: transparent;
}

#range_result {
    width: 50%;
    height: 45px;
    margin-top: 20px;
    border: 2px solid silver;
    border-radius: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
}

.food_category {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
}

.food_category_layout {
    margin:0px auto 0px;
    width: 95%;
    height: 87%;
    display: flex;
    flex-direction: column;
    justify-content: space-evenly;
    align-items: center;
}

.food_category_inner_layout {
    width: 100%;
    height: 50%;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    margin-bottom: 5px;
}

.food_category_list {
    width: 20%;
    height: 83%;
    border: 2px solid red;
}

.food_category_list:hover {
    cursor: pointer;
}

.food_icon_layout {
    width: 100%;
    height:78%;
    border: 1px solid silver;
    display: flex;
    justify-content: center;
    align-items: center;
}

.food_icon {
    width: 90%;
    height: 90%;
    filter: invert(30%) sepia(0%) saturate(1%) hue-rotate(187deg) brightness(98%) contrast(89%);
}

.food_name {
    width: 100%;
    height: 22%;
    font-size: 14px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid silver;

}

.btn_layout {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
}

.btn_inner_layout {
    width: 25%;
    height: 60%;
}

.sort_apply_btn {
    width: 100%;
    height: 45px;
    border-radius: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 15px;
    background-color: white;
    border: 2px solid silver;
}

.sort_apply_btn:hover {
    cursor: pointer;
}

.istrue {
    filter: invert(28%) sepia(63%) saturate(6367%) hue-rotate(351deg) brightness(92%) contrast(101%);
}

.isfalse {
    filter: invert(100%) sepia(0%) saturate(2%) hue-rotate(209deg) brightness(110%) contrast(101%);
}

</style>
</head>

<body>
    <div class="container_searchResult">
        <div class="store_searchResult_layout">
            <div class="main_layout">
                <div class="search_category_layout">
                    <div class="search_category_title_layout">
                        <c:choose>
                            <c:when test='${approachBy!=null}'>
                                <p class="search_category_title">#${food_category}</p>
                            </c:when>
                            <c:otherwise>
                                <p class="search_category_title">가게 검색 결과</p>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <div class="show_filterForm_layout">
                        <button id="show_filterForm_btn" class="navbar-toggler" type="button"
                            data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
                            aria-controls="offcanvasNavbar">
                            <i class="fa-solid fa-sliders"></i>&nbsp 필터
                        </button>
                    </div>
                </div>
            </div>

            <hr>

            <c:choose>
                <c:when test="${search_store_list!=null}">
                    <div class="row outer_layout">
                        <c:forEach var="i" items="${search_store_list}" varStatus="status">
                            <div class="col-12 col-md-6 col-xl-4 inner_cover_layout">
                                <div class="inner_layout">
                                    <div class="img_layout">
                                        <!-- 사진 리스트 썸네일 구현(엑박일 시, 기본 이미지 지정(onerror) -->
                                        <c:choose>
                                            <c:when test="${search_store_imgList.get(status.index)!=null}">
                                                <img id="img${status.index}"
                                                    src="/store/${search_store_imgList.get(status.index).sysName}"
                                                    onerror="this.src='/allstore_inquiry/khplate2.jpg'"
                                                    class="restaurant_img">
                                            </c:when>
                                            <c:otherwise>
                                                <img id="img${status.index}"
                                                    src="/allstore_inquiry/khplate2.jpg" class="restaurant_img">
                                            </c:otherwise>
                                        </c:choose>
                                        <div class="restaurant_addFavorite">
                                            <input type="text" name="addFavorite_storeID" value="${i.storeID}"
                                                style="display: none;"> <input type="text"
                                                name="addFavorite_userno" value="${sessionScope.userno}"
                                                style="display: none;">

                                            <!-- 즐겨찾기 여부 체크 -->
                                            <c:set var="favoriteCheck" value="false" />
                                            <c:forEach var="favorite" items="${Favorite_list}"
                                                varStatus="status">
                                                <c:if test="${favorite.getStoreID() == i.storeID}">
                                                    <svg xmlns="http://www.w3.org/2000/svg" width="16"
                                                        height="16" fill="currentColor"
                                                        class="addFavorite_btn istrue" viewBox="0 0 16 16">
                                                        <path fill-rule="evenodd"
                                                            d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z" />
                                                    </svg>
                                                    <c:set var="favoriteCheck" value="true" />
                                                </c:if>
                                            </c:forEach>
                                            <c:if test="${favoriteCheck==false}">
                                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    fill="currentColor" class="addFavorite_btn isfalse"
                                                    viewBox="0 0 16 16">
                                                    <path fill-rule="evenodd"
                                                        d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z" />
                                                </svg>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="info_layout">
                                        <div class="info_title_layout" style="padding-left: 10px">
                                            <div class="info_title">${i.name}</div>
                                            <div class="info_score">
                                                <ul class="stars">
                                                    <c:forEach var="scoreCount" begin="0" end="4" step="1">
                                                        <c:choose>
                                                            <c:when test="${i.avgScore>=(scoreCount+0.5)}">
                                                                <i
                                                                    class="stars__icon fas fa-star js-clear js-fill"></i>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <i class="stars__icon fas fa-star js-clear"></i>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </c:forEach>
                                                </ul>
                                            </div>
                                        </div>
                                        <div class="info_address" style="padding-left: 10px">
                                            ${i.address}</div>
                                    </div>
                                </div>
                            </div>
                            <script>
                                $.ajax({
                                    url: "/getMainPhoto.store",
                                    type: "get",
                                    data: {
                                        storeID: "${i.storeID}"
                                    },
                                    dataType: "json"
                                })
                                    .done(function (resp) {
                                        if (resp.imageID == -1) {
                                            $("#img${status.index}").attr("src", "/common/restaurant_img1.jpg")
                                        } else {
                                            $("#img${status.index}").attr("src", "/store/" + resp.sysName);
                                        }
                                    });
                            </script>
                        </c:forEach>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="search_none_layout">표시할 내용이 없습니다.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- 네비게이터 영역 -->
    <div class="navigator" style="position: relative; width: 100%; border: 0px;">
        <hr>
        <ul class="navigator_list">${search_store_list_navi}
        </ul>
    </div>

    <c:choose>
        <c:when test="${userno!=null}">
            <input type="checkbox" value="true" id="loginCheck" style="display: none;">
        </c:when>
        <c:otherwise>
            <input type="checkbox" value="false" id="loginCheck" style="display: none;">
        </c:otherwise>
    </c:choose>

    <input type="text" class="search_store_filter_toScript" id="fillter_settings_sortMethod"
        value="${sortMethod}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_cost_range"
        value="${cost_range}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_korean"
        value="${food_category_korean}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_western"
        value="${food_category_western}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_chinese"
        value="${food_category_chinese}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_japanese"
        value="${food_category_japanese}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_asian"
        value="${food_category_asian}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_fastfood"
        value="${food_category_fastfood}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_dessert_drink"
        value="${food_category_dessert_drink}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_etc"
        value="${food_category_etc}" style="display: none;">




    <!-- 현제 페이지 네비게이터 링크 미부여 -->
    <c:choose>
        <c:when test="${param.cpage>1}">
            <script>
                $(".naviItem").each(function (index, item) {
                    if ($(item).children().html() == ${ param.cpage }){
                        $(item).prop("href", "#null");
                        $(item).children().css("color", "#ED1C16");
                    }
                })
            </script>
        </c:when>
        <c:otherwise>
            <script>
                $(".naviItem").each(function (index, item) {
                    if ($(item).children().html() == 1) {
                        $(item).prop("href", "#null");
                        $(item).children().css("color", "#ED1C16");
                    }
                })
            </script>
        </c:otherwise>
    </c:choose>

    <!-- 필터 영역 -->

    <div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasNavbar"
        aria-labelledby="offcanvasNavbarLabel">
        <div class="offcanvas-header">
            <h5 class="offcanvas-title" id="offcanvasNavbarLabel">필터</h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
            
        <hr>

        <div class="offcanvas-body">
            <div class="print_searchResult_layout">
                <ul class="navbar-nav justify-content-end flex-grow-1 customUl">
                    <form action="/searchStoreBySearchFilter.store" id="searchFilterForm"
                        onsubmit="return false;">
                        <input type="text" name="searchedBy" value="mainSearch" style="display: none;">
                        
                        <li class="nav-item filterNav1">
                            <div class="search_filter">
                                <p class="sort_title">검색 필터</p>
                                <div class="filter_sort">
                                    <input type="text" id="sortMethod" name="sortMethod" style="display: none;">
                                    <div class="filter_options">
                                        <button class="filter_option_btn" id="order_by_distance">거리순</button>
                                    </div>
                                    <div class="filter_options">
                                        <button class="filter_option_btn" id="order_by_score">평점순</button>
                                    </div>
                                    <div class="filter_options">
                                        <button class="filter_option_btn" id="order_by_review">리뷰순</button>
                                    </div>
                                </div>
                            </div>
                        </li>


                        <hr>


                        <li class="nav-item filterNav2">
                            <div class="cost_average">
                                <p class="sort_title">가격/1인당</p>
                                <div class="filter_cost">
                                    <input type="text" id="cost_set" name="cost_range" style="display: none;">
                                    <input type="range" id="range" class="form-range" min="0" max="4" step="1"
                                        onchange="SetValue()">

                                    <div id="range_result">범위를 지정해주세요</div>
                                </div>
                            </div>
                        </li>

                        <hr>

                        <li class="nav-item filterNav3">
                            <div class="food_category">
                                <p class="sort_title">음식종류</p>
                                <div class="food_category_layout">

                                    <div class="food_category_inner_layout">
                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                                                    class="food_icon">
                                                    <path
                                                        d="M176 56c0-13.3 10.7-24 24-24h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H200c-13.3 0-24-10.7-24-24zm24 48h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H200c-13.3 0-24-10.7-24-24s10.7-24 24-24zM56 176H72c13.3 0 24 10.7 24 24s-10.7 24-24 24H56c-13.3 0-24-10.7-24-24s10.7-24 24-24zM0 283.4C0 268.3 12.3 256 27.4 256H484.6c15.1 0 27.4 12.3 27.4 27.4c0 70.5-44.4 130.7-106.7 154.1L403.5 452c-2 16-15.6 28-31.8 28H140.2c-16.1 0-29.8-12-31.8-28l-1.8-14.4C44.4 414.1 0 353.9 0 283.4zM224 200c0-13.3 10.7-24 24-24h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H248c-13.3 0-24-10.7-24-24zm-96 0c0-13.3 10.7-24 24-24h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H152c-13.3 0-24-10.7-24-24zm-24-96h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H104c-13.3 0-24-10.7-24-24s10.7-24 24-24zm216 96c0-13.3 10.7-24 24-24h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H344c-13.3 0-24-10.7-24-24zm-24-96h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H296c-13.3 0-24-10.7-24-24s10.7-24 24-24zm120 96c0-13.3 10.7-24 24-24h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H440c-13.3 0-24-10.7-24-24zm-24-96h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H392c-13.3 0-24-10.7-24-24s10.7-24 24-24zM296 32h16c13.3 0 24 10.7 24 24s-10.7 24-24 24H296c-13.3 0-24-10.7-24-24s10.7-24 24-24z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">한식</div>
                                            <input type="text" class="food_category_menu"
                                                id="food_category_korean" name="food_category_korean"
                                                style="display: none;">
                                        </div>

                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                                                    class="food_icon">
                                                    <path
                                                        d="M169.7 .9c-22.8-1.6-41.9 14-47.5 34.7L110.4 80c.5 0 1.1 0 1.6 0c176.7 0 320 143.3 320 320c0 .5 0 1.1 0 1.6l44.4-11.8c20.8-5.5 36.3-24.7 34.7-47.5C498.5 159.5 352.5 13.5 169.7 .9zM399.8 410.2c.1-3.4 .2-6.8 .2-10.2c0-159.1-128.9-288-288-288c-3.4 0-6.8 .1-10.2 .2L.5 491.9c-1.5 5.5 .1 11.4 4.1 15.4s9.9 5.6 15.4 4.1L399.8 410.2zM176 208a32 32 0 1 1 0 64 32 32 0 1 1 0-64zm64 128a32 32 0 1 1 64 0 32 32 0 1 1 -64 0zM96 384a32 32 0 1 1 64 0 32 32 0 1 1 -64 0z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">양식</div>
                                            <input type="text" class="food_category_menu"
                                                id="food_category_western" name="food_category_western"
                                                style="display: none;">
                                        </div>

                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 384 512"
                                                    class="food_icon">
                                                    <path
                                                        d="M192 496C86 496 0 394 0 288C0 176 64 16 192 16s192 160 192 272c0 106-86 208-192 208zM154.8 134c6.5-6 7-16.1 1-22.6s-16.1-7-22.6-1c-23.9 21.8-41.1 52.7-52.3 84.2C69.7 226.1 64 259.7 64 288c0 8.8 7.2 16 16 16s16-7.2 16-16c0-24.5 5-54.4 15.1-82.8c10.1-28.5 25-54.1 43.7-71.2z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">중식</div>
                                            <input type="text" class="food_category_menu"
                                                id="food_category_chinese" name="food_category_chinese"
                                                style="display: none;">
                                        </div>

                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 576 512"
                                                    class="food_icon">
                                                    <path
                                                        d="M180.5 141.5C219.7 108.5 272.6 80 336 80s116.3 28.5 155.5 61.5c39.1 33 66.9 72.4 81 99.8c4.7 9.2 4.7 20.1 0 29.3c-14.1 27.4-41.9 66.8-81 99.8C452.3 403.5 399.4 432 336 432s-116.3-28.5-155.5-61.5c-16.2-13.7-30.5-28.5-42.7-43.1L48.1 379.6c-12.5 7.3-28.4 5.3-38.7-4.9S-3 348.7 4.2 336.1L50 256 4.2 175.9c-7.2-12.6-5-28.4 5.3-38.6s26.1-12.2 38.7-4.9l89.7 52.3c12.2-14.6 26.5-29.4 42.7-43.1zM448 256a32 32 0 1 0 -64 0 32 32 0 1 0 64 0z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">일식</div>
                                            <input type="text" class="food_category_menu"
                                                id="food_category_japanese" name="food_category_japanese"
                                                style="display: none;">
                                        </div>
                                    </div>

                                    <div class="food_category_inner_layout">
                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                                                    class="food_icon">
                                                    <path
                                                        d="M428.3 3c11.6-6.4 26.2-2.3 32.6 9.3l4.8 8.7c19.3 34.7 19.8 75.7 3.4 110C495.8 159.6 512 197.9 512 240c0 18.5-3.1 36.3-8.9 52.8c-6.1 17.3-28.5 16.3-36.8-.1l-11.7-23.4c-4.1-8.1-12.4-13.3-21.5-13.3H360c-13.3 0-24-10.7-24-24V152c0-13.3-10.7-24-24-24l-17.1 0c-21.3 0-30-23.9-10.8-32.9C304.7 85.4 327.7 80 352 80c28.3 0 54.8 7.3 77.8 20.2c5.5-18.2 3.7-38.4-6-55.8L419 35.7c-6.4-11.6-2.3-26.2 9.3-32.6zM171.2 345.5L264 160l40 0v80c0 26.5 21.5 48 48 48h76.2l23.9 47.8C372.3 443.9 244.3 512 103.2 512H44.4C19.9 512 0 492.1 0 467.6c0-20.8 14.5-38.8 34.8-43.3l49.8-11.1c37.6-8.4 69.5-33.2 86.7-67.7z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">아시안</div>
                                            <input type="text" class="food_category_menu"
                                                id="food_category_asian" name="food_category_asian"
                                                style="display: none;">
                                        </div>

                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                                                    class="food_icon">
                                                    <path
                                                        d="M61.1 224C45 224 32 211 32 194.9c0-1.9 .2-3.7 .6-5.6C37.9 168.3 78.8 32 256 32s218.1 136.3 223.4 157.3c.5 1.9 .6 3.7 .6 5.6c0 16.1-13 29.1-29.1 29.1H61.1zM144 128a16 16 0 1 0 -32 0 16 16 0 1 0 32 0zm240 16a16 16 0 1 0 0-32 16 16 0 1 0 0 32zM272 96a16 16 0 1 0 -32 0 16 16 0 1 0 32 0zM16 304c0-26.5 21.5-48 48-48H448c26.5 0 48 21.5 48 48s-21.5 48-48 48H64c-26.5 0-48-21.5-48-48zm16 96c0-8.8 7.2-16 16-16H464c8.8 0 16 7.2 16 16v16c0 35.3-28.7 64-64 64H96c-35.3 0-64-28.7-64-64V400z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">패스트푸드</div>
                                            <input type="text" class="food_category_menu"
                                                id="food_category_fastfood" name="food_category_fastfood"
                                                style="display: none;">
                                        </div>

                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512"
                                                    img class="food_icon">
                                                    <path
                                                        d="M88 0C74.7 0 64 10.7 64 24c0 38.9 23.4 59.4 39.1 73.1l1.1 1C120.5 112.3 128 119.9 128 136c0 13.3 10.7 24 24 24s24-10.7 24-24c0-38.9-23.4-59.4-39.1-73.1l-1.1-1C119.5 47.7 112 40.1 112 24c0-13.3-10.7-24-24-24zM32 192c-17.7 0-32 14.3-32 32V416c0 53 43 96 96 96H288c53 0 96-43 96-96h16c61.9 0 112-50.1 112-112s-50.1-112-112-112H352 32zm352 64h16c26.5 0 48 21.5 48 48s-21.5 48-48 48H384V256zM224 24c0-13.3-10.7-24-24-24s-24 10.7-24 24c0 38.9 23.4 59.4 39.1 73.1l1.1 1C232.5 112.3 240 119.9 240 136c0 13.3 10.7 24 24 24s24-10.7 24-24c0-38.9-23.4-59.4-39.1-73.1l-1.1-1C231.5 47.7 224 40.1 224 24z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">디저트/음료</div>
                                            <input type="text" class="food_category_menu"
                                                id="food_category_dessert_drink"
                                                name="food_category_dessert_drink" style="display: none;">
                                        </div>

                                        <div class="food_category_list">
                                            <div class="food_icon_layout">
                                                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 448 512"
                                                    class="food_icon">
                                                    <path
                                                        d="M416 0C400 0 288 32 288 176V288c0 35.3 28.7 64 64 64h32V480c0 17.7 14.3 32 32 32s32-14.3 32-32V352 240 32c0-17.7-14.3-32-32-32zM64 16C64 7.8 57.9 1 49.7 .1S34.2 4.6 32.4 12.5L2.1 148.8C.7 155.1 0 161.5 0 167.9c0 45.9 35.1 83.6 80 87.7V480c0 17.7 14.3 32 32 32s32-14.3 32-32V255.6c44.9-4.1 80-41.8 80-87.7c0-6.4-.7-12.8-2.1-19.1L191.6 12.5c-1.8-8-9.3-13.3-17.4-12.4S160 7.8 160 16V150.2c0 5.4-4.4 9.8-9.8 9.8c-5.1 0-9.3-3.9-9.8-9L127.9 14.6C127.2 6.3 120.3 0 112 0s-15.2 6.3-15.9 14.6L83.7 151c-.5 5.1-4.7 9-9.8 9c-5.4 0-9.8-4.4-9.8-9.8V16zm48.3 152l-.3 0-.3 0 .3-.7 .3 .7z" />
                                                </svg>
                                            </div>
                                            <div class="food_name">기타</div>
                                            <input type="text" class="food_category_menu" id="food_category_etc"
                                                name="food_category_etc" style="display: none;">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </li>

                        <hr>

                        <li class="nav-item filterNav4">
                            <div class="btn_layout">
                                <div class="btn_inner_layout">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        fill="currentColor" class="sort_apply_btn" id="cancel_btn"
                                        viewBox="0 0 16 16">
                                        <path fill-rule="evenodd"
                                            d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z" />
                                        <path
                                            d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z" />
                                    </svg>
                                </div>
                                <div class="btn_inner_layout">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                        fill="currentColor" class="sort_apply_btn" id="apply_btn"
                                        viewBox="0 0 16 16">
                                        <path
                                            d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z" />
                                    </svg>
                                </div>
                            </div>
                        </li>
                    </form>
                </ul>
            </div>
        </div>
    </div>

    <!-- 필터 영역 -->

    <c:choose>
        <c:when test="${userno!=null}">
            <input type="checkbox" value="true" id="loginCheck" style="display: none;">
        </c:when>
        <c:otherwise>
            <input type="checkbox" value="false" id="loginCheck" style="display: none;">
        </c:otherwise>
    </c:choose>

    <input type="text" class="search_store_filter_toScript" id="fillter_settings_sortMethod"
        value="${sortMethod}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_cost_range"
        value="${cost_range}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_korean"
        value="${food_category_korean}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_western"
        value="${food_category_western}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_chinese"
        value="${food_category_chinese}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_japanese"
        value="${food_category_japanese}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_asian"
        value="${food_category_asian}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_fastfood"
        value="${food_category_fastfood}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_dessert_drink"
        value="${food_category_dessert_drink}" style="display: none;">
    <input type="text" class="search_store_filter_toScript" id="fillter_settings_food_category_etc"
        value="${food_category_etc}" style="display: none;">

    <!-- 별점 등록 Script -->
<script>
    let stars = document.querySelectorAll('.stars__link');
    let phrase = document.querySelector('.stars-phrase');

    var getNextSiblings = function (elem) {
        var siblings = [];
        var sibling = elem;
        for (; sibling; sibling = sibling.nextElementSibling)
            siblings.push(sibling);
        return siblings;
    }

    var getPrevSiblings = function (elem) {
        var siblings = [];
        var sibling = elem;
        for (; sibling; sibling = sibling.previousElementSibling)
            siblings.push(sibling);
        return siblings;
    }

    stars.forEach((el, idx) => {
        el.addEventListener('click', (e) => {
            let nextSibs = getNextSiblings(el);
            nextSibs.forEach((sib) => {
                sib
                    .children[0]
                    .classList
                    .add('js-clear');
                sib
                    .children[0]
                    .classList
                    .remove('js-fill');

            });
            let prevSibs = getPrevSiblings(el);
            prevSibs.forEach((sib) => {
                sib
                    .children[0]
                    .classList
                    .add('js-fill');
            });
        });
    });
</script>

<script>
    // 필터 Toggle 기능 부여
    let sort_check = false;

    $("#show_filterForm_btn").on("click", function () {
        if (sort_check == false) {
            $('#sort_layout').css({ "display": "" });
            sort_check = true;
        } else {
            $("#sort_layout").css({ "display": "none" });
            sort_check = false;
        }
    });

    // 필터 정렬 지정
    $(".filter_option_btn").on("click", function () {
        $("#sortMethod").val($(this).attr("id"));
        $(".filter_option_btn").css({ "border": "2px solid silver" });
        $(this).css({ "border": "2px solid red" });
    })

    // 각 음식 카테고리 div에 boolean변수 부여(closer)
    $(".food_category_list").each(function (index, item) {
        let food_category_list_check = true;
        $(this)
            .find(".food_category_menu")
            .val(true);
        $(item).on("click", function () {
            if (food_category_list_check == false) {
                $(this).css({ "border": "2px solid red" })
                $(this)
                    .find(".food_category_menu")
                    .val(true);
                food_category_list_check = true;
            } else {
                $(this).css({ "border": "1px solid silver" })
                $(this)
                    .find(".food_category_menu")
                    .val(false);
                food_category_list_check = false;
            }
        })
    })

    // 필터 초기화 지정
    let sortMethod = $("#fillter_settings_sortMethod").val();
    let cost_range = $("#fillter_settings_cost_range").val();
    let food_category_korean = $("#fillter_settings_food_category_korean").val();
    let food_category_western = $("#fillter_settings_food_category_western").val();
    let food_category_chinese = $("#fillter_settings_food_category_chinese").val();
    let food_category_japanese = $("#fillter_settings_food_category_japanese").val();
    let food_category_asian = $("#fillter_settings_food_category_asian").val();
    let food_category_fastfood = $("#fillter_settings_food_category_fastfood").val();
    let food_category_dessert_drink = $(
        "#fillter_settings_food_category_dessert_drink"
    ).val();
    let food_category_etc = $("#fillter_settings_food_category_etc").val();

    if (sortMethod == 'order_by_distance') {
        $("#order_by_distance").click();
    } else if (sortMethod == 'order_by_score') {
        $("#order_by_score").click();
    } else if (sortMethod == 'order_by_review') {
        $("#order_by_review").click();
    }

    let range_result = $("#range_result");

    if (cost_range == '5000이하') {
        $("#range").val(0);
        $("#cost_set").val("5000이하");
        range_result.html("5000원 이하");

    } else if (cost_range == '5000~10000') {
        $("#range").val(1);
        $("#cost_set").val("5000~10000");
        range_result.html("5000원 ~ 10000원");

    } else if (cost_range == '10000~15000') {
        $("#range").val(2);
        $("#cost_set").val("10000~15000");
        range_result.html("10000원 ~ 15000원");

    } else if (cost_range == '15000~20000') {
        $("#range").val(3);
        $("#cost_set").val("15000~20000");
        range_result.html("15000원 ~ 20000원");

    } else if (cost_range == '20000이상') {
        $("#range").val(4);
        $("#cost_set").val("20000이상");
        range_result.html("20000원 이상");
    }

    let target = document.getElementById('range');
    const min = target.min
    const max = target.max
    const val = target.value
    target.style.backgroundSize = (val - min) * 100 / (max - min) + '% 100%'


    if (food_category_korean != 'true') {
        $("#food_category_korean").click();
    }
    if (food_category_western != 'true') {
        $("#food_category_western").click();
    }
    if (food_category_chinese != 'true') {
        $("#food_category_chinese").click();
    }
    if (food_category_japanese != 'true') {
        $("#food_category_japanese").click();
    }
    if (food_category_asian != 'true') {
        $("#food_category_asian").click();
    }
    if (food_category_fastfood != 'true') {
        $("#food_category_fastfood").click();
    }
    if (food_category_dessert_drink != 'true') {
        $("#food_category_dessert_drink").click();
    }
    if (food_category_etc != 'true') {
        $("#food_category_etc").click();
    }

    // 즐겨찾기 등록,삭제 버튼
    $(".addFavorite_btn").each(function (index, item) {
        let loginCheck = $("#loginCheck").val();

        let addFavoriteStoreCheck;

        if ($(item).attr("class") == "addFavorite_btn istrue") {
            addFavoriteStoreCheck = true;
        } else {
            addFavoriteStoreCheck = false;
        }

        $(this).on("click", function () {
            event.stopPropagation();
            if (loginCheck == "false") {
                alert("로그인을 먼저 진행해주세요.");
            } else {
                let addFavorite_btn = $(this);

                if (addFavoriteStoreCheck == false) {
                    $.ajax({
                        url: "/addFavoriteStore.store",
                        type: "post",
                        data: {
                            addFavorite_storeID: addFavorite_btn.prev().prev().val()
                        }
                    }).done(function (resp) {
                        if (resp == "true") {
                            addFavoriteStoreCheck = true;
                            addFavorite_btn.removeClass("isfalse");
                            addFavorite_btn.addClass("istrue");
                        }
                    })
                } else {
                    $.ajax({
                        url: "/deleteFavoriteStore.store",
                        type: "post",
                        data: {
                            addFavorite_storeID: addFavorite_btn.prev().prev().val()
                        }
                    })
                    .done(function (resp) {
                        if (resp == "true") {
                            addFavoriteStoreCheck = false;
                            addFavorite_btn.removeClass("istrue");
                            addFavorite_btn.addClass("isfalse");
                        }
                    })
                }
            }
        })
    })


    // 범위 바의 값을 변경하였을 때 적용
    function SetValue() {
        if ($("#range").prop("name") == false) {
            $("#range").prop("name", "range");
        }

        let range = $("#range").val();
        let range_result = $("#range_result");

        if (range == 0) {
            $("#cost_set").val("5000이하");
            range_result.html("5000원 이하");
        } else if (range == 1) {
            $("#cost_set").val("5000~10000");
            range_result.html("5000원 ~ 10000원");
        } else if (range == 2) {
            $("#cost_set").val("10000~15000");
            range_result.html("10000원 ~ 15000원");
        } else if (range == 3) {
            $("#cost_set").val("15000~20000");
            range_result.html("15000원 ~ 20000원");
        } else {
            $("#cost_set").val("20000이상");
            range_result.html("20000원 이상");
        }
    }

    // 범위 바 변경 시에 적용 내용 2
    const rangeInputs = document.querySelectorAll('input[type="range"]')

    function handleInputChange(e) {
        let target = e.target
        if (e.target.type !== 'range') {
            target = document.getElementById('range')
        }
        const min = target.min
        const max = target.max
        const val = target.value

        target.style.backgroundSize = (val - min) * 100 / (max - min) + '% 100%'
    }

    rangeInputs.forEach(input => {
        input.addEventListener('input', handleInputChange)
    })


    // 맛집 리스트를 클릭했을 때, 가게 상세 페이지로 이동
    $(".inner_layout").on("click", function () {
        let storeID = $(this)
            .find("[name=addFavorite_storeID]")
            .val();
        location.href = "/view.store?storeID=" + storeID;
    })

    // 검색 정렬 확인 버튼
    $("#apply_btn").on("click", function () {
        $("#searchFilterForm").prop("onsubmit", true);
        $("#searchFilterForm").submit();
    });

    // 검색 정렬 취소 버튼
    $("#cancel_btn").on("click", function () {
        $("#sortMethod").val("");
        $("#cost_set").val("");

        $(".food_category_menu").each(function (index, item) {
            $(item).val("true");
        });

        $("#searchFilterForm").prop("onsubmit", true);
        $("#searchFilterForm").submit();
    })
    
    
	</script>
</body>

</html>