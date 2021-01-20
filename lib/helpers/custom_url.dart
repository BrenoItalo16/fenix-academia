import 'package:url_launcher/url_launcher.dart';

whatsapp() async {
  const whatsappUrl =
      "whatsapp://send?phone=+5584996641848&text=Olá, tudo bem?";

  if (await canLaunch(whatsappUrl)) {
    await launch(whatsappUrl);
  } else {
    throw 'Could not launch $whatsappUrl';
  }
}

openMap() async {
  const urlMap =
      "https://www.google.com/maps/search/?api=1&query=-5.517906,-36.862493";
  if (await canLaunch(urlMap)) {
    await launch(urlMap);
  } else {
    throw 'Could not launch Maps';
  }
}

customCall() async {
  const url = "tel:84996641848";
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
