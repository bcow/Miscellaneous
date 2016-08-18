INSERT INTO metrics (name, description, citation_id) VALUES ('MSE', 'Mean Squared Error', 1000000001) RETURNING *;
INSERT INTO metrics (name, description, citation_id) VALUES ('MAE', 'Mean Absolute Error', 1000000001) RETURNING *;
INSERT INTO metrics (name, description, citation_id) VALUES ('AME', 'Absolute Maximum Error', 1000000001) RETURNING *;
INSERT INTO metrics (name, description, citation_id) VALUES ('RAE', 'Relative Absolute Error', 1000000001) RETURNING *;
INSERT INTO metrics (name, description, citation_id) VALUES ('PPMC', 'Pearson Product Moment Correlation', 1000000001) RETURNING *;
INSERT INTO metrics (name, description, citation_id) VALUES ('R2', 'Coefficient of Determination', 1000000001) RETURNING *;

INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000004, 1000000000);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000004, 1000000001);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000004, 1000000002);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000003, 1000000003);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000003, 1000000004);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000003, 1000000005);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000003, 1000000006);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000004, 1000000007);
INSERT INTO benchmarks_metrics (benchmark_id, metric_id) VALUES (1000000004, 1000000008);




bm2 <- db.query(paste(
  "INSERT INTO benchmarks (input_id, site_id, variable_id, created_at, updated_at)",
  "VALUES ( 1000000651 ,", workflow$site_id, ", 1000000046 , NOW(), NOW() ) RETURNING * "), con)
