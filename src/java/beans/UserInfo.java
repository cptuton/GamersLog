package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UserInfo implements Serializable{
    
    private static HashMap users = new HashMap();
    private Connection connection;
    
    private String username;
    private String password;
    private String picture;
    private String email;
    private String name;
    private int age;
    private String bio;
    private java.util.Date dateJoined;
    
    public UserInfo() {
        try {
            String driver = "org.mariadb.jdbc.Driver";
            Class.forName(driver);
            String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
            String username = "apollo.6";
            String password = "hatsunemiku";
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `User`");
            while(rs.next()) {
                String user = rs.getString("username");
                String pass = rs.getString("password");
                String picture = rs.getString("picture");
                if(picture == null || picture.equals("") || picture.equals("null")) {
                    picture = "images/blank_user.jpg";
                }
                String email = rs.getString("email");
                String name = rs.getString("name");
                int age = rs.getInt("age");
                String bio = rs.getString("bio");
                Date dateJoined = rs.getDate("joined");
                java.util.Date convertedDate = new java.util.Date(dateJoined.getTime());
                
                users.put(user, new UserInfo(user, pass, picture, email, name, age, bio, dateJoined));
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(UserInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public UserInfo(String username, String password, String picture, String email, String name, int age, String bio, java.util.Date dateJoined) {
        this.username = username;
        this.password = password;
        this.picture = picture;
        this.email = email;
        this.name = name;
        this.age = age;
        this.bio = bio;
        this.dateJoined = dateJoined;
    }
    
    public static UserInfo getUser(String username) {
        return ((UserInfo)users.get(username));
    }
    
    public String getUsername() {
        return username;
    }
    
    public String getPassword() {
        return password;
    }
    
    public String getPicture() {
        return picture;
    }
    
    public String getEmail() {
        return email;
    }
    
    public String getName() {
        return name;
    }
    
    public int getAge() {
        return age;
    }
    
    public String getBio() {
        return bio;
    }
    
    public java.util.Date getDateJoined() {
        return dateJoined;
    }
    
}
