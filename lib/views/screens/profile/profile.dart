import 'package:dine_in/bloc/sign_in/sign_in_bloc.dart';
import 'package:dine_in/views/widgets/custome_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_iconsax/flutter_iconsax.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInBloc, SignInState>(
      builder: (context, state) {
        final data = state.user;
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              "Profile",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: IconButton(
                  onPressed: () {
                    context.read<SignInBloc>().add(const LogOutEvent());
                  },
                  icon: const Icon(Iconsax.logout4),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child:
                          CustomeNetworkImage(data: data.resturantImage ?? '')),
                ),
                Text("Name : ${data.name ?? ''}"),
                Text("Description : ${data.description ?? ''}"),
                Text("Address : ${data.address ?? ''}"),
                Text("Contact : ${data.contact ?? 0}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
