<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/common/adminheader.jsp" />
<c:set var="path" value="${pageContext.request.contextPath }" />
<c:set
  var="loginMember"
  value="${sessionScope.SPRING_SECURITY_CONTEXT.authentication.principal }"
/>
<!-- <style>
    th {
  text-align: center;
  background-color: #dc354675;
  padding-right: 10px;
  padding-left: 10px;
  font-size: 15px;
}
td {
  text-align: center;
  background-color: rgba(211, 211, 211, 0.219);
}
tr {
  height: 50px;
  padding-bottom: 10px;
  border-bottom: rgba(0, 0, 0, 0.37) 5px solid;
  border-color: white;
}
#pageBar {
  margin-top: 20px;
}
#box {
  display: flex;
  flex-direction: row;
  justify-content: space-around;
}
#adInfo {
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin: auto;
}
#adimg {
  width: 100px;
  height: 100px;
  margin-right: 50px;
  align-self: center;
}
.sep {
  border-style: none;
}
#sep {
  background-color: #dc3546;
  height: 2px;
  width: 100%;
}
#headbox {
  display: flex;
  flex-direction: row;
  width: 100%;
  justify-content: space-between;
  margin-bottom: 10px;
}
#fns {
  align-self: first baseline;
  margin: auto;
  /* justify-content: space-between; */
}
#fnsmem,
#stylebtn {
  display: flex;
  flex-direction: row;
  margin: auto;
}
#memberList,
#reportList,
#meetingList,
#myresList,
#solvereportList,
#msgListBox,
#msgList,
#myresList,
#solvereportListBox {
  width: 100%;
}
#searchbox {
  display: flex;
  flex-direction: row;
  justify-content: center;
}
#memdata,
#mtdata,
#reportdata {
  display: flex;
  flex-direction: row;
  justify-content: center;
  margin: auto;
}
#repsearch,
#solvesearch,
#search {
  height: 30px;
  align-self: center;
  width: 500px;
}
#orderbox {
  display: flex;
  float: right;
}
#order {
  align-self: end;
}
.btn-primary.btn-circle {
  margin: 1rem;
  --btn-bg: rgba(211, 211, 211, 0.781);
  --btn-border: #dc3546;
}
.btn.btn-primary.btn-ghost {
  transition: 0.3s;
  margin: 1rem;
  --btn-color: #dc3546;
  border-color: #dc3546;
  /* font-style: ; */
}
.btn.btn-primary.btn-circle:hover {
  background: transparent;
  background-color: #dc3546;
}

/* .btn-slide {
  --btn-bg: var(--primary-color);
  --btn-border: 1pxsolidvar (--btn-bg);
} */

.btn-primary.btn-ghost.btn-slide:hover {
  background: transparent;
  background-color: #dc3546;
  box-shadow: inset 90px 0 0 0 var(background-color);
}
#repview {
  display: flex;
  flex-direction: row;
}
#reportDate,
#repTag {
  float: left;
}
#repTitle {
  margin-left: 20px;
}

.modal-body {
  display: flex;
  flex-direction: column;
} -->

</style>
<div id="profile-wrapper">
  <section id="adContent">
    <hr class="sep" />
    <hr class="sep" />
    <hr class="sep" />
    <!-- ????????? ????????? -->
    <div id="box">
      <div id="adInfo">
        <img id="adimg" src="${path}/resources/images/????????? ?????? ?????????.jpg" />
        <div id="adText"></div>
      </div>
    </div>
    <!-- ????????? -->
    <hr class="sep" />
    <hr class="sep" />
    <div id="sep"></div>
    <hr class="sep" />
    <hr class="sep" />
    <!-- ?????? -->
    <hr class="sep" />
    <hr class="sep" />
    <div id="headbox">
      <div id="fns">
        <button
          id="delbtn"
          onclick="deletemyres()"
          class="btn btn-primary btn-ghost btn-slide"
          onclick="deletemem()"
        >
          ?????? ??????
        </button>
      </div>

      <div id="searchbox">
        <input id="search" placeholder="???????????? ??????" />
        <button class="btn btn-primary btn-circle" onclick="searchName()">
          <i class="search-icon"></i>
        </button>
      </div>
    </div>
     <!-- ????????? -->
     <input type="hidden" value="${no}" id="no" />
     <div id="myresBox">
       <table id="myresList"></table>
       <div id="pageBar"></div>
     </div>
     <hr class="sep" />
     <hr class="sep" />
  </section>
