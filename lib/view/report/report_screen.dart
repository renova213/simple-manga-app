import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_time/view/report/report_view_model.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _namaKomikEditingController = TextEditingController();
  final _messageEditingController = TextEditingController();
  String? _namaKomik;
  String? _message;

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final report = Provider.of<ReportViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title:
            const Text("Report Screen", style: TextStyle(color: Colors.black)),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Isi Nama Komik :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      controller: _namaKomikEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onChanged: (value) {
                        _namaKomik = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Nama Komik Tidak Boleh Kosong",
                              textColor: Colors.white,
                              backgroundColor: Colors.red);
                        }
                        return null;
                      }),
                ]),
                const SizedBox(height: 15),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Text("Isi Permasalahan :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      maxLines: 6,
                      maxLength: 100,
                      controller: _messageEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      onChanged: (value) {
                        _message = value;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "form pesan tidak boleh kosong",
                              textColor: Colors.white,
                              backgroundColor: Colors.red);
                        }
                        return null;
                      }),
                ]),
                const SizedBox(height: 10),
                SizedBox(
                  width: 300,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.red),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ))),
                    child: const Text(
                      "SUBMIT",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        await report
                            .postReport(
                                'komik yang bermasalah $_namaKomik, $_message')
                            .then((value) =>
                                Fluttertoast.showToast(msg: 'berhasil terkirim')
                                    .then((value) =>
                                        _namaKomikEditingController.clear())
                                    .then((value) =>
                                        _messageEditingController.clear()));
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
