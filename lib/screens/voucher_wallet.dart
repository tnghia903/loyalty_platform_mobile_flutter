import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loyalty_platform_mobile_flutter/datas/voucher_wallet.dart';
import 'package:loyalty_platform_mobile_flutter/object/voucher_wallet.dart';

class VoucherWallet extends StatelessWidget {
  const VoucherWallet({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    List<VoucherWalletObject> wallet = getListVocherWallet();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text('Ví Voucher'),
      ),
      body: Container(
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
                itemCount: wallet.length,
                itemBuilder: (BuildContext context, int index) {
                  return _buildCardVoucher(size, wallet[index]);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCardVoucher(Size size, VoucherWalletObject wallet) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.all(10),
      height: size.height * 0.14,
      width: size.width * 10,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            width: size.width * 0.3,
            decoration: const BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: Color.fromARGB(255, 226, 226, 226),
                  width: 1,
                ),
              ),
            ),
            child: Image.asset(wallet.image),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            width: size.width * 0.65,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    wallet.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.width * 0.04,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 32),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      wallet.deadline,
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
    );
  }
}
