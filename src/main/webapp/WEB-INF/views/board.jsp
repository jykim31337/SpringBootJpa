<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<jsp:include page="./template/common.jsp" />

<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<!-- Custom fonts for this template -->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">

<!-- Custom styles for this template -->
<link href="css/sb-admin-2.min.css" rel="stylesheet">

<!-- Custom styles for this page -->
<link href="vendor/datatables/dataTables.bootstrap4.min.css"
	rel="stylesheet">

<script type="text/javascript">

	var boardPage = "${boardPage}";

	function movePage(ctl) {
		
		var gotoNaviIdx;
		var naviIdxCtl;
		var naviIdxCtlVal;
		
		try{
			
			naviIdxCtl = $('#naviIdx');
			naviIdxCtlVal = naviIdxCtl.val();
			
			if(ctl.id != null && ctl.id != '') {
				
				var nNaviSize = Number($('#naviSize').val());
				var nNaviStIdx = Number($('#naviStIdx').val());
				
				if(ctl.id == 'naviNext') {
					
					gotoNaviIdx = nNaviStIdx + nNaviSize;
					
				} else if(ctl.id == 'naviPrev') {
					
					gotoNaviIdx = nNaviStIdx - 1;
					
				} else {
					alert(ctl.id);
				}
				
			} else {
				gotoNaviIdx = ctl.innerText;
			}
			
			naviIdxCtl.val(gotoNaviIdx);
			
			$('#frmSearch').submit();
		} catch(err) {
			console.log(JSON.stringify(err));
			alert(JSON.stringify(err));
		}
	}

	
	/* ready start */
	$(document).ready(function() {
		
		var date = new Date();
		console.log(date);
		
		var inputItemPerPage = $('#inputItemPerPage').val();
		
		$('#itemPerPage').val(inputItemPerPage);
		
		$('#itemPerPage').change(function() {
			$('#frmSearch').submit();
		});
		
		
	$('#searchText').keypress(function(e) {
			if (e.keyCode == 13) {
				$('#frmSearch').submit();
			}
		});
	});
	
	/* ready end */
</script>

<title>BOARD</title>

