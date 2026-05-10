import 'package:flutter/material.dart';
import '../models/airport.dart';

class AirportSearchField extends StatefulWidget {
  final List<Airport> airports;
  final void Function(String from, String to, DateTime date) onSearch;

  const AirportSearchField(
      {super.key, required this.airports, required this.onSearch});

  @override
  State<AirportSearchField> createState() => _AirportSearchFieldState();
}

class _AirportSearchFieldState extends State<AirportSearchField> {
  String? _from;
  String? _to;
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'From'),
                items: widget.airports
                    .map((a) => DropdownMenuItem(
                          value: a.code,
                          child: Text(a.name),
                        ))
                    .toList(),
                value: _from,
                onChanged: (v) => setState(() => _from = v),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'To'),
                items: widget.airports
                    .map((a) => DropdownMenuItem(
                          value: a.code,
                          child: Text(a.name),
                        ))
                    .toList(),
                value: _to,
                onChanged: (v) => setState(() => _to = v),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextFormField(
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Date'),
                controller: TextEditingController(
                    text: _date == null
                        ? ''
                        : '${_date!.year}-${_date!.month.toString().padLeft(2, '0')}-${_date!.day.toString().padLeft(2, '0')}'),
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setState(() => _date = picked);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              child: const Text('Search'),
              onPressed: () {
                if (_from != null && _to != null && _date != null) {
                  widget.onSearch(_from!, _to!, _date!);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
