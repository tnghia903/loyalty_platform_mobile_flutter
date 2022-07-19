import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loyalty_platform_mobile_flutter/services/voucher_wallet_service.dart';

class VoucherWallet extends StatelessWidget {
  const VoucherWallet({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: const Text('Ví Voucher'),
        ),
        body: FutureBuilder(
          future: VoucherWalletService().getVoucherWallets(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return snapshot.hasData
                ? Container(
                    height: double.infinity,
                    color: const Color.fromARGB(255, 240, 240, 240),
                    child: SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Sắp hết hạn',
                                style: TextStyle(
                                  fontSize: size.width * 0.06,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: (snapshot.data! as List).length,
                            itemBuilder: (BuildContext context, int index) {
                              return _buildCardVoucher(context, size,
                                  (snapshot.data! as List)[index]);
                            },
                          )
                        ],
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(),
                  );
          },
        ));
  }

  Widget _buildCardVoucher(BuildContext context, Size size, wallet) {
    // DateTime now = DateTime.now();
    // DateTime date = DateTime(now.year, now.month, now.day);
    // DateTime expirationDateString =
    DateTime expirationDate =
        DateFormat('yyyy/MM/dd').parse(wallet['expirationDate']);

    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String expirationDateFormatted = formatter.format(expirationDate);

    // final expirationDate = expirationDateString.difference(date).inDays;

    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          useRootNavigator: true,
          isScrollControlled: true,
          context: context,
          builder: (BuildContext context) {
            return FractionallySizedBox(
              heightFactor: 0.7,
              child: _buildVoucherDetails(context, size, wallet),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(10),
        height: size.height * .14,
        width: size.width * .9,
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: size.width * 0.3,
              decoration: const BoxDecoration(
                border: Border(
                  right: BorderSide(
                    color: Color.fromARGB(255, 194, 194, 194),
                    width: 1,
                  ),
                ),
              ),
              child: Image.network(wallet['image']),
            ),
            Container(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 8),
              width: size.width * .62,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      wallet['description'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: size.width * 0.04,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hết hạn ngày ${expirationDateFormatted.toString()}',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: size.width * 0.035,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVoucherDetails(BuildContext context, Size size, wallet) {
    DateTime expirationDate =
        DateFormat('yyyy/MM/dd').parse(wallet['expirationDate']);

    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String expirationDateFormatted = formatter.format(expirationDate);
    return CustomScrollView(
      slivers: [
        SliverOpacity(
          alwaysIncludeSemantics: true,
          opacity: 0.5,
          sliver: SliverAppBar(
            expandedHeight: 25,
            collapsedHeight: 45,
            toolbarHeight: 45,
            elevation: 0,
            pinned: true,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.cancel_outlined),
                  color: Colors.black,
                ),
              ),
            ],
            floating: true,
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            width: size.width * 10,
            margin: const EdgeInsets.only(
              right: 18,
              left: 18,
            ),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(32),
                right: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              color: Colors.white,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Text(
                        'The Coffee House',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 32.0),
                      child: Text(
                        wallet['name'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                          width: 1, color: Color.fromARGB(255, 189, 189, 189)),
                    ),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 52,
                          left: 52,
                          right: 52,
                        ),
                        child: BarcodeWidget(
                          textPadding: 18,
                          data: wallet['voucherCode'],
                          barcode: Barcode.code128(),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Clipboard.setData(
                            ClipboardData(
                              text: wallet['voucherCode'],
                            ),
                          );
                        },
                        child: const Text('Sao chép'),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 32,
                          horizontal: 32,
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        decoration: const BoxDecoration(
                          border: Border(
                            top: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 212, 212),
                            ),
                            bottom: BorderSide(
                              width: 1,
                              color: Color.fromARGB(255, 212, 212, 212),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Ngày hết hạn:'),
                            Text(
                              expirationDateFormatted.toString(),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 12.0,
                          bottom: 32,
                          left: 12,
                          right: 12,
                        ),
                        child: Text(
                          wallet['description'],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