</div>
<script>
  let cPage;
  let numPerpage;
  let functionN;
  let myresno;
  let N = "N";
  let Y = "Y";
  //?????? ????????? ??????
  (() => {
    myresno = $("#no").val();
    console.log(myresno);
    myreslist(cPage, functionN, myresno);
  })();

  //???????????? ???????????? ??????
  function selectAll() {
    const myrescheck = document.querySelectorAll("input[name='myrescheck']");
    // console.log($("#selectAll").prop("checked"))
    if ($("#selectAll").prop("checked")) {
      for (var i = 0; i < myrescheck.length; i++) {
        myrescheck[i].checked = true;
      }
    } else {
      for (var i = 0; i < myrescheck.length; i++) {
        myrescheck[i].checked = false;
      }
    }
  }

  //???????????? ??? ???????????? delete
  function deletemyres() {
    if (!window.confirm("???????????? ????????? ?????? ?????????????????????????")) {
      console.log("??????");
    } else {
      const del = document.querySelectorAll("input[name=myrescheck]:checked");
      nodata = [];
      // let nodata="";
      for (let i = 0; i < del.length; i++) {
        // console.log(delmem[i].value)
        nodata.push(del[i].value);
      }
      // console.log(JSON.stringify(nodata))
      $.ajax({
        url: "${path}/admin/deletedata.do",
        // dataType:"JSON",
        traditional: true,
        data: {
          nodata: JSON.stringify(nodata),
          tableN: "MYRES",
          columnN: "MYRES_NO",
          yn: "DEL_YN",
        },
        success: (data) => {
          console.log(data.result);
          for (let i = 0; i < data.result.length; i++) {
            let total = +Number(data.result[i]);
          }
          if ((total = data.result.length)) myreslist();
        },
      });
    }
  }

  //????????? ??????
  function myreslist(cPage, functionN, myresno) {
    $("#myresList").empty();
    $("#pageBar").empty();
    $("#adText").empty();
    myresno = $("#no").val();
    $.ajax({
      url: "${path}/admin/selectmyres.do",
      data: {
        cPage: cPage,
        functionN: "myreslist",
        no: myresno,
        tableN: "member_no",
        yn: "DEL_YN",
        ynval: "N",
        // numPerpage:numPerpage
      },
      success: (data) => {
        // console.log(data.pageBar)
        console.log(data.member.member_email);
        $("#adText").append(
          $("<h2>").append($("<b>").text(data.member.member_name))
        );
        $("#adText").append($("<h5>").text(data.member.member_email));
        $("#adText").append($("<h5>").text(data.member.member_nickname));
        $("#adText").append($("<h5>").text(data.member.member_gender));
        $("#adText").append($("<h5>").text(data.member.member_enrolldate));

        const tr = $("<tr>");
        const checkbox = $("<input id='selectAll' type='checkbox'>").attr(
          "onclick",
          "selectAll()"
        );
        tr.append($("<th>").append(checkbox));
        tr.append($("<th>").text("????????????"));
        tr.append($("<th>").text("???????????? ??????"));
        tr.append($("<th>").text("?????? ??????"));
        tr.append($("<th>").text("??????"));
        tr.append($("<th>").text("??????"));
        tr.append($("<th>").text("???????????? ?????? ???"));

        $("#myresList").append(tr);
        if (data.list.length == 0) {
          let tr2 = $("<tr>");
          tr2.append($("<td colspan='6'>").text("??????????????? ????????????"));
          $("#myresList").append(tr2);
        } else {
          data.list.forEach((v) => {
            // console.log(v.member_no, v.introduce)
            // console.log(v)

            let tr2 = $("<tr>");
            let a = $("<a>");
            tr2.append(
              $("<td>").append(
                $(
                  "<input name='myrescheck' type='checkbox' value=" +
                    v.MYRES_NO +
                    ">"
                )
              )
            );
            tr2.append($("<td>").text(v.MEMBER_NO));
            tr2.append($("<td>").text(v.MYRES_NO));
            let enrolldate = v.MYRES_SAVE_DATE;
            tr2.append($("<td>").text(enrolldate.slice(0, 10)));
            tr2.append($("<td>").text(v.MYRES_MEMO));
            tr2.append($("<td>").text(v.MYRES_YN));
            tr2.append($("<td>").text(v.REPORT_CNT));

            $("#myresList").append(tr2);
          });
          $("#pageBar").append(data.pageBar);
        }
      },
    });
  }
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp" />
