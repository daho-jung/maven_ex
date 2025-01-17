<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@include file="../includes/header.jsp"%>
<div class="row">
	<div class="col-lg-12">
		<h1 class="page-header">Tables</h1>
	</div>
	<!-- /.col-lg-12 -->
</div>
<!-- /.row -->
<div class="row">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">DataTables Advanced Tables
				<button id='regBtn' type="button" class="btn btn-xx pull-right">reg new</button>
			</div>
			<!-- /.panel-heading -->
			<div class="panel-body">
				<table width="100%"
					class="table table-striped table-bordered table-hover"
					id="dataTables-example">
					<thead>
						<tr>
							<th>number</th>
							<th>title</th>
							<th>writer</th>
							<th>date</th>
							<th>moddate</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${list}" var="board">
							<tr class="odd gradeX">
								<td><c:out value="${board.bno}" /></td>
								<td><a class='move' href='<c:out value="${board.bno}"/>'><c:out value="${board.title}"/></a></td>
								<td><c:out value="${board.writer}" /></td>
								<td><fmt:formatDate value="${board.regdate}"
										pattern="yyyy/MM/dd" /></td>
								<td><fmt:formatDate value="${board.updateDate}"
										pattern="yyyy/MM/dd" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
				<div class='row'>
					<div class="col-lg-12">
						<form id='searchForm' action="/board/list" method='get'>
							<select name='type'>
								<option value="">--</option>
								<option value="T">title</option>
								<option value="C">content</option>
								<option value="W">writer</option>
								<option value="TC">tit&cont</option>
								<option value="TW">tit&wri</option>
								<option value="TWC">tit&wri&cont</option>
							</select>
							<input type='text' name='keyword'/>
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum }'>
							<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
							<button class='btn btn-default'>Search</button>
						</form>
					</div>
				</div>
				<div class='pull-right'>
					<ul class="pagination">
					
						<c:if test="${pageMaker.prev }">
							<li class="paginate_button previous"><a href="${pageMaker.startPage-1 }">Previous
							</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage }" end="${pageMaker.endPage }">
							<li class="paginate_button ${pageMaker.cri.pageNum == num? "active":""}"><a href="${num}">${num }</a></li>
						</c:forEach>
						<c:if test="${pageMaker.next }">
							<li class="paginate_button next"><a href="${pageMaker.endPage+1 }">Next</a></li>
						</c:if>
						
						</ul>
						<form id='actionForm' action="/board/list" method='get'>
							<input type='hidden' name='pageNum' value='${pageMaker.cri.pageNum}'>
							<input type='hidden' name='amount' value='${pageMaker.cri.amount }'>
							<input type='hidden' name='type' value='<c:out value="${pageMaker.cri.type }"/>'>
							<input type='hidden' name='keyword' value='<c:out value="${pageMaker.cri.keyword }"/>'>
						</form>
				</div>

			</div>
			<!-- /.panel-body -->
		</div>
		<!-- /.panel -->
	</div>
	<!-- /.col-lg-12 -->
</div>
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">Modal title</h4>
			</div>
			<div class="modal-body">mmmmoooodddd</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				<button type="button" class="btn btn-primary">Save changes</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<script type="text/javascript">
          	$(document).ready(function(){
          		var result= '<c:out value="${result}"/>';
          		var board= '<c:out value="${board}"/>';
          		
          		checkModal(result);
          		history.replaceState({},null,null);
          		
          		function checkModal(result){
          			console.log('result',result);
          			console.log('board',board);
          			if(result===''|| history.state){
          				return;
          			}
          			if(parseInt(result)>0){
          				$(".modal-body").html("게시글"+parseInt(result)+"is reged");
          			}
          			$("#myModal").modal("show");
          		}
          		
          		$("#regBtn").on("click",function(){
          			self.location="/board/register";
          		});
          		var actionForm = $("#actionForm");
          		$(".paginate_button a").on("click",function(e){
          			e.preventDefault();
          			console.log('click');
          			actionForm.find("input[name='pageNum']").val($(this).attr("href"));
          			actionForm.submit();
          		});
          		$(".move").on("click",function(e){
          			e.preventDefault();
          			actionForm.append("<input type='hidden' name='bno' value='"+$(this).attr("href")+"'>");
          			actionForm.attr("action","/board/get");
          			actionForm.submit();
          		})
          		
          	});
          </script>
<%@include file="../includes/footer.jsp"%>