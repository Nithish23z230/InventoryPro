from django.contrib import admin
from .models import User, Survey, SurveyResponse, Reward

admin.site.register(User)
admin.site.register(Survey)
admin.site.register(SurveyResponse)
admin.site.register(Reward)
