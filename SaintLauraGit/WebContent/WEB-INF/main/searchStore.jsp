<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% String ctxPath = request.getContextPath(); %>    

<jsp:include page="../header.jsp" />

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=개인key"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="css/searchStore.css">


<body>

<div class="storelocator-container">
	<div id="storeMap"></div>
	
	<script type="text/javascript">

var container = document.getElementById('storeMap'); //지도를 담을 영역의 DOM 레퍼런스
var options = { //지도를 생성할 때 필요한 기본 옵션
	center: new kakao.maps.LatLng(36.564757, 127.994852), //지도의 중심좌표.
	level: 13 //지도의 레벨(확대, 축소 정도)
};

var map = new kakao.maps.Map(container, options); //지도 생성 및 객체 리턴

//마커를 표시할 위치와 내용을 가지고 있는 객체 배열입니다 
var positions = [
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">1. 신세계백화점 광주점, 광주</div>', 
        latlng: new kakao.maps.LatLng(35.160539, 126.882679)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">2. 스타필드 하남, 경기</div>', 
        latlng: new kakao.maps.LatLng(37.545852, 127.224096)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">3. 신세계백화점 본점, 서울</div>', 
        latlng: new kakao.maps.LatLng(37.561156, 126.981090)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">4. 신세계백화점 경기점, 경기</div>',
        latlng: new kakao.maps.LatLng(37.325367, 127.108096)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">5. 현대백화점 판교점, 경기</div>',
        latlng: new kakao.maps.LatLng(37.392809, 127.111985)
    },
    {
        content: '<div style="font-size:8pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">6. 롯데백화점 본점 에비뉴엘,<br/> 서울</div>',
        latlng: new kakao.maps.LatLng(37.565110, 126.981927)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">7. 신세계백화점 본점 본관, 서울</div>',
        latlng: new kakao.maps.LatLng(37.561054, 126.981153)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">8. 갤러리아 백화점 럭셔리 홀 이스트, 서울</div>',
        latlng: new kakao.maps.LatLng(37.527975, 127.041807)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">9. 현대백화점 압구정 본점, 서울</div>',
        latlng: new kakao.maps.LatLng(37.527584, 127.027355)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">10. 신세계백화점 영등포점, 서울</div>',
        latlng: new kakao.maps.LatLng(37.517881, 126.905229)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">11. 롯데백화점 잠실점, 서울</div>',
        latlng: new kakao.maps.LatLng(37.512866, 127.101615)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">12. 신세계백화점 강남점, 서울</div>',
        latlng: new kakao.maps.LatLng(37.504388, 127.003096)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">13. 현대 백화점 무역센터점, 서울</div>',
        latlng: new kakao.maps.LatLng(37.508841, 127.059780)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">14. 신세계백화점 대구점, 대구</div>',
        latlng: new kakao.maps.LatLng(35.878030, 128.628498)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">15. 롯데백화점 대구점, 대구</div>',
        latlng: new kakao.maps.LatLng(35.875994, 128.596137)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">16. 신세계백화점 센텀시티점, 부산</div>',
        latlng: new kakao.maps.LatLng(35.168922, 129.129736)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">17. 롯데 부산 프리미엄 아울렛, 부산</div>',
        latlng: new kakao.maps.LatLng(35.193628, 129.212791)
    },
    {
        content: '<div style="font-size:9pt; margin:15px 15px; display:inline-block; min-witdh:400px; height:40px;">18. 여주 프리미엄 아울렛, 경기</div>',
        latlng: new kakao.maps.LatLng(37.241213, 127.612519)
    }
];

for (var i = 0; i < positions.length; i ++) {
    // 마커를 생성합니다
    var marker = new kakao.maps.Marker({
        map: map, // 마커를 표시할 지도
        position: positions[i].latlng // 마커의 위치
    });

    // 마커에 표시할 인포윈도우를 생성합니다 
    var infowindow = new kakao.maps.InfoWindow({
        content: positions[i].content // 인포윈도우에 표시할 내용
    });

    // 마커에 mouseover 이벤트와 mouseout 이벤트를 등록합니다
    // 이벤트 리스너로는 클로저를 만들어 등록합니다 
    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록됩니다
    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));
}

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}

// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

// 텍스트 클릭시 해당 마커로 이동
function setCenter(index) {
	
	var lat = positions[index].latlng.getLat().toString();
	var lng = positions[index].latlng.getLng().toString();
	
    // 이동할 위도 경도 위치를 생성합니다 
    var moveLatLon = new kakao.maps.LatLng(lat, lng);
    
    // 지도 중심을 부드럽게 이동시킵니다
    // 만약 이동할 거리가 지도 화면보다 크면 부드러운 효과 없이 이동합니다
    map.setLevel(2);
    map.setCenter(moveLatLon);
 
    javascript:window.scrollTo(0,0);
}

