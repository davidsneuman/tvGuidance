Original App Design Project - README Template
===

# TV Guidance

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

## Overview
### Description
Not too long ago, streaming services were not a thing! To find out if a movie or tv show was playing on cable, you would go to your trusty tv guide. In 2021 we need the tv guide of streaming services. Say no more! TV Guidance is an app where you can search for any movie or tv show and the guide will tell you where you can watch it on your favorite platforms! 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Movie and TV indexing
- **Mobile:** Mobile first experience
- **Story:** Allows users to search for Movie/TV show giving all streaming platforms
- **Market:** Anyone who uses streaming platform
- **Habit:** Anytime someone is going to watch a new show
- **Scope:** Potential for larger scope (see optional stories)

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* Search for movie/show, app gives streaming platforms.

**Optional Nice-to-have Stories**

* Login, and store owned streaming services
* Specified search: only outputs services for searched item that user has
* Home page of recommended movies/shows for all platforms user has
* If show is unavailable, give recommendations
* Allow users to watch show from app links

### 2. Screen Archetypes

* Search
   * Search bar screen
   * Search results screen
   * detail view screen

### 3. Navigation

**Flow Navigation** (Screen to Screen)

* Search
   * Details of searched item


## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="tvGuidance/assets/tv_guidance_wireframes.png" width=600>

### [BONUS] Digital Wireframes & Mockups
<img src="tvGuidance/assets/tv_guidance_wireframes.png" width=600>

### [BONUS] Interactive Prototype
<img src="http://g.recordit.co/wNsLlWfWBM.gif" width=600>

## Schema 
[This section will be completed in Unit 9]
### Models

#### Home Search Screen

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | searchID        | String   | name of movie/TVshow user is searching for |
   
#### Search Results Screen
| Property      | Type     | Description |
| ------------- | -------- | ------------|
| image        | file   | image of movie/TVshow |
| nameID     | String   | name of movie/TVshow | 
| synopsisID  | String  | description of the movie/TVshow  |

#### Detail View

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | image         | file     | image of movie/TVshow|
   | nameID        | String   | name of movie/TVshow |
   | streamLogo    | file     | image of streaming service logo |

### Networking
- Home Search Screen 
    - (Read/GET) search for movie/tv show given by user.
    
- Search Results View Screen 
    - (Read/GET) Return name of movie/tv show. 
    - (Read/GET) Return poster of movie/tv show. 
    - (Read/GET) Return Synopsis of the movie/tv show. 

- Detail View Screen 
    - (Read/GET) Return name of movie/tv show. 
    - (Read/GET) Return poster of movie/tv show. 
    - (Read/GET) Return logo of streaming service offering movie/tv show user searched for. 

### **Existing API endpoints**
**The Movie Database (TMDB) API**
- Base URL - https://developers.themoviedb.org/3/getting-started



| HTTP Verb  | Endpoint | Description |
| ------------- | ------------- | -------------|
|`GET`| /search/multi | Search for movies, tv shows in a single request. |
|`GET`| /watch/providers/movie  | Returns a list of the watch provider (OTT/streaming) data for movies. |
|`GET`| /watch/providers/tv  | Returns a list of the watch provider (OTT/streaming) data for TV series. |

