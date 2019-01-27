# Generated by Django 2.0.2 on 2018-07-24 16:22

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('backend', '0037_metaparam'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='event',
            name='poststate',
        ),
        migrations.RemoveField(
            model_name='event',
            name='prestate',
        ),
        migrations.AlterField(
            model_name='condition',
            name='comp',
            field=models.TextField(choices=[('eq', 'is'), ('neq', 'is not'), ('lt', 'is less than'), ('gt', 'is greater than')]),
        ),
        migrations.DeleteModel(
            name='Event',
        ),
    ]