// 현재 위치로 이동
function currentStore() {
	
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        
	        var locPosition = new kakao.maps.LatLng(lat, lon), // 마커가 표시될 위치를 geolocation으로 얻어온 좌표로 생성합니다
	            message = '<div style="padding:5px;">고객님의 현재 위치입니다.</div>'; // 인포윈도우에 표시될 내용입니다
	        
	        // 마커와 인포윈도우를 표시합니다
	        displayMarker(locPosition, message);
	            
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    
	    var locPosition = new kakao.maps.LatLng(33.450701, 126.570667),    
	        message = '현재 위치를 찾을 수 없습니다.'
	        
	    displayMarker(locPosition, message);
	}

	// 지도에 마커와 인포윈도우를 표시하는 함수입니다
	function displayMarker(locPosition, message) {

	    // 마커를 생성합니다
	    var marker = new kakao.maps.Marker({  
	        map: map, 
	        position: locPosition
	    }); 
	    
	    var iwContent = message, // 인포윈도우에 표시할 내용
	        iwRemoveable = true;

	    // 인포윈도우를 생성합니다
	    var infowindow = new kakao.maps.InfoWindow({
	        content : iwContent,
	        removable : iwRemoveable
	    });
	    
	    // 인포윈도우를 마커위에 표시합니다 
	    infowindow.open(map, marker);
	    
	    // 지도 중심좌표를 접속위치로 변경합니다
	    map.setLevel(2);
	    map.setCenter(locPosition);      
	}    	
}

