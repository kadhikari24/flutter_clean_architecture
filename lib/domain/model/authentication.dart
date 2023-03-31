class Authentication {
  Customer? customer;

  Contacts? contacts;

  Authentication(this.customer, this.contacts);
}

class Customer {
  String id;
  String name;
  int? numberOfNotification;

  Customer(this.id, this.name, this.numberOfNotification);
}

class Contacts {
  String phone;

  String link;

  String email;

  Contacts(this.phone, this.link, this.email);
}
