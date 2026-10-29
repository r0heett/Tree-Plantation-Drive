# Tree Plantation Drive

A simple Java web app for recording tree plantation activities and viewing planting totals.

## Requirements

- Java 17
- Maven
- MySQL
- Apache Tomcat

## Setup

1. Run `database.sql` in MySQL.
2. Set the `DB_USER` and `DB_PASSWORD` environment variables for Tomcat. Optionally set `DB_URL` to override the default JDBC URL.
3. Build the app with `mvn clean package`.
4. Deploy `target/Tree.war` to Tomcat and open the app in your browser.
