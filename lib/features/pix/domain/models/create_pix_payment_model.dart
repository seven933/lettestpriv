/**
* @author Giovane Neves
* Classe que recebe dados que serão usados para gerar um cobrança pix.
*/
class CreatePixPaymentModel{

	double transactionAmount;
	String userCpf;

	CreatePixPaymentModel({required this.transactionAmount, required this.userCpf});

	factory CreatePixPaymentModel.fromJson(Map<String, dynamic> json) {
	    return CreatePixPaymentModel(
	      transactionAmount: json['transaction_amount'],
	      userCpf: json['user_cpf'],
	    );
	}

	Map<String, dynamic> toJson() {
    	return {
      		'transaction_amount': transactionAmount,
      		'user_cpf': userCpf,
    	};
  	}


}