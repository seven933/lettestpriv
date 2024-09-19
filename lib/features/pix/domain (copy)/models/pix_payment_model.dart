class PixPaymentModel{
	String randomPixKey;

	PixPaymentModel({required this.randomPixKey});

	factory PixPaymentModel.fromJson(Map<String, dynamic> json) {
	    return PixPaymentModel(
	      randomPixKey: json['pix_copia_e_cola'],
	    );
	}

  	Map<String, dynamic> toJson() {
    	return {
      		'pix_copia_e_cola': randomPixKey,
    	};
  	}

}