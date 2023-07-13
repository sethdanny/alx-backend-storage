-- Create the stored procedure
CREATE PROCEDURE ComputeAverageWeightedScoreForUsers ()
BEGIN
  DECLARE total_score FLOAT;
  DECLARE total_weight INT;
  DECLARE user_id INT;

  SELECT COUNT(*) INTO user_id
  FROM users;

  -- Initialize total score and total weight
  SET total_score = 0;
  SET total_weight = 0;

  -- Iterate over all users
  FOR i IN 1..user_id
  DO
    -- Retrieve the total score for the user
    SELECT SUM(score * weight) INTO total_score
    FROM corrections
    WHERE user_id = i;

    -- Retrieve the total weight of all the projects
    SELECT SUM(weight) INTO total_weight
    FROM projects;

    -- Update the user's average score
    UPDATE users
    SET average_score = total_score / total_weight
    WHERE id = i;
  END FOR;
END;

