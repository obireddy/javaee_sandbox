<%@ page import="java.util.List" %>
<%!
    private static String toString(long timeInterval)
    {
        if(timeInterval < 1000)
            return "less than one second";
        if(timeInterval < 60000)
            return (timeInterval / 1000) + " seconds";
        return "about " + (timeInterval / 60000) + " minutes";
    }
%>
<%
    int numberOfSessions = (Integer)request.getAttribute("numberOfSessions");
    @SuppressWarnings("unchecked")
    List<HttpSession> sessions =
            (List<HttpSession>)request.getAttribute("sessionList");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Customer Support</title>
    </head>
    <body>
        <a href="<c:url value="/login?logout" />">Logout</a>
        <h2>Sessions</h2>
        There are a total of <%= numberOfSessions %> active sessions in this
        application.<br /><br />
        <%
            long timestamp = System.currentTimeMillis();
            for(HttpSession aSession : sessions)
            {
                out.print(aSession.getId() + " - " +
                        aSession.getAttribute("username"));
                if(aSession.getId().equals(session.getId()))
                    out.print(" (you)");
                out.print(" - last active " +
                        toString(timestamp - aSession.getLastAccessedTime()));
                out.println(" ago<br />");
            }
        %>
    </body>
</html>
