<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Group" %>
<%@ page import="model.Category" %>
<%@ page import="model.Day" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="initial-scale=1, width=device-width">
    <title>모임 검색 결과</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/global.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/groupList.css" />
</head>
<body>
<%
    List<Group> searchResults = (List<Group>) request.getAttribute("searchResults");
    String searchQuery = (String) request.getAttribute("searchQuery");
    String sessionEmail = (String) session.getAttribute("email");
%>
<div class="div">
    <div class="header">
        <div class="container">
            <a href="/main">
                <div class="web-logo">
                    <img class="logo" alt="" src="media/Icon.svg">
                    <div class="logo-text">Project</div>
                </div>
            </a>
            <div class="nav">
                <%
                    if (sessionEmail != null) {
                %>
                <div class="nav-component">
                    <%
                    } else {
                    %>
                    <div class="nav-component" style="visibility: hidden;">
                        <%
                            }
                        %>
                        <div class="label"><a href="/groupCreate.jsp">새 모임 만들기</a></div>
                    </div>
                    <div class="nav-component">
                        <div class="label"><a href="/main">모임 둘러보기</a></div>
                    </div>
                    <div class="nav-component">
                        <div class="label">
                            <%
                                if (sessionEmail != null) {
                            %>
                            <a href="/user/mypage">마이페이지</a></div>
                        <%
                        } else {
                        %>
                        <a href="/signup.jsp">회원가입</a></div>
                    <%
                        }
                    %>

                </div>
                <%
                    if(sessionEmail==null){
                %>
                <div class="nav-component">
                    <a href="/login.jsp"><div class="label">로그인</div></a>
                </div>
                <%
                    }
                %>
                <%
                    if(sessionEmail!=null){
                %>
                <div class="nav-component">
                    <a href="/user/logout"><div class="label">로그아웃</div></a>
                </div>
                <%
                    }
                %>
                <div class="nav-component">
                    <a href="/user/mypage"><img class="icon-profile" alt="" src="media/icon-profile.png"></a>
                </div>
            </div>
        </div>
    </div>
    <div class="search-group">
        <div class="search-box">
            <form method="get" action="<%= request.getContextPath() %>/groupSearch">
                <input type="text" name="search" id="search" placeholder="모임을 검색해보세요!" value="<%= searchQuery != null ? searchQuery : "" %>" />
                <input type="submit" id="button-search" value="" />
            </form>
        </div>
    </div>
    <div class="card-set">
        <h2 style="margin-left: 50px;">검색 결과: "<%= searchQuery %>"</h2>
        <%
            if (searchResults != null && !searchResults.isEmpty()) {
                for (Group group : searchResults) {
        %>
        <a href="<%= request.getContextPath() %>/groupDetail?id=<%= group.getId() %>" class="card">
            <div class="image-area">
                <img src="<%= request.getContextPath() %>/media/<%= group.getImageUrl() != null ? "group" + group.getId() + ".png" : "placeholder.png" %>" alt="" class="card-image">
            </div>
            <div class="info-area">
                <div class="meeting-name"><%= group.getTitle() %></div>
                <div class="member-status">
                    <img class="icon-people" alt="" src="<%= request.getContextPath() %>/media/icon-people.png">
                    <div class="member-status-text"><%= group.getCurrentMembers() %>/<%= group.getMaxMembers() %></div>
                </div>
                <div class="meeting-time">
                    <%
                        List<Day> days = group.getDays();
                        for (Day day : days) {
                            out.print(day.getDay() + " " + day.getStartTime() + "~" + day.getEndTime() + ", ");
                        }
                    %>
                </div>
            </div>
            <div class="tag-area">
                <%
                    List<Category> categories = group.getCategories();
                    for (Category category : categories) {
                %>
                <div class="tag">
                    <div class="tag-box" style="background-color: <%= getCategoryColor(category.getCategoryName()) %>;">
                        <div class="tag-text"><%= category.getCategoryName() %></div>
                    </div>
                </div>
                <%
                    }
                %>
            </div>
        </a>
        <%
            }
        } else {
        %>
        <div class="no-groups">검색 결과가 없습니다.</div>
        <%
            }
        %>
    </div>
</div>
<%!
    private String getCategoryColor(String category) {
        switch (category) {
            case "토론": return "#e9e587";
            case "공부": return "#87b6e9";
            case "언어": return "#e98787";
            case "자유": return "#cecece";
            case "운동": return "#8be3f4";
            case "취미": return "#87e9ba";
            default: return "grey";
        }
    }
%>
</body>
</html>
