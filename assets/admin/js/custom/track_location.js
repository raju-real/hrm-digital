(function ($) {
    "use strict";

    class LocationTrackingMap {
        constructor() {
            this.map = null;
            this.markers = [];
            this.checkInData = null;
            this.checkOutData = null;
            this.employeeName = "";

            this.init();
        }

        init() {
            const dataContainer = $("#location-data");
            if (!dataContainer.length) {
                return;
            }

            // Get data from individual attributes
            this.checkInData = {
                latitude: dataContainer.data("check-in-lat"),
                longitude: dataContainer.data("check-in-lng"),
                punch_time: dataContainer.data("check-in-time"),
            };

            this.checkOutData = {
                latitude: dataContainer.data("check-out-lat"),
                longitude: dataContainer.data("check-out-lng"),
                punch_time: dataContainer.data("check-out-time"),
            };

            this.employeeName =
                dataContainer.data("employee-name") || "Employee";

            if (!this.checkInData.latitude || !this.checkInData.longitude) {
                console.error("No valid check-in location data found");
                return;
            }

            this.initializeMap();
            this.addMarkers();
            this.adjustMapView();
        }

        initializeMap() {
            const checkInLat = parseFloat(this.checkInData.latitude);
            const checkInLng = parseFloat(this.checkInData.longitude);

            if (isNaN(checkInLat) || isNaN(checkInLng)) {
                console.error("Invalid check-in coordinates");
                return;
            }

            this.map = L.map("locationMap").setView(
                [checkInLat, checkInLng],
                16
            );

            L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
                attribution: "&copy; OpenStreetMap contributors",
                maxZoom: 19,
            }).addTo(this.map);
        }

        addMarkers() {
            this.addCheckInMarker();

            if (this.hasValidCheckOutData()) {
                this.addCheckOutMarker();
            }
        }

        addCheckInMarker() {
            const lat = parseFloat(this.checkInData.latitude);
            const lng = parseFloat(this.checkInData.longitude);
            const checkInTime = this.formatTime(this.checkInData.punch_time);

            // Create green icon for check-in
            const greenIcon = new L.Icon({
                iconUrl:
                    "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png",
                shadowUrl:
                    "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png",
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34],
                shadowSize: [41, 41],
            });

            const checkInMarker = L.marker([lat, lng], {
                icon: greenIcon,
            }).addTo(this.map);

            checkInMarker.bindPopup(`
                <div class="text-center">
                    <i class="fas fa-user-check fa-2x text-success mb-2"></i>
                    <h6 class="fw-bold text-success">Check-in Location</h6>
                    <p class="mb-1"><strong>Employee:</strong> ${this.employeeName}</p>
                    <p class="mb-1"><strong>Time:</strong> ${checkInTime}</p>
                    <p class="mb-0"><strong>Coordinates:</strong><br>${lat.toFixed(6)}, ${lng.toFixed(6)}</p>
                </div>
            `);

            this.markers.push(checkInMarker);
        }

        addCheckOutMarker() {
            const lat = parseFloat(this.checkOutData.latitude);
            const lng = parseFloat(this.checkOutData.longitude);
            const checkOutTime = this.formatTime(this.checkOutData.punch_time);

            // Create orange icon for check-out
            const orangeIcon = new L.Icon({
                iconUrl:
                    "https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-orange.png",
                shadowUrl:
                    "https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png",
                iconSize: [25, 41],
                iconAnchor: [12, 41],
                popupAnchor: [1, -34],
                shadowSize: [41, 41],
            });

            const checkOutMarker = L.marker([lat, lng], {
                icon: orangeIcon,
            }).addTo(this.map);

            checkOutMarker.bindPopup(`
                <div class="text-center">
                    <i class="fas fa-user-clock fa-2x text-warning mb-2"></i>
                    <h6 class="fw-bold text-warning">Check-out Location</h6>
                    <p class="mb-1"><strong>Employee:</strong> ${ this.employeeName}</p>
                    <p class="mb-1"><strong>Time:</strong> ${checkOutTime}</p>
                    <p class="mb-0"><strong>Coordinates:</strong><br>${lat.toFixed(6)}, ${lng.toFixed(6)}</p>
                </div>
            `);

            this.markers.push(checkOutMarker);
        }

        adjustMapView() {
            if (this.markers.length === 0) return;

            if (this.markers.length === 1) {
                const marker = this.markers[0];
                this.map.setView(marker.getLatLng(), 16);
            } else {
                const group = L.featureGroup(this.markers);
                this.map.fitBounds(group.getBounds().pad(0.1));
            }
        }

        hasValidCheckOutData() {
            return (
                this.checkOutData &&
                this.checkOutData.latitude &&
                this.checkOutData.longitude
            );
        }

        formatTime(dateTimeString) {
            const date = new Date(dateTimeString);
            return date.toLocaleTimeString("en-US", {
                hour: "2-digit",
                minute: "2-digit",
                hour12: true,
            });
        }
    }

    // Initialize when document is ready
    $(document).ready(function () {
        new LocationTrackingMap();
    });
})(jQuery);
