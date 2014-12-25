<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib prefix="sx" uri="/struts-dojo-tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%> 
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"  
   "http://www.w3.org/TR/html4/loose.dtd">  
  
<html>  
    <head>  
        <title>Build Management</title> 
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">   
        <link type="text/css" href="css/featureSearch.css" rel="stylesheet"  />
        <link type="text/css" href="css/layout.css" rel="stylesheet"  /> 
        <link rel="stylesheet" href="css/zTreeDemo.css" type="text/css">
		<link rel="stylesheet" href="css/zTreeStyle.css" type="text/css">
		<script type="text/javascript" src="js/jquery/jquery-1.4.4.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery.ztree.core-3.4.min.js"></script>
		<script type="text/javascript" src="js/jquery/jquery.ztree.excheck-3.4.js"></script>
		<script type="text/javascript" src="js/platformMember.js"></script>
        <script type="text/javascript" src="js/page.js"></script>
        <script type="text/javascript" src="js/XHR.js"></script> 
		<script type="text/javascript">
			window.onload=function(){
	            var release = document.getElementById('release');
				var status = document.getElementById('status');
	            // var spaObject = document.getElementById('spaId');
	            var platform = document.getElementById('platform');
	            XHR.request({
					param:"",
					url:"configure!getConfiguration.action",
					method:"POST",
					callback:function(){
						var xhr = XHR.xhr;
						if(xhr.readyState==4){
							if(xhr.status == 200){		
							   	var configinfo = xhr.responseText.toString();
							   	var indexstart = configinfo.indexOf("BuildStatus");
							    var indexbegin = configinfo.indexOf("=");
							   	var indexend = configinfo.indexOf(",");
							   	var info = configinfo.substring(indexbegin+1,indexend);
							   	if(info != "")
							   	{
							   	   var detailinfo = info.split(";"); 
							   	   for(i = 0;i < detailinfo.length;i++)  	
							   	      status.options.add(new Option(detailinfo.slice(i,i+1),detailinfo.slice(i,i+1)));
							   	}
							   								   	    
							   			
							   	/*
							   	indexstart = configinfo.indexOf("Platform");
							    indexbegin = configinfo.indexOf("=",indexstart);
							   	indexend = configinfo.indexOf(",",indexstart);
							   	info = configinfo.substring(indexbegin+1,indexend);	   
							   	if(info != "")
							   	{						   		
							   		detailinfo = info.split(";");
							   		for(i = 0;i < detailinfo.length;i++)
							   		{
							   		   platform.options.add(new Option(detailinfo.slice(i,i+1),detailinfo.slice(i,i+1)));
							   		}  	
							   	        
							   	}*/
							   	
							   	/*indexstart = configinfo.indexOf("Spa");
							    indexbegin = configinfo.indexOf("=",indexstart);
							   	indexend = configinfo.indexOf("}",indexstart);
							   	info = configinfo.substring(indexbegin+1,indexend);	  
							   	if(info != "")
							   	{						   		
							   		detailinfo = info.split(";");
							   		for(i = 0;i < detailinfo.length;i++)
							   		{
							   		   spaObject.options.add(new Option(detailinfo.slice(i,i+1),detailinfo.slice(i,i+1)));
							   		}  	
							   	        
							   	}
							   	*/
							   	indexstart = configinfo.indexOf("ReleaseValue");
							    indexbegin = configinfo.indexOf("=",indexstart);
							   	indexend = configinfo.indexOf(",",indexstart);
							   	info = configinfo.substring(indexbegin+1,indexend);	
							   	
							   	if(info != "")
							   	{						   		
							   		detailinfo = info.split(";");
							   		for(i = 0;i < detailinfo.length;i++)  	
							   	        release.options.add(new Option(detailinfo.slice(i,i+1), detailinfo.slice(i,i+1)));
							   	}
							   	selectShow(status,"status1");
							   	selectShow(release,"release1");
							   	//selectShow(spaObject,"spaId1");
							   	selectShow(platform,"platform1");
							   	
							}
							else{
								alert("Error:"+xhr.status);
							}
						}
					}
				});	
			}
			
			function selectShow(obj,itemValue){
				if(document.getElementById(itemValue).value!=""){		   			       
		            for(var i = 0;i <= obj.options.length - 1;i++){
			        	if(obj.options[i].value == document.getElementById(itemValue).value){        			  
		                    obj.options[i].selected = true;
		                   
			            }else{
	 			        	obj.options[i].selected = false;
			            }
	               	 }
				    
		    	}
			}  
		    
		    function checkId() {
				var types = document.getElementsByName("ids");
				var msg = document.getElementById("msg");
				for(var i = 0; i < types.length; i++) {
					if(types[i].checked==true) {
						msg.innerHTML = "";
						return true;
					}
				}
				msg.innerHTML = "You should select at lease one request.";
				return false;
			}
		    
			function validateStatus() {
				var obj = document.getElementById("status2");
				var status = (obj.options[obj.selectedIndex]).value;
				var msg = document.getElementById("msg");
				if("" == status) {
					msg.innerHTML = "Status should not be null.";
					return false;
				}
				msg.innerHTML = "";
				return true;
			}
			
			function validatePath() {
				var path = document.getElementById("path").value;
				var msg = document.getElementById("msg");
				if("" == path) {
					msg.innerHTML = "Build Path should not be null.";
					return false;
				}
				msg.innerHTML = "";
				return true;
			}
			function check() {
				if(checkId() && validatePath() && validateStatus()) {
					return true;
				}
				return false;
			}
			
			function search() {
				var form = document.getElementById("form1");
				form.action = "request!search.action";
				form.submit();
			}
			
			function reSearch() {
				var form = document.getElementById("form1");
				form.action = "request!reSearch.action";
				form.submit();
			}
			
			function modify() {alert("modify");
				document.getElementById("modifyRequest").submit();
			}
		</script>          
        <sx:head extraLocales="en"/>  
    </head>  
    <body>
    	<form action="" method="post" name=form1 id="form1">       
    		<div style="width: 100%;" class="label">  
    			<table width="100%" align="left">
    				<tr>
    					<td align="right"><strong>Request ID:</strong> </td>
    					<td><input name="reqId" type="text" onkeyup="value=this.value.replace(/\D+/g,'')" value="<s:property value='reqId'/>"/></td>
    					<td align="right"><strong>From:</strong> </td>
    					<td><sx:datetimepicker name="startDate" displayFormat="yyyy-MM-dd" language="en" ></sx:datetimepicker></td>
    					<td align="right"><strong>To:</strong> </td>
    					<td><sx:datetimepicker name="endDate" displayFormat="yyyy-MM-dd" language="en" ></sx:datetimepicker></td>
    					<td align="right"><strong>SPA:</strong> </td>
    					<td>
		    				<input type="text" name="spa">
    					</td>
    				</tr>
    				<tr>
    					<td align="right"><strong>Platform:</strong> </td>
    					<td>
    						<input type="text" name="platform" style="width:150px" value="<s:property value='platform'/>" id="platform1" onClick="showAllPlatforms('platformMember','platform')"/>
	              	    	<div id="platformMember" class="zTreeDemoBackground left" style="display: none">
					  	  		<ul id="platform" class="ztree"></ul>
					  		</div>
		    			</td>
    					<td align="right"><strong>Release:</strong> </td>
    					<td>
    						<input type="hidden" name="releace1" id="release1" value="<s:property value='releace'/>">
    						<select name="releace" id="release">
    							<option value="">--Please Select--</option>
    						</select>
    					</td>
		    			<td align="right"><strong>Status:</strong> </td>
    					<td>
    						<input type="hidden" name="status1" id="status1" value="<s:property value='status'/>">
    						<select name="status" id="status">
		   						<option value="">--Please Select--</option>
		   					</select>
    					</td>
    				</tr>
    				<tr>
    					<td align="right"><strong>FeatureId:</strong> </td>
    					<td><input type="text" name="featureId" value="<s:property value='featureId'/>"/> </td>
    					<td align="right"><strong>CrId:</strong> </td>
    					<td><input type="text" name="crId" value="<s:property value='crId'/>"/> </td>
    					<td align="center" colspan="4">
    						<sec:authorize ifNotGranted="ROLE_GUEST">
		    					<input type="button" value="Build Request" onClick="window.location.href='/projectTracker/addRequestLink.action'"/>&nbsp;&nbsp;  <!--modified  -->
    						</sec:authorize>
	    					<input type="button" value="Search Build" onclick="window.location.href='/projectTracker/build!list.action'"/>&nbsp;&nbsp;
	    					<sec:authorize ifNotGranted="ROLE_Admin,ROLE_Manager,ROLE_RE">
				    			<input type="button" value="Search Build Request" onclick="search();"/>
			    			</sec:authorize>
			    			<sec:authorize ifAnyGranted="ROLE_Admin,ROLE_Manager,ROLE_RE">
				    			<input type="button" value="RE Search" onclick="reSearch();"/>
			    			</sec:authorize>
    					</td>
    				</tr>
    				<tr>
    					<td>
    						<input type="hidden" name="currentPage" id="current" value="<s:property value='currentPage'/>"/>
    					</td>
    				</tr>
    			</table>  			
			</div>
		</form>	  
		<form action="build!add.action" method="post" id="buildForm">
  		<table class="datatable"  width="100%" cellpadding="1" cellspacing="1">
	  		<tr bgcolor="#C4E4E4" align="center">
	  			<th>RequestId</th>
	  	  		<th>SPA</th>
		  	  	<th>Expected Date<br/>(MM/dd/yy) </th>
	  	  		<th>Platform</th>
	  	  		<th>Release</th>
		  	  	<th>Status</th>
		  	  	<th>BuildId</th>
		  	  	<th>Customer</th>
		  	  	<th>Request Type</th>
		  	  	<sec:authorize ifNotGranted="ROLE_GUEST">
			  	  	<th>Operation</th>
		  	  	</sec:authorize>
		  	  	<sec:authorize ifAnyGranted="ROLE_Admin,ROLE_Manager,ROLE_RE">
		  	  		<th>Build</th>
		  	  	</sec:authorize>		  	  	
	  		</tr>
      		<s:iterator value="requests">
      		<tr  align="center">
      			<td>
      				<a style="text-decoration: underline;" href="request!detail.action?reqId=<s:property  value="reqId"/>"><s:property  value="reqId"/></a>
      			</td>
	      	  	<td><s:property  value="spa"/></td>
	      	  	<td><s:property  value="expectedDate"/></td>
	      	  	<td><s:property  value="platform"/></td>
	      	  	<td><s:property  value="releace"/></td>
	      	  	<td><s:property  value="status"/></td>
	      	  	<td><s:property  value="build.buildId"/></td>
	      	  	<td><s:property  value="customer"/></td>
	      	  	<td><s:property  value="reqType"/></td>
	      	  	<sec:authorize ifNotGranted="ROLE_GUEST">
			  	  	<td>
			  	  		<s:if test="isSubmitted==1">
			  	  			
			  	  		</s:if>
		      	  		<s:elseif test="status=='Waiting'">
		      	  			<a href="request!update?reqId=<s:property  value='reqId'/>">Edit</a>&nbsp;
		      	  			<s:a action="request" method="sendEmail2RE">
		      	  				<s:param name="reqId" value="reqId"/>
		      	  				Submit
		      	  			</s:a>
		      	  		</s:elseif>
		      	  	</td>
		  	  	</sec:authorize>
	      	  	
	      	  	<sec:authorize ifAnyGranted="ROLE_Admin,ROLE_Manager,ROLE_RE">
		  	  		<td>
		  	  			<input type="checkbox" name="ids" value="<s:property  value="reqId"/>"/>
		  	  		</td>
		  	  	</sec:authorize>	      	  	
      		</tr>
      		</s:iterator>
      		<tr bgcolor="#C4E4E4" align="center">
      			<sec:authorize ifAnyGranted="ROLE_Admin,ROLE_Manager,ROLE_RE">
      				<td colspan="11" >
      					total <font color="blue"><s:property  value="total"/></font> records	         
          		</td>
      			</sec:authorize>
      			<sec:authorize ifNotGranted="ROLE_Admin,ROLE_Manager,ROLE_RE">
      				<td colspan="10" >
      					total <font color="blue"><s:property  value="total"/></font> records&nbsp;&nbsp;&nbsp;&nbsp;	         
          			<a onclick="first()"><img src="/images/icon-first.gif" border="0"/></a>
          			<a onclick="prior()"><img src="/images/icon-prior.gif" border="0"/></a>
          			Page  <s:property  value="currentPage"/> of <s:property  value="pages"/>
          			<a onclick="next()"><img src="/images/icon-next.gif" border="0"/></a>
          			<a onclick="last()"><img src="/images/icon-last.gif" border="0"/></a>
          			<input type="hidden" id="totalPage" value="<s:property value='pages'/>"/>
          		</td>
      			</sec:authorize>
      		</tr>
  		</table>
  		<sec:authorize ifAnyGranted="ROLE_Admin,ROLE_Manager,ROLE_RE">
	  		
	  		<table width="100%" cellpadding="1" cellspacing="5" border="0">
	  			<tr>
	  				<td align="right"><strong>Build Path:</strong> </td>
	  				<td align="left">
	  					<textarea rows="3" cols="100" name="buildPath" id="path"></textarea>
	  				</td>
	  			</tr>
	  			<tr>
	  				<td align="right"><strong>Status:</strong> </td>
	  				<td align="left">
	  					<select name="status" id="status2">
	  						<option value="">--Please Select--</option>
	  						<s:iterator value="statusList">
	  							<option value="<s:property/>"><s:property/> </option>
	  						</s:iterator>
	  					</select>
	  				</td>
	  			</tr>
	  			<tr>
	  				<td align="right"><strong>Notes:</strong> </td>
	  				<td align="left">
	  					<textarea rows="3" cols="100" name="notes"></textarea>
	  				</td>
	  			</tr>
	  			<tr>
	  				<td colspan="2" align="center">
	  					<input type="submit" value="Submit" onclick=" return check()"/>
	  				</td>
	  			</tr>
	  			<tr>
	  				<td colspan="4">
	  					<strong><font color="red"><span id="msg"></span> </font> </strong>
	  				</td>
	  			</tr>
	  		</table>
  		</sec:authorize>
	  	</form>
    </body>  
</html>  
