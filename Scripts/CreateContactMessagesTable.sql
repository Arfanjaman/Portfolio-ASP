-- SQL Script to create ContactMessages table

USE Portfolio;
GO

-- Create ContactMessages table
IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='ContactMessages' AND xtype='U')
BEGIN
    CREATE TABLE ContactMessages (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        Email NVARCHAR(255) NOT NULL,
        Message NVARCHAR(MAX) NOT NULL,
        SubmittedDate DATETIME NOT NULL DEFAULT GETDATE(),
        IsRead BIT NOT NULL DEFAULT 0,
        AdminNotes NVARCHAR(MAX) NULL
    );
    
    PRINT 'ContactMessages table created successfully.';
END
ELSE
BEGIN
    PRINT 'ContactMessages table already exists.';
END


-- View the table structure
SELECT * FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'ContactMessages';