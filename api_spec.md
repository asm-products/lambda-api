# Authentication

Once the client has signed in with Google/Facebook/Twitter and obtained the appropriate access token, it will make the following request.

`GET /auth/google_oauth2/callback?redirect_uri=postmessage&code=...`

`GET /auth/facebook_access_token/callback?access_token=...`

`GET /auth/twitter_access_token/callback?token=...&token_secret=...`

Response:
```
{
    id:12345,
    first_name: "Michael",
    last_name: "Scott",
    email: “mscott@dundermifflin.com"
}
```

Response Headers:

```
X-User-JWT: [json web token]
```

The JWT expires in 1 month. On requests that require authentication, the following header must be set:

```
Authorization: Token [json web token]
```

**All of the following endpoints require authentication**

# Gameplay

## Games

**JSON Representation of a `Game` object:**

```
{
    id:1,
    winner_id: 1,
    player_1_accept: true,
    player_2_accept: false,
    player_1: {
        id: 1,
        first_name: 'Goku',
        last_name: 'Son', 
        email: 'goku@spiritbomb.com'
    },
    player_2: {
        id: 2,
        first_name: 'Dwight',
        last_name: 'Shrute',
        email: 'dwight@dundermifflin.com'
    },
    category: {
        id: 1,
        name: 'Ruby'
    },
    rounds: [
        {
            id: 1,
            player_1_score: 3,
            player_2_score: 2
        },
        { … },
        { … }
    ]
}
```

**Additional `[game json]` notes:**
- `player_2` may be `null`
- `rounds` only contains rounds that have been started.

### `GET /games`

Returns all games 'belonging to' the authenticated user. Games are considered active when `player_1_accept` and `player_2_accept` are both `true`. If one player has not accepted the match, the game is considered a challenge to that player.

**Authorization**: anyone

**Response:**

An array of games
```
[
    { [game json] },
    { [game json] }
]
```

### `POST /games`

Creates a game asynchronously. Will send push notification when game creation is completed (i.e. players are matched). If an opponent email is specified, we’ll create a “challenge” game. If an opponent is not specified, we’ll create a “random” game. 

**Authorization**: anyone

**Request:**
```
{
    opponent_email: 'michael@dundermifflin.com',
    category_id: 1 // required
}
```

**Response:**
`[game json]`

### `GET /games/:id`

Get an individual game.

**Authorization**: only user that is player 1 or player 2 for that game

**Response**:
`[game json]`

### `PATCH /games/:id`

Accept or decline a challenge.

**Authorization**: only user that is player 2 for that game.

**Request:**

```
{
   player_2_accept: [true|false]
}
```

**Response:**

`[game json]`

### `DELETE /games/:id`

Surrender/Cancel the game.

**Authorization**: only user that is player 1 or player 2 for that game

**Response**:
`[game json]`

## Questions

**JSON Representation of a `Question` object:**

```
{
    content: 'What is the answer to the ultimate question of life, the universe, and everything?',
    category: {
        id: 22,
        name: 'JavaScript'
    },
    answers: [
        {
            id: 22,
            content: '42'
        },
        {
            id: 23,
            content: 'To crush your enemies, to see them driven before you, and to hear the lamentations of their women.'
        },
        {
            id: 23,
            content: 'bee boop di boom boop'
        }
    ]
}
```

**Additional `[question json]` notes:**
- `answers` is an array of variable length

### `GET /rounds/:id/questions`

Get all questions in the specified round.

**Authorization**: only user that is player 1 or player 2 for the game for the round. 

**Response:**

```
[
    { [question json] },
    { [question json] },
    { [question json] }
]
```

## Responses

**JSON representation of the `Response` object:**

```
{
   question_id: 1,
   answer_id: 12312,
   correct_answer_id: 12312,
   round_id: 23457
}
```

### `POST /rounds/:id/responses`

Submit a response to a question.

**Authorization:** The `question_id` is included in the list returned by `GET /rounds/:id/questions` for the same round.

**Request:**

```
{
    question_id: 3,
    answer_id: 4
}
```

**Response:**

`[response json]`

## Categories

**JSON representation of the `Category` object:**

```
{
  id: 1212,
  name: 'JavaScript'
}
```

### `GET /categories`

Get list of all categories.

**Authorization:** anyone

**Response**:
`[category json]`

## Leaderboards

**JSON representation of the `Leader` object:**
```
{
    first_name: 'Pam',
    last_name: 'Beesly',
    gem_count: 4592
}
```

### `GET /categories/:id/leaders`

Get gem (internet points) leaderboard for category. This will include the top 100. If current user is not included in the top 100, a “leader” object for the current user will be included in the end of the array.

**Authorization:** anyone

**Response:**
```
[
    {[leader json]},
    {[leader json]},
    {[leader json]},
    ...
]
```

## Profile

**JSON representation of the `Profile` object:**

```
{
    first_name: 'Stanley',
    last_name: 'Hudson',
    email: 'shudson@dundermifflin.com',
    image: 'dundermifflin.aws.s3.com/stanley',
    facebook_url: 'https://www.facebook.com/stanley.hudson.3133',
    twitter_url: 'https://twitter.com/hudsonstanley',
    dribbble_url: null,
    linkedin_url: null,
    github_url: null,
    biography: 'Sadly, I work for Dunder Mifflin. As a sales representative.',
    statistics: [
        {
            statistic_type: 'streak',
            value: 12110
        },
        {
            statistic_type: 'games_played',
            value: 12454
        },
        ....
    ]
}
```

### `GET /users/:id`

**Authorization**: anyone

**Response**
`[profile json]`
