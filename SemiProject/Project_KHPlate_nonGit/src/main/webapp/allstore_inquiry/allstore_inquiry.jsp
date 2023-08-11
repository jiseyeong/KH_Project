<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>전체 가게 조회</title>

<!-- JQuery -->
<script src="https://code.jquery.com/jquery-3.6.4.min.js"
    integrity="sha256-oP6HI9z1XaZNBrJURtCoUT5SUnxFr8s3BzRl+cbzUq8=" crossorigin="anonymous"></script>

<!-- Font-Awesome-->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
    crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- 지도 Script -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2504febed8c67836e8db1a31bda054e9"></script>
<style>
@import url('https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap');

* {
    box-sizing: border-box;
    border-collapse: collapse;
    font-family: 'Nanum Gothic', sans-serif;
}

a {
    text-decoration: none;
    color: black;
}

body {
    width: 100%;
    height: 100%;
    margin: 0px;
}

button:hover {
    cursor: pointer;
}

.container_layout {
    position: relative;
    width: 1920px;
    height: 929px;
    overflow: hidden;
}

#searchForm {
    float: left;
    width: 27%;
    height: 100%;
}

/* 맛집 리스트 영역 */
.store_list {
    float: left;
    width: 100%;
    height: 100%;
    position: inherit;
    border: 1px solid silver;
}

.img_layout>img {
	height:100%;
	object-fit:cover;
}


.search_layout {
    width: 100%;
    height: 10%;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
    display: flex;
    justify-content: space-evenly;
}

.toBack_layout {
    width: 12%;
    height: 50%;
    float: left;
    display: flex;
    justify-content: center;
    align-items: center;
}

#toBack_btn {
    width: 85%;
    height: 85%;
    filter: invert(28%) sepia(63%) saturate(6367%) hue-rotate(351deg) brightness(92%) contrast(101%);
}

.show_filterForm_layout {
    width: 17%;
    height: 50%;
    float: left;
    display: flex;
    justify-content: center;
    align-items: center;
}

#show_filterForm_btn {
    width: 100%;
    height: 100%;
    background-color: white;
    border: 2px solid silver;
    border-radius: 20px;
    font-size: 15px;
}

.searchBox {
    width: 65%;
    height: 50%;
    line-height: 50px;
    position: relative;
    border-radius: 20px;
    border: 2px solid silver;
    display: flex;
    justify-content: space-evenly;
    align-items: center;
}

.searchBar {
    line-height: 140px;
}

#search {
    width: 80%;
    height: 80%;
    border-radius: 15px;
    border: none;
    padding-left: 10px;
}

#searchBtn {
    width: 12%;
    height: 70%;
    position: relative;
    font-size: 10px;
    padding: 0px;
    filter: invert(28%) sepia(63%) saturate(6367%) hue-rotate(351deg) brightness(92%) contrast(101%);
    display: flex;
    justify-content: center;
    align-items: center;
}

.restaurant_list_layout {
    width: 100%;
    height: 90%;
}

.restaurant_list {
    width: 98%;
    height: 93%;
    list-style: none;
    padding: 0px;
    margin: 0px;
    margin-left: 10px;
}

.restaurant {
    width: 100%;
    height: 140px;
    margin-bottom: 10px;
    border: 1px solid silver;
    border-radius: 70px;
}

.restaurant:hover {
    cursor:pointer;
}

.restaurant_none {
    margin: auto;
    width: 100%;
    height: 100%;
}

