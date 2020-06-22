<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

 <ul class="top-nav">
     <li class="hidden-xl-up"><a data-sa-action="search-open"><i class="zmdi zmdi-search"></i></a></li>

     <li class="dropdown" id="fhsmsCount">
         <a data-toggle="dropdown" class="top-nav__notify" onclick="fhsms();" ><i class="zmdi zmdi-email"></i></a>
         <div class="dropdown-menu dropdown-menu-right dropdown-menu--block">
         </div>
     </li>

     <li class="dropdown top-nav__notifications" id="myIm">
         <a  data-toggle="dropdown" class="top-nav__notify"><i class="zmdi zmdi-notifications"></i></a>
         <div class="dropdown-menu dropdown-menu-right dropdown-menu--block">
         </div>
     </li>

     <li class="dropdown hidden-xs-down">
         <a  data-toggle="dropdown"><i class="zmdi zmdi-check-circle"></i></a>

         <div class="dropdown-menu dropdown-menu-right dropdown-menu--block" role="menu">
             <div class="dropdown-header"> 这个地方目前只是个图标而已</div>
         </div>
     </li>

     <li class="dropdown hidden-xs-down">
         <a  data-toggle="dropdown"><i class="zmdi zmdi-apps"></i></a>

         <div class="dropdown-menu dropdown-menu-right dropdown-menu--block" role="menu">
             <div class="row app-shortcuts">
                	 这个地方目前只是个图标而已
             </div>
         </div>
     </li>

     <li class="dropdown hidden-xs-down">
         <a data-toggle="dropdown"><i class="zmdi zmdi-more-vert"></i></a>

         <div class="dropdown-menu dropdown-menu-right">
             <a class="dropdown-item" data-sa-action="fullscreen">全屏显示</a>
             <a class="dropdown-item" onclick="showHideMenu();">菜单隐现</a>
             <a class="dropdown-item" id="systemset" onclick="sysSet();">系统设置</a>
         </div>
     </li>

     <li class="hidden-xs-down">
         <a  class="top-nav__themes" data-sa-action="aside-open" data-sa-target=".themes"><i class="zmdi zmdi-palette"></i></a>
     </li>
 </ul>
 <div id="fhsmsobj"><!-- 站内信声音消息提示 --></div>