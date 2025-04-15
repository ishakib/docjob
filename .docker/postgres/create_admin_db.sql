-- # Create second_db database if it doesnt exist
-- CREATE DATABASE IF NOT EXISTS revews_shopify_admin;
-- # Grant all privilidges on second_db to org_user
-- GRANT ALL ON root.* TO 'root'@'localhost';

CREATE DATABASE revews_admin
    WITH 
    OWNER = root
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

CREATE DATABASE revews_admin_app
    WITH 
    OWNER = root
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.utf8'
    LC_CTYPE = 'en_US.utf8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

