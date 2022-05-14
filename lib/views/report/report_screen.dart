import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_time/models/report_model/report_model.dart';
import 'package:manga_time/views/report/report_view_model.dart';
import 'package:provider/provider.dart';

class ReportScreen extends StatefulWidget {
  final String judul;
  const ReportScreen({Key? key, required this.judul}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final _messageEditingController = TextEditingController();
  final _emailEditingController = TextEditingController();
  final _nameEditingController = TextEditingController();

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
      body: ListView(children: [
        Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      widget.judul.toString(),
                      style: const TextStyle(
                          fontSize: 20,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text("Isi Nama Kamu :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      key: const Key("name_field"),
                      textInputAction: TextInputAction.next,
                      controller: _nameEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Form nama tidak boleh kosong";
                        }
                        return null;
                      }),
                  const SizedBox(height: 15),
                  const Text("Isi Email Kamu :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      key: const Key("email_field"),
                      textInputAction: TextInputAction.next,
                      controller: _emailEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Form email tidak boleh kosong";
                        }
                        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                            .hasMatch(value)) {
                          return "Gunakan email yang valid";
                        }
                        return null;
                      }),
                  const SizedBox(height: 15),
                  const Text("Isi Permasalahannya :",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                      key: const Key("message_field"),
                      textInputAction: TextInputAction.next,
                      maxLines: 6,
                      maxLength: 100,
                      controller: _messageEditingController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Form pesan tidak boleh kosong";
                        }
                        return null;
                      }),
                  const SizedBox(height: 15),
                  Center(
                    child: SizedBox(
                      width: 300,
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ))),
                        child: const Text(
                          "SUBMIT",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            report.postReport(ReportModel(
                                judulKomik: widget.judul.toString(),
                                message: _messageEditingController.text,
                                email: _emailEditingController.text,
                                name: _nameEditingController.text));

                            _messageEditingController.clear();
                            _emailEditingController.clear();
                            _nameEditingController.clear();

                            Fluttertoast.showToast(
                                toastLength: Toast.LENGTH_SHORT,
                                backgroundColor: Colors.red,
                                textColor: Colors.white,
                                msg: 'Berhasil Terkirim');
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ]),
    );
  }
}
