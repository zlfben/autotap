# Generated by Django 2.0.2 on 2018-06-12 20:34

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0002_remove_state_dev'),
    ]

    operations = [
        migrations.AddField(
            model_name='state',
            name='dev',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.CASCADE, to='backend.Device'),
        ),
    ]