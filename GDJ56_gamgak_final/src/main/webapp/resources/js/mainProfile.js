const clearChildBottom=(e)=>{
	//태그의 자식 밑줄 제거
	$(e).children().css('border-bottom','0px')
}

const redBottom=(e)=>{
	//태그 밑줄 생성
	$(e).css('border-bottom','2px #dc3545 solid');
}

const hideChild=(e)=>{
	//태그 자식 숨기기
	$(e).children().hide();
}

const showTag=(e)=>{
	//태그 보이기
	$(e).show();
}

$("#show-click").click((e)=>{
	//내 맛집 클릭 시
	clearChildBottom("#search-container");
	redBottom(e.target);
	hideChild("#search-item");
	showTag("#show-search");
		
});

$("#area-click").click((e)=>{
	//지역별 클릭 시
	clearChildBottom("#search-container");
	redBottom(e.target);
	hideChild("#search-item");
	showTag("#area-search");
		
});

$("#title-click").click((e)=>{
	//검색 클릭 시
	clearChildBottom("#search-container");
	redBottom(e.target);
	hideChild("#search-item");
	showTag("#title-search");
		
});

// 지도를 생성합니다    
let mapContainerLdh = $('#insertMap')[0], // 지도를 표시할 div 
	    mapOptionLdh = {
	        center: new kakao.maps.LatLng(37.47789829947013, 126.87901846929363), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
let insertMyresMap;

$("#insertModal").on('shown.bs.modal', ()=>{
	insertMyresMap=new kakao.maps.Map(mapContainerLdh, mapOptionLdh); 
})

// 마커를 담을 배열입니다
	var markers = [];

// 장소 검색 객체를 생성합니다
	var ps = new kakao.maps.services.Places();  
	
	// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});

	//임시 객체 저장
	var  positions = {};

	function savePositionsOne(e){
		$.extend(positions,e);
	}
	
	// 키워드로 장소를 검색합니다
	//searchPlaces();
	
	// 키워드 검색을 요청하는 함수입니다
	function dhsearchPlaces() {
	
	    var keyword =$('#insert_keyword').val();
	
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch( keyword, placesSearchCB,{size:15} ); 
	}
	
	// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	
	        // 정상적으로 검색이 완료됐으면
	        // 검색 목록과 마커를 표출합니다
	        displayPlaces(data);
	
	        // 페이지 번호를 표출합니다
	        displayPagination(pagination);
	
	    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {
	
	        alert('검색 결과가 존재하지 않습니다.');
	        return;
	
	    } else if (status === kakao.maps.services.Status.ERROR) {
	
	        alert('검색 결과 중 오류가 발생했습니다.');
	        return;
	
	    }
	}
	
	// 검색 결과 목록과 마커를 표출하는 함수입니다
	function displayPlaces(places) {
	
	    var listEl = document.getElementById('insert_placesList'), 
	    menuEl = document.getElementById('insert_menu_wrap'),
	    fragment = document.createDocumentFragment(), 
	    bounds = new kakao.maps.LatLngBounds(), 
	    listStr = '';
	    
	    // 검색 결과 목록에 추가된 항목들을 제거합니다
	    removeAllChildNods(listEl);
	
	    // 지도에 표시되고 있는 마커를 제거합니다
	    removeMarker();
	    

	    for ( var i=0; i<places.length; i++ ) {
	        // 마커를 생성하고 지도에 표시합니다
	        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
	            marker = addMarker(placePosition, i), 
	            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다
	
	        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
	        // LatLngBounds 객체에 좌표를 추가합니다
	        bounds.extend(placePosition);
	
	        // 마커와 검색결과 항목에 mouseover 했을때
	        // 해당 장소에 인포윈도우에 장소명을 표시합니다
	        // mouseout 했을 때는 인포윈도우를 닫습니다
	        (function(marker, title, placeInfo) {
	            kakao.maps.event.addListener(marker, 'mouseover', function() {
	                displayInfowindow(marker, title);
	            });
	
	            kakao.maps.event.addListener(marker, 'mouseout', function() {
	                infowindow.close();
	            });
	
	            itemEl.onmouseover =  function () {
	                displayInfowindow(marker, title);
	            };
	
	            itemEl.onmouseout =  function () {
	                infowindow.close();
	            };

				itemEl.onclick = function (e) {
					savePositionsOne(placeInfo);
					$("#insert_placesList>li").css('border','0px')
					$(e.target).closest('li').css('border','red 2px solid');
					$("#insertLocation>span").text(title);
					console.log(positions);
				};
	        })(marker, places[i].place_name, places[i]);
	
	        fragment.appendChild(itemEl);
	    }


	
	    // 검색결과 항목들을 검색결과 목록 Element에 추가합니다
	    listEl.appendChild(fragment);
	    menuEl.scrollTop = 0;
	
	    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
	    insertMyresMap.setBounds(bounds);
	}
	
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
	                '<div class="info">' +
	                '   <h5>' + places.place_name + '</h5>';
	
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	                    '   <span class="jibun gray">' +  places.address_name  + '</span>';
	    } else {
	        itemStr += '    <span>' +  places.address_name  + '</span>'; 
	    }
	                 
	      itemStr += '  <span class="tel">' + places.phone  + '</span>' +
	                '</div>';           
	
	    el.innerHTML = itemStr;
	    el.className = 'insert_item';
	
	    return el;
	}
	
	// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
	function addMarker(position, idx, title) {
	    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
	        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
	        imgOptions =  {
	            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
	            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
	            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
	        },
	        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
	            marker = new kakao.maps.Marker({
	            position: position, // 마커의 위치
	            image: markerImage 
	        });
	
	    marker.setMap(insertMyresMap); // 지도 위에 마커를 표출합니다
	    markers.push(marker);  // 배열에 생성된 마커를 추가합니다
	
	    return marker;
	}
	
	// 지도 위에 표시되고 있는 마커를 모두 제거합니다
	function removeMarker() {
	    for ( var i = 0; i < markers.length; i++ ) {
	        markers[i].setMap(null);
	    }   
	    markers = [];
	}
	
	// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
	function displayPagination(pagination) {
	    var paginationEl = document.getElementById('insert_pagination'),
	        fragment = document.createDocumentFragment(),
	        i; 
	
	    // 기존에 추가된 페이지번호를 삭제합니다
	    while (paginationEl.hasChildNodes()) {
	        paginationEl.removeChild (paginationEl.lastChild);
	    }
	
	    for (i=1; i<=pagination.last; i++) {
	        var el = document.createElement('a');
	        el.href = "#";
	        el.innerHTML = i;
	
	        if (i===pagination.current) {
	            el.className = 'on';
	        } else {
	            el.onclick = (function(i) {
	                return function() {
	                    pagination.gotoPage(i);
	                }
	            })(i);
	        }
	
	        fragment.appendChild(el);
	    }
	    paginationEl.appendChild(fragment);
	}
	
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
	    infowindow.setContent(content);
	    infowindow.open(insertMyresMap, marker);
	}
	
	 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
	function removeAllChildNods(el) {   
	    while (el.hasChildNodes()) {
	        el.removeChild (el.lastChild);
	    }
	}

