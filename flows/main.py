from tasks.adders import print_t2
from tasks.tracker import see_behavior
from prefect import flow

@flow(
log_prints=True
)
def run_demo():
    print("Helll-oooo")
    print_t2()
    see_behavior()

if __name__ == "__main__":
    run_demo()