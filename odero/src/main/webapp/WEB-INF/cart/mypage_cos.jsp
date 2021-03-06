<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet"
	href="http://fonts.googleapis.com/earlyaccess/hanna.css">
<link rel="stylesheet"
	href="https://cdn.rawgit.com/openhiun/hangul/14c0f6faa2941116bb53001d6a7dcd5e82300c3f/nanumbarungothic.css">

<link href="css/mypage.css" rel="stylesheet" type="text/css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script>
	
</script>

<style>
.title_wrap {
	margin-bottom: 25px;
}

.infoTable tr th, .infoTable tr td {
	font-size: 15px;
	vertical-align: center;
	padding: 5px;
}
.map_marker a, .map_marker a:link {
text-decoration: none;
color:white;
}
.map_marker a:hover {
text-decoration: none;
color:gray;
}


</style>

</head>
<body class="body">
	<div class="container">
		<div class="title_wrap">코스 자세히 보기</div>
		<div class="tab_wrap">


			|<a href="mypage_list.do"><span class="tab">목록</span></a>| <a
				href="cos_delete.do?no=${cvo.c_no }"><span class="seltab"
				id="delBtn">찜 삭제</span></a>

		</div>


		<%-- c:forEach var="i" begin="1" end="3"> --%>
		<div class="row cart">

			<div class="cart_wrap">
				<hr class="soften">
				<h3 class="sub_text text-left main_text">코스 전체보기</h3>
				<hr class="soften">
				<input type=hidden id="caddr" value="${cvo.pvo.p_addr }"> <input
					type=hidden id="faddr" value="${fvo.pvo.p_addr }"> <input
					type=hidden id="paddr" value="${pvo.pvo.p_addr }">
				<div class="col-lg-3 cart_div">
					<img src="${fvo.pvo.p_img }" class="cart_img">
					<table class="infoTable">
						<tr>
							<th width=20%>맛집</th>
							<td width=80%>&nbsp;${fvo.pvo.p_name }</td>
						</tr>
						<tr>
							<th width=20%>주소</th>
							<td width=80% id="faddr">${fvo.pvo.p_addr }</td>
						</tr>
						<tr>
							<th width=20%>태그</th>
							<td width=80%>&nbsp;${fvo.pvo.p_keyword }</td>
						</tr>
						<tr>
							<th width=20%>가격</th>
							<td width=80%>&nbsp; ${fvo.pvo.p_price }</td>
						</tr>
					</table>
				</div>
				<div class="col-lg-3 cart_div">
					<img src="${pvo.pvo.p_img }" class="cart_img">
					<table class="infoTable">
						<tr>
							<th width=20%>놀거리</th>
							<td width=80%>&nbsp; ${pvo.pvo.p_name }</td>
						</tr>
						<tr>
							<th width=20%>주소</th>
							<td width=80% id="paddr">${pvo.pvo.p_addr }</td>
						</tr>
						<tr>
							<th width=20%>태그</th>
							<td width=80%>&nbsp;${pvo.pvo.p_keyword }</td>
						</tr>
						<tr>
							<th width=20%>가격 :&nbsp;</th>
							<td width=80%>${pvo.pvo.p_price }</td>
						</tr>
					</table>
				</div>
				<div class="col-lg-3 cart_div">
					<img src="${cvo.pvo.p_img }" class="cart_img">
					<table class="infoTable">
						<tr>
							<th width=20%>카페</th>
							<td width=80%>&nbsp;${cvo.pvo.p_name }</td>
						</tr>
						<tr>
							<th width=20%>주소</th>
							<td width=80% id="caddr">${cvo.pvo.p_addr }</td>
						</tr>
						<tr>
							<th width=20%>태그 :&nbsp;</th>
							<td width=80%>${cvo.pvo.p_keyword }</td>
						</tr>
						<tr>
							<th width=20%>가격</th>
							<td width=80%>&nbsp;${cvo.pvo.p_price }</td>
						</tr>
					</table>
				</div>
			</div>
			<div class="map_div col-lg-12">
				<hr class="soften" />
				<h3 class="sub_text">코스 경로</h3>
				<hr class="soften" />
				<div class="map">
				
					<br>
					<div id="map" style="width: 100%; height: 600px;"></div>
					<script type="text/javascript"
						src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d7e1caf16f1fe180e708f6b17474f2fa&libraries=services"></script>
					<script>
						var point1;
						var point2;
						var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
						mapOption = {
							center : new daum.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
							level : 5
						// 지도의 확대 레벨
						};

						// 지도를 생성합니다    
						var map = new daum.maps.Map(mapContainer, mapOption);

						// 주소-좌표 변환 객체를 생성합니다

						var geocoder1 = new daum.maps.services.Geocoder();
						geocoder1
								.addressSearch(
										"${fvo.pvo.p_addr}",
										function(result, status) {
											if (status === daum.maps.services.Status.OK)
												var coords1 = new daum.maps.LatLng(
														result[0].y,
														result[0].x);
											point1 = new daum.maps.LatLng(
													result[0].y, result[0].x);
											var marker1 = new daum.maps.Marker(
													{
														map : map,
														position : coords1
													});

											var infowindow1 = new daum.maps.InfoWindow(
													{
														content :'<div class="map_marker" style="background: #002060;; color:white; width:150px;text-align:center;padding:6px 0;"><a href="p_detail.do?p_no=${fvo.pvo.p_no}">${fvo.pvo.p_name} </a></div>'
													});
											infowindow1.open(map, marker1);
											// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다

										});
						var geocoder2 = new daum.maps.services.Geocoder();
						geocoder2
								.addressSearch(
										"${pvo.pvo.p_addr}",
										function(result, status) {
											if (status === daum.maps.services.Status.OK)
												var coords2 = new daum.maps.LatLng(
														result[0].y,
														result[0].x);
											point2 = new daum.maps.LatLng(
													result[0].y, result[0].x);
											var marker2 = new daum.maps.Marker(
													{
														map : map,
														position : coords2
													});
											var infowindow2 = new daum.maps.InfoWindow(
													{
														content : '<div class="map_marker" style="background: #002060;; color:white; width:150px;text-align:center;padding:6px 0;"><a href="p_detail.do?p_no=${pvo.pvo.p_no}">${pvo.pvo.p_name} </a></div>'
													});
											infowindow2.open(map, marker2);

										});
						var geocoder3 = new daum.maps.services.Geocoder();
						geocoder3
								.addressSearch(
										"${cvo.pvo.p_addr}",
										function(result, status) {
											if (status === daum.maps.services.Status.OK)
												var coords3 = new daum.maps.LatLng(
														result[0].y,
														result[0].x);
											var marker3 = new daum.maps.Marker(
													{
														map : map,
														position : coords3
													});
											var infowindow3 = new daum.maps.InfoWindow(
													{
														content : '<div class="map_marker" style="background: #002060;; color:white; width:150px;text-align:center;padding:6px 0;"><a href="p_detail.do?p_no=${cvo.pvo.p_no}">${cvo.pvo.p_name} </a></div>'
													});
											infowindow3.open(map, marker3);
											// 3곳의 평균좌표 로 센터설정
											var center = new daum.maps.LatLng(
													(point1.getLat()
															+ point2.getLat() + coords3
															.getLat()) / 3,
													(point1.getLng()
															+ point2.getLng() + coords3
															.getLng()) / 3);
										

											map.setCenter(center);

										});
					</script>

				</div>

			</div>
		</div>
		<div class="table_wrap">


			<hr class="soften" />
			<h3 class="sub_text">코스 개별정보</h3>
			<hr class="soften" />


			<br> <br>
			<table class="info" id="table_content">

				<tr>
					<table class="table_content">
						<tr>
							<td width=30% align=center rowspan="5"><img
								src="${fvo.pvo.p_img }" width=300></td>
						</tr>
						<tr>
							<td width=20% align=center><h4>코스 개별정보</h4></td>
							<td width=50% align=left class="explain">음식점</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>장소 이름</h4></td>
							<td width=50% align=left class="explain">${fvo.pvo.p_name }</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>지역 설명</h4></td>
							<td width=50% align=left class="explain">${fvo.pvo.p_addr }</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>장소 설명</h4></td>
							<td width=50% align=left class="explain">해시 태그 :
								${fvo.pvo.p_keyword } <br> 전화 번호 : ${fvo.pvo.p_tel } <br>
								가격 대 : ${fvo.pvo.p_price } <br>
							</td>
						</tr>
					</table>

					<br>
					<br>
					<hr class="hr" />
					<br>
					<br>
				</tr>
				<tr>
					<table class="table_content">
						<tr>
							<td width=30% align=center rowspan="5"><img
								src="${pvo.pvo.p_img }" width=300></td>
						</tr>
						<tr>
							<td width=20% align=center><h4>코스 개별정보</h4></td>
							<td width=50% align=left class="explain">놀거리</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>장소 이름</h4></td>
							<td width=50% align=left class="explain">${pvo.pvo.p_name }</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>지역 설명</h4></td>
							<td width=50% align=left class="explain">${pvo.pvo.p_addr }</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>장소 설명</h4></td>
							<td width=50% align=left class="explain">해시 태그 :
								${pvo.pvo.p_keyword } <br> 전화 번호 : ${pvo.pvo.p_tel } <br>
								가격 대 : ${pvo.pvo.p_price } <br>
							</td>
						</tr>
					</table>

					<br>
					<br>
					<hr class="hr" />
					<br>
					<br>
				</tr>
				<tr>
					<table class="table_content">
						<tr>
							<td width=30% align=center rowspan="5"><img
								src="${cvo.pvo.p_img }" width=300></td>
						</tr>
						<tr>
							<td width=20% align=center><h4>코스 개별정보</h4></td>
							<td width=50% align=left class="explain">카페</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>장소 이름</h4></td>
							<td width=50% align=left class="explain">${cvo.pvo.p_name }</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>지역 설명</h4></td>
							<td width=50% align=left class="explain">${cvo.pvo.p_addr }</td>
						</tr>
						<tr>
							<td width=20% align=center><h4>장소 설명</h4></td>
							<td width=50% align=left class="explain">해시 태그 :
								${cvo.pvo.p_keyword } <br> 전화 번호 : ${cvo.pvo.p_tel } <br>
								가격 대 : ${cvo.pvo.p_price } <br>
							</td>
						</tr>
					</table>

					<br>
					<br>
					<hr class="hr" />
					<br>
					<br>
				</tr>
			</table>
			<br> <br>


		</div>


	</div>
	<%-- </c:forEach> --%>


</body>
</html>