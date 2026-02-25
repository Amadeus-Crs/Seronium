import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:go_router/go_router.dart';
import 'package:seronium_flutter/api/user.dart';
import 'package:seronium_flutter/stores/TokenManager.dart';
import 'package:seronium_flutter/stores/UserController.dart';
import 'package:seronium_flutter/utils/Joke.dart';
import 'package:seronium_flutter/utils/SQLInjectionPattern.dart';
import 'package:seronium_flutter/utils/ToastUtils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _accountController = TextEditingController();
  final _passwordController = TextEditingController();

  final Usercontroller _usercontroller = Get.find();

  bool _isChecked = false;
  bool _isLoading = false;

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_isChecked) {
      ToastUtils.showToast(context, "请同意隐私政策和用户协议");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final res = await LoginAPI({
        "username": _accountController.text.trim(),
        "password": _passwordController.text.trim(),
      });

      _usercontroller.updateUser(res);
      tokenManager.setToken(res.token);

      ToastUtils.showToast(context, "登录成功");
      context.go('/home');
      print("登录成功，当前路由: ${GoRouterState.of(context).uri}");
    } catch (e) {
      ToastUtils.showToast(context, (e as DioException).message ?? "登录失败");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _accountController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录", style: TextStyle(fontWeight: FontWeight.w600)),
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                const SizedBox(height: 48),
                _buildAccountTextField(),
                const SizedBox(height: 20),
                _buildPasswordTextField(),
                const SizedBox(height: 28),
                _buildCheckbox(),
                const SizedBox(height: 40),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "欢迎回来",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 8),
        Text(
          "用户不存在将自动创建账号",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
        ),
      ],
    );
  }

  Widget _buildAccountTextField() {
    return TextFormField(
      controller: _accountController,
      validator: (value) {
        if (value == null || value.isEmpty) return "账号不能为空";
        if (!isSafeInput(value)) return "请勿尝试 SQL 注入";
        return null;
      },
      decoration: InputDecoration(
        hintText: "请输入账号",
        filled: true,
        // ignore: deprecated_member_use
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      ),
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: true,
      validator: (value) {
        if (value == null || value.isEmpty) return "密码不能为空";
        if (!RegExp(r"^[a-zA-Z0-9_@#\$%\^&\+=]{6,20}$").hasMatch(value)) {
          return "密码必须是6-20位的字母、数字或特殊字符";
        }
        return null;
      },
      decoration: InputDecoration(
        hintText: "请输入密码",
        filled: true,
        // ignore: deprecated_member_use
        fillColor: Theme.of(context).colorScheme.surfaceContainerHighest.withOpacity(0.6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
      ),
    );
  }

  Widget _buildCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          onChanged: (value) => setState(() => _isChecked = value ?? false),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                const TextSpan(text: "我已阅读并同意 "),
                TextSpan(
                  text: "《隐私政策》",
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()..onTap = JokeURL,
                ),
                const TextSpan(text: " 和 "),
                TextSpan(
                  text: "《用户协议》",
                  style: const TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
                  recognizer: TapGestureRecognizer()..onTap = JokeURL,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
          elevation: 2,
        ),
        child: _isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(color: Colors.white, strokeWidth: 3),
              )
            : const Text("登录", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }
}