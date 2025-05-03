from django.db import models
from django.contrib.auth.models import AbstractUser

class User(AbstractUser):
    city = models.CharField(max_length=100, blank=True, null=True)
    is_entrepreneur = models.BooleanField(default=False)
    is_investor = models.BooleanField(default=False)
    is_mentor = models.BooleanField(default=False)

class Survey(models.Model):
    entrepreneur = models.ForeignKey(User, on_delete=models.CASCADE, related_name='surveys')
    title = models.CharField(max_length=255)
    google_form_url = models.URLField()
    target_city = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)

class SurveyResponse(models.Model):
    survey = models.ForeignKey(Survey, on_delete=models.CASCADE, related_name='responses')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    response_data = models.JSONField()
    submitted_at = models.DateTimeField(auto_now_add=True)

class Reward(models.Model):
    survey = models.ForeignKey(Survey, on_delete=models.CASCADE, related_name='rewards')
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    reward_description = models.CharField(max_length=255)
    redeemed = models.BooleanField(default=False)
    redeemed_at = models.DateTimeField(blank=True, null=True)
