import requests

letters = 'abcdefghijklmnopqrstuvwxyz'
avatar_bucket = 'http://action-files.parabol.co/static/avatars/'
variations = []

# Generate letter variations
for i in range(0, len(letters)):
	variations.append(letters[i])
	for j in range(0, len(letters)):
		variations.append('{}{}'.format(letters[i], letters[j]))

# Download avatars
for v in variations:
	filename = '{}{}'.format(v, '.png')
	url = '{}{}'.format(avatar_bucket, filename)
	path = '{}{}'.format('static/images/avatars/', filename)

	response = requests.get(url)
	open(path, "wb").write(response.content)
