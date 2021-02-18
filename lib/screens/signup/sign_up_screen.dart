import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xlo/screens/signup/components/field_title.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Card(
            margin: EdgeInsets.symmetric(horizontal: 16),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FieldTitle(
                    title: 'Apelido',
                    subtitle: 'Como aparecera em seus anúncios.',
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Exemplo: Raimundo M.',
                      isDense: true,
                    ),
                  ),
                  SizedBox(height: 16),
                  FieldTitle(
                    title: 'E-mail',
                    subtitle: 'Enviaremos um e-mail de confimação.',
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Exemplo: martins@gmail.com',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                  ),
                  SizedBox(height: 16),
                  FieldTitle(
                    title: 'Celular',
                    subtitle: 'Proteja sua conta.',
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Exemplo: (88)99999-9999',
                      isDense: true,
                    ),
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      // ignore: deprecated_member_use
                      WhitelistingTextInputFormatter.digitsOnly,
                      TelefoneInputFormatter()
                    ],
                  ),
                  SizedBox(height: 16),
                  FieldTitle(
                    title: 'Senha',
                    subtitle: 'Use letras, números e caracteres especiais.',
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  FieldTitle(
                    title: 'Confirmar senha',
                    subtitle: 'Repita a senha, por favor.',
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      isDense: true,
                    ),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 50,
                    margin: EdgeInsets.symmetric(vertical: 16),
                    child: RaisedButton(
                      color: Colors.orange,
                      child: Text('CADASTRAR'),
                      textColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Divider(color: Colors.black),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'Já tem uma conta?',
                          style: TextStyle(fontSize: 16),
                        ),
                        GestureDetector(
                          onTap: Navigator.of(context).pop,
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.purple,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
