-- Create the stored procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageWeightedScoreForUser(IN user_id INT)
BEGIN
  DECLARE total_score DECIMAL(10, 2);
  DECLARE total_weight DECIMAL(10, 2);
  DECLARE weighted_average DECIMAL(10, 2);

  -- Calculate the total score and total weight for the user
  SELECT SUM(c.score * p.weight) INTO total_score, SUM(p.weight) INTO total_weight
  FROM corrections c
  JOIN projects p ON c.project_id = p.id
  WHERE c.user_id = user_id;

  -- Calculate the weighted average
  SET weighted_average = total_score / total_weight;

  -- Update the average_score column in the users table
  UPDATE users SET average_score = weighted_average WHERE id = user_id;
END //

DELIMITER ;

