from django.http import JsonResponse

from .service import get_host, get_random_number


def indexPageView(request):
    rn = get_random_number()
    output = {
        "Time": str(rn.created_at),
        "Number": rn.number,
    }
    response = JsonResponse(output, status=200)
    response["X-Origin-Server"] = get_host()

    return response
