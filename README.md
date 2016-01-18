# BattleMonsters Readme
1. Set up postgres:
    -   Create the following databases `createdb fish_labs_challenge_development`, `createdb fish_labs_challenge_production`, `createdb fish_labs_challenge_test`
2. Set up ruby:
    -   I'm using fish shell so .rvmrc files never work for me
    -   Use Ruby 2.2.0 - `rvm use 2.2.0`
3. Run `bundle install` to install plugins
4. Run necesarry migrations: `padrino rake ar:migrate` and `padrino rake ar:migrate -e test`
5. Execute the server via `padrino start` or run unit tests by `rspec spec`

## Structure & Endpoints - Explanation

```
    URL                           REQUEST  PATH
1   (:monster, :list)               GET    /monster/list
2   (:monster, :create)            POST    /monster/create
3   (:sort, :name)                  GET    /sort/name
4   (:sort, :power)                 GET    /sort/power
5   (:sort, :type)                  GET    /sort/type
6   (:sort, :weakness)              GET    /sort/weakness
7   (:team, :add)                  POST    /team/add
8   (:team, :delete_from_team)     POST    /team/delete_from_team
9   (:team, :delete)               POST    /team/delete
10  (:user, :register)             POST    /user/register
```
1. Lists all monsters created
2. Creates a monster
3. Sorts a user's monsters by name
4. Sorts a user's monsters by power (Alphabetical)
5. Sorts a user's monsters by type (Alphabetical)
6. Sorts a user's monsters by weakness (Alphabetical)
7. Adds a monster to a team or owned monsters, and to that user's owned monsters
8. Deletes the given monster from a team - but not owned monsters
9. Deletes the given monster from a team and owned monsters
10. Registers a user's account with the password given

## Structure & Endpoints - Example
- Assuming the padrino server is started on 127.0.0.1:3000

```
    URL                           REQUEST  PATH
1   (:monster, :list)               GET    /monster/list
2   (:monster, :create)            POST    /monster/create
3   (:sort, :name)                  GET    /sort/name
4   (:sort, :power)                 GET    /sort/power
5   (:sort, :type)                  GET    /sort/type
6   (:sort, :weakness)              GET    /sort/weakness
7   (:team, :add)                  POST    /team/add
8   (:team, :delete_from_team)     POST    /team/delete_from_team
9   (:team, :delete)               POST    /team/delete
10  (:user, :register)             POST    /user/register
```
1. `curl -i -X GET '127.0.0.1:3000/monster/list'`
2. `curl -i -X POST -H "Content-Type: application/json" -d "{\"name\": \"most_powerful_monster\", \"power\": \"100\", \"type\": \"electric\"}" "127.0.0.1:3000/monster/create"`
3. `curl -i -X GET '127.0.0.1:3000/sort/name?user_id=5&order=desc'`
4. `curl -i -X GET '127.0.0.1:3000/sort/power?user_id=5&order=asc'`
5. `curl -i -X GET '127.0.0.1:3000/sort/type?user_id=5&order=desc'`
6. `curl -i -X GET '127.0.0.1:3000/sort/weakness?user_id=5&order=desc'`
7. `curl -i -X POST -H "Content-Type: application/json" -d "{\"username\": \"a_test_user\", \"password\":\"sample_password\", \"monster_id\":\"4\"}" "127.0.0.1:3000/team/add"`
8. `curl -i -X POST -H "Content-Type: application/json" -d "{\"username\": \"example_email\", \"password\":\"example_password\", \"monster_id\":\"1\"}" "127.0.0.1/team/delete_from_team"`
9. `curl -i -X POST -H "Content-Type: application/json" -d "{\"username\": \"example_email\", \"password\":\"example_password\", \"monster_id\":\"1\"}" "127.0.0.1/team/delete"`
10. `curl -i -X POST -H "Content-Type: application/json" -d "{\"username\": \"username\", \"password\":\"password\"}" "127.0.0.1:3000/user/register"`

## Running, registering, adding, deleting an sorting
- First, register by using the `/user/register` endpoint - an id will be returned which is used for GET requests
- Create a monster by using the `/monster/create` endpoint like in the example above - an id will be returned which is used for all requests involving adding/deleting monsters
- To add a monster to your team, hit the `/team/add` endpoint with the proper username, password, and monster_id. *You can only have and own one monster of the same ID at any time*. If all teams are full but you have not eclipsed the 20 monster limit, the monster will be placed in your owned_monsters array.
- To delete a monster, hit the `/team/delete` endpoint - this will also delete from the owned_monsters. *If anything goes wrong when using `/team/delete_from_team`, hit this endpoint again with the monster_id you wish to delete* Hitting the `/team/delete_from_team` endpoint will **NOT** delete from owned_monsters
- Sort your monsters by using any of the `/sort` endpoints, the **ONLY** valid orders are the strings `asc` or `desc` these are *case sensitive, so be sure of it!*

## RSpec Tests Notes
- I tried my best to have DatabaseCleaner clean after each run but it doesn't seem to do it - so you can't run any tests indivudally. Every test relies on each other for proper ID matching. Ideally this wouldn't be there (since I've used DatabaseCleaner before and never had this issue) but I don't want to spend too much time on this and would rather show you my solution!
