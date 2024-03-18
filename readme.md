# Deploying prefect

This demo is a simple poc where I'm testing out ideas for deploying prefect.

prefect is quite simple to get started with but you may need to bury your head in the docs for a little bit if you want to go
live with it on a production server. If you're thinking about deploying prefect on the cloud I suggest you start by studying the [work poll section](https://docs.prefect.io/latest/guides/#work-pools) in prefect how-to guide as it's very practical, intuitive, and well put together.

I think a neat way to manage your code should be:

- use git for [storage](https://docs.prefect.io/latest/guides/#work-pools) 

- manage your deployment [using the prefect.yaml file](https://docs.prefect.io/latest/guides/prefect-deploy/#working-with-multiple-deployments-with-prefectyaml)

- leverage prefect blocks as much as possible.

using work-pools for deployment means [you need infrastructure](https://docs.prefect.io/latest/guides/#work-pools) for your flow to be executed in

the overall idea with deploying prefect is that:

- you define your tasks and execute them within a flow

- create a deployment object based on your flow

- deployments can either be [work-pool-based](https://docs.prefect.io/latest/guides/prefect-deploy/#work-pool-based-deployments) or not require a work-pool

- you can use flow.serve() to start a server-styled deployment which will require dedicated infra that's always up. This won't require a work-pool

- you can use flow.deploy() to initiate a work-pool based deployment

- deployments that require a work-poolrequires that you associte your flow deployment to the workpool created


in this repo I have used a process-type workpool requiring a worker to manage my deployments but I think the [serverless infra approach](https://docs.prefect.io/latest/guides/deployment/serverless-workers/) is also very interesting and should be considered


## Organizing code

Prefect isn't opinionated which makes it easy to pick up and test ideas with but one of the most interesting challenge I faced with prefect was how to arrange my code. here, i have used a python package style approach defining a pyproject.toml file in the project root and install my project (executing `pip install -e .`) at the project root to ensure my changes are always hot-reloaded. i think the structure i followed here can still be improved upon (all things prefect related - tasks, flows should live in the same folder e.g etl/flows, etl/tasks, etl/hooks, etl/utils, etc.) but i have explored this structure to test out a few things!


my work was inspired by Mira Thidel article on creating [event driven serverless etl pipelines](https://www.prefect.io/blog/orchestrating-event-driven-serverless-data-pipelines-prefect-pulumi-aws)