<!DOCTYPE html>
<html>
<head>
<title>Web Inventory Tool</title>
<script src="js/jquery-2.2.3.min.js"></script>
<script src="bootstrap-3.3.6/js/bootstrap.min.js"></script>

<script src="DataTables-1.10.11/media/js/jquery.dataTables.js"></script>
<script src="DataTables-1.10.11/media/js/dataTables.bootstrap.min.js"></script>
<script src="DataTables-1.10.11/media/js/dataTables.jqueryui.min.js"></script>
<script src="DataTables-1.10.11/extensions/Buttons/js/dataTables.buttons.min.js"></script>
<script src="DataTables-1.10.11/extensions/Buttons/js/buttons.flash.min.js"></script>
<script src="DataTables-1.10.11/extensions/Buttons/js/buttons.html5.min.js"></script>
<script src="DataTables-1.10.11/extensions/Buttons/js/buttons.print.min.js"></script>
<script src="DataTables-1.10.11/extensions/Buttons/js/jszip.min.js"></script>
<script src="DataTables-1.10.11/extensions/Buttons/js/pdfmake.min.js"></script>
<script src="DataTables-1.10.11/extensions/Buttons/js/vfs_fonts.js"></script>


<link href="bootstrap-3.3.6/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="DataTables-1.10.11/media/css/dataTables.bootstrap.min.css">
<link rel="stylesheet" href="DataTables-1.10.11/media/css/dataTables.jqueryui.min.css">
<link rel="stylesheet" href="DataTables-1.10.11/media/css/jquery.dataTables.min.css">
<link rel="stylesheet" href="DataTables-1.10.11/extensions/Buttons/css/buttons.dataTables.min.css">
<link rel="stylesheet" href="font-awesome-4.6.2/css/font-awesome.css">
<script>
$(document).ready(function() {
//     $('.datatable table').dataTable();
$('#dropdownMenu1').text("All");
	$.ajax({
		type:'post',
		url:'InventoryController',
		data:'operation='+'loadStores',
		success:function(jsonStr)
		{
			$.each($.parseJSON(jsonStr),function(key,value){
				/* $('.dropdown-menu').append($("<li/>"));
				$('.dropdown-menu li:last-child').append($("<a href='#'/>").text("ALL")); */
				if(key=="stores")
					{
					$.each(value,function(key,value){
						$('.dropdown-menu').append($("<li/>"));
						$('.dropdown-menu li:last-child').append($("<a href='#'/>").text(value));
					});
					}
			});
		}
	});
	$('.dropdown-menu').on('click','li a',function(){
		var selectedOption=$(this).text();
// 		alert(selectedOption);
		$('#dropdownMenu1').text(selectedOption);
		if($('#articleNo').val()!="")
		$('.datatable').hide();
		$('#articleNo').val("");

	});
	$('#articleNo').keypress(function (e) {
		  if (e.which == 13) {
		    $('#searchBtn').click();
		    return false;    //<---- Add this line
		  }
		});
    $('#searchBtn').click(function(){
    	$('.datatable').show();
    	$('#indicator').show();
    	$('body').addClass('overlay');
    	if($('.datatable table thead').length>0)
    	$('.datatable table').DataTable().destroy();
    	$.ajax({
    		type:'post',
    		url:'InventoryController',
    		data:'store='+$('#dropdownMenu1').text()+'&sku='+$('#articleNo').val()+'&operation='+'searchArticles',
// 			data:'store='+'store1'+'&sku='+$('#articleNo').val()+'&operation='+'searchArticles',
			error:function()
			{
				$('#indicator').hide();
				$('body').removeClass('overlay');
			},
    		success:function(jsonStr)
    		{
    			$.each($.parseJSON(jsonStr),function(key,value){
    				if(key=="articleInfo")
    					{
    					$('.datatable table').dataTable({
    						pageLength: 10,
    						dom: 'Bfrtip',
   						 	/* buttons: [
   						            'copy', 'csv', 'excel', 'pdf', 'print'
   						        ], */
   						     buttons: [
								'print',   
   						        {
   					                extend: 'excelHtml5',
   					                title: 'ArticleData'
   					            },
   					            {
   					                extend: 'pdfHtml5',
   					                title: 'ArticleData'
   					            }],
    						data:value,
    						columns: [
    						          { title: "Store" },
    						            { title: "SKU" },
    						            { title: "Description" },
    						            { title: "Status" },
    						            { title: "On Hand" },
    						            { title: "Ordered" },
    						            { title: "Display Price" },
    						            { title: "Save Price" },
    						            { title: "Was Price" },
    						            { title: "Last Updated" },
    						            
    						        ]
    						 
    						});
    					}
    			});
    			$('#indicator').hide();
    			$('body').removeClass('overlay');
    		}
    	});
    });
} );
</script>
<style>
html{
height:100%;
}
body{
background-color: #999;
font-family: serif !important;
height:100%;
}
/* #mainContent{
background-color:#E6E0EC !important;
box-shadow: 0 0 10px black;
border-top: 1px solid white;
} */
header .container{
    background-color: white;
    border: 1px solid white;
    box-shadow: 0 0 10px black;
}
#headerText{
color:white;
font-weight:bold;
}
#headerTextContainer{
background-color: #7CBF33;
}
#wowText{
color:#126B4D;
}
.jumbotron{
background-color:transparent;
}
#storAddon{
background-color: rgb(128,100,162);
    color: white;
    font-weight: bold;
