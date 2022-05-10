import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:manga_time/view/report/report_view_model.dart';
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
      body: Form(
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
                textFormField(
                    "Nama Tidak Boleh Kosong", _nameEditingController),
                const SizedBox(height: 15),
                const Text("Isi Email :",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 5,
                ),
                textFormField(
                    "Email Tidak Boleh Kosong", _emailEditingController),
                const SizedBox(height: 15),
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
                    validator: (value) {
                      if (value!.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "form pesan tidak boleh kosong",
                            textColor: Colors.white,
                            backgroundColor: Colors.red);
                      }
                      return null;
                    }),
                const SizedBox(height: 15),
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
                                widget.judul.toString(),
                                _messageEditingController.text,
                                _emailEditingController.text,
                                _nameEditingController.text)
                            .then((value) => Fluttertoast.showToast(
                                msg: 'berhasil terkirim'))
                            .then((value) => _messageEditingController.clear())
                            .then((value) => _emailEditingController.clear())
                            .then((value) => _nameEditingController.clear());
                      }
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget textFormField(msgValidator, controller) {
    return TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            Fluttertoast.showToast(
                msg: msgValidator,
                textColor: Colors.white,
                backgroundColor: Colors.red);
          }
          return null;
        });
  }
}
