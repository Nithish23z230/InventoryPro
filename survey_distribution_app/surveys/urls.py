from django.urls import path
from . import views

urlpatterns = [
    path('create/', views.create_survey, name='create_survey'),
    path('city/<str:city>/', views.get_surveys_for_city, name='get_surveys_for_city'),
    path('submit_response/', views.submit_survey_response, name='submit_survey_response'),
]
