from django.shortcuts import get_object_or_404
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth import get_user_model
from .models import Survey, SurveyResponse
import json

User = get_user_model()

@csrf_exempt
def create_survey(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        entrepreneur_id = data.get('entrepreneur_id')
        title = data.get('title')
        google_form_url = data.get('google_form_url')
        target_city = data.get('target_city')

        entrepreneur = get_object_or_404(User, id=entrepreneur_id, is_entrepreneur=True)
        survey = Survey.objects.create(
            entrepreneur=entrepreneur,
            title=title,
            google_form_url=google_form_url,
            target_city=target_city
        )
        return JsonResponse({'survey_id': survey.id, 'message': 'Survey created successfully'}, status=201)
    return JsonResponse({'error': 'Invalid request method'}, status=400)

def get_surveys_for_city(request, city):
    surveys = Survey.objects.filter(target_city__iexact=city)
    survey_list = [{
        'id': survey.id,
        'title': survey.title,
        'google_form_url': survey.google_form_url,
        'entrepreneur': survey.entrepreneur.username
    } for survey in surveys]
    return JsonResponse({'surveys': survey_list})

@csrf_exempt
def submit_survey_response(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        survey_id = data.get('survey_id')
        user_id = data.get('user_id')
        response_data = data.get('response_data')

        survey = get_object_or_404(Survey, id=survey_id)
        user = get_object_or_404(User, id=user_id)

        SurveyResponse.objects.create(
            survey=survey,
            user=user,
            response_data=response_data
        )
        return JsonResponse({'message': 'Response submitted successfully'}, status=201)
    return JsonResponse({'error': 'Invalid request method'}, status=400)
