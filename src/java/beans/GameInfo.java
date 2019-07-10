package beans;

import java.io.Serializable;
import java.sql.*;
import java.util.HashMap;
import java.util.logging.Level;
import java.util.logging.Logger;

public class GameInfo implements Serializable{
    
    private static HashMap gamesByTitle = new HashMap();
    private static HashMap gamesById = new HashMap();
    private Connection connection;
    
    private int id;
    private String title;
    private String image;
    private float score;
    private String platform;
    private String modes;
    private Boolean genres;
    private String description;
    private String esrb;
    private String publisher;
    private String developer;
    private int members;
    
    public GameInfo() {
        try {
            String driver = "org.mariadb.jdbc.Driver";
            Class.forName(driver);
            String dbURL = "jdbc:mariadb://localhost:3306/apollo_6_project";
            String username = "apollo.6";
            String password = "hatsunemiku";
            connection = DriverManager.getConnection(dbURL, username, password);
        
            Statement statement = connection.createStatement();

            ResultSet rs = statement.executeQuery("SELECT * FROM `Games`");
            while(rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("title");
                String image = "http://thegamesdb.net/banners/boxart/original/front/" + rs.getString("id") + "-1.jpg";
                float score = rs.getFloat("score");
                String platform;
                switch(rs.getInt("platform")) {
                    case 4916:
                        platform = "Android";
                        break;
                    case 23:
                        platform = "Arcade";
                        break;
                    case 4915:
                        platform = "iOS";
                        break;
                    case 37:
                        platform = "Mac OS";
                        break;
                    case 14:
                        platform = "Microsoft Xbox";
                        break;
                    case 15:
                        platform = "Xbox 360";
                        break;
                    case 4920:
                        platform = "Microsoft Xbox One";
                        break;
                    case 4912:
                        platform = "Nintendo 3DS";
                        break;
                    case 3:
                        platform = "Nintendo 64";
                        break;
                    case 8:
                        platform = "Nintendo DS";
                        break;
                    case 7:
                        platform = "Nintendo Entertainment System (NES)";
                        break;
                    case 4:
                        platform = "Nintendo Game Boy";
                        break;
                    case 5:
                        platform = "Nintendo Game Boy Advanced";
                        break;
                    case 41:
                        platform = "Nintendo Game Boy Color";
                        break;
                    case 2:
                        platform = "Nintendo Game Cube";
                        break;
                    case 4971:
                        platform = "Nintendo Switch";
                        break;
                    case 9:
                        platform = "Nintendo Wii";
                        break;
                    case 38:
                        platform = "Nintendo Wii U";
                        break;
                    case 1:
                        platform = "PC";
                        break;
                    case 10:
                        platform = "Sony Playstation";
                        break;
                    case 11:
                        platform = "Sony Playstation 2";
                        break;
                    case 12:
                        platform = "Sony Playstation 3";
                        break;
                    case 4919:
                        platform = "Sony Playstation 4";
                        break;
                    case 13:
                        platform = "Sony Playstation Portable";
                        break;
                    case 6:
                        platform = "Super Nintendo (SNES)";
                        break;
                    default:
                        platform = "Unknown";
                }
                String modes = rs.getString("modes");
                Boolean genres = rs.getBoolean("genres");
                String description = rs.getString("description");
                String esrb;
                switch(rs.getInt("esrb")) {
                    case 0:
                        esrb = "images/RP.png";
                        break;
                    case 1:
                        esrb = "images/C.png";
                        break;
                    case 2:
                        esrb = "images/E.png";
                        break;
                    case 3:
                        esrb = "images/E10.png";
                        break;
                    case 4:
                        esrb = "images/T.png";
                        break;
                    case 5:
                        esrb = "images/M.png";
                        break;
                    default:
                        esrb = "images/RP.png";
                }
                String publisher = rs.getString("publisher");
                String developer = rs.getString("developer");
                int members = rs.getInt("members");
                
                gamesByTitle.put(title, new GameInfo(id, title, image, score, platform, modes, genres, description, esrb, publisher, developer, members));
                gamesById.put(id, new GameInfo(id, title, image, score, platform, modes, genres, description, esrb, publisher, developer, members));
            }
            rs.close();
            connection.close();
        } catch (ClassNotFoundException | SQLException ex) {
            Logger.getLogger(GameInfo.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
    
    public GameInfo(int id, String title, String image, float score, String platform, String modes, Boolean genres, String description, String esrb, String publisher, String developer, int members) {
        this.id = id;
        this.title = title;
        this.image = image;
        this.score = score;
        this.platform = platform;
        this.modes = modes;
        this.genres = genres;
        this.description = description;
        this.esrb = esrb;
        this.publisher = publisher;
        this.developer = developer;
        this.members = members;
    }
    
    public static GameInfo getGameByTitle(String title) {
        return ((GameInfo)gamesByTitle.get(title));
    }
    
    public static GameInfo getGameById(int id) {
        return ((GameInfo)gamesById.get(id));
    }
    
    public int getId() {
        return id;
    }
    
    public String getTitle() {
        return title;
    }
    
    public String getImage() {
        return image;
    }
    
    public float getScore() {
        return score;
    }
    
    public String getPlatform() {
        return platform;
    }
    
    public String getModes() {
        return modes;
    }
    
    public Boolean getGenres() {
        return genres;
    }
    
    public String getDescription() {
        return description;
    }
    
    public String getEsrb() {
        return esrb;
    }
    
    public String getPublisher() {
        return publisher;
    }
    
    public String getDeveloper() {
        return developer;
    }
    
    public int getMembers() {
        return members;
    }
}
