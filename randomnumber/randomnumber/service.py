from socket import gethostname

from .models import RandomNumber


def get_random_number() -> RandomNumber:
    return RandomNumber.objects.create()


def get_host() -> str:
    return str(gethostname())
