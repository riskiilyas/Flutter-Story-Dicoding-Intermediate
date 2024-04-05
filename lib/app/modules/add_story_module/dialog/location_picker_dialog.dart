import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationPickerDialog extends StatefulWidget {
  final LatLng? initialPosition;

  const LocationPickerDialog({super.key, this.initialPosition});

  @override
  LocationPickerDialogState createState() => LocationPickerDialogState();
}

class LocationPickerDialogState extends State<LocationPickerDialog> {
  GoogleMapController? _mapController;
  LatLng? _pickedLocation;
  Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Pick Location'),
      content: SizedBox(
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        child: GoogleMap(
          markers: _markers,
          initialCameraPosition: CameraPosition(
            target:
                _pickedLocation ?? widget.initialPosition ?? const LatLng(0, 0),
            zoom: 12,
          ),
          onTap: (LatLng latLng) {
            setState(() {
              _pickedLocation = latLng;
              _markers = {
                Marker(
                  markerId: const MarkerId('picked_location'),
                  position: latLng,
                  onTap: () {
                    _mapController?.animateCamera(
                      CameraUpdate.newLatLngZoom(latLng, 18),
                    );
                  },
                ),
              };
            });
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: () async {
            Get.back(result: widget.initialPosition);
          },
          child: const Text('Use Current Location'),
        ),
        TextButton(
          onPressed: () {
            Get.back(result: _pickedLocation);
          },
          child: const Text('Select'),
        ),
      ],
    );
  }
}
