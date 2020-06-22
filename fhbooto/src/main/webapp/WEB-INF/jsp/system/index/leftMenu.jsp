<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String pathf = request.getContextPath();
	String basePathf = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort()
			+ pathf + "/";
%>
<ul class="navigation">

	<!-- 一级菜单循环开始 -->
	<c:forEach items="${menuList}" var="menu1">
	
		<!-- 判断此一级菜单是否有权限，并且状态是可视的 -->
		<c:if test="${menu1.hasMenu && '1' == menu1.MENU_STATE}">
	
	       <li class="navigation__sub @@uiactive" id="lm${menu1.MENU_ID }">
	           <a>${menu1.MENU_ICON}${menu1.MENU_NAME }</a>
	           <ul>
	           
	           	<!-- 判断是否有二级级菜单 -->
	           	<c:if test="${'[]' != menu1.subMenu}">
	           	
	           		<!--二级菜单循环开始 -->
	           		<c:forEach items="${menu1.subMenu}" var="menu2">
	           			
	           			<!-- 判断此二级菜单是否有权限，并且状态是可视的 -->
	           			<c:if test="${menu2.hasMenu && '1' == menu2.MENU_STATE}">
	           			
	               			<li ${'[]' != menu2.subMenu?'class="navigation__sub @@uiactive"':'class="@@sidebaractive"'} id="z${menu2.MENU_ID }">
	               				<a <c:if test="${not empty menu2.MENU_URL && '#' != menu2.MENU_URL}">target="mainFrame" onclick="siMenu('z${menu2.MENU_ID }','lm${menu1.MENU_ID }','${menu2.MENU_NAME }','${menu2.MENU_URL }')"</c:if>>
	               					${menu2.MENU_ICON} ${menu2.MENU_NAME }<c:if test="${'[]' != menu2.subMenu}"><i class="zmdi zmdi-chevron-down zmdi-hc-fw"></i></c:if>
	               				</a>
	               			
	               				<!-- 判断是否有三级级菜单 -->
	               				<c:if test="${'[]' != menu2.subMenu}">
	               					<ul>
	               					<!--三级菜单循环开始 -->
	               					<c:forEach items="${menu2.subMenu}" var="menu3">
	               					
	               						<!-- 判断此三级菜单是否有权限，并且状态是可视的 -->
	               						<c:if test="${menu3.hasMenu && '1' == menu3.MENU_STATE}">
	               						
	               						  <li ${'[]' != menu2.subMenu?'class="navigation__sub @@uiactive"':'class="@@sidebaractive"'} id="m${menu3.MENU_ID }">
									           <a <c:if test="${not empty menu3.MENU_URL && '#' != menu3.MENU_URL}">target="mainFrame" onclick="siMenu('m${menu3.MENU_ID }','lm${menu1.MENU_ID }','${menu3.MENU_NAME }','${menu3.MENU_URL }')"</c:if>>
									           	 &nbsp; &nbsp;${menu3.MENU_ICON} ${menu3.MENU_NAME }<c:if test="${'[]' != menu3.subMenu}"><i class="zmdi zmdi-chevron-down zmdi-hc-fw"></i></c:if>
									           </a>
									           
									            <!-- 判断是否有四级级菜单 -->
									           	<c:if test="${'[]' != menu3.subMenu}">
									                 <ul>
									                 
									                	<!--四级菜单循环开始 -->
						               					<c:forEach items="${menu3.subMenu}" var="menu4">
						               					
						               						<!-- 判断此四级菜单是否有权限，并且状态是可视的 -->
						               						<c:if test="${menu4.hasMenu && '1' == menu4.MENU_STATE}">
						               						
						               						  <li ${'[]' != menu2.subMenu?'class="navigation__sub @@uiactive"':'class="@@sidebaractive"'} id="n${menu4.MENU_ID }">
						               						  
						               						  		<!-- 有五级级菜单 -->
						               						  		<c:if test="${'[]' != menu4.subMenu}">
																	<a  target="mainFrame" onclick="siMenu('n${menu4.MENU_ID }','m${menu3.MENU_ID }','${menu4.MENU_NAME }','menu/otherlistMenu?MENU_ID=${menu4.MENU_ID }')">
																		&nbsp; &nbsp;&nbsp; &nbsp;${menu4.MENU_ICON}${menu4.MENU_NAME }
																	</a>
																	</c:if>
														            <!-- 没有五级级菜单 -->
														           	<c:if test="${'[]' == menu4.subMenu}">
														                 <a <c:if test="${not empty menu4.MENU_URL && '#' != menu4.MENU_URL}">target="mainFrame" onclick="siMenu('n${menu4.MENU_ID }','lm${menu1.MENU_ID }','${menu4.MENU_NAME }','${menu4.MENU_URL }')"</c:if>>
														                 	&nbsp; &nbsp;&nbsp; &nbsp;${menu4.MENU_ICON}${menu4.MENU_NAME }
														                 </a>
														            </c:if> 
														      </li>
														       
														    </c:if> 
														     
						               					</c:forEach>
						               					<!--四级菜单循环结束 -->
									                 
									                </ul>
									            </c:if> 
									            
									      </li>
									       
									    </c:if> 
									     
	               					</c:forEach>
	               					<!--三级菜单循环结束 -->
	               					</ul>
	               				</c:if> 
	               			
	               			</li>
	               
	               		</c:if> 
	               
	               	</c:forEach>
	               	<!--二级菜单循环结束 -->
	               	
	            </c:if>   
	            
	           </ul>
	       </li>
	       
		</c:if>     
		
	</c:forEach>
	<!-- 一级菜单循环结束 -->
	
</ul>