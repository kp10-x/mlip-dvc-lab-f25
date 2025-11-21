dvc-init:
	dvc init

dvc-exp:
	dvc exp run -S train.n_estimators=50 -S train.max_depth=5
	dvc exp run -S train.n_estimators=10 -S train.max_depth=1
	dvc exp run -S train.n_estimators=200 -S train.max_depth=12

dvc-exp-show:
	dvc exp show --no-pager

dvc-apply:
	dvc exp apply ${EXP_NAME}

dvc-push:
	dvc exp push origin ${EXP_NAME}