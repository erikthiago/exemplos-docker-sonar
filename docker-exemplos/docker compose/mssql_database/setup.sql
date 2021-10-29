IF db_id('sonar') IS NULL 
    CREATE DATABASE sonar COLLATE SQL_Latin1_General_CP1_CS_AS
GO

ALTER DATABASE sonar SET READ_COMMITTED_SNAPSHOT ON WITH ROLLBACK IMMEDIATE;
SELECT is_read_committed_snapshot_on FROM sys.databases WHERE name='sonar';

USE sonar
GO

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'SonarSchema')
  BEGIN
    EXEC ('CREATE SCHEMA SonarSchema;');
  END;

IF NOT EXISTS (SELECT name FROM master.sys.server_principals WHERE name = 'sonarUser')
  BEGIN
    CREATE LOGIN sonarUser WITH PASSWORD = N'<suaSenha>6'
  END

CREATE USER sonarUser FOR LOGIN sonarUser;
GRANT CONTROL ON SCHEMA::SonarSchema TO sonarUser;
ALTER USER sonarUser WITH DEFAULT_SCHEMA = SonarSchema;
GRANT CONTROL ON DATABASE::sonar TO sonarUser;