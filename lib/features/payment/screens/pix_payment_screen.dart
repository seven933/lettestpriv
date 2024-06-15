import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/helper/route_helper.dart';

/**
* @author Giovane Neves
* Classe que exibe tela de pagamento do Pix.
*/
class PixPaymentScreen extends StatefulWidget {

  final String pixCode;
  final double amount;

  PixPaymentScreen({required this.pixCode, required this.amount});

  @override
  _PixPaymentScreenState createState() => _PixPaymentScreenState();
}

class _PixPaymentScreenState extends State<PixPaymentScreen> {

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pix_payment'.tr, style: TextStyle(color: Colors.white)),
        backgroundColor: Theme.of(context).primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Get.toNamed(RouteHelper.getInitialRoute(fromSplash: false));
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'now_it_is_time_to_do_the_PIX'.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 10),
            Text('here_is_your_payment_copy_and_paste_pix'.tr, style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Valor: R\$ ${widget.amount}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor)),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SelectableText(
                widget.pixCode,
                style: TextStyle(fontSize: 16, color: Theme.of(context).primaryColor),
                onTap: () {
                  Clipboard.setData(ClipboardData(text: widget.pixCode));
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Código copiado!')));
                },
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: widget.pixCode));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Código copiado!')));
              },
              icon: Icon(Icons.copy),
              label: Text(
                'COPIAR CÓDIGO',
                 style: TextStyle(color: Colors.white),
              ),

              style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 20),
            Text(
              'Instruções',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
            ),
            SizedBox(height: 10),
            instructionStep(context, 'Copie o código que geramos aqui acima'),
            instructionStep(context, 'Abra o app do seu banco, na seção PIX'),
            instructionStep(context, 'No app do seu banco vá na opção "PIX copia e cola" e cole o código que você copiou aqui'),
            instructionStep(context, 'Confirme o valor, e efetue o pagamento'),
            SizedBox(height: 20),
            Text(
              'OBS: O pagamento é confirmado na hora e o status do seu pedido mudará assim que for confirmado.',
              style: TextStyle(fontSize: 14, color: Theme.of(context).primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget instructionStep(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              '${text[0]}',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
