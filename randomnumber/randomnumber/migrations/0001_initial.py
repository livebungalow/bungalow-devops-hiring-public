# Generated by Django 4.0.4 on 2022-05-11 17:52

import django.utils.timezone
from django.db import migrations, models

import randomnumber.models


class Migration(migrations.Migration):

    initial = True

    dependencies = []

    operations = [
        migrations.CreateModel(
            name="RandomNumber",
            fields=[
                (
                    "id",
                    models.BigAutoField(
                        auto_created=True,
                        primary_key=True,
                        serialize=False,
                        verbose_name="ID",
                    ),
                ),
                (
                    "number",
                    models.PositiveBigIntegerField(
                        default=randomnumber.models.RandomNumber.get_random_number
                    ),
                ),
                ("created_at", models.DateTimeField(default=django.utils.timezone.now)),
            ],
        ),
    ]
