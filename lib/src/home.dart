import 'package:flutter/material.dart';
import 'package:mymoney_app/src/state_management/card_carousel_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CardCarouselState(),
      child: Column(
        children: <Widget>[
          CardCarousel(),
          SizedBox(height: 20),
          Text(
            "Transactions",
            style: TextStyle(fontSize: 20),
          ),
          Expanded(
            child: ExpensesList(),
          ),
        ],
      ),
    );
  }
}

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<CardCarouselState>(
      builder: (context, state, _) => PageView(
        controller: state.expensePageController,
        children: <Widget>[
          Text('Cartao 1'),
          Text('Cartao 2'),
          Text('Cartao 3'),
        ],
      ),
    );
  }
}

class CardCarousel extends StatelessWidget {
  const CardCarousel({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = Provider.of<CardCarouselState>(context);

    return Container(
      height: 145.0,
      child: PageView(
        onPageChanged: (index) {
          print(index);
          state.currentCard = index.toDouble();
        },
        controller: PageController(viewportFraction: 0.8),
        scrollDirection: Axis.horizontal,
        pageSnapping: true,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/Nubank.png'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/Santander.png'),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image(
                fit: BoxFit.fill,
                image: AssetImage('assets/images/Ticket.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
