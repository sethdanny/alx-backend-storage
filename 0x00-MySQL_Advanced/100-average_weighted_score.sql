--create proceedure to compute average weighted score for user
CREATE PROCEDURE ComputeAverageWeightedScoreForUser (IN user_id INT)
BEGIN
  DECLARE total_score FLOAT;
  DECLARE total_weight INT;

  SELECT SUM(score * weight) INTO total_score
  FROM corrections
  WHERE user_id = user_id;

  SELECT SUM(weight) INTO total_weight
  FROM projects;

  UPDATE users
  SET average_score = total_score / total_weight
  WHERE id = user_id;
END;

