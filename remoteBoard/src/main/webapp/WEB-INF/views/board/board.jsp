<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script type="text/javascript" src="https://cdn.datatables.net/1.10.22/js/jquery.dataTables.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>



<style>
#main:after {
    content: '';
    display: block;
    clear: both;
    float: none;
}

</style>

<body>
	<div id="main">
	
	<div class="clear" style="width: 50%; float: left;">
		<input id="nowPageNum" type="hidden" value="" />
		<table id="example_list" style="width: 100%; text-align: center;">
			<thead>
				<tr>
					<th style="width: 25%;">구분</th>
					<th style="width: 25%;">구역</th>
					<th style="width: 25%;">c</th>
					<th style="width: 25%;">발생일시</th>
				</tr>

				<tr>

					<td><select id="error_type" name="error_type"
						onchange="viewList(num)">
							<option value=""></option>
							<option value="ELB">ELB</option>
							<option value="SMPS">SMPS</option>
							<option value="LAMP">LAMP</option>
							<option value="통신">통신</option>
					</select></td>

					<td><select id="sector_area" name="error_type"
						onchange="viewList(num)">
							<option value=""></option>
							<option value="방화">방화</option>
							<option value="공원">공원</option>
					</select></td>
					<td></td>
					<td>
						<input type="text" id="error_date"/>
					</td>
					
				<tr>
			</thead>
			<tbody id="listTbody">
			</tbody>
		</table>
	</div>
	
	<div id="detail_view">
	<h2>상세정보</h2>
	<div id="detail_info">
	
	</div>
	</div>
	<!-- <table id="example_detail" style="width: 50%;">
		<thead>
			<tr>
				<th>a</th>
				<th>b</th>
				<th>c</th>
				<th>d</th>
			</tr>
		</thead>
		<tbody>
		</tbody>
	</table> -->
	
	</div>
	
	<div id=paging></div>
</body>

<script>
$(function() {
    $( "#error_date" ).datepicker({
    });
});


var num = $("#nowPageNum").val();
function viewList(num){
	let error_select = $("#error_type").val();
	let sector_select = $("#sector_area").val();
	let now_page = num;
	let error_type = error_select;
	let sector = sector_select;
	let filter_data = {'error_type':error_type, 'sector':sector, 'now_page':now_page};
	
	$.ajax({
		url:"/board/dataList",
		async: true,
		data: filter_data,
		dataType: 'json',
		type: 'GET',
		success:function(rst){
			let chgArr = Object.values(rst);
			let dataList = chgArr[0];
			let pagingData = Object.values(chgArr[1]);
			let groupCount = pagingData[3];
			let totalPageNum = pagingData[4];
			let startPage = pagingData[5];
			let endPage = pagingData[6];
			let prevPage = pagingData[7];
			let nextPage = pagingData[8];
			
			// 페이징 넘버 생성
			createPagingButton(groupCount, totalPageNum, startPage, endPage, prevPage, nextPage);
			// 데이터 리스트 생성
			createDataList(dataList);
				},
				  error:function(jqXHR, textStatus, errorThrown){ console.log("error \n" + textStatus + " : " + errorThrown);
			    }
			});
	$("#nowPageNum").val(now_page);
}

function createPagingButton(groupCount, totalPageNum, startPage, endPage, prevPage, nextPage) {
	// 페이징 버튼 생성
	$("#paging").empty();
		if(prevPage > 0){
		$("#paging").append('<button id="prevGroupPageBtn">[prev]</button>');

		// 이전 그룹 이동 버튼 이벤트 리스너 등록
		var prevBtnAddEvent = document.getElementById("prevGroupPageBtn");
		prevBtnAddEvent.addEventListener("click", function() {prevButtonClick(prevPage)}, false);
		
		}
	
		if(totalPageNum>groupCount){
			for(let i=startPage; i<=endPage; i++){
				$("#paging").append('<button  class="pageNum" value="'+i +'">['+i+']</button>');
			}
		}
		else {
			for(let i=1; i<=totalPageNum; i++){
				$("#paging").append('<button  class="pageNum" value="'+i +'">['+i+']</button>');
			}
		}
		
		if(nextPage>0){
			$("#paging").append('<button id="nextGroupPageBtn">[next]</button>');
			var nextBtnAddEvent = document.getElementById("nextGroupPageBtn");
			nextBtnAddEvent.addEventListener("click", function() {nextButtonClick(nextPage)}, false);
			
		}

		// 숫자 버튼 마다 클릭 이벤트 리스너 등록
		var cols = document.querySelectorAll('.pageNum'); 
		[].forEach.call(cols,function(col){
			col.addEventListener("click", function(){
				viewList(this.value);
			}, false); 
		});
}


function prevButtonClick(prevNum){
	$("#paging").empty();
	viewList(prevNum);
}

function nextButtonClick(nextNum){
	$("#paging").empty();
	viewList(nextNum);
}

function createDataList(dataList){
	let rows = [];
	if (dataList.length > 0) {
		$("#listTbody").empty();
		$.each(dataList, (idx, val) => {
			rows.push([val.error_type, val.sector]);
		});
		createTable(rows);
	}
}

// 테이블 생성 및 데이터 삽입
function createTable(rows) {
	//$("#example_list > tbody").append("<tr role='row'>" + rows+ "</tr>");
	var tag = "";
	for (var i = 0; i < rows.length; i++) {
		tag = "";
		for (var j = 0; j < rows[i].length; j++) {
			tag += "<td>" + rows[i][j] + "</td>";
		}
		$("#example_list > tbody").append("<tr role='row' onClick='detailView()'>" + tag + "</tr>");
	}

}

function detailView() {
	$("#detail_info").empty();
	alert("asdf")
	$("#detail_info").append("test");
	
}

$(document).ready(function() {
	viewList(num);
});


/* function createDetailTable(rows) {
	$("#example_detail > tbody").append("<tr role='row'>" + rows+ "</tr>");
	var tag = "";
	for (var i = 0; i < rows.length; i++) {
		tag = "";
		for (var j = 0; j < rows[i].length; j++) {
			tag += "<td>" + rows[i][j] + "</td>";
		}
		$("#example_detail > tbody").append("<tr role='row'>" + tag + "</tr>");
	}
} */

</script>