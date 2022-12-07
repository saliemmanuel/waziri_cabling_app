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

class UserTable extends StatelessWidget {
  final userList;
  final Users users;

  const UserTable({super.key, required this.userList, required this.users});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children: [
          Row(
            children: [
              const SizedBox(width: 15.0),
              CustomText(
                  data: "Liste des utilisateurs (${userList.length ?? ""})"),
              const SizedBox(width: 70.0),
              Container(
                alignment: Alignment.center,
                height: 40.0,
                width: 230.0,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.teal),
                    borderRadius: BorderRadius.circular(5.0)),
                child: const Expanded(
                    child: TextField(
                  // onChanged: (value) => runFilter(value),
                  decoration: InputDecoration(
                      hintText: "Search", border: InputBorder.none),
                )),
              ),
              InkWell(
                child: Container(
                  alignment: Alignment.center,
                  height: 40.0,
                  margin: const EdgeInsets.all(10.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.teal),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.add, color: Colors.teal),
                      CustomText(
                        data: "Ajoutez un utilisateur",
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  actionDialogue(
                      context: context,
                      child: AddNewUser(
                        users: users,
                      ));
                },
              ),
            ],
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: CustomText(data: 'N°')),
                  DataColumn(label: CustomText(data: 'Nom et prénom')),
                  DataColumn(
                      label: CustomText(
                          data: 'E-mail', overflow: TextOverflow.ellipsis)),
                  DataColumn(label: CustomText(data: 'Téléphone')),
                  // DataColumn(
                  //     label: CustomText(
                  //         data: 'Rôle', overflow: TextOverflow.ellipsis)),
                  // DataColumn(
                  //     label: CustomText(
                  //         data: 'Secteur', overflow: TextOverflow.ellipsis)),
                  DataColumn(label: CustomText(data: '   Action')),
                ],
                rows: [
                  for (var index = 0; index < userList!.length; index++)
                    DataRow(
                      color: index % 2 == 0
                          ? MaterialStateProperty.all(
                              Colors.grey.withOpacity(0.1))
                          : MaterialStateProperty.all(Colors.white),
                      cells: [
                        DataCell(CustomText(data: '${index + 1}')),
                        DataCell(
                          CustomText(
                            data:
                                "${userList![index]['nom_utilisateur']} ${userList![index]['prenom_utilisateur']}",
                          ),
                        ),
                        DataCell(CustomText(
                          data: userList![index]['email'],
                        )),
                        DataCell(CustomText(
                            data: userList![index]['telephone_utilisateur']
                                .toString())),
                        DataCell(Row(children: [
                          Expanded(
                            child: MaterialButton(
                                color: Colors.teal,
                                child: const Icon(IconlyBold.edit,
                                    color: Colors.white),
                                onPressed: () {
                                  actionDialogue(
                                      child:
                                          EditeUser(userData: userList![index]),
                                      context: context);
                                }),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: MaterialButton(
                                color: Palette.online,
                                child: const CustomText(
                                    data: "Détail", color: Colors.white),
                                onPressed: () async {
                                  actionDialogue(
                                      child: DetailUtilisateur(
                                        users: Users(
                                            prenomUtilisateur: userList![index]
                                                ['prenom_utilisateur'],
                                            nomUtilisateur: userList![index]
                                                ['nom_utilisateur'],
                                            roleUtilisateur: userList![index]
                                                ['prenom_utilisateur'],
                                            email: userList![index]
                                                ['prenom_utilisateur'],
                                            telephoneUtilisateur: userList![
                                                        index]
                                                    ['telephone_utilisateur']
                                                .toString(),
                                            zoneUtilisateur: userList![index]
                                                ['prenom_utilisateur']),
                                      ),
                                      context: context);
                                }),
                          ),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: MaterialButton(
                                color: Colors.red,
                                onPressed: userList![index]['id'] == users.id
                                    ? null
                                    : () async {
                                        getCodeAuth(
                                            context: context,
                                            idAdmin: users.id.toString(),
                                            onCall: () async {
                                              var res = await Provider.of<
                                                          AuthProvider>(context,
                                                      listen: false)
                                                  .codeAuth(
                                                      idAmin:
                                                          users.id.toString(),
                                                      code:
                                                          code.text.toString(),
                                                      context: context);
                                              if (res) {
                                                // ignore: use_build_context_synchronously
                                                Provider.of<HomeProvider>(
                                                        context,
                                                        listen: false)
                                                    .getDeleteUser(
                                                        email: userList![index]
                                                                ['email']
                                                            .toString(),
                                                        idUser: userList![index]
                                                                ['id']
                                                            .toString(),
                                                        context: context);
                                                print("delete");
                                                print(userList![index]);
                                                // ignore: use_build_context_synchronously
                                                Provider.of<HomeProvider>(
                                                        context,
                                                        listen: false)
                                                    .providelistUtilisateur();
                                              }
                                              code.clear();
                                            });
                                      },
                                child: const Icon(IconlyBold.delete,
                                    color: Colors.white)),
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
