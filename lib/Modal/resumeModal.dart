class ResumeModal {
  String id;
  String achivements;
  String address;
  String email;
  String interests;
  String languages;
  String name;
  String objective;
  String photoUrl;
  String projName;
  String phoneNum;
  String linkedInUrl;
  String githubUrl;
  List<EducationModal>? educationModal;
  List<WorkExpModal>? workExpModal;
  List<ProjectModal>? projectModal;

  ResumeModal(
      {this.id = "",
      this.name = "",
      this.email = "",
      this.address = "",
      this.languages = "",
      this.photoUrl = "",
      this.achivements = "",
      this.interests = "",
      this.objective = "",
      this.projName = "",
      this.linkedInUrl = "",
      this.phoneNum = "",
      this.githubUrl = "",
      this.educationModal,
      this.projectModal,
      this.workExpModal});

  factory ResumeModal.fromJson(Map<String, dynamic> json) {
    var educationJson = json['educationModal'] as List?;
    var workExpJson = json['workExpModal'] as List?;
    var projectJson = json['projectModal'] as List?;
    List<EducationModal>? educationData;
    List<WorkExpModal>? workExpData;
    List<ProjectModal>? projectData;

    if (educationJson != null) {
      educationData = educationJson
          .map((educationJson) => EducationModal.fromJson(educationJson))
          .toList();
    }
    if (workExpJson != null) {
      workExpData = workExpJson
          .map((workExpJson) => WorkExpModal.fromJson(workExpJson))
          .toList();
    }
    if (projectJson != null) {
      projectData = projectJson
          .map((projectJson) => ProjectModal.fromJson(projectJson))
          .toList();
    }
    return ResumeModal(
        id: json['id'],
        achivements: json['achivements'],
        address: json['address'],
        email: json['email'],
        interests: json['interests'],
        languages: json['languages'],
        name: json['name'],
        objective: json['objective'],
        photoUrl: json['photoUrl'],
        projName: json['projName'],
        linkedInUrl: json['linkedInUrl'],
        phoneNum: json['phoneNum'],
        githubUrl: json['githubLink'],
        educationModal: educationData,
        workExpModal: workExpData,
        projectModal: projectData);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'achivements': achivements,
        'address': address,
        'email': email,
        'interests': interests,
        'languages': languages,
        'name': name,
        'objective': objective,
        'photoUrl': photoUrl,
        'projName': projName,
        'linkedInUrl': linkedInUrl,
        'educationModal': educationModal,
        'projectModal': projectModal,
        'workExpModal': workExpModal,
        'phoneNum': phoneNum,
        'githubLink': githubUrl
      };
}

class EducationModal {
  String id;
  String course;
  String endYear;
  String joinYear;
  String name;
  String percentage;

  EducationModal(
      {this.id = "",
      this.course = "",
      this.endYear = "",
      this.joinYear = "",
      this.name = "",
      this.percentage = ""});
  factory EducationModal.fromJson(Map<String, dynamic> json) => EducationModal(
      course: json['course'],
      endYear: json['endYear'],
      id: json['id'],
      joinYear: json['joinYear'],
      name: json['name'],
      percentage: json['percentage']);

  Map<String, dynamic> toJson() => {
        'course': course,
        'id': id,
        'endYear': endYear,
        'joinYear': joinYear,
        'name': name,
        'percentage': percentage
      };
}

class WorkExpModal {
  String id;
  String compName;
  String desc;
  String endDate;
  String jobName;
  String joinDate;
  WorkExpModal(
      {this.id = "",
      this.compName = "",
      this.desc = "",
      this.endDate = "",
      this.jobName = "",
      this.joinDate = ""});
  factory WorkExpModal.fromJson(Map<String, dynamic> json) => WorkExpModal(
      compName: json['compName'],
      desc: json['desc'],
      endDate: json['endDate'],
      id: json['id'],
      jobName: json['jobName'],
      joinDate: json['joinDate']);
  Map<String, dynamic> toJson() => {
        'compName': compName,
        'desc': desc,
        'id': id,
        'jobName': jobName,
        'joinDate': joinDate,
        'endDate': endDate
      };
}

class ProjectModal {
  String id;
  String desc;
  String projName;
  ProjectModal({this.id = "", this.desc = "", this.projName = ""});

  factory ProjectModal.fromJson(Map<String, dynamic> json) => ProjectModal(
      desc: json['desc'], id: json['id'], projName: json['projName']);

  Map<String, dynamic> toJson() => {
        'projName': projName,
        'desc': desc,
        'id': id,
      };
}
