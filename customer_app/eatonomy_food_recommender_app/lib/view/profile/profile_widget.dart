import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'profile_model.dart';
import 'package:eatonomy_food_recommender_app/view/edit_profile/edit_profile_widget.dart';
export 'profile_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:eatonomy_food_recommender_app/utils/routes/routes_name.dart';
import 'package:eatonomy_food_recommender_app/res/components/Shared_Preferences/Shared_Preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../cart/persistent_shopping_cart.dart';
class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  late ProfileModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProfileModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        drawer: const Drawer(
          elevation: 16.0,
        ),
        appBar: AppBar(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          iconTheme:
              IconThemeData(color: FlutterFlowTheme.of(context).secondaryText),
          automaticallyImplyLeading: true,
          title: Text(
            'Profile',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).bodyLarge.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).secondaryText,
                  fontSize: 24.0,
                  letterSpacing: 0.0,
                  fontWeight: FontWeight.w600,
                ),
          ),
          actions: [
            PersistentShoppingCart().showCartItemCountWidget(
                cartItemCountWidgetBuilder: (itemCount) => IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, RoutesName.cartScreen);
                    },
                    icon: Badge(
                      label: Text(itemCount.toString()),
                      child: const Icon(Icons.shopping_bag_outlined),
                    )))
          ],
          centerTitle: true,
          elevation: 0.0,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileTile(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                child: Text(
                  'Account',
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              ProfileListItem(
                iconData: Icons.person,
                title: 'Edit Profile',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EditProfileWidget()),
                  );
                },
              ),
              ProfileListItem(
                iconData: Icons.location_on,
                title: 'Address',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileWidget()),
                  );
                },
              ),
              ProfileListItem(
                iconData: Icons.notifications_none,
                title: 'Notification Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileWidget()),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 16.0, 0.0, 0.0),
                child: Text(
                  'General',
                  style: FlutterFlowTheme.of(context).labelLarge.override(
                        fontFamily: 'Readex Pro',
                        letterSpacing: 0.0,
                      ),
                ),
              ),
              ProfileListItem(
                iconData: Icons.help_outline_rounded,
                title: 'Support',
                iconColor: FlutterFlowTheme.of(context).secondaryText,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileWidget()), // Replace SupportScreen with your actual support screen class
                  );
                },
              ),

              ProfileListItem(
                iconData: Icons.privacy_tip_rounded,
                title: 'Terms of Service',
                iconColor: FlutterFlowTheme.of(context).secondaryText,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileWidget()), // Replace TermsServiceScreen with your actual terms of service screen class
                  );
                },
              ),

              ProfileListItem(
                iconData: Icons.ios_share,
                title: 'Invite Friends',
                iconColor: FlutterFlowTheme.of(context).secondaryText,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileWidget()), // Replace InviteFriendsScreen with your actual invite friends screen class
                  );
                },
              ),

              LogoutButton(),

            ],
          ),
        ),
      ),
    );
  }
}




class ProfileTile extends StatefulWidget {
  final String? profileName;
  final String? profileEmail;
  final String? imageUrl;

  const ProfileTile({
    Key? key,
    this.profileName,
    this.profileEmail,
    this.imageUrl,
  }) : super(key: key);

  @override
  _ProfileTileState createState() => _ProfileTileState();
}

class _ProfileTileState extends State<ProfileTile> {
  String? _profileName;
  String? _profileEmail;
  String? _imageUrl;

  @override
  void initState() {
    super.initState();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _profileName = widget.profileName ?? prefs.getString('Name');
      _profileEmail = widget.profileEmail ?? prefs.getString('Email');
      _imageUrl = widget.imageUrl ?? prefs.getString('ProfilePic');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16.0, 1.0, 16.0, 0.0),
      child: Container(
        width: MediaQuery.of(context).size.width,
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.95,
          maxHeight: MediaQuery.of(context).size.height * 0.15,
        ),
        decoration: BoxDecoration(
          color: Colors.white, // Adjust as needed for your theme
          boxShadow: const [
            BoxShadow(
              blurRadius: 3.0,
              color: Color(0xFFE1E2E3),
              offset: Offset(0.0, 1.0),
            )
          ],
          borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                width: 90.0,
                height: 90.0,
                decoration: BoxDecoration(
                  color: Colors.white, // Adjust as needed for your theme
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white, // Adjust as needed for your theme
                    width: 2.0,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50.0),
                    child: CachedNetworkImage(
                      imageUrl: _imageUrl ?? 'https://i.imgur.com/VTGxlk8.jpeg', // This should ideally be a valid URL
                      width: 60.0,
                      height: 60.0,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Image.asset('assets/default_profile.jpg', fit: BoxFit.cover),
                      errorWidget: (context, url, error) => Image.asset('assets/default_profile.jpg', fit: BoxFit.cover),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 0.0, 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _profileName ?? 'Your Name',
                      style: TextStyle(
                        color: Color(0xFF5C5F65),
                        fontSize: 16.0,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(0.0, 4.0, 0.0, 0.0),
                      child: Text(
                        _profileEmail ?? 'email@example.com',
                        style: TextStyle(
                          color: Color(0xFF76777D),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class ProfileListItem extends StatelessWidget {
  final IconData iconData;
  final String title;
  final Color iconColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final VoidCallback onTap;  // Callback for tap action

  const ProfileListItem({
    Key? key,
    required this.iconData,
    required this.title,
    this.iconColor = const Color(0xFF5C5F65),
    this.textColor = const Color(0xFF5C5F65),
    this.padding = const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
    required this.onTap,  // Ensure onTap is provided
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: padding,
        child: Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0xFFE1E2E3),
                offset: Offset(0.0, 2.0),
              ),
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Icon(
                  iconData,
                  color: iconColor,
                  size: 24.0,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Text(
                      title,
                      style: FlutterFlowTheme.of(context).bodyLarge.override(
                        fontFamily: 'Readex Pro',
                        color: textColor,
                        letterSpacing: 0.0,
                      ),
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Color(0xFF5C5F65),
                  size: 18.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  const LogoutButton({
    Key? key,
    this.title = 'Logout',
    this.icon = Icons.exit_to_app_rounded,
    this.iconColor = const Color(0xFFEC3434),
    this.textColor = const Color(0xFFEC3434),
    this.padding = const EdgeInsetsDirectional.fromSTEB(16.0, 12.0, 16.0, 0.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: GestureDetector(
        onTap: () {
          FirebaseAuth.instance.signOut();
          Navigator.of(context).pushNamedAndRemoveUntil(
              RoutesName.login, (route) => false);
        },
        child: Container(
          width: double.infinity,
          height: 60.0,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.of(context).secondaryBackground,
            boxShadow: const [
              BoxShadow(
                blurRadius: 5.0,
                color: Color(0x3416202A),
                offset: Offset(0.0, 2.0),
              ),
            ],
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 24.0,
                    ),
                  ),
                ),
                Text(
                  title,
                  style:    FlutterFlowTheme.of(context).bodyLarge.override(
                    fontFamily: 'Readex Pro',
                    color: textColor,
                    letterSpacing: 0.0,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
