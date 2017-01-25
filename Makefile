prod:
	opzworks berks whosonfirst::prod::us-east -u -c whosonfirst_data

dev:
	opzworks berks whosonfirst::dev::us-east -u -c whosonfirst_data

stacks: dev prod
