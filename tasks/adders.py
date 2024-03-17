from prefect import task

@task
def print_t2(x="t2"):
    print(f"{x} called")