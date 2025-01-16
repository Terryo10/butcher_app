import 'package:flutter/material.dart';

import '../../../../core/enums/dummy_order_status.dart';
import 'order_preview_tile.dart';

class RunningTab extends StatelessWidget {
  const RunningTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 8),
      children: [
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.confirmed,
          onTap: () {},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.processing,
          onTap: (){},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.shipped,
          onTap: (){},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.delivery,
          onTap: () {},
        ),
        OrderPreviewTile(
          orderID: '232425627',
          date: '25 Nov',
          status: OrderStatus.cancelled,
          onTap: (){},
        ),
      ],
    );
  }
}
