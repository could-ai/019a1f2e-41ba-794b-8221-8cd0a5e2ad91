import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Seat {
  final int seatNumber;
  bool isBooked;

  Seat({required this.seatNumber, this.isBooked = false});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Awdesh Yadav Library',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const LibraryHomePage(),
    );
  }
}

class LibraryHomePage extends StatefulWidget {
  const LibraryHomePage({super.key});

  @override
  State<LibraryHomePage> createState() => _LibraryHomePageState();
}

class _LibraryHomePageState extends State<LibraryHomePage> {
  final int totalSeats = 80;
  late List<Seat> seats;

  @override
  void initState() {
    super.initState();
    seats = List.generate(totalSeats, (index) => Seat(seatNumber: index + 1));
  }

  int get availableSeats => seats.where((seat) => !seat.isBooked).length;

  void _toggleSeatBooking(int seatIndex) {
    setState(() {
      seats[seatIndex].isBooked = !seats[seatIndex].isBooked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awdesh Yadav Library'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(30.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Owner: Awdesh Yadav | Available Seats: $availableSeats / $totalSeats',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: seats.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 8,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemBuilder: (context, index) {
                  final seat = seats[index];
                  return InkWell(
                    onTap: () => _toggleSeatBooking(index),
                    child: SeatWidget(seat: seat),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.green.shade200,
                    ),
                    const SizedBox(width: 8),
                    const Text('Available'),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      color: Colors.red.shade200,
                    ),
                    const SizedBox(width: 8),
                    const Text('Booked'),
                  ],
                ),
              ],
            ),
             const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class SeatWidget extends StatelessWidget {
  final Seat seat;

  const SeatWidget({super.key, required this.seat});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: seat.isBooked ? Colors.red.shade200 : Colors.green.shade200,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: seat.isBooked ? Colors.red : Colors.green,
          width: 2,
        ),
      ),
      child: Center(
        child: Text(
          seat.seatNumber.toString(),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
