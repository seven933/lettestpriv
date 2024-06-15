/**
* @author Giovane Neves
* Classe que recebe dados que serão usados para gerar um cobrança pix.
*/
class CreatePixPaymentModel{

	double transactionAmount;
	
	CreatePixPaymentModel({required this.transactionAmount});

	factory CreatePixPaymentModel.fromJson(Map<String, dynamic> json) {
	    return CreatePixPaymentModel(
	      transactionAmount: json['transaction_amount'],
	    );
	}

	Map<String, dynamic> toJson() {
    	return {
      		'transaction_amount': transactionAmount,
    	};
  	}


}