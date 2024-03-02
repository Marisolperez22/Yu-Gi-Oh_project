import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:ygo_project/providers/api_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final scrollController = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    final apiProvider = Provider.of<ApiProvider>(context, listen: false);
    apiProvider.getCards();
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          isLoading = true;
        });
        await apiProvider.getCards();
        setState(() {
          isLoading = false; // Corregir: Cambiado de true a false
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Yu-Gi-Oh!',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              context.go('archetypes');
            },
            child: const Icon(
              Icons.animation,
              size: 30,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: apiProvider.cards.isNotEmpty
              ? CardList(
                  scrollController: scrollController,
                  isLoading: isLoading,
                  apiProvider: apiProvider,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}

class CardList extends StatelessWidget {
  const CardList({
    Key? key,
    required this.apiProvider,
    required this.scrollController,
    required this.isLoading,
  }) : super(key: key);

  final ApiProvider apiProvider;
  final ScrollController scrollController;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final filteredCards =
        apiProvider.cards.where((card) => card.banlistInfo == null).toList();

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.87,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final card = filteredCards[index];
              return GestureDetector(
                onTap: () {
                  context.go('/card', extra: card);
                },
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              color: Colors.white,
                              width: 10), // Borde en la parte superior
                          left: BorderSide(
                              color: Colors.white,
                              width: 10), // Borde en el lado izquierdo
                          right: BorderSide(
                              color: Colors.white,
                              width: 10), // Borde en el lado derecho
                        ),
                      ),
                      child: Hero(
                        tag: card.id!,
                        child: FadeInImage(
                          height: 180,
                          width: 180,
                          fit: BoxFit.cover,
                          placeholder:
                              const AssetImage('assets/images/loading.gif'),
                          image: NetworkImage(
                              card.cardImages![0].imageUrlCropped.toString()),
                        ),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          card.name!,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            childCount: filteredCards.length,
          ),
        ),
        if (isLoading)
          const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
