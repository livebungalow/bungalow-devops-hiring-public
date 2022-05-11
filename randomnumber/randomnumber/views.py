from .service import get_random_number
from django.http import JsonResponse
from django.utils import timezone


def indexPageView(request):
    rn = get_random_number()
    output = {
        "Time": str(rn.created_at),
        "Number": rn.number,
    }

    return JsonResponse(output)