</head>
<body id="page-top">
	<jsp:include page="./template/top.jsp" />
	<jsp:include page="./template/left.jsp" />
	<div id="wrapper">
		<!-- Content Wrapper -->
		<div id="content-wrapper" class="d-flex flex-column">

			<!-- Main Content -->
			<div id="content">

				<!-- Topbar -->
				<nav
					class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

					<!-- Sidebar Toggle (Topbar) -->
					<form class="form-inline">
						<button id="sidebarToggleTop"
							class="btn btn-link d-md-none rounded-circle mr-3">
							<i class="fa fa-bars"></i>
						</button>
					</form>

					<!-- Topbar Search -->
					<form
						class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">

					</form>

				</nav>
				<!-- End of Topbar -->

				<!-- Begin Page Content -->
				<div class="container-fluid">

					<!-- DataTales Example -->
					<div class="card shadow mb-4">

						<div class="card-body">

							<div class="table-responsive">
								<div id="dataTable_wrapper" class="dataTables_wrapper dt-bootstrap4">

									<input type="hidden" id="itemTotCnt" name="itemTotCnt" value="${boardPage.itemTotCnt}"/>
									<input type="hidden" id="inputItemPerPage" name="inputItemPerPage" value="${boardPage.itemPerPage}"/>
									
									<input type="hidden" id="naviSize" name="naviSize" value="${boardPage.naviSize}"/>
									<input type="hidden" id="naviStIdx" name="naviStIdx" value="${boardPage.naviStIdx}"/>
									<input type="hidden" id="naviEdIdx" name="naviEdIdx" value="${boardPage.naviEdIdx}"/>
									
									<input type="hidden" id="naviLstIdx" name="naviLstIdx" value="${boardPage.naviLstIdx}"/>
									
									<input type="hidden" id="itemStIdx" name="itemStIdx" value="${boardPage.itemStIdx}"/>
									<input type="hidden" id="itemEdIdx" name="itemEdIdx" value="${boardPage.itemEdIdx}"/>
									
									<form class="col-sm-12 px-0" id="frmSearch" name="frmSearch" method="get" action="board">
									
										<div class="row mx-0">
											
											<input type="hidden" id="naviIdx" name="naviIdx" value="${boardPage.naviIdx}"/>
											
											<div class="col-sm-12 col-md-6 px-0">
												<div class="dataTables_length" id="dataTable_length">
													<label>Show</label>
													<select id="itemPerPage" name="itemPerPage" aria-controls="dataTable" class="custom-select custom-select-sm form-control form-control-sm">
														<option value="10">10</option>
														<option value="25">25</option>
														<option value="50">50</option>
														<option value="100">100</option>
													</select>
													<label>entries</label>
												</div>
											</div>
											<div class="col-sm-12 col-md-6 px-0">
												<div id="dataTable_filter" class="dataTables_filter">
													<label>Search:
														<input id="searchText" name="searchText" value="${boardPage.searchText}" type="search" class="form-control form-control-sm" placeholder="" aria-controls="dataTable">
													</label>
												</div>
											</div>
											
										</div>
									
									</form>
									
									
									<div class="row">
										<div class="col-sm-12">
											<table class="table table-bordered" id="dataTable"
												width="100%" cellspacing="0">
												<thead>
													<tr>
														<th>idx</th>
														<th>seq</th>
														<th>title</th>
														<th>usrId</th>
														<th>creDt</th>
													</tr>
												</thead>
												<tbody>
												
													<c:forEach var="item" items="${boardPage.list}" varStatus="status">
														<tr>
														    <td>${item.rownum}</td>
															<td>${item.seq}</td>
															<td>${item.title}</td>
															<td>${item.usrId}</td>
															<td>${item.creDt}</td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</div>

									<!-- navi -->
									<div class="row">
										<div class="col-sm-12 col-md-5">
											<div class="dataTables_info" id="dataTable_info" role="status" aria-live="polite">Showing ${boardPage.itemStIdx} to ${boardPage.itemEdIdx} of ${boardPage.itemTotCnt} entries</div>
										</div>
										<div class="col-sm-12 col-md-7">
											<div class="dataTables_paginate paging_simple_numbers"
												id="dataTable_paginate">
												<ul class="pagination justify-content-end">
													<c:choose>
														<c:when test="${boardPage.naviStIdx eq '1'}">
															<li class="paginate_button page-item previous disabled" id="dataTable_previous">
																<a id="naviPrev" href="javascript:void(0)" onclick="movePage(this)" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Prev</a>
															</li>
														</c:when>
														<c:otherwise>
															<li class="paginate_button page-item previous" id="dataTable_previous">
																<a id="naviPrev" href="javascript:void(0)" onclick="movePage(this)" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Prev</a>
															</li>
														</c:otherwise>
													</c:choose>
													<%--
													<li class="paginate_button page-item previous disabled" id="dataTable_previous">
														<a href="#" aria-controls="dataTable" data-dt-idx="0" tabindex="0" class="page-link">Previous</a>
													</li>
													--%>

													<%--													
													<li class="paginate_button page-item active">
														<a href="#" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">1</a>
													</li>
													<li class="paginate_button page-item ">
														<a href="#" aria-controls="dataTable" data-dt-idx="2" tabindex="0" class="page-link">2</a>
													</li>
													--%>
													
													<c:forEach var="i" begin="${boardPage.naviStIdx}" end="${boardPage.naviEdIdx}">
														<c:choose>
															<c:when test="${i eq boardPage.naviIdx}">
																<li class="paginate_button page-item active">
																	<a href="javascript:void(0)" onclick="movePage(this)" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${i}</a>
																</li>
															</c:when>
															<c:otherwise>
																<li class="paginate_button page-item">
																	<a href="javascript:void(0)" onclick="movePage(this)" aria-controls="dataTable" data-dt-idx="1" tabindex="0" class="page-link">${i}</a>
																</li>
															</c:otherwise>
														</c:choose>
													</c:forEach>
													
													<c:choose>
														<c:when test="${boardPage.naviEdIdx eq boardPage.naviLstIdx}">
															<li class="paginate_button page-item next disabled" id="dataTable_next">
																<a id="naviNext" href="javascript:void(0)" onclick="movePage(this)" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
															</li>
														</c:when>
														<c:otherwise>
															<li class="paginate_button page-item next" id="dataTable_next">
																<a id="naviNext" href="javascript:void(0)" onclick="movePage(this)" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
															</li>
														</c:otherwise>
													</c:choose>
													<%--
														<li class="paginate_button page-item next" id="dataTable_next">
															<a href="#" aria-controls="dataTable" data-dt-idx="7" tabindex="0" class="page-link">Next</a>
														</li>
													--%>
												</ul>
											</div>
										</div>
									</div>
									<!-- navi -->
								</div>


							</div>
						</div>
					</div>
				</div>
				<!-- /.container-fluid -->

			</div>
			<!-- End of Main Content -->

			<!-- Footer -->
			<footer class="sticky-footer bg-white">
				<div class="container my-auto">
					<div class="copyright text-center my-auto"></div>
				</div>
			</footer>
			<!-- End of Footer -->

		</div>
		<!-- End of Content Wrapper -->

	</div>
	<jsp:include page="./template/bottom.jsp" />
</body>
</html>