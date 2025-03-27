import spotipy
from spotipy.oauth2 import SpotifyOAuth

# Set up authentication
sp = spotipy.Spotify(auth_manager=SpotifyOAuth(
    client_id="dcbfa82eb9454afabd02e143dbe2cfca",
    client_secret="a399bffdd7114e339b41a9ed3d044fb2",
    redirect_uri="http://localhost:5000/callback",
    scope="playlist-read-private"
))

redirect_uri="http://localhost:5000/callback"

# Get user ID
user_id = sp.me()["id"]
print(f"Connected as: {user_id}")