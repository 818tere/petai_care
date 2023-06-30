import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petai_care/screens/account/sphelper.dart';
import 'package:flutter/src/widgets/image.dart' as uploadImage;

class DirectDialog extends StatefulWidget {
  final TextEditingController amountController;
  final TextEditingController descpController;
  final SPHelper helper;
  final Map<String, List<dynamic>> mySelectedEvents;
  final DateTime? selectedDay;
  final Function(String, String, String) savePerformance;

  const DirectDialog({
    super.key,
    required this.amountController,
    required this.descpController,
    required this.helper,
    required this.mySelectedEvents,
    required this.selectedDay,
    required this.savePerformance,
  });

  @override
  State<DirectDialog> createState() => _DirectDialogState();
}

class _DirectDialogState extends State<DirectDialog> {
  String? selectedItem;

  final List<String> _items = [
    '병원비',
    '양육비',
  ];

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        '내역 추가',
        textAlign: TextAlign.center,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: widget.amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: const InputDecoration(
              labelText: '금액',
            ),
          ),
          TextField(
            controller: widget.descpController,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(
                  r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]')),
            ],
            decoration: const InputDecoration(
              labelText: '내용',
            ),
          ),
          DropdownButton<String>(
            value: selectedItem,
            onChanged: ((value) {
              setState(() {
                selectedItem = value!;
              });
            }),
            items: _items
                .map(
                  (e) => DropdownMenuItem(
                    value: e,
                    child: Container(
                      alignment: Alignment.center,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 20,
                            child: uploadImage.Image.asset(
                                'assets/accountimages/$e.png'),
                          ),
                          const SizedBox(width: 10),
                          Text(e),
                        ],
                      ),
                    ),
                  ),
                )
                .toList(),
            selectedItemBuilder: (BuildContext context) => _items
                .map((e) => Row(
                      children: [
                        SizedBox(
                          width: 20,
                          child: uploadImage.Image.asset(
                              'assets/accountimages/$e.png'),
                        ),
                        const SizedBox(width: 5),
                        Text(e)
                      ],
                    ))
                .toList(),
            hint: const Text(
              '카테고리',
              style: TextStyle(color: Colors.grey),
            ),
            isExpanded: true,
            dropdownColor: Colors.white,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('취소'),
        ),
        TextButton(
          child: const Text('추가'),
          onPressed: () {
            if (widget.amountController.text.isEmpty &&
                widget.descpController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('내용이 입력되지 않았습니다.'),
                  duration: Duration(seconds: 2),
                ),
              );
              return;
            } else {
              widget.savePerformance(widget.amountController.text,
                  widget.descpController.text, selectedItem!);

              widget.amountController.clear();
              widget.descpController.clear();

              Navigator.of(context).pop();
              return;
            }
          },
        ),
      ],
    );
  }
}
