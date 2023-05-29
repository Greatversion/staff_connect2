class salary_Model {
  String? jobRole;
  int? attendance;
  String? department;
  String? post;
  double? equity;
  int? experience;
  int? nClients;
  int? testScores;
  List<String>? skills;

  salary_Model(
      {this.jobRole,
      this.attendance,
      this.department,
      this.post,
      this.equity,
      this.experience,
      this.nClients,
      this.testScores,
      this.skills});

  salary_Model.fromJson(Map<String, dynamic> json) {
    jobRole = json['job_role'];
    attendance = json['attendance'];
    department = json['department'];
    post = json['post'];
    equity = json['equity'];
    experience = json['experience'];
    nClients = json['n_clients'];
    testScores = json['test_scores'];
    skills = json['skills'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job_role'] = jobRole;
    data['attendance'] = attendance;
    data['department'] = department;
    data['post'] = post;
    data['equity'] = equity;
    data['experience'] = experience;
    data['n_clients'] = nClients;
    data['test_scores'] = testScores;
    data['skills'] = skills;
    return data;
  }
}