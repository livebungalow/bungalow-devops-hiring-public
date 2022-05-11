from .models import RandomNumber


def get_random_number() -> RandomNumber:
    return RandomNumber.objects.create()
