// Sure, I can help you with that. To create the body page for recording medicine intake, you can use a `ListView` widget to display a list of medicines that the user has added. Each medicine can be represented by a `Card` widget that contains the medicine's name and type.

// To allow the user to add new medicines, you can use a `FloatingActionButton` widget that opens a new page when pressed. Inside the new page, the user can enter the name and type of the medicine, and then save it using `SharedPreferences`.

// Here's an example of how you can create the body page for recording medicine intake:

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MedicineIntakeTracker extends StatefulWidget {
  @override
  _MedicineIntakeTrackerState createState() => _MedicineIntakeTrackerState();
}

class _MedicineIntakeTrackerState extends State<MedicineIntakeTracker> {
  List<Map<String, String>> _medicines = [];

  @override
  void initState() {
    super.initState();
    _loadMedicines();
  }

  void _loadMedicines() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> medicineList = prefs.getStringList('medicines') ?? [];

    setState(() {
      _medicines = medicineList.map((medicine) {
        List<String> medicineInfo = medicine.split(',');
        return {
          'name': medicineInfo[0],
          'type': medicineInfo[1],
        };
      }).toList();
    });
    print(_medicines);
  }

  void _saveMedicine(String name, String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // _medicines.add({'name': name!, 'type': type!});
      setState(() {
        _medicines.add({
          'name': name,
          'type': type,
        });
      });
    });

    prefs.setStringList(
      'medicines',
      _medicines
          .map((medicine) => '${medicine['name']},${medicine['type']}')
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(''),
      // ),

      body: _medicines.isEmpty
          ? Center(
              child: Text('No medications added'),
            )
          : ListView.builder(
              itemCount: _medicines.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    // title: Text(_medicines[index]['name']),
                    // subtitle: Text(_medicines[index]['type']),
                    title: Text(_medicines[index]['name'] ?? 'Unknown'),
                    subtitle: Text(_medicines[index]['type'] ?? 'Unknown'),
                  ),
                );
              },
            ),
      // body: ListView.builder(
      //   itemCount: _medicines.length,
      //   itemBuilder: (context, index) {
      //     return Card(
      //       child: ListTile(
      //         title: Text(_medicines[index]['name']),
      //         subtitle: Text(_medicines[index]['type']),
      //       ),
      //     );
      //   },
      // ),

      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddMedicinePage()));

          if (result != null) {
            _saveMedicine(result['name'], result['type']);
          }
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class AddMedicinePage extends StatefulWidget {
  @override
  _AddMedicinePageState createState() => _AddMedicinePageState();
}

class _AddMedicinePageState extends State<AddMedicinePage> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _type = '';
  String _selectedMedicineType = '';
  final List<String> _medTypeOptions = [
    'medicine',
    'herbs',
    'vitamins',
    'supplements',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Medicine'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Medicine Name',
                  ),
                  validator: (value) {
                    if (value?.isEmpty ?? true) {
                      return 'Please enter a medicine name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _name = value!;
                  },
                ),
                // TextFormField(
                //   decoration: InputDecoration(
                //     labelText: 'Medicine Type',
                //   ),
                //   validator: (value) {
                //     if (value?.isEmpty ?? true) {
                //       return 'Please enter a medicine type';
                //     }
                //     return null;
                //   },
                //   onSaved: (value) {
                //     _type = value!;
                //   },
                // ),

                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelText: 'Medicine Type',
                  ),
                  value:
                      null, // the value must be null or it keep saying u do not have the value in DropdownMenuItem becox default is empty string

                  onChanged: (value) {
                    setState(() {
                      _selectedMedicineType = value.toString();
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select a medicine type';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _type = value!;
                  },
                  items: _medTypeOptions.map((String type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16),
                RaisedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _formKey.currentState?.save();
                      Navigator.pop(context, {
                        'name': _name,
                        'type': _type
                      }); // close the current screen and return the result to previous screen
                    }
                  },
                  child: Text('Save'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// In this example, we're creating a new page called `MedicineIntakePage` that extends the `StatefulWidget` class. Inside the `_MedicineIntakePageState` class, we're defining a `_medicines` list that stores the medicines that the user has added. We're also loading the list of medicines from `SharedPreferences` when the page is initialized, using the `_loadMedicines` method.

// To display the list of medicines, we're using a `ListView.builder` widget that creates a new `Card` widget for each medicine in the `_medicines` list. We're also using a `FloatingActionButton` widget that opens a new page called `AddMedicinePage` when pressed.

// Inside the `AddMedicinePage` page, we're using a `Form` widget with two `TextFormField` widgets that allow the user to enter the name and type of the medicine. When the user presses the "Save" button, the `_formKey.currentState.save()` method saves the form data, and the `Navigator.pop()` method returns the medicine data to the `MedicineIntakePage`. The `_saveMedicine` method then saves the new medicine to `SharedPreferences`.

// I hope this helps! Let me know if you have any questions or need further assistance.

//when to use previous state --> when u want to determine any change has been done
// In Flutter, the `previousState` property is used in the `didUpdateWidget` method of a `State` object to access the previous state of the widget. The `didUpdateWidget` method is called whenever the widget is rebuilt with new properties.

// You might use `previousState` in situations where you need to compare the previous state of a widget with its current state to determine if any changes have occurred. For example, if you're building a game and you need to keep track of the player's score, you might use `previousState` to check if the score has changed in the current frame.

// Another use case for `previousState` is when you need to access data that is only available in the previous state of the widget. For example, if you're implementing an undo/redo feature in a text editor, you might use `previousState` to get the previous text value of the editor, which is not available in the current state.

// In general, you should use `previousState` sparingly, because accessing the previous state of a widget can be expensive in terms of memory and performance. If possible, it's better to store the state data that you need in a separate object or store, and update it in a predictable and efficient way.
