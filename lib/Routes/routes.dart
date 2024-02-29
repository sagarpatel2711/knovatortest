// ignore_for_file: constant_identifier_names

part of 'pages.dart';

abstract class Routes {
  static const ROOT = _Paths.ROOT;
  static const PreviewView = _Paths.PreviewView;
  static const HomeView = _Paths.HomeView;
  static const AddUpdateResumeView = _Paths.AddUpdateResumeView;
  static const ResumePreviewView = _Paths.ResumePreviewView;
}

abstract class _Paths {
  static const ROOT = '/';
  static const PreviewView = '/PreviewView';
  static const HomeView = '/HomeView';
  static const AddUpdateResumeView = '/AddUpdateResumeView';
  static const ResumePreviewView = '/ResumePreviewView';
}
