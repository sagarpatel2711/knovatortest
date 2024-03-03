import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knovatortest/Modal/resumeModal.dart';
import 'package:knovatortest/Themes/appColors.dart';
import 'package:knovatortest/Utility/logger.dart';

import '../Widgets/imgStorage.dart';

class FireDBController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  late CollectionReference resumeRefrence;
  RxList<ResumeModal> resumeModal = <ResumeModal>[].obs;
  RxList<EducationModal> educationModal = <EducationModal>[].obs;
  RxList<WorkExpModal> workExpModal = <WorkExpModal>[].obs;
  RxList<ProjectModal> projectModal = <ProjectModal>[].obs;
  RxList<WorkExpModal> addWorkModal = <WorkExpModal>[].obs;
  RxList<EducationModal> addEduModal = <EducationModal>[].obs;
  RxList<ProjectModal> addProjModal = <ProjectModal>[].obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController githubController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController languagesController = TextEditingController();
  TextEditingController achivmentController = TextEditingController();
  TextEditingController interestsController = TextEditingController();
  TextEditingController objectiveController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController compNameController = TextEditingController();
  TextEditingController jobNameController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController projectNameController = TextEditingController();
  TextEditingController projectDescController = TextEditingController();
  String photoUrl = "";

  setData() async {
    try {
      DocumentReference documentReference = resumeRefrence.doc();
      ResumeModal resumeModal = ResumeModal(
        id: documentReference.id,
        achivements: achivmentController.text,
        address: addressController.text,
        email: emailController.text,
        githubUrl: githubController.text,
        interests: interestsController.text,
        languages: languagesController.text,
        name: nameController.text,
        linkedInUrl: linkedInController.text,
        objective: objectiveController.text,
        phoneNum: numberController.text,
        photoUrl: photoUrl,
      );
      final resumeJson = resumeModal.toJson();
      await documentReference.set(resumeJson);
      for (var addWork in addWorkModal) {
        await resumeRefrence
            .doc(documentReference.id)
            .collection('workExep')
            .add(addWork.toJson());
      }
      for (var addEdu in addEduModal) {
        await resumeRefrence
            .doc(documentReference.id)
            .collection('education')
            .add(addEdu.toJson());
      }
      for (var addProj in addProjModal) {
        await resumeRefrence
            .doc(documentReference.id)
            .collection('project')
            .add(addProj.toJson());
      }
      Get.snackbar("Success", "Resume Added Successfully",
          backgroundColor: AppColors.greenColor,
          colorText: AppColors.whiteColor);
    } catch (e) {
      Get.snackbar("Error", "Resume Not Added",
          backgroundColor: AppColors.redColor, colorText: AppColors.whiteColor);
      logger.e(e);
    }
  }

  setWorkData({String id = ""}) async {
    try {
      DocumentReference documentReference = resumeRefrence.doc(id);
      for (var addWoek in addWorkModal) {
        await documentReference.collection('workExep').add(addWoek.toJson());
      }
    } catch (e) {
      logger.e(e);
    }
  }

  getData() async {
    try {
      QuerySnapshot querySnapshot = await resumeRefrence.get();
      final List<ResumeModal> retriveData = querySnapshot.docs
          .map((resumeData) =>
              ResumeModal.fromJson(resumeData.data() as Map<String, dynamic>))
          .toList();
      resumeModal.clear();
      resumeModal.assignAll(retriveData);

      update();
    } catch (e) {
      logger.e(e);
    }
  }

  getEduData({String resumeID = ""}) async {
    if (resumeModal.isNotEmpty) {
      QuerySnapshot queryshot =
          await resumeRefrence.doc(resumeID).collection('education').get();
      final List<EducationModal> retriveEduData = queryshot.docs
          .map((eduData) =>
              EducationModal.fromJson(eduData.data() as Map<String, dynamic>))
          .toList();
      educationModal.clear();
      educationModal.assignAll(retriveEduData);
      update();
    }
  }

  getWorkExpData({String resumeID = ""}) async {
    if (resumeModal.isNotEmpty) {
      QuerySnapshot queryworkshot =
          await resumeRefrence.doc(resumeID).collection('workExep').get();
      final List<WorkExpModal> retriveWorkData = queryworkshot.docs
          .map((workData) =>
              WorkExpModal.fromJson(workData.data() as Map<String, dynamic>))
          .toList();
      workExpModal.clear();
      workExpModal.assignAll(retriveWorkData);
      update();
    }
  }

  getProjectData({String resumeID = ""}) async {
    if (resumeModal.isNotEmpty) {
      QuerySnapshot queryprojshot =
          await resumeRefrence.doc(resumeID).collection('project').get();
      final List<ProjectModal> retriveProjectData = queryprojshot.docs
          .map((projectData) =>
              ProjectModal.fromJson(projectData.data() as Map<String, dynamic>))
          .toList();
      projectModal.clear();
      projectModal.assignAll(retriveProjectData);
      update();
    }
  }

  Future<void> uploadimg(String img) async {
    photoUrl = img;
    logger.i("ProfileImg : $photoUrl");
    update();
    await Storage.uploadFile(
      img,
      DateTime.now().toString(),
    );
    update();
    logger.w("sfdsd img : $img");
  }

  deleteResume(String id) async {
    try {
      await resumeRefrence.doc(id).delete();
      Get.snackbar("Success", "Resume Successfully Deleted",
          backgroundColor: AppColors.greenColor,
          colorText: AppColors.whiteColor);
      update();
    } catch (e) {
      Get.snackbar("Error", "Resume Not Deleted",
          backgroundColor: AppColors.redColor, colorText: AppColors.whiteColor);
    }
  }

  addWorkModalData({String joinDate = "", String endDate = ""}) async {
    DocumentReference documentReference = resumeRefrence.doc();

    addWorkModal.add(
      WorkExpModal(
          id: documentReference.collection('workExep').id,
          compName: compNameController.text,
          desc: descController.text,
          jobName: jobNameController.text,
          joinDate: joinDate,
          endDate: endDate),
    );
    return addWorkModal;
  }

  updateWorkData(
      {String resumeID = "",
      String projID = "",
      String endYear = "",
      String joinYear = ""}) async {
    DocumentReference documentReference = resumeRefrence.doc(resumeID);
    WorkExpModal reterviewProj = WorkExpModal(
        id: projID,
        compName: compNameController.text,
        desc: descController.text,
        endDate: endYear,
        jobName: jobNameController.text,
        joinDate: joinYear);

    await documentReference
        .collection('workExep')
        .doc(projID)
        .update(reterviewProj.toJson());
    getWorkExpData(resumeID: resumeID);
  }

  addEduModalData({String joinDate = "", String endDate = ""}) async {
    DocumentReference documentReference = resumeRefrence.doc();
    addEduModal.add(EducationModal(
        id: documentReference.collection('education').id,
        course: courseController.text,
        endYear: endDate,
        joinYear: joinDate,
        name: nameController.text,
        percentage: percentageController.text));
    return addEduModal;
  }

  updateEduData(
      {String resumeID = "",
      String projID = "",
      String endYear = "",
      String joinYear = ""}) async {
    DocumentReference documentReference = resumeRefrence.doc(resumeID);
    EducationModal reterviewProj = EducationModal(
        id: projID,
        course: courseController.text,
        endYear: endYear,
        joinYear: joinYear,
        name: nameController.text,
        percentage: percentageController.text);

    await documentReference
        .collection('education')
        .doc(projID)
        .update(reterviewProj.toJson());
    getEduData(resumeID: resumeID);
  }

  addProjModalData() async {
    DocumentReference documentReference = resumeRefrence.doc();

    addProjModal.add(ProjectModal(
        id: documentReference.collection('project').doc().id,
        desc: projectDescController.text,
        projName: projectNameController.text));

    return addProjModal;
  }

  updateProjModalData({String resumeID = "", String projID = ""}) async {
    DocumentReference documentReference = resumeRefrence.doc(resumeID);
    ProjectModal reterviewProj = ProjectModal(
        desc: projectDescController.text,
        id: projID,
        projName: projectNameController.text);

    await documentReference
        .collection('project')
        .doc(projID)
        .update(reterviewProj.toJson());
    getProjectData(resumeID: resumeID);
  }

  updateResume(String id) async {
    ResumeModal retriveData = ResumeModal(
      id: id,
      address: addressController.text,
      name: nameController.text,
      email: emailController.text,
      linkedInUrl: linkedInController.text,
      githubUrl: githubController.text,
      phoneNum: numberController.text,
      languages: languagesController.text,
      achivements: achivmentController.text,
      interests: interestsController.text,
      objective: objectiveController.text,
      photoUrl: photoUrl,
    );
    final resumeJson = retriveData.toJson();

    await resumeRefrence.doc(id).update(resumeJson);
    DocumentReference documentReference = resumeRefrence.doc();

    for (var addWork in addWorkModal) {
      await resumeRefrence
          .doc(documentReference.id)
          .collection('workExep')
          .add(addWork.toJson());
    }
    for (var addEdu in addEduModal) {
      await resumeRefrence
          .doc(documentReference.id)
          .collection('education')
          .add(addEdu.toJson());
    }
    for (var addProj in addProjModal) {
      await resumeRefrence
          .doc(documentReference.id)
          .collection('project')
          .add(addProj.toJson());
    }

    update();
  }

  @override
  void onInit() {
    resumeRefrence = firestore.collection('resume');
    super.onInit();
  }
}