.none {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.img_layout {
    float: left;
    width: 30%;
    height: 102%;
    border: 1px solid silver;
    margin-top: -1px;
}

img {
    width: 100%;
    height: 100%;
}

.info_layout {
    float: left;
    height: 100%;
    width: 70%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: left;
    overflow: hidden;
}

.info_layout_topside {
    width: 100%;
    height: 65%;
}

.info_layout_bottomside {
    width: 82%;
    height: 35%;
}

.info_layout_left {
    height: 100%;
    width: 58%;
    float: left;
    padding-top: 10px;
}

.info_layout_right {
    height: 100%;
    width: 42%;
    float: left;
    text-align: right;
    padding-top: 20px;
    padding-right: 16px;
}

.restaurant_info {
    margin: 15px;
}

.restaurant_name {
    font-size: 20px;
    color: red;
}

.restaurant_address {
    font-size: 16px;
    /* 주소 길어질 경우 생략 기호로 간략 표시 (...)*/
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
}

.restaurant_score {
    font-size: 16px;
}

.restaurant_category {
    margin-right: 26px;
    font-size: 14px;
}

/* 별점 */
.stars {
    padding: 0px;
    margin: 0px;
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
    cursor: pointer;
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

.navigator {
    height: 7%;
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    padding-bottom: 10px;
    font-size: 20px;
    padding: 0px;
}

.navigator_list {
    list-style-type: none;
    padding-left: 0px;
    margin: 0px;
}

.navigator_list_item {
    width: 30px;
    height: 30px;
    float: left;
    margin-left: 5px;
    margin-right: 5px;
}

.navigator_list_item_btn_layout {
    width: 30px;
    height: 30px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.navigator_list_item_btn_layout * {
    width: 100%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
}

.navigator_direction_btn {
    background-color: white;
    border: 1px solid silver;
    border-radius: 10px;
}

.navigator_direction_btn>i {
    font-size: 16px;
}

.item {
    text-decoration: none;
}

/* 지도 영역 */
.map_layout {
    width: 73%;
    height: 100%;
    float: right;
    position: relative;
}

#map {
    float: right;
    position: inherit;
    width: 100%;
    height: 100%;
}

/* 필터 영역 */
hr {
    width: 90%;
    border: 1px solid silver;
}

#sort_layout {
    position: absolute;
    z-index: 1;
    width: 400px;
    height: 650px;
    background-color: white;
    border: 1px solid silver;
    opacity: 90%;
}

.sort_title {
    margin: 10px auto 10px;
    padding-left: 10px;
    font-size: 16px;
}

.search_filter {
    width: 100%;
    height: 15%;
}

.filter_sort {
    width: 100%;
    height: 60%;
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
    height: 100%;
    border-radius: 30px;
    font-size: 13px;
    background-color: white;
    border: 2px solid silver;
}

.cost_average {
    width: 100%;
    height: 18%;
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
    transition: background .3s ease-in-out;
}

input[type="range"]::-moz-range-thumb {
    -webkit-appearance: none;
    height: 20px;
    width: 20px;
    border-radius: 50%;
    background: #ff4500;
    box-shadow: 0 0 2px 0 #555;
    transition: background .3s ease-in-out;
}

input[type="range"]::-ms-thumb {
    -webkit-appearance: none;
    height: 20px;
    width: 20px;
    border-radius: 50%;
    background: #ff4500;
    box-shadow: 0 0 2px 0 #555;
    transition: background .3s ease-in-out;
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

input[type="range"]:hover{
	cursor:pointer;
}

#range_result {
    width: 50%;
    height: 35%;
    margin-top: 20px;
    border: 2px solid silver;
    border-radius: 25px;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
    flex: 2;
}



.food_category {
    width: 100%;
    height: 317px;
}

.food_category_title {
    margin-bottom: 10px;
}

.food_category_layout {
    margin: auto;
    width: 90%;
    height: 90%;
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

}

.food_category_list {
    width: 20%;
    height: 77%;
    border: 2px solid red;
}

.food_category_list:hover {
    cursor: pointer;
}

.food_icon_layout {
    width: 100%;
    height: 105px;
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
    height: 25%;
    font-size: 12px;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid silver;
}


.btn_layout {
    width: 100%;
    height: 45px;
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
    height: 100%;
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

/* 맵에 표시될 InfoWindow */
.restaurant_infoWindow {
    width: auto;
    height: 50px;
    background-color: white;
    border: 1px solid silver;
    border-radius: 70px;
    display: flex;
    justify-content: center;
    align-items: center;
}

.infoWindow_img_layout {
    float: left;
    width: 50px;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    border: 1px solid silver;
    border-radius: 70px;
}

.kh_icon {
    width: 100%;
    height: 100%;
    border-radius: 70px;
}

.store_icons {
    width: 70%;
    height: 80%;
}

.infoWindow_info_layout {
    float: left;
    width: auto;
    height: 100%;
    margin-left: 4px;
    margin-right: 10px;
}

.infoWindow_info_top {
    width: 100%;
    height: 60%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 14px;
    white-space: nowrap;
    /* 텍스트가 한 줄로 유지되도록 설정 */
    overflow: hidden;
    white-space: nowrap;
}

.infoWindow_info_bottom {
    width: 100%;
    height: 40%;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 12px;
    height: 40%;
}

.search_store_list_toScript {
    display: none;
}
</style>
</head>

<body>
    <input type="text" name="searchedBy" value="mapSearch" style="display: none;">
    <div class="container_layout">
        <form id="searchForm" action="/searchStoreBySearchBox.store" onsubmit="return false;">
            <div class="store_list">
                <div class="search_layout">
                    <div class="toBack_layout">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor"
                            id="toBack_btn" viewBox="0 0 16 16">
                            <path
                                d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L8 2.207l6.646 6.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5Z" />
                            <path
                                d="m8 3.293 6 6V13.5a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 13.5V9.293l6-6Z" />
                        </svg>
                    </div>

                    <div class="searchBox">
                        <input type="text" id="search" name="search">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                            id="searchBtn" viewBox="0 0 16 16">
                            <path
                                d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001c.03.04.062.078.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1.007 1.007 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0z" />
                        </svg>
                    </div>

                    <div class="show_filterForm_layout">
                        <button id="show_filterForm_btn">
                            <i class="fa-solid fa-sliders"></i>&nbsp 필터
                        </button>
                    </div>
                </div>
                <div class="restaurant_list_layout">
                    <ul class="restaurant_list">
                        <c:choose>
                            <c:when test="${search_store_list==null || search_store_list.size()==0}">
                                <li class="restaurant_none">
                                    <div class="none">
                                        표시할 내용이 없습니다.<br>검색을 진행해주세요.
                                    </div>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var='i' items='${search_store_list}' varStatus='status'>
                                    <li class="restaurant restaurant_number${status.index}"><input type="hidden"
                                            class="restaurant_storeID" value="${i.storeID}">
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
                                                        src="/allstore_inquiry/khplate2.jpg"
                                                        class="restaurant_img">
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                        <div class="info_layout">
                                            <div class=info_layout_topside>
                                                <div class="info_layout_left">
                                                    <p class="restaurant_info restaurant_name">${i.name}
                                                    </p>
                                                </div>
                                                <div class="info_layout_right">
                                                    <div class="restaurant_info restaurant_score">
                                                        <ul class="stars">
                                                            <c:forEach var="scoreCount" begin="0" end="4"
                                                                step="1">
                                                                <c:choose>
                                                                    <c:when
                                                                        test="${i.avgScore>=(scoreCount+0.5)}">
                                                                        <i
                                                                            class="stars__icon fas fa-star js-clear js-fill"></i>
                                                                    </c:when>
                                                                    <c:otherwise>
                                                                        <i
                                                                            class="stars__icon fas fa-star js-clear"></i>
                                                                    </c:otherwise>
                                                                </c:choose>
                                                            </c:forEach>
                                                        </ul>
                                                    </div>
                                                    <p class="restaurant_info restaurant_category">
                                                        #${i.category}</p>
                                                </div>
                                            </div>
                                            <div class=info_layout_bottomside>
                                                <p class="restaurant_info restaurant_address">
                                                    ${i.address}</p>
                                            </div>
                                        </div>
                                    </li>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </ul>

                    <!-- Navigator 리스트를 표시 (getNavi(currentpage,search)) -->
                    <c:if test="${search_store_list_navi!=null}">
                        <div class="navigator">
                            <ul class="navigator_list">${search_store_list_navi}</ul>
                        </div>
                    </c:if>

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
                </div>
            </div>
        </form>

        <!--  맵 영역 -->
        <div class="map_layout">
            <div id="map">

        </div>

        <!-- 정렬 팝업 창 (SlideToggle)-->
        <form id="searchFilterForm" action="/searchStoreBySearchFilter.store" onsubmit="return false;">
            <input type="text" name="searchedBy" value="mapSearch" style="display: none;">
            <div id="sort_layout" style="display: none;">
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

                <hr>

                <div class="cost_average">
                    <p class="sort_title">가격/1인당</p>
                    <div class="filter_cost">
                        <input type="text" id="cost_set" name="cost_range" style="display: none;"> <input
                            type="range" id="range" class="form-range" min="0" max="4" step="1"
                            onchange=SetValue()>

                        <div id="range_result">범위를 지정해주세요</div>
                    </div>
                </div>

                <hr>

                <div class="food_category">
                    <p class="sort_title food_category_title">음식종류</p>
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
                                <input type="text" class="food_category_menu" id="food_category_korean"
                                    name="food_category_korean" style="display: none;">
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
                                <input type="text" class="food_category_menu" id="food_category_western"
                                    name="food_category_western" style="display: none;">
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
                                <input type="text" class="food_category_menu" id="food_category_chinese"
                                    name="food_category_chinese" style="display: none;">
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
                                <input type="text" class="food_category_menu" id="food_category_japanese"
                                    name="food_category_japanese" style="display: none;">
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
                                <input type="text" class="food_category_menu" id="food_category_asian"
                                    name="food_category_asian" style="display: none;">
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
                                <input type="text" class="food_category_menu" id="food_category_fastfood"
                                    name="food_category_fastfood" style="display: none;">
                            </div>

                            <div class="food_category_list">
                                <div class="food_icon_layout">
                                    <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 512 512" img
                                        class="food_icon">
                                        <path
                                            d="M88 0C74.7 0 64 10.7 64 24c0 38.9 23.4 59.4 39.1 73.1l1.1 1C120.5 112.3 128 119.9 128 136c0 13.3 10.7 24 24 24s24-10.7 24-24c0-38.9-23.4-59.4-39.1-73.1l-1.1-1C119.5 47.7 112 40.1 112 24c0-13.3-10.7-24-24-24zM32 192c-17.7 0-32 14.3-32 32V416c0 53 43 96 96 96H288c53 0 96-43 96-96h16c61.9 0 112-50.1 112-112s-50.1-112-112-112H352 32zm352 64h16c26.5 0 48 21.5 48 48s-21.5 48-48 48H384V256zM224 24c0-13.3-10.7-24-24-24s-24 10.7-24 24c0 38.9 23.4 59.4 39.1 73.1l1.1 1C232.5 112.3 240 119.9 240 136c0 13.3 10.7 24 24 24s24-10.7 24-24c0-38.9-23.4-59.4-39.1-73.1l-1.1-1C231.5 47.7 224 40.1 224 24z" />
                                    </svg>
                                </div>
                                <div class="food_name">디저트/음료</div>
                                <input type="text" class="food_category_menu"
                                    id="food_category_dessert_drink" name="food_category_dessert_drink"
                                    style="display: none;">
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

                <hr>

                <div class="btn_layout">
                    <div class="btn_inner_layout">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                            class="sort_apply_btn" id="cancel_btn" viewBox="0 0 16 16">
                            <path fill-rule="evenodd"
                                d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2v1z" />
                            <path
                                d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466z" />
                        </svg>
                    </div>
                    <div class="btn_inner_layout">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor"
                            class="sort_apply_btn" id="apply_btn" viewBox="0 0 16 16">
                            <path
                                d="M10.97 4.97a.75.75 0 0 1 1.07 1.05l-3.99 4.99a.75.75 0 0 1-1.08.02L4.324 8.384a.75.75 0 1 1 1.06-1.06l2.094 2.093 3.473-4.425a.267.267 0 0 1 .02-.022z" />
                        </svg>
                    </div>
                </div>
            </div>
        </form>
    </div>

    <c:if test="${search_store_infoWindowList!=null || search_store_infoWindowList.size()>0}">
        <c:forEach var="dto" items="${search_store_infoWindowList}" varStatus="status">
            <input type="hidden" class="search_store_list_toScript"
                id="search_store_list_storeID${status.index}" value='${dto.storeID}'>
            <input type="hidden" class="search_store_list_toScript"
                id="search_store_list_distance${status.index}" value='${dto.distance}'>
            <input type="hidden" class="search_store_list_toScript" id="search_store_list_name${status.index}"
                value='${dto.name}'>
            <input type="hidden" class="search_store_list_toScript" id="search_store_list_lat${status.index}"
                value='${dto.lat}'>
            <input type="hidden" class="search_store_list_toScript" id="search_store_list_lng${status.index}"
                value='${dto.lng}'>
            <input type="hidden" class="search_store_list_toScript"
                id="search_store_list_address${status.index}" value='${dto.address}'>
            <input type="hidden" class="search_store_list_toScript"
                id="search_store_list_avgScore${status.index}" value='${dto.avgScore}'>
            <input type="hidden" class="search_store_list_toScript"
                id="search_store_list_introduction${status.index}" value='${dto.introduction}'>
            <input type="hidden" class="search_store_list_toScript"
                id="search_store_list_category${status.index}" value='${dto.category}'>
        </c:forEach>
    </c:if>

    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_sortMethod"
        value="${sortMethod}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_cost_range"
        value="${cost_range}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_korean"
        value="${food_category_korean}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_western"
        value="${food_category_western}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_chinese"
        value="${food_category_chinese}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_japanese"
        value="${food_category_japanese}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_asian"
        value="${food_category_asian}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_fastfood"
        value="${food_category_fastfood}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_dessert_drink"
        value="${food_category_dessert_drink}">
    <input type="hidden" class="search_store_filter_toScript" id="fillter_settings_food_category_etc"
        value="${food_category_etc}">

    <script>
    // 필터 기능들

    $(function () {

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
        })


        // 필터 정렬 지정
        $(".filter_option_btn").on("click", function () {
            $("#sortMethod").val($(this).attr("id"));
            $(".filter_option_btn").css({
                "border": "2px solid silver"
            });
            $(this).css({
                "border": "2px solid red"
            });
        })

        // 각 음식 카테고리 div에 boolean변수 부여(closer)
        $(".food_category_list").each(function (index, item) {
            let food_category_list_check = true;
            $(this).find(".food_category_menu").val(true);
            $(item).on("click", function () {
                if (food_category_list_check == false) {
                    $(this).css({
                        "border": "2px solid red"
                    });
                    $(this).find(".food_category_menu").val(true);
                    food_category_list_check = true;
                } else {
                    $(this).css({
                        "border": "1px solid silver"
                    });
                    $(this).find(".food_category_menu").val(false);
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
        let food_category_dessert_drink = $("#fillter_settings_food_category_dessert_drink").val();
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

        let target = document.getElementById('range')
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

    
 	// 엔터 입력 시 검색 적용
    $("#search").on("keyup", function (input) {
        if (input.keyCode == 13) {
            $("#searchForm").prop("onsubmit", true);
            $("#searchForm").submit();
        }
    })

    // 뒤로가기 버튼
    $("#toBack_btn").on("click", function () {
        location.href = "/page/main.jsp";
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

        $("#searchForm").prop("onsubmit", true);
        $("#searchForm").submit();
    });
    </script>

    <script>

    // 학원 지도 설정
    var map_layout = document.getElementById('map');

    // 학원 중심 좌표 설정
    var options = {
        center: new kakao.maps.LatLng(37.567917, 126.983043),
        level: 3
    };

    // 학원 영역 변수 설정
    var khacademyMap = new kakao.maps.Map(map_layout, options);

    // 학원 마커 이미지 등록
    var imageSrc = '/allstore_inquiry/khplate_marker.png', // 마커이미지의 주소입니다    
        imageSize = new kakao.maps.Size(74, 79), // 마커이미지의 크기입니다
        imageOption = { offset: new kakao.maps.Point(27, 69) }; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.
    // 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
    var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption)

    // 학원 마커 표시
    // 지도를 클릭한 위치에 표출할 마커입니다
    var khacademy = new kakao.maps.Marker({
        // 지도 중심좌표에 마커를 생성합니다 
        position: khacademyMap.getCenter(),
        // 마커이미지 설정 
        image: markerImage
    });
    // 지도에 마커를 표시합니다
    khacademy.setMap(khacademyMap);

    var khacademy_infoWindow = '<body><div class="restaurant_infoWindow" style="width:130px; height:40px; text-align:center; font-size:14px; line-height:40px; font-weight:bold; color:blue; padding:0;">KH 아카데미</div></body>'

    //인포윈도우 표시 위치입니다
    khacademy_Position = new kakao.maps.LatLng(37.567917, 126.983043);

    // 인포윈도우를 생성합니다
    var infowindow = new kakao.maps.InfoWindow({
        position: khacademy_Position,
        content: khacademy_infoWindow
    });

    // 커서 올리고 내릴 시, 인포윈도우 표시 및 해제
    kakao.maps.event.addListener(khacademy, 'mouseover', makeOverListener(khacademyMap, khacademy, infowindow));
    kakao.maps.event.addListener(khacademy, 'mouseout', makeOutListener(infowindow));

    let Store_markers = []; // 마커 배열
    let open_checks = []; // 리스트의 클릭 여부 체크용 배열
    // 1번 클릭 시, 인포윈도우를 띄우며 마커의 위치로 화면 이동
    // 인포윈도우가 열린 상태에서 클릭 시, 해당 상세 페이지로 이동

    let infowindows = []; // 마커의 인포윈도우 배열
    let searchStoreid = [];
    let searchStoreTemp = [];
    let valueTemp = [];

    let list_length = '${search_store_infoWindowList.size()}';
    let count = 0;

    if (${ search_store_list != null || search_store_list.size() > 0 }){
       for (i = 0; i < 5; i++) {
           searchStoreTemp[i] = $(".restaurant_number" + i);
           valueTemp[i] = parseInt(searchStoreTemp[i].find(".restaurant_storeID").val());
           console.log("기존 :"+valueTemp[i]);
       }
       for (i = 0; i < valueTemp.length - 1; i++) {
           for (j = i + 1; j < valueTemp.length; j++) {
               if (valueTemp[i] > valueTemp[j]) {
                   let temp = valueTemp[i]
                   valueTemp[i] = valueTemp[j];
                   valueTemp[j] = temp;
               }
           }
       }
       for(i = 0 ; i< valueTemp.length ; i++){
    	   console.log("변경 후 : "+valueTemp[i]);
       }
       for (i = 0; i < searchStoreTemp.length; i++) {
           console.log(i + "번째 : " + searchStoreTemp[i].find(".restaurant_storeID").val());
           for (j = 0; j < searchStoreTemp.length; j++) {
               if (parseInt(searchStoreTemp[j].find(".restaurant_storeID").val()) == valueTemp[i]) {
                   searchStoreid[i] = searchStoreTemp[j];
               }
           }
       }
       for(i = 0 ; i< searchStoreid.length ; i++){
    	   console.log(searchStoreid[i].find(".restaurant_storeID").val());
       }
    }
    
   	$(function () {
        for (i = 0; i < list_length; i++) {
            let storeID = $("#search_store_list_storeID" + i).val();
            let name = $("#search_store_list_name" + i).val();
            let category = $("#search_store_list_category" + i).val();
            let lat = $("#search_store_list_lat" + i).val()
            let lng = $("#search_store_list_lng" + i).val()

            let marker_position = new kakao.maps.LatLng(lat, lng);

            // 마커를 생성합니다
            let Store_marker = new kakao.maps.Marker({
                position: marker_position
            });

            // 마커가 지도 위에 표시되도록 설정합니다
            Store_marker.setMap(khacademyMap);

            // 배열 추가
            Store_markers.push(Store_marker);

            let marker_content = '<body><div class="restaurant_infoWindow"><div class="infoWindow_img_layout"><img class="store_icons" src="/allstore_inquiry/infowindow_restaurant_icon.png"></div><div class="infoWindow_info_layout"><div class="infoWindow_info_top">' + name + '</div><div class="infoWindow_info_bottom"># ' + category + '</div></div></div></body>'
            
            let infowindow = new kakao.maps.InfoWindow({
                position: marker_position,
                content: marker_content
            });
            
            let infowindow_switch = false;
            infowindows.push(infowindow);

            // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
            // 이벤트 리스너로는 클로저를 만들어 등록합니다 
            kakao.maps.event.addListener(Store_marker, 'mouseover', makeOverListener(khacademyMap, Store_marker, infowindow));
            kakao.maps.event.addListener(Store_marker, 'mouseout', makeOutListener(infowindow));

            // 마커를 클릭했을 시, 해당 맛집 상세 페이지로 이동
            kakao.maps.event.addListener(Store_marker, 'click', function () {
                location.href = "/view.store?storeID=" + storeID;
            });
            // i 인덱스는 이벤트 내에 마지막 값으로 고정되어 남아있기에
            // open_index 변수를 따로 주어 이벤트 마다 해당 인덱스 값을 저장, 클로저 방식으로 사용(open_index);
            open_index = i;
            if (parseInt(searchStoreid[count].find(".restaurant_storeID").val()) == storeID) {
                // 기본 리스트 클릭 여부는 false
                open_checks[count] = false;
                let tempCount = count;
                searchStoreid[count].on("click", function () {
                    if (!open_checks[tempCount]) {
                        for (j = 0; j < open_checks.length; j++) {
                            open_checks[j] = false;
                        }

                        open_checks[tempCount] = true;

                        khacademyMap.setLevel(2);

                        infowindows.map(infowindow => {
                            infowindow.close();
                        })

                        infowindow.open(khacademyMap, Store_marker);
                        $(".restaurant_infoWindow").parent().parent().css({
                            "border": "0px",
                            "background-color": "transparent"
                        });
                        khacademyMap.panTo(marker_position);
                    } else {
                        location.href = "/view.store?storeID=" + storeID;
                    }
                })
                count++;
            }
        }
    });

    // 인포윈도우를 여는 클로저를 만드는 함수입니다
    function makeOverListener(map, marker, infowindow) {
        return function () {
            for (j = 0; j < open_checks.length; j++) {
                open_checks[j] = false;
            }
            infowindows.map(infowindow => {
                infowindow.close();
            })

            infowindow.open(map, marker);
            $(".restaurant_infoWindow").parent().parent().css({
                "border": "0px",
                "background-color": "transparent"
            });
        };
    }

    // 인포윈도우를 닫는 클로저를 만드는 함수입니다 
    function makeOutListener(infowindow) {
        return function () {
            infowindow.close();
        };
    }

    // 지도 중심을 부드럽게 이동시킵니다
    function panTo() {
        // 이동할 위도 경도 위치를 생성합니다 
        var moveLatLon = new kakao.maps.LatLng(33.450580, 126.574942);
        // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
        map.panTo(moveLatLon);
    }


    //검색 함수


    function search2() {
        $("#searchForm").prop("onsubmit", true);
        $("#searchForm").submit();
    }
    $("#searchBtn").on("click", function () {
        search2();
    })


    $("#search").keydown(function (key) {
        if (key.keyCode == 13) {
            search2();
        }
    });

</script>

</body>

</html>