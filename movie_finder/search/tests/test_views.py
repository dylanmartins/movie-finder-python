import pytest
from simple_settings.utils import settings_stub


class TestSearchMovieView:

    async def test_post_return_data(self, client):
        url = '/search/'

        response = await client.post(url, json={})

        content = await response.json()
        assert content == {'data': 'OK'}
        assert response.status == 200
