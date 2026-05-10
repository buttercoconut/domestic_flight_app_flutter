import pytest
from fastapi.testclient import TestClient
from ..main import app

client = TestClient(app)

def test_health_check():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "ok"}

def test_search_flights():
    response = client.get("/flights/search", params={"departure": "ICN", "arrival": "GMP", "date": "2024-05-20"})
    assert response.status_code == 200
    data = response.json()
    assert isinstance(data, list)
    assert len(data) > 0
    assert data[0]["flight_number"] == "SK123"

def test_create_reservation():
    payload = {
        "flight_number": "SK123",
        "passenger_name": "John Doe",
        "seat": "12A",
        "payment_token": "tok_123",
    }
    response = client.post("/reservations/create", json=payload)
    assert response.status_code == 200
    data = response.json()
    assert data["status"] == "confirmed"
    assert "reservation_id" in data
