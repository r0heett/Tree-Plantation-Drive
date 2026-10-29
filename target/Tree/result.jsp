<%@ page import="java.sql.*" %>
<%
    String url = System.getenv().getOrDefault("DB_URL", "jdbc:mysql://localhost:3306/tree_plantation");
    String user = System.getenv("DB_USER");
    String password = System.getenv("DB_PASSWORD");

    try {
        if (user == null || password == null) {
            throw new IllegalStateException("Set the DB_USER and DB_PASSWORD environment variables.");
        }

        Class.forName("com.mysql.cj.jdbc.Driver");

        Connection connection = DriverManager.getConnection(url, user, password);

        if ("POST".equalsIgnoreCase(request.getMethod())) {
            String sql = "INSERT INTO tree_drive (volunteer, tree, location, trees) VALUES (?, ?, ?, ?)";
            PreparedStatement insert = connection.prepareStatement(sql);
            insert.setString(1, request.getParameter("volunteer"));
            insert.setString(2, request.getParameter("tree"));
            insert.setString(3, request.getParameter("location"));
            insert.setInt(4, Integer.parseInt(request.getParameter("trees")));
            insert.executeUpdate();
            insert.close();
        }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Saved All Records</title>
</head>
<body>
    <h2>Saved! All Records</h2>

    <table border="1">
        <tr>
            <th>ID</th>
            <th>Volunteer</th>
            <th>Tree</th>
            <th>Location</th>
            <th>Trees Planted</th>
        </tr>
        <%
            Statement statement = connection.createStatement();
            ResultSet records = statement.executeQuery("SELECT * FROM tree_drive");

            while (records.next()) {
        %>
        <tr>
            <td><%= records.getInt("id") %></td>
            <td><%= records.getString("volunteer") %></td>
            <td><%= records.getString("tree") %></td>
            <td><%= records.getString("location") %></td>
            <td><%= records.getInt("trees") %></td>
        </tr>
        <%
            }
            records.close();

            ResultSet total = statement.executeQuery("SELECT SUM(trees) AS total FROM tree_drive");
            total.next();
        %>
    </table>

    <p>Total Trees Planted: <%= total.getInt("total") %></p>
    <%
        total.close();

        ResultSet counts = statement.executeQuery(
            "SELECT tree, SUM(trees) AS count FROM tree_drive GROUP BY tree");
    %>

    <h2>Tree Count</h2>
    <table border="1">
        <tr>
            <th>Tree</th>
            <th>Count</th>
        </tr>
        <%
            while (counts.next()) {
        %>
        <tr>
            <td><%= counts.getString("tree") %></td>
            <td><%= counts.getInt("count") %></td>
        </tr>
        <%
            }
            counts.close();
            statement.close();
            connection.close();
        %>
    </table>

    <p><a href="index.html">Add Another Record</a></p>
</body>
</html>
<%
    } catch (Exception e) {
        out.println("Error: " + e.getMessage());
    }
%>
