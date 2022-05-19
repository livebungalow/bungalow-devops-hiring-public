import random

from django.db import models
from django.utils.timezone import now


class RandomNumber(models.Model):
    def get_random_number() -> int:
        return random.getrandbits(random.randint(61, 64))

    number = models.PositiveBigIntegerField(default=get_random_number)
    created_at = models.DateTimeField(default=now)

    def __str__(self):
        return f"{self.number} (f{self.created_at})"
