from .models import RandomNumber
from socket import gethostname


def get_random_number() -> RandomNumber:
    return RandomNumber.objects.create()


def get_host() -> str:
    return str(gethostname())
