install:
	pip install --upgrade pip &&\
	pip install -r requirements.txt

format:
	black *.py

train:
	python train.py

eval:
	echo "## Model Metrics" > report.md
	cat ./Results/metrics.txt >> report.md
	echo '\n## Confusion Matrix Plot' >> report.md
	echo '![Confusion Matrix](./Results/model_results.png)' >> report.md
	cml comment create report.md

update-branch:
	git config --global user.name $(USER_NAME)
	git config --global user.email $(USER_EMAIL)
	git commit -am "Update with new results"
	git push --force origin HEAD:update

hf-login:
	git pull origin update
	git switch update
	pip install -U huggingface_hub

push-hub:
	python -c "from huggingface_hub import HfApi; HfApi(token='$(HF)').upload_folder(folder_path='./App', repo_id='tavi33/Drug-Classifiaction', repo_type='space', commit_message='Sync App files')"
	python -c "from huggingface_hub import HfApi; HfApi(token='$(HF)').upload_folder(folder_path='./Model', repo_id='tavi33/Drug-Classifiaction', repo_type='space', path_in_repo='Model', commit_message='Sync Model')"
	python -c "from huggingface_hub import HfApi; HfApi(token='$(HF)').upload_folder(folder_path='./Results', repo_id='tavi33/Drug-Classifiaction', repo_type='space', path_in_repo='Metrics', commit_message='Sync Results')"

deploy: hf-login push-hub