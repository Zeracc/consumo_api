import 'package:api/data/http/http_client.dart';
import 'package:api/data/repositories/api_repository.dart';
import 'package:api/stores/layout_store.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final LayoutStore store = 
  LayoutStore(repository: ApiRepository(
    client: HttpClient()
    ),
  );

  @override
  void initState(){
    super.initState();
    store.getApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consumo de api'),
      ),
      body: AnimatedBuilder(
        animation: Listenable.merge([store.isLoading, store.erro, store.state]),
        builder: (context, child) {
          if (store.isLoading.value){
            return const CircularProgressIndicator();
          }

          if (store.erro.value.isNotEmpty){
            return Center(
              child: Text(
                store.erro.value,
                style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                textAlign:TextAlign.center,
              ),
            );
          }

          if (store.state.value.isEmpty){
            return const Center(
              child: Text('Nenhum item na lista', 
              style: TextStyle(
                color: Colors.black54,
                fontSize: 20,
                ),
                textAlign: TextAlign.center,
                ),
            );
          } else {
            return ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(
                height: 32,
              ),
              padding: const EdgeInsets.all(16),
              itemCount: store.state.value.length,
              itemBuilder: (_, index) {
                final item = store.state.value[index];
                return Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        item.name,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.style),
                          Text(item.color),
                      ]),
                    ),
                  ],
                );
              },
            );
          }
        
        },
      ),
    );
  }
}