//사진 업로드 시 사진 출력
$("#mypic").change((e)=>{
	//기존 클릭 시 이미지 출력 숨기기
	$("a#insertMyResImage").hide();
	let fileArr=e.target.files;
	$.each (fileArr, (index, el)=> {
		console.log(el);
		//업로드 된 파일 이미지 경로
		let mypicURL=URL.createObjectURL(el);
		console.log(mypicURL);
		//새 div 만들기
		let mypicDivTag=$("<div>").addClass("carousel-item").css("height","100%");
		if(index==0)mypicDivTag.addClass("active");
		let mypicImgTag=$("<img>").addClass("d-block w-100").attr("src",mypicURL).css("height","100%");;
		mypicDivTag.append(mypicImgTag);
		$("#mypic-inner").append(mypicDivTag);

	})
	$("#mypic-carousel").show();
})


//textarea 글자 수 동적 변경
$("textarea[name='myres_memo").keyup((e)=>{
	$("#textNum>span").text($(e.target).val().length);
})


//header.jsp 맛집 저장 Modal 저장 클릭 시 식당 객체 전달
$("#myResSave").click(()=>{
	//위치 설정을 안했을 시에 return false
	if($("#insertLocation>span").text()=="위치를 설정해주세요"){
		alert("위치를 설정해주세요");
		return false;
	}

	let restaurant=JSON.stringify(positions);
	
	$("input[name='restaurant").val(restaurant);

	$("form#insertModal-body").submit();
	
})









	


