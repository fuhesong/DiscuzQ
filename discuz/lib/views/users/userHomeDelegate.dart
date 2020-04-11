import 'package:flutter/material.dart';

import 'package:discuzq/states/scopedState.dart';
import 'package:discuzq/states/appState.dart';
import 'package:discuzq/widgets/ui/ui.dart';
import 'package:discuzq/widgets/appbar/appbar.dart';
import 'package:discuzq/widgets/users/userHomeDelegateCard.dart';
import 'package:discuzq/models/userModel.dart';
import 'package:discuzq/widgets/common/discuzNomoreData.dart';
import 'package:discuzq/widgets/users/userRecentThreads.dart';

const double _userHomeDelagateCardHeight = 140;

class UserHomeDelegate extends StatefulWidget {
  final UserModel user;

  const UserHomeDelegate({Key key, @required this.user}) : super(key: key);

  @override
  _UserHomeDelegateState createState() => _UserHomeDelegateState();
}

class _UserHomeDelegateState extends State<UserHomeDelegate> {
  ///
  /// uniquekey
  ///
  final UniqueKey uniqueKey = UniqueKey();

  ///
  /// showUserDeleagetCard
  /// 显示顶部用户信息卡片
  bool _showUserDeleagetCard = true;

  ///
  /// 使用用户信息的时候，不应该使用widget.user进行渲染
  /// 而应该使用_user
  /// 这是因为 widget.user不不包含完整的用户信息
  UserModel _user;

  @override
  void setState(fn) {
    if (!mounted) {
      return;
    }

    super.setState(fn);
  }

  @override
  void initState() {
    ///
    /// 在组件初始化前，先使用 widget.user 赋值到 _user
    /// 之后再异步更新 _user
    /// 记得，要在super.initState前进行这个操作
    _user = widget.user;

    super.initState();
    
    ///
    /// 异步请求新的用户信息
    Future.delayed(Duration(milliseconds: 300)).then((_) => _requestUserData());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScopedStateModelDescendant<AppState>(
      rebuildOnChange: false,
      builder: (context, child, state) => Scaffold(
            key: uniqueKey,
            appBar: DiscuzAppBar(
              title: _getTitle(),
            ),
            backgroundColor: DiscuzApp.themeOf(context).scaffoldBackgroundColor,
            body: _buildBody(context: context),
          ));

  ///
  /// Title
  String _getTitle() => _user.attributes.username == ''
      ? '这个人去火星了'
      : '${_user.attributes.username}的个人主页';

  Widget _buildBody({BuildContext context}) {
    if (_user.attributes.username == "") {
      return const Center(
        child: const DiscuzNoMoreData(),
      );
    }

    return Column(
      children: <Widget>[
        ///
        /// 用户信息卡片
        /// 用于显示粉丝数量
        /// 关注或取消
        UserHomeDelegateCard(
          user: _user,
          height:
              _showUserDeleagetCard == true ? _userHomeDelagateCardHeight : 0,
        ),

        ///
        /// 展示用户最近发帖
        ///
        Expanded(
          child: UserRecentThreads(
            user: _user,
            onUserCardState: (bool showUserDeleagetCard) {
              if (_showUserDeleagetCard == showUserDeleagetCard) {
                return;
              }

              setState(() {
                _showUserDeleagetCard = showUserDeleagetCard;
              });
            },
          ),
        )
      ],
    );
  }

  ///
  /// 异步的请求用户的信息，以覆盖现有的用户信息
  Future<void> _requestUserData() async {
    
  }
}