/*     font-size: 17px; */
        padding-left: 10px !important;
}
#articleAddon{
background-color: rgb(0,112,192);
    color: white;
    font-weight: bold;
/*     font-size: 17px; */
        padding-left: 10px !important;
}
#articleNo,#store>.btn{
background-color:transparent;
border: none;
    outline: none;
}
#searchBtn{
background-color:rgb(146,208,80);
color:white;
font-weight:bold;
font-size: 17px;
}
#articleClick,#export{
background-color:rgb(112,48,160);
color:white;
font-weight:bold;
font-size:17px;
}
.datatable table thead th{
background-color:#254061;
color:white;
font-weight:normal !important;
font-size:17px;
vertical-align: middle;
}
.datatable table tbody tr.odd{
background-color:#C3D69B;
font-size:16px;
}
.datatable table tbody tr.even{
background-color:#D7E4BD;
font-size:16px;
}
#optionsSelection,#articleNo,.dropdown-menu	{
font-size: 19px !important;
}
#optionsSelection tr{
background-color:transparent !important;
}
#optionsSelection tr td:first-child{
width:15%;
vertical-align: middle;
}
#optionsSelection tr td{
padding:3px;
    box-shadow: 0 0 3px black;
}
#optionsSelection tr td:last-child{
border:none;
}
.h1, .h2, .h3, h1, h2, h3 {
    margin-top: 12px;
    margin-bottom: 12px;
}
ul.dropdown-menu{
height : 200px;
overflow-y : scroll;
}
.dropdown-menu,#dropdownMenu1{
width:100%;
}
#dropdownMenu1{
text-align:left;
}
table.dataTable thead .sorting_asc:after {
    content: "";
}
table.dataTable thead .sorting:after {
    opacity: 0.2;
    content: "";
}
table.dataTable thead .sorting_desc:after {
    content: "";
}
#bottomDiv{
margin-bottom: 15px;
}
#indicator{
display:none;
text-align:center;
position:absolute;
left: 0;
right: 0;
}
.overlay::after{
  content: "";
  display: block;
  position: fixed; /* could also be absolute */
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  z-index: 112;
  background-color: rgba(0,0,0,0.2);
}
#overallContainer{
    padding-right: 0;
    padding-left: 0;
    min-height: 100%;
    border: 1px solid white;
    box-shadow: 0 0 10px black;
    background-color: #E6E0EC !important;
        zoom: 0.9;
}
button.dt-button, div.dt-button, a.dt-button {
    position: relative;
    display: inline-block;
    box-sizing: border-box;
    margin-right: 0.333em;
    padding: 0.5em 1em;
    border: 1px solid #999;
    border-radius: 2px;
    cursor: pointer;
    font-size: 0.88em;
    color: white;
    white-space: nowrap;
    overflow: hidden;
    background-color: #254061;
    background-image: -webkit-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: -moz-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: -ms-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: -o-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: linear-gradient(top, #254061 0%, #171446 100%);
    filter: progid:DXImageTransform.Microsoft.gradient(GradientType=0,StartColorStr='white', EndColorStr='#e9e9e9');
    -webkit-user-select: none;
    -moz-user-select: none;
    -ms-user-select: none;
    user-select: none;
    text-decoration: none;
    outline: none;
}
button.dt-button:hover:not(.disabled), div.dt-button:hover:not(.disabled), a.dt-button:hover:not(.disabled) {
	background-color: #254061;
    background-image: -webkit-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: -moz-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: -ms-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: -o-linear-gradient(top, #254061 0%, #171446 100%);
    background-image: linear-gradient(top, #254061 0%, #171446 100%);
}
/* @media (min-width: 1200px){ */
/* .container { */
/*     width: 1070px !important; */
/* } */
/* } */
/* @media (min-width: 992px){ */
/* .container { */
/*     width: 870px !important; */
/* }} */
/* @media (min-width: 768px){ */
/* .container { */
/*     width: 650px !important; */
/* }} */
#logo{
    width: 270px;
}
.datatable table thead tr th:nth-child(1)
{
width:10% !important;
}
.datatable table thead tr th:nth-child(2)
{
width:5% !important;
}
.datatable table thead tr th:nth-child(3)
{
width:35% !important;
}
.datatable table thead tr th:nth-child(4)
{
width:10% !important;
}
.datatable table thead tr th:nth-child(5)
{
width:5% !important;
}
.datatable table thead tr th:nth-child(6)
{
width:5% !important;
}
.datatable table thead tr th:nth-child(7)
{
width:5% !important;
}
.datatable table thead tr th:nth-child(8)
{
width:5% !important;
}
.datatable table thead tr th:nth-child(9)
{
width:5% !important;
}
.datatable table thead tr th:nth-child(10)
{
width:10% !important;
}
</style>
</head>
<body>
<div class="container" id="overallContainer">
<header>
	<div class="container">
		<div class="row">
			<div class="col-md-9" id="headerTextContainer">
				<h1 id="headerText">Real Time Inventory Tool</h1>
			</div>
			<div class="col-md-2" id="logoDiv">
				<img src="logo.png" id="logo">	
			</div>
			<div class="col-md-1">
				
			</div>
		</div>
	</div>
</header>
<div class="container" id="mainContent">

<div class="jumbotron">
	<div class="row">
		<div>
			<table  class="table" id="optionsSelection">
				<tr>
					<td id="storAddon">Store</td>
					<td>
						<div class="dropdown" id="store">
					 		 <button class="btn btn-default dropdown-toggle fa fa-caret-down" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							    All
							    <span class="caret"></span>
							  </button>
							  <ul class="dropdown-menu">
							    <li><a href="#">All</a></li>
							  </ul>		
						</div>
					</td>
				</tr>
				<tr>
					<td id="articleAddon">SKU/Article no</td>
					<td>
						  <input type="text" class="form-control" id="articleNo" placeholder="Search SKU's with comma separated values.">
					</td>
				</tr>
			</table>
		</div>
	</div>
	<div class="row">
	<button type="button" class="btn btn-default" id="searchBtn">Search</button>	
	</div>
	<div class="row" id="indicator">
	<img src="ajax-loader.gif">	
	</div>
	</div>
	<div class="datatable">
		<table class="table table-striped table-bordered"></table>
	</div>
	<!-- <div class="row" id="bottomDiv">
		<div class="col-md-9">
		 <button type="button" class="btn btn-default" id="articleClick">Click here for OOS Articles</button>
		</div>
		<div class="col-md-3">
		 <button type="button" class="btn btn-default" id="export">Export</button>
		</div>
	</div> -->
	
</div>
</div>
</body>
</html>