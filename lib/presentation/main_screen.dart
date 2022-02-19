import 'package:flutter/material.dart';
import 'package:flutter_data_layer_sample/data/repository/asset_repository.dart';
import 'package:flutter_data_layer_sample/domain/asset.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data layer sample')),
      body: FutureBuilder<List<Asset>>(
        future: Provider.of<AssetRepository>(context).getAssets(),
        builder: (BuildContext context, AsyncSnapshot<List<Asset>> snapshot) {
          if (snapshot.hasData) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final asset = snapshot.data![index];
                final StringBuffer buffer = StringBuffer();

                if (asset.supply != null) {
                  buffer.write('Supply: ${asset.supply!.toStringAsFixed(2)}');

                  if (asset.maxSupply != null) {
                    buffer.write(
                      ' / Max supply: ${asset.maxSupply!.toStringAsFixed(2)}',
                    );
                  }
                }

                return ListTile(
                  leading: Text(
                    asset.symbol,
                    style: const TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  title: Text(asset.name),
                  subtitle: Text(buffer.toString()),
                  trailing: Text('\$${asset.priceUsd.toStringAsFixed(2)}'),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
              itemCount: snapshot.data!.length,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
