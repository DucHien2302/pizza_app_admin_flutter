import 'dart:html' as html;
import 'package:flutter/services.dart';
import 'models/models.dart';

abstract class PizzaRepo {
  Future<List<Pizza>> getPizzas();
  Future<String> sendImage(Uint8List file, String name);
  Future<void> createPizza(Pizza pizza);
}
