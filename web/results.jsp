<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%String username = request.getParameter("username");%>
<%@include file="header.jsp"%>
    <!-- Add code here -->
    <div id="content">
      <h1>Search Results</h1>
      <div class="container-fluid">
        <div class="row">
          <div class="col-sm-12">
            <div class="panel-body table-responsive" id="large_table">
              <table class="table table-bordered">
                <thead>
                  <tr>
                    <th>Name</th>
                    <th>Image</th>
                    <th>Description</th>
                    <th>Platform</th>
                  </tr>
                </thead>
                <tbody>
                  <tr>
                    <td id="entry_medium">World of Warcraft</td>
                    <td id="entry_medium"><img src="images/world_of_warcraft.jpg" alt="World of Warcraft" id="entry_medium"></td>
                    <td>
                      World of Warcraft (WoW) is a massively multiplayer online role-playing game (MMORPG) released in 2004 by Blizzard Entertainment. It is the fourth released game set in the fantasy Warcraft universe, which was first introduced by Warcraft: Orcs & Humans in 1994.
                    </td>
                    <td id="entry_large">Computer</td>
                  </tr>
                  <tr>
                    <td id="entry_medium">Minecraft</td>
                    <td id="entry_medium"><img src="images/minecraft.png" alt="Minecraft" id="entry_medium"></td>
                    <td>
                      Minecraft is a sandbox video game created and designed by Swedish game designer Markus "Notch" Persson, and later fully developed and published by Mojang. The creative and building aspects of Minecraft enable players to build constructions out of textured cubes in a 3D procedurally generated world.
                    </td>
                    <td id="entry_large">Computer</td>
                  </tr>
                  <tr>
                    <td id="entry_medium">Cuphead</td>
                    <td id="entry_medium"><img src="images/cuphead.jpg" alt="Cuphead" id="entry_medium"></td>
                    <td>
                      Cuphead is a classic run and gun action game heavily focused on boss battles. Inspired by cartoons of the 1930s, the visuals and audio are painstakingly created with the same techniques of the era, i.e. traditional hand drawn cel animation, watercolor backgrounds, and original jazz recordings.
                    </td>
                    <td id="entry_large">XBox One</td>
                  </tr>
                  <tr>
                    <td id="entry_medium">Halo Reach</td>
                    <td id="entry_medium"><img src="images/halo_reach.jpg" alt="Halo Reach" id="entry_medium"></td>
                    <td>
                      The sixth installment in the Halo series, Reach was released worldwide in September 2010. The game takes place in the year 2552, where humanity is locked in a war with the alien Covenant. Players control Noble Six, a member of an elite supersoldier squad, when the human world known as Reach falls under Covenant attack.
                    </td>
                    <td id="entry_large">XBox 360</td>
                  </tr>
                  <tr>
                    <td id="entry_medium">Pokemon Emerald</td>
                    <td id="entry_medium"><img src="images/pokemon_emerald.jpg" alt="Pokemon Emerald" id="entry_medium"></td>
                    <td>
                      Pokémon Emerald is a role-playing video game developed by Game Freak, published by The Pokémon Company and distributed by Nintendo for the Game Boy Advance handheld video game console.
                    </td>
                    <td id="entry_large">Gamboy Advanced</td>
                  </tr>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>
