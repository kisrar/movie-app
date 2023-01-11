# Movie Explorer Application (using TMDB)
___
## Features
1. Showing movie posters and title in Grid-view with Pagination.
2. Search any movie (using Searc API) with Pagination
3. Sort the movie by Popularity or Highest rating
4. Movie Details screen with following details:
    - Movie Poster
    - Movie Description (i.e. Overview)
    - Movie Release Date
    - Average rating  

___

## Steps to use this code:
1. Clone this repo `https://github.com/kisrar/movie-app.git`
2. Create your tmdb account so that you can generate an API key which is required to run this Project.
3. Create a file named `.env` in root directory of the project and paste the following content into that
    ```
    TMDB_KEY=<paste-your-TMDB-API-Key-Here>
    ``` 
4. Run `flutter pub run build_runner build --delete-conflicting-outputs` to generate the required files.
5. Now run the App :relieved:
___
## Helpful resources:
- [How to get TMDB API key](https://youtu.be/FlFyrOEz2S4)
[![](https://markdown-videos.deta/youtube/FlFyrOEz2S4)](https://youtu.be/FlFyrOEz2S4)
- [Getting started with TMDB](https://developers.themoviedb.org/3/getting-started/introduction)
- [TMDB API DOCS](https://www.themoviedb.org/documentation/api)


