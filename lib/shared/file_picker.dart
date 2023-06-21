import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:wecheck/shared/constants.dart';

class SMFilePicker extends StatefulWidget {
  SMFilePicker({
    Key? key,
    this.filePickerFn,
    this.multipleFiles,
    this.withData,
  }) : super(key: key);

  final Function(List<PlatformFile>)? filePickerFn;
  bool? multipleFiles;
  bool? withData;

  @override
  State<SMFilePicker> createState() => _SMFilePickerState();
}

class _SMFilePickerState extends State<SMFilePicker> {
  String selectedFileName = 'No file selected';
  List<PlatformFile> selectedFiles = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          left: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          top: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
          right: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
      ),
      child: Center(
          child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          TextButton.icon(
            icon: Icon(Icons.upload, color: Theme.of(context).primaryColor),
            onPressed: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                allowMultiple: widget.multipleFiles ?? false,
                withData: widget.withData ?? false,
                type: FileType.custom,
                allowedExtensions: ['jpg', 'png', 'pdf', 'doc'],
              );
              if (result != null) {
                List<PlatformFile> files = result.files;
                PlatformFile file = result.files.first;

                widget.filePickerFn!(files);

                setState(() {
                  selectedFileName = file.name;
                  selectedFiles = files;
                });
              } else {
                // User canceled the picker
              }
            },
            label: Text(
              'Select File',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
          selectedFiles.isEmpty
              ? Text("No files selected")
              : Column(
                  children: selectedFiles.map((e) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(e.name),
                        SizedBox(
                          width: 15,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedFiles.remove(e);
                            });
                          },
                          child: Icon(
                            Icons.delete_outlined,
                            size: 20,
                            color: Constants.PRIMARY_COLOR,
                          ),
                        )
                      ],
                    );
                  }).toList(),
                )
          // selectedFileName != 'No file selected'
          //     ? Text(selectedFileName)
          //     : Text(selectedFileName),
        ],
      )),
    );
  }
}
