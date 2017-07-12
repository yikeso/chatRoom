<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
	
	 <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" />
     <meta http-equiv="x-pjax-version" content="v173" />
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3" />
    <meta http-equiv="description" content="this is my page" />
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<title>陇东直播</title>
	<!--讨论区滚动条begin -->
    <link rel="stylesheet" type="text/css" href="<%= basePath %>resources/css/public.css" />
	<link rel="stylesheet" type="text/css" href="<%= basePath %>resources/css/t3.css" />
	<link rel="stylesheet" type="text/css" href="<%= basePath %>resources/css/index.css" />
  
   	
   <script type="text/javascript" src="resources/js/common/jquery-1.11.1.js"></script>
	<script src="<%= basePath %>resources/js/common/jquery-1.8.0.min.js" type="text/javascript"></script>
	<!-- the mousewheel plugin -->
	<script type="text/javascript" src="<%= basePath %>resources/js/common/jquery.mousewheel.js"></script>
	<!-- the jScrollPane script -->
	<script type="text/javascript" src="<%= basePath %>resources/js/common/jquery.jscrollpane.min.js"></script>
	<script type="text/javascript" src="<%= basePath %>resources/js/common/jscroll.js"></script>
	
	<!--讨论区滚动条end	-->
	<style type="text/css">
	  #content{
      color:white;
}
     h3{
     color:white;
     }
	div{
	
	}
	</style>
	
	<script type="text/javascript">
	   $(function(){
	  
	
	   //H5 浏览器都支持WebSocket对象的创建  ws协议的服务地址 websocket
          var client =new WebSocket("ws://"+document.domain+"/1018online/server");
          client.onopen=function(){
           console.log("连接webSocket服务器成功!");
          };
          client.onclose=function(){
          console.log("跟服务器断开连接!");
          };
          client.onmessage=function(result){
       	  $("#pic").attr("src",result.data);
       	  if(!(result.data).startsWith("data")){  
      
     appendDialog("talk_recordboxme","my账号",result.data);
	 $("#content").val("");
       
       	  }
          };
          $("#talk_send").click(function(){
              sendMsg();
          });
          
          
          
		function sendMsg(){
		 
           //alert(document.getElementById("msg").value);
           var msg=$("#msg");
           client.send(msg.val());
           msg.val("");
         
          };
	

function appendDialog(myClass,name,content) {
	var div = "";
	div += "<div class='" + myClass + "'>";
	div += "<div class='user'><img src='" + $("#basePath").val() + "resources/images/thumbs/" + myClass + ".jpg'/>" + name + "</div>";
	div += "<div class='talk_recordtextbg'>&nbsp;</div>";
	div += "<div class='talk_recordtext'>";
	div += "<h3>" + content + "</h3>";
	div += "<span class='talk_time'></span>";
	div += "</div>";
	div += "</div>";
	
	$('#jp-container').children().eq(0).append(div);
}

$(".scroll-demo ul").on("click","li",function(){
      //  alert($(this).html());
         $(".scroll-demo ul li").removeClass("scroll-tab tab-active");
         $(this).addClass(function(){
          return "scroll-tab tab-active" ;
         });
         if($(this).html()=="交流"){
          $("#one").show();
          
          $("#two").hide();
          $("#three").hide();
          $("#four").hide();
          $(".scroll-send2").hide();
          $(".scroll-send1").show();
        }else if($(this).html()=="简介"){
          $(".scroll-wrap").attr("height","241px");
          $("#one").hide();
          $("#two").show();
          $("#three").hide();
          $("#four").hide();
          $(".scroll-send1").hide();
          $(".scroll-send2").show();
        }else if($(this).html()=="商城"){
          $(".scroll-wrap").attr("height","241px");
          $("#one").hide();
          $("#two").hide();
          $("#three").show();
          $("#four").hide();
         $(".scroll-send1").hide();
          $(".scroll-send2").show();
        }else if($(this).html()=="打赏榜"){
          $(".scroll-wrap").attr("height","241px");
          $("#one").hide();
          $("#two").hide();
          $("#three").hide();
          $("#four").show();
         $(".scroll-send1").hide();
         $(".scroll-send2").show();
        }
        
      });
  });
   
				
	</script>

	</head>
	
	<body>
		
		
		<div class="talk">
			
			
			<div class="talk_record">
			<div id="box">
		<img id="pic" src="" style=" height:220px" />
		    </div>
		    </div> 
		 </div> 
      
    
				  <!--实例容器  -->  
    <div class="scroll-demo"  >
    <!-- <hr style="width: 100%;border-color: #ccc"  /> -->
    <hr style="width: 100%;border-color:#fff;padding-top: 0px;display:none;"  />
     <!-- 标签切换区 --> 
     <ul class="scroll-tab clearfix" id="index" >
     <li class="tab-item tab-active">交流</li>
     <li class="tab-item " >简介</li>
     <li class="tab-item " >商城</li>
     <li class="tab-item " >打赏榜</li>
     <li class="tab-item " style="background-color: rgb(22,179,248);color:#fff;" >关注</li>
     </ul>
      <div class="scroll-black">“心如止水,身超然物外”,一起来探讨道家文化吧!!!</div>
     <!-- 滚动内容区 -->
    <div class="scroll-wrap">
     <!-- 滚动内容 --> 
     <div class="scroll-cont">
     
     
     
      <div id="one" style="height: 200px" >   
    <div id="jp-container" class="jp-container">
       
                   <div class="zanshang">
                    <div class="zan"><img src="resources/images/zan.png" width="30px" height="30px" onclick=""/></div>
                    <div class="count"><span>1121</span></div>
                    <div class="shang"><img src="resources/images/shang.png" width="30px" height="30px" onclick=""/></div>
                 </div> 
           
                </div>    
      <div class="scroll-ol" id="two" style="display:none;">
              
                  
          <p>2017年5月1日上午10点10分，甘肃省庆阳市星启科技联
                                        合"诺伊之恋"高端饮品集团举办的"道风仙骨"领略道家
                                       文化活动正式启动。此次活动路线为：&nbsp;出发点：西峰区公司
                                   总部—中转点：崆峒古镇—终点站：平凉市崆峒山道教文化风景区。</p>
      </div>
               
                <div class="scroll-ol" id="three"  style="display:none;">
                      <h3>商城</h3>
                
                </div>  
                <div class="scroll-ol" id="four" style="display:none;">
                <div class="bang">  
                 <button >排行榜</button>
                </div> 
                
                 <div class="bang-item" style="" >
                  <table style="" >
                   <tr style="text-align: center;height: 40px">
                     <td style="text-align: left;width: 53px;" ><img style="vertical-align:middle;" src="resources/images/1.png" width="21px" height="21px"/></td>
                     <td style="text-align: left;width: 53px;"><img style="vertical-align:middle;" src="resources/images/head.png" width="39px" height="39px"/></td>
                     <td style="text-align: center;width: 108px; font-size: 8px;"><span>一枚帅哥飘过</span><br/><span>贡献值：1110</span></td>
                     <td style="text-align: center;width: 108px;" ><img style="vertical-align:middle;" src="resources/images/guanzhu.png" width="51px" height="24px"/></td>
                   </tr>
                  
                 </table>
                 <table style="" >
                   <tr style="text-align: center;height: 40px">
                     <td style="text-align: left;width: 53px;" ><img style="vertical-align:middle;" src="resources/images/1.png" width="21px" height="21px"/></td>
                     <td style="text-align: left;width: 53px;"><img style="vertical-align:middle;" src="resources/images/head.png" width="39px" height="39px"/></td>
                     <td style="text-align: center;width: 108px; font-size: 8px;"><span>一枚帅哥飘过</span><br/><span>贡献值：1110</span></td>
                     <td style="text-align: center;width: 108px;" ><img style="vertical-align:middle;" src="resources/images/guanzhu.png" width="51px" height="24px"/></td>
                   </tr>
                  
                 </table>
                 </div>
              
                </div>
     </div>
    
     <!-- 滚动条 --> 
    <div class="scroll-bar"></div>
    <!-- 滚动滑块 -->
    <div class="scroll-slider"></div>
    </div>
      <div class="message" id="msg" >
                <ul class="scroll-send1">
                   <li class="tab-send"><img src="resources/images/shizi.png" alt="" onclick="" /></li>
                   <li class="tab-send"><input type="text" value="说点什么吧..." style="display:inline-block;"  /></li>
                   <li class="tab-send"><img src="resources/images/dan.png" width="36px" height="36px" onclick="" /></li>
                   <li class="tab-send" id=".talk_send"><img src="resources/images/send.png" width="36px" height="36px" onclick="" /></li>
               </ul>
               <ul class="scroll-send2" style="display:none">
                  <li class="tab-send"></li>
                  <li class="tab-send"></li>
                  <li class="tab-send"></li>
                   <li class="tab-send"></li>  
               </ul>
           </div>     
       </div>
       </div>
       <input type="hidden" value="<%= basePath %>" id="basePath"/> 
	</body>
</html>