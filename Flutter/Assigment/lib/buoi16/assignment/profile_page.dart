import 'package:buoi_4_bai_1/buoi16/assignment/ProfileData.dart';
import 'package:buoi_4_bai_1/buoi16/assignment/profile_cubit.dart';
import 'package:buoi_4_bai_1/buoi16/assignment/profile_responsitory.dart';
import 'package:buoi_4_bai_1/buoi16/assignment/profile_state.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _HomePage(),
    );
  }
}

class _HomePage extends StatefulWidget {
  const _HomePage();

  @override
  State<_HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<_HomePage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final profileCubit = ProfileCubit(ProfileRepository());

  @override
  void initState() {
    super.initState();
    profileCubit.getAllProfiles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: BlocProvider.value(
        value: profileCubit,
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is InitialProfileState || state is LoadingProfileState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SuccessLoadAllProfileState) {
              final profiles = state.listProfiles;
              return ListView.builder(
                itemCount: profiles.length,
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 8, right: 8),
                    child: Card(
                      child: ListTile(
                        leading: Text('Name: ${profile.name}'),
                        title: Text('Email: ${profile.email}'),
                        subtitle: Text('Age: ${profile.age}'),
                        trailing: SizedBox(
                          width: 40,
                          child: PopupMenuButton(
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem(
                                  value: 'Edit', child: Text('Edit')),
                              const PopupMenuItem(
                                  value: 'Delete', child: Text('Delete')),
                            ],
                            onSelected: (String result) async {
                              if (result == "Edit") {
                                await _showDialog(context, profile);
                                profileCubit.getAllProfiles();
                              } else {
                                await profileCubit.deleteProfile(profile.id!);
                                profileCubit.getAllProfiles();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is FailureProfileState) {
              return Center(
                child: Text(state.errorMessage),
              );
            }
            return Text(state.toString());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            await _showDialog(context, null);
            profileCubit.getAllProfiles();
          },
          label: const Text('Add Profile')),
    );
  }

  Future<void> _showDialog(
      BuildContext context, ProfileData? profileData) async {
    if (profileData != null) {
      nameController.text = profileData.name!;
      emailController.text = profileData.email!;
      ageController.text = profileData.age!;
    } else {
      nameController.text = "";
      emailController.text = "";
      ageController.text = "";
    }
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return Dialog(
              insetPadding: EdgeInsets.zero,
              child: Scaffold(
                appBar: AppBar(
                  title: profileData == null
                      ? const Text("Create new profile")
                      : const Text("Update profile"),
                  leading: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close),
                  ),
                  actions: [
                    TextButton(
                        onPressed: () {
                          final profile = ProfileData(
                              name: nameController.text,
                              email: emailController.text,
                              age: ageController.text);
                          if (profileData == null) {
                            profileCubit.createProfile(profile);
                          } else {
                            final profile = ProfileData(
                                id: profileData.id!,
                                name: nameController.text,
                                email: emailController.text,
                                age: ageController.text);
                            profileCubit.updateProfile(profile);
                          }
                        },
                        child: const Text(
                          'Save',
                          style: TextStyle(color: Colors.white),
                        ))
                  ],
                ),
                body: BlocProvider.value(
                  value: profileCubit,
                  child: BlocListener<ProfileCubit, ProfileState>(
                    listener: (_, state) {
                      if (state is SuccessSubmitProfileState) {
                        profileData == null
                            ? ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Profile adds successfully')))
                            : ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text('Profile updates successfully')));
                        setState(() {
                          nameController.text = "";
                          emailController.text = "";
                          ageController.text = "";
                        });
                      } else if (state is FailureProfileState) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errorMessage)));
                      }
                    },
                    child: Stack(
                      children: [_buildWidgetForm(), _buildWidgetLoading()],
                    ),
                  ),
                ),
              ),
            );
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    ageController.dispose();
  }

  Widget _buildWidgetForm() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter your name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people)),
            controller: nameController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter your email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people)),
            controller: emailController,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: TextFormField(
            decoration: const InputDecoration(
                hintText: 'Enter your age',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.people)),
            controller: ageController,
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }

  Widget _buildWidgetLoading() {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (_, state) {
        if (state is LoadingProfileState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
