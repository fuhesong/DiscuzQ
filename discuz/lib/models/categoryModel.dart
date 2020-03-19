import 'dart:convert';
import 'package:flutter/material.dart';

class CategoryModel {
  ///
  /// id
  /// 分类的ID
  ///
  final String id;

  ///
  /// type
  /// 类型
  ///
  final String type;

  ///
  /// attributes
  /// 关联数据
  ///
  final CategoryModelAttributes attributes;

  ///
  /// 分类模型
  ///
  const CategoryModel({this.id, this.type = 'categories', this.attributes});

  ///
  /// fromMap
  /// 转换模型
  ///
  static CategoryModel fromMap({@required dynamic maps}) {
    ///
    /// 返回一个空的模型，如果为空的话
    ///
    if (maps == null) {
      return CategoryModel();
    }

    dynamic data = maps;

    /// 数据来自json
    if (maps.runtimeType == String) {
      data = jsonDecode(data);
    }

    ///
    /// 返回转化的分类模型
    return CategoryModel(
        id: data['id'] ?? 0,
        type: data['type'],
        attributes: data['attributes'] == null
            ? CategoryModelAttributes()
            : CategoryModelAttributes.fromMap(maps: data['attributes']));
  }
}

class CategoryModelAttributes {
  ///
  /// name
  /// 分类的名称
  ///
  final String name;

  ///
  /// description
  /// 分类的描述
  ///
  final String description;

  ///
  /// icon
  /// 图标URl
  ///
  final String icon;

  ///
  /// sort
  /// 排序
  ///
  final int sort;

  ///
  /// property
  /// 属性：0:正常 1:首页展示
  ///
  final int property;

  ///
  /// thread_count
  /// 帖子数量
  final int threadCount;

  ///
  /// ip
  ///
  final String ip;

  ///
  /// createdAt
  /// 创建时间
  ///
  final String createdAt;

  ///
  /// updatedAt
  /// 修改时间
  ///
  final String updatedAt;

  ///
  /// 分类属性
  const CategoryModelAttributes(
      {this.name = "",
      this.icon = "",
      this.description = "",
      this.sort = 0,
      this.threadCount = 0,
      this.createdAt = "",
      this.updatedAt = "",
      this.ip = "",
      this.property = 0});

  ///
  /// fromMap
  /// 转换模型
  ///
  static CategoryModelAttributes fromMap({@required dynamic maps}) {
    ///
    /// 返回一个空的模型，如果为空的话
    ///
    if (maps == null) {
      return CategoryModelAttributes();
    }

    dynamic data = maps;

    /// 数据来自json
    if (maps.runtimeType == String) {
      data = jsonDecode(data);
    }

    return CategoryModelAttributes(
        name: data['name'] ?? '',
        icon: data['icon'] ?? '',
        description: data['description'] ?? '',
        sort: data['sort'] ?? 0,
        property: data['property'] ?? 0,
        threadCount: data['thread_count'] ?? 0,
        createdAt: data['created_at'] ?? '',
        updatedAt: data['updated_at'] ?? '',
        ip: data['ip'] ?? '');
  }
}
