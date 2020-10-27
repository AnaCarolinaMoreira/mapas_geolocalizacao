import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsTesteCamadas extends StatefulWidget {
  @override
  _MapsTesteCamadasState createState() => _MapsTesteCamadasState();
}

class _MapsTesteCamadasState extends State<MapsTesteCamadas> {
  Color color = Colors.yellow;

  MapType _mapa = MapType.normal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mapas Geolocalização"),
      // Text("Monitoramento"),
      //  backgroundColor: Color.fromARGB(255, 20, 39, 61),
        backgroundColor: Color.fromARGB(255, 20, 39, 61),
        centerTitle: true,
      ),
      body: Container(
        child: Stack(
          children: [
            GoogleMap(
              mapType:_mapa,
              initialCameraPosition: CameraPosition(
                target: LatLng(-23.562436, -46.655005),
                zoom: 10,
              ),
              // onMapCreated: _onMapCreated,
            ),

            Padding(
              padding: EdgeInsets.fromLTRB(15.0,10.0,15.0,0),
              //padding: const EdgeInsets.fromLTRB(60.0,20.0,60.0,20.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(10),
                  child: TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                      const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hintText: "Pesquisar...",
                      //labelText: "Pesquisar...",
                      labelStyle:
                    TextStyle(fontSize: 20.0, color: Color(0xFFB14273d)),
                      //borda ahover /desatica
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      //borde hover/ativa
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                        const BorderSide(color: Colors.grey, width: 1.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,10.0,8.0,17.8),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Material(
                  elevation: 10.0,
                  borderRadius: BorderRadius.circular(9),
                  child: Container(
                    padding: EdgeInsets.all(0),
                 // width: MediaQuery.of(context).size.width*0.72,
                    height: MediaQuery.of(context).size.height * 0.130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                    ),
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          padding: EdgeInsets.all(0),
                          child: Text("Normal"),
                          //onPressed: () {},
                          onPressed: () {
                            setState(() {
                              _mapa = MapType.normal;
                            });
                          },

                        ),
                        FlatButton(
                          child: Text("Satélite"),
                          onPressed: () {
                            setState(() {
                              _mapa = MapType.satellite;
                            });
                          },
                        ),
                        FlatButton(
                          child: Text("Escuro"),
                          onPressed: () {
                            setState(() {
                              _mapa = MapType.terrain;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
