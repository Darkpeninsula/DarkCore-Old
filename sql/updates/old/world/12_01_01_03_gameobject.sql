--Quest: Clean Up=12818
--Replaced old gameobject with correct gameobject
UPDATE gameobject SET id=191530 WHERE id BETWEEN 191531 AND 191534;

--Added more spawn
INSERT INTO gameobject VALUES
(NULL, 191530, 571, 1, 1, 6089.619141, -931.958923, 386.346954, 1.527429, 0, 0, 0, 0, 300, 100, 1),
(NULL, 191530, 571, 1, 1, 6084.938965, -995.411072, 400.874634, 4.573998, 0, 0, 0, 0, 300, 100, 1),
(NULL, 191530, 571, 1, 1, 6059.382324, -995.492554, 402.085327, 2.637206, 0, 0, 0, 0, 300, 100, 1),
(NULL, 191530, 571, 1, 1, 6045.041016, -963.099731, 397.947998, 1.336586, 0, 0, 0, 0, 300, 100, 1),
(NULL, 191530, 571, 1, 1, 6055.323730, -927.433228, 379.090363, 1.770911, 0, 0, 0, 0, 300, 100, 1),
(NULL, 191530, 571, 1, 1, 6138.116211, -962.460999, 397.833313, 4.374509, 0, 0, 0, 0, 300, 100, 1),
(NULL, 191530, 571, 1, 1, 6089.638672, -994.560486, 400.575867, 1.193643, 0, 0, 0, 0, 300, 100, 1);