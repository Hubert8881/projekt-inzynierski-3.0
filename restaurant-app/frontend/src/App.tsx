import React from 'react';
import ReservationForm from './components/ReservationForm';
import AvailableTables from './components/AvailableTables';
import Map from './components/Map';
import './styles.css';

function App() {
  const restaurants = [
  {
    name: "Stół Polski",
    lat: 52.2154144,
    lon: 21.0205885,
    imageUrl: "https://imgproxy.restaurantclub.pl/VISINoEFAD-mcZcmqsEBwZSEUq8wz_L3Idkea1Bz0OY/rs:fit:900:900/plain/gs://cdn.restaurantclub.pl/store/b227c0bdcc384c678d74d7f9d561db33.jpg",
    description: "Nowoczesna restauracja z polską kuchnią w eleganckim wydaniu.",
    hours: "12:00 – 22:00"
  },
  {
    name: "VegeMiasto",
    lat: 52.2463696,
    lon: 21.0058193,
    imageUrl: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/14/56/34/84/ogrodek.jpg?w=900&h=-1&s=1",
    description: "Wegetariańska oaza w sercu Warszawy – zdrowo, świeżo i smacznie.",
    hours: "11:00 – 21:00"
  },
  {
    name: "Sakana Sushi",
    lat: 52.2438138,
    lon: 21.0119338,
    imageUrl: "https://sakana.pl/wp-content/uploads/2018/12/moliera_01.jpg",
    description: "Ekskluzywne sushi bar z autentyczną kuchnią japońską.",
    hours: "13:00 – 23:00"
  },
  {
    name: "Pod Wawelem",
    lat: 50.0546022,
    lon: 19.939342,
    imageUrl: "https://podwawelem.eu/images/slideshow/sl-planty.jpg",
    description: "Tradycyjna kuchnia polska w klimatycznym lokalu tuż przy Wawelu.",
    hours: "12:00 – 23:00"
  },
  {
    name: "Zielone Tarasy",
    lat: 50.0509253,
    lon: 19.9227223,
    imageUrl: "https://www.zielone-tarasy.eu/uploads/9fbQTTBg/ZieloneTarasy00037__msi___jpg.jpg",
    description: "Restauracja z dużym tarasem i widokiem, serwująca sezonowe dania.",
    hours: "10:00 – 20:00"
  },
  {
    name: "Nolio",
    lat: 50.0493698,
    lon: 19.9428644,
    imageUrl: "https://dynamic-media-cdn.tripadvisor.com/media/photo-o/09/93/50/ff/nolio.jpg?w=800&h=500&s=1",
    description: "Nowoczesna włoska kuchnia z piecem opalanym drewnem.",
    hours: "13:00 – 22:00"
  },
  {
    name: "Muga",
    lat: 52.4039736,
    lon: 16.9290364,
    imageUrl: "https://media-cdn.tripadvisor.com/media/photo-m/1280/1d/c0/0b/11/caption.jpg",
    description: "Restauracja fine dining w centrum Poznania – smaki Europy.",
    hours: "17:00 – 23:00"
  },
  {
    name: "Frontiera",
    lat: 52.4073496,
    lon: 16.9380317,
    imageUrl: "https://restaumatic-production.imgix.net/uploads/accounts/26983/media_library/611fca8e-b5c3-49a9-844d-99abc33e1a9c.jpg?auto=compress&crop=focalpoint&fit=max&h=auto&w=1920",
    description: "Pizza i kuchnia włoska w industrialnym, stylowym wnętrzu.",
    hours: "12:00 – 22:00"
  },
  {
    name: "Pierogarnia Stary Młyn",
    lat: 52.408827,
    lon: 16.934679,
    imageUrl: "https://www.pierogarnie.com/wp-content/uploads/2021/10/5.png",
    description: "Pierogi w dziesiątkach odsłon – klasyczne i nowoczesne smaki.",
    hours: "11:00 – 21:30"
  },
  {
    name: "Gvara",
    lat: 54.3496753,
    lon: 18.6485301,
    imageUrl: "https://www.pitupitu.pl/files/XxTeR2uKLAEVDGsIInkFAi5q-aA/coverBig",
    description: "Nowoczesna restauracja z lokalnym twistem w sercu Gdańska.",
    hours: "12:00 – 22:00"
  },
  {
    name: "Billy’s American Restaurant",
    lat: 54.3499121,
    lon: 18.6491786,
    imageUrl: "https://billys.com.pl/wp-content/uploads/2022/06/billys_forum_gdansk-7.jpg",
    description: "Amerykański klimat i klasyki kuchni USA – burgery, steki, żeberka.",
    hours: "11:30 – 22:00"
  },
  {
    name: "Mandu",
    lat: 54.3536682,
    lon: 18.6468446,
    imageUrl: "https://pierogarnia-mandu.pl/wp-content/uploads/2021/11/xlokal_gd_centrum.jpg.pagespeed.ic.b83gl8UoI3.jpg",
    description: "Pierogarnia z sercem – ręcznie robione pierogi z całego świata.",
    hours: "12:00 – 21:30"
  },
  {
    name: "Chleb i Wino",
    lat: 53.0110202,
    lon: 18.6038065,
    description: "Kameralna restauracja z winem i wypiekami – idealna na romantyczną kolację.",
    hours: "12:00 – 22:00"
  },
  {
    name: "Jan Olbracht",
    lat: 53.0110129,
    lon: 18.6056115,
    imageUrl: "https://www.browar-olbracht.pl/uploads/site/img/og-tag.jpg",
    description: "Browar restauracyjny z pyszną kuchnią i własnym piwem.",
    hours: "13:00 – 23:00"
  },
  {
    name: "Manekin",
    lat: 53.0107142,
    lon: 18.6032042,
    imageUrl: "https://manekin.pl/wp-content/uploads/2024/04/274_img1_546fd64cac7c8_2.jpg",
    description: "Legendarne naleśniki w różnych wariantach – słodkie i wytrawne.",
    hours: "10:00 – 22:00"
  }
];


  return (
    <div id="app">
      <h1>Rezerwacja Restauracji</h1>
      <ReservationForm />
      <hr />
      <AvailableTables restaurants={[]} />
      <hr />
      <Map restaurants={restaurants} />
    </div>
  );
}

export default App;
