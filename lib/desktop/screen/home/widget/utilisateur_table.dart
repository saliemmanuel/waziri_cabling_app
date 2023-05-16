import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:waziri_cabling_app/config/config.dart';
import 'package:waziri_cabling_app/desktop/screen/home/provider/home_provider.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/action_dialogue.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/add_new_user.dart';
import 'package:waziri_cabling_app/desktop/screen/home/widget/edite_user.dart';

import '../../../../global_widget/custom_dialogue_card.dart';
import '../../../../global_widget/custom_text.dart';
import '../../../../global_widget/widget.dart';
import '../../../../models/users.dart';
import '../../log/provider/auth_provider.dart';
import '../home_desk_screen.dart';
import 'detail_utilisateur.dart';

class UserTable extends StatefulWidget {
  final userList;
  final Users users;

  const UserTable({super.key, required this.userList, required this.users});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  var listTypeUtilisateur = ['admin', 'chef-secteur', 'Tout les utilisateurs'];
  var listTypeSearch = ['E-mail', 'Téléphone'];
  var selectedTypeUtilisateur = '';
  var selectedSearch = '';
  var controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              const SizedBox(width: 15.0),
              CustomText(
                  data:
                      "Liste des utilisateurs (${widget.userList.length ?? ""})"),
              const SizedBox(width: 35.0),
              Row(
                children: [
                  ComboBox<String>(
                    style: const TextStyle(color: Palette.teal),
                    value: selectedSearch,
                    items: listTypeSearch.map<ComboBoxItem<String>>((e) {
                      return ComboBoxItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedSearch = value!);
                      Provider.of<HomeProvider>(context, listen: false)
                          .providelistUtilisateur(selectedTypeUtilisateur);
                    },
                    placeholder: const Text("Recherche par"),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 35.0,
                    width: 200.0,
                    margin: const EdgeInsets.all(8.0),
                    padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Palette.teal),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                            child: TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                              border: InputBorder.none, hintText: 'Search'),
                          onChanged: (value) {
                            if (value.isEmpty) {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .providelistUtilisateur(
                                      selectedTypeUtilisateur);
                            } else {
                              Provider.of<HomeProvider>(context, listen: false)
                                  .searchInListUtilisateur(
                                      value,
                                      selectedSearch == 'Téléphone'
                                          ? "telephone_utilisateur"
                                          : "email");
                            }
                          },
                        )),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(IconlyBold.search, color: Palette.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ComboBox<String>(
                style: const TextStyle(color: Palette.teal),
                value: selectedTypeUtilisateur,
                items: listTypeUtilisateur.map<ComboBoxItem<String>>((e) {
                  return ComboBoxItem<String>(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => selectedTypeUtilisateur = value!);
                  Provider.of<HomeProvider>(context, listen: false)
                      .providelistUtilisateur(selectedTypeUtilisateur);
                },
                placeholder: const Text('Type utilisateur'),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 35.0,
                  margin: const EdgeInsets.all(8.0),
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Palette.teal),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Palette.teal),
                      CustomText(
                        data: "Ajoutez un utilisateur",
                        color: Palette.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                      context: context, child: AddNewUser(users: widget.users));
                },
              ),
            ],
          ),
          Container(height: 1, color: Palette.grey, width: double.infinity),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: CustomText(data: 'N°')),
                  DataColumn(
                      label: Expanded(
                          child: CustomText(
                              data: 'Nom et prénom',
                              overflow: TextOverflow.clip))),
                  DataColumn(
                      label: CustomText(
                          data: 'E-mail', overflow: TextOverflow.ellipsis)),
                  DataColumn(label: CustomText(data: 'Téléphone')),
                  DataColumn(label: CustomText(data: 'Rôle')),
                  DataColumn(label: CustomText(data: '   Action')),
                ],
                rows: [
                  for (var index = 0; index < widget.userList!.length; index++)
                    DataRow(
                      color: index % 2 == 0
                          ? MaterialStateProperty.all(
                              Palette.grey.withOpacity(0.1))
                          : MaterialStateProperty.all(Palette.white),
                      cells: [
                        DataCell(CustomText(data: '${index + 1}')),
                        DataCell(
                          CustomText(
                            data:
                                "${widget.userList![index]['nom_utilisateur']} ${widget.userList![index]['prenom_utilisateur']}",
                          ),
                        ),
                        DataCell(CustomText(
                          selectable: true,
                          data: widget.userList![index]['email'],
                        )),
                        DataCell(CustomText(
                            data: widget.userList![index]
                                    ['telephone_utilisateur']
                                .toString())),
                        DataCell(CustomText(
                            data: widget.userList![index]['role_utilisateur']
                                .toString())),
                        DataCell(Row(children: [
                          Expanded(
                            child: MaterialButton(
                                color: Palette.online,
                                child: const CustomText(
                                    data: "Détail", color: Palette.white),
                                onPressed: () {
                                  actionDialogue(
                                      child: DetailUtilisateur(
                                        users: Users(
                                            prenomUtilisateur:
                                                widget.userList![index]
                                                    ['prenom_utilisateur'],
                                            nomUtilisateur:
                                                widget.userList![index]
                                                    ['nom_utilisateur'],
                                            roleUtilisateur:
                                                widget.userList![index]
                                                    ['role_utilisateur'],
                                            email: widget.userList![index]
                                                ['email'],
                                            telephoneUtilisateur: widget
                                                .userList![index]
                                                    ['telephone_utilisateur']
                                                .toString(),
                                            zoneUtilisateur:
                                                widget.userList![index]
                                                    ['zone_utilisateur']),
                                      ),
                                      context: context);
                                }),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: MaterialButton(
                                color: Palette.red,
                                onPressed: widget.userList![index]['id'] ==
                                        widget.users.id
                                    ? null
                                    : () async {
                                        getCodeAuth(
                                            context: context,
                                            onCall: () async {
                                              if (code.text.isNotEmpty) {
                                                var res = await Provider.of<
                                                    AuthProvider>(
                                                  context,
                                                  listen: false,
                                                ).codeAuth(
                                                  idAmin: widget.users.id
                                                      .toString(),
                                                  code: code.text.toString(),
                                                  context: context,
                                                );
                                                if (res) {
                                                  // ignore: use_build_context_synchronously
                                                  Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .getDeleteUser(
                                                          email: widget
                                                              .userList![index]
                                                                  ['email']
                                                              .toString(),
                                                          idUser: widget
                                                              .userList![index]
                                                                  ['id']
                                                              .toString(),
                                                          context: context);

                                                  // ignore: use_build_context_synchronously
                                                  Provider.of<HomeProvider>(
                                                          context,
                                                          listen: false)
                                                      .providelistUtilisateur(
                                                          'Tout les utilisateurs');
                                                }
                                                code.clear();
                                              } else {
                                                echecTransaction(
                                                    "Entrez le code svp!",
                                                    context);
                                              }
                                            });
                                      },
                                child: const Icon(IconlyBold.delete,
                                    color: Palette.white)),
                          ),
                        ])),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ]));
  }
}
