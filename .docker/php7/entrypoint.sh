#!/bin/bash
if [ ! -f "web/admin/cli/cron.php" ]; then
    git clone --progress -b "${MOODLE_VERSION}" --single-branch --depth 1 -j 4 git://git.moodle.org/moodle.git /tmp/moodle
    rsync -r /tmp/moodle/ web
    rm -rf /tmp/moodle
    cp web/config-dist.php web/config.php
    sed -i "s/\$CFG->dbhost    = 'localhost';/\$CFG->dbhost    = 'db';/g" web/config.php
    sed -i "s/\$CFG->dbname    = 'moodle';/\$CFG->dbname    = '$POSTGRES_DB';/g" web/config.php
    sed -i "s/\$CFG->dbuser    = 'username';/\$CFG->dbuser    = '$POSTGRES_USER';/g" web/config.php
    sed -i "s/\$CFG->dbpass    = 'password';/\$CFG->dbpass    = '$POSTGRES_PASSWORD';/g" web/config.php
    sed -i "s@\$CFG->wwwroot   = 'http://example.com/moodle';@\$CFG->wwwroot   = '$BASE_URL';@g" web/config.php
    sed -i "s@\$CFG->dataroot  = '/home/example/moodledata';@\$CFG->dataroot  = '$DATA_PATH';@g" web/config.php
    mkdir $DATA_PATH
    chown -R www-data:www-data $DATA_PATH
fi
php-fpm
