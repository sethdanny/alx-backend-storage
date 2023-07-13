-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUsers()
BEGIN
  DECLARE user_cursor CURSOR FOR SELECT id FROM users;
  DECLARE current_user_id INT;

  -- Declare variables for calculations
  DECLARE total_score DECIMAL(10, 2);
  DECLARE total_weight DECIMAL(10, 2);
  DECLARE weighted_average DECIMAL(10, 2);

  -- Declare temporary table to hold results
  CREATE TEMPORARY TABLE IF NOT EXISTS temp_average_scores (
    user_id INT,
    average_score DECIMAL(10, 2)
  );

  -- Open the cursor
  OPEN user_cursor;

  -- Loop through each user
  user_loop: LOOP
    -- Fetch the next user id
    FETCH user_cursor INTO current_user_id;

    -- Exit loop if no more users
    IF current_user_id IS NULL THEN
      LEAVE user_loop;
    END IF;

    -- Calculate the total score and total weight for the user
    SELECT SUM(c.score * p.weight) INTO total_score, SUM(p.weight) INTO total_weight
    FROM corrections c
    JOIN projects p ON c.project_id = p.id
    WHERE c.user_id = current_user_id;

    -- Calculate the weighted average
    SET weighted_average = total_score / total_weight;

    -- Insert the user's average weighted score into the temporary table
    INSERT INTO temp_average_scores (user_id, average_score)
    VALUES (current_user_id, weighted_average);
  END LOOP;

  -- Close the cursor
  CLOSE user_cursor;

  -- Update the average_score column in the users table
  UPDATE users u
  JOIN temp_average_scores t ON u.id = t.user_id
  SET u.average_score = t.average_score;

  -- Drop the temporary table
  DROP TEMPORARY TABLE IF EXISTS temp_average_scores;
END //

DELIMITER ;