</script>
	
	<div class="storeInfo">
		<div class="infoTop" style='border-bottom: solid 1px #e6e6e6;'>
			<h2 style="padding: 30px 0 15px 30px; display: inline-block;">생 로라 매장 안내</h2>
			<span style='float:right; padding: 35px 15px 15px 0; display: inline-block; text-decoration: underline; cursor: pointer;' onclick="currentStore();">내 현재 위치 사용</span>
		</div>
		<div class="infoBottom">
			<div class="infoLine">
				<div class="col-xs-4 infoContent">
					<span style="font-size: 9pt; font-weight: bold;">1. 신세계백화점 광주점, 광주</span><br/>
					<span>광주광역시 서구 무진대로</span><br/>
					<span>932 신세계백화점 광주점 2층</span><br/>
					<span>광주 KR 61937</span><br/>
					<span>+82 62 360 1627</span><br/>
					<span>월 - 목 11:00 AM - 8:00 PM</span><br/>
					<span>금 - 일 11:00 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(0);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4 infoContent">
					<span style="font-size: 9pt; font-weight: bold;">2. 스타필드 하남, 경기</span><br/>
					<span>경기도 하남시 미사대로 750</span><br/>
					<span>스타필드 하남 지상 2층 1184호</span><br/>
					<span>경기 KR 12942</span><br/>
					<span>+82 31 8072 8349</span><br/>
					<span>월 - 일 10:00 AM – 10:00 PM</span><br/>
					<span>연중무휴</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(1);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4 infoContent">
					<span style="font-size: 9pt; font-weight: bold;">3. 신세계백화점 본점, 서울</span><br/>
					<span>서울시 중구 소공로 63</span><br/>
					<span>6층</span><br/>
					<span>서울 KR 4530</span><br/>
					<span>+82 2 310 1591</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(2);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4 infoContent">
					<span style="font-size: 9pt; font-weight: bold;">4. 신세계백화점 경기점, 경기</span><br/>
					<span>경기도 용인시 수지구 포은대로 536</span><br/>
					<span>1층</span><br/>
					<span>경기 KR 16896</span><br/>
					<span>+82 31 695 1741</span><br/>
					<span>월 - 일 10:30 AM – 9:00 PM</span><br/>
					<span>연중무휴</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(3);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4 infoContent">
					<span style="font-size: 9pt; font-weight: bold;">5. 현대백화점 판교점, 경기</span><br/>
					<span>경기도 성남시 분당구 판교역로</span><br/>
					<span>146번길 20, 1층</span><br/>
					<span>경기 KR 13529</span><br/>
					<span>+82 31 5170 1147</span><br/>
					<span>월 - 목 10:30 AM – 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM – 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(4);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4 infoContent">
					<span style="font-size: 9pt; font-weight: bold;">6. 롯데백화점 본점 에비뉴엘, 서울</span><br/>
					<span>서울시 중구 남대문로 81</span><br/>
					<span>1층</span><br/>
					<span>서울 KR 4533</span><br/>
					<span>+82 2 726 4198</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(5);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">7. 신세계백화점 본점 본관, 서울</span><br/>
					<span>서울시 중구 소공로 63</span><br/>
					<span>신세계백화점 본점 본관 2층</span><br/>
					<span>서울 KR 04530</span><br/>
					<span>+82 2 310 1367</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(6);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">8. 갤러리아 백화점 럭셔리 홀 이스트, 서울</span><br/>
					<span>서울시 강남구 압구정로 407 </span><br/>
					<span>갤러리아 명품관 2층</span><br/>
					<span>서울 KR 6009</span><br/>
					<span>+82 2 549 5741</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(7);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">9. 현대백화점 압구정 본점, 서울</span><br/>
					<span>서울시 강남구 압구정로 165</span><br/>
					<span>2층</span><br/>
					<span>서울 KR 6001</span><br/>
					<span>+82 2 546 4184</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(8);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">10. 신세계백화점 영등포점, 서울</span><br/>
					<span>서울시 영등포구 영중로 15</span><br/>
					<span>1층</span><br/>
					<span>서울 KR 7305</span><br/>
					<span>+82 2 2639 1925</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(9);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">11. 롯데백화점 잠실점, 서울</span><br/>
					<span>서울시 송파구 올림픽로 240</span><br/>
					<span>1층</span><br/>
					<span>서울 KR 5554</span><br/>
					<span>+82 2 2143 1890</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(10);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">12. 신세계백화점 강남점, 서울</span><br/>
					<span>서울시 서초구 신반포로 176</span><br/>
					<span>2층</span><br/>
					<span>서울 KR 6546</span><br/>
					<span>+82 2 3479 6069</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(11);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">13. 현대 백화점 무역센터점, 서울</span><br/>
					<span>서울시 강남구 테헤란로 517</span><br/>
					<span>2층</span><br/>
					<span>서울 KR 6164</span><br/>
					<span>+82 2 3467 8725</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(12);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">14. 신세계백화점 대구점, 대구</span><br/>
					<span>대구시 동구 동부로 149</span><br/>
					<span>5층</span><br/>
					<span>대구 KR 41229</span><br/>
					<span>+82 53 661 6455</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(13);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">15. 롯데백화점 대구점, 대구</span><br/>
					<span>대구시 북구 태평로 161</span><br/>
					<span>1층</span><br/>
					<span>대구 KR 41581</span><br/>
					<span>+82 53 660 3180</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(14);">지도에서 보기</span>
					<br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">16. 신세계백화점 센텀시티점, 부산</span><br/>
					<span>부산시 해운대구 센텀남대로 35</span><br/>
					<span>1층</span><br/>
					<span>부산 KR 48058</span><br/>
					<span>+82 51 745 1222</span><br/>
					<span>월 - 목 10:30 AM - 8:00 PM</span><br/>
					<span>금 - 일 10:30 AM - 8:30 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(15);">지도에서 보기</span>
					<br/><br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">17. 롯데 부산 프리미엄 아울렛, 부산</span><br/>
					<span>부산시 기장군 기장읍 기장해안로 147</span><br/>
					<span>롯데 동부산 아울렛 1층</span><br/>
					<span>부산 KR 46084</span><br/>
					<span>+82 51 901 2192</span><br/>
					<span>월 - 목 10:30 AM - 8:30 PM</span><br/>
					<span>금 - 일 10:30 AM - 9:00 PM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(16);">지도에서 보기</span>
					<br/><br/><br/><br/>
				</div>
			</div>
			<div class="infoLine">
				<div class="col-xs-4">
					<span style="font-size: 9pt; font-weight: bold;">18. 여주 프리미엄 아울렛, 경기</span><br/>
					<span>경기도 여주시 명품로 360</span><br/>
					<span>700동 553호</span><br/>
					<span>경기 KR 12646</span><br/>
					<span>+82 31 8087 2553</span><br/>
					<span>월 - 목 10:00 AM – 8:00 PM</span><br/>
					<span>금 - 일 10:00 AM – 9:00 AM</span><br/>
					<span style="font-size: 9pt; text-decoration: underline; cursor: pointer;" onClick="setCenter(17);">지도에서 보기</span>
					<br/><br/><br/><br/>
				</div>
			</div>
			<div style="font-size: 9pt; text-decoration: underline; text-align: center; font-weight: bold; cursor: pointer;" onclick="javascript:window.scrollTo(0,0)">맨 위로<br/><br/></div>			
		</div>
	</div>
</div>

</body>
</html>