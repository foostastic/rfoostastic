# Season change

1. Fetch the new season id from Foos API: https://suso.eu/foos/api/v1/seasons
2. Update the Foos season id for the Refresh job:
    $ heroku config:set SUSO_FOOS_API_SEASON=14
3. Create the new season in the DB, deactivate the current one
    $ heroku run rails c
    irb> s = Season.last; s.active = false; s.save
    irb> Season.create(id: Season.last.id + 1, name: "2018q2", foos_id: "14", active: true)
    irb> exit
3. Launch the refresh job manually to fetch the players and check everything works
    $ heroku run rails suso_refresh

