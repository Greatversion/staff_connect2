// ignore_for_file: camel_case_types

class Get_Constants {
  List<String>? departments;
  Jobroles? jobroles;
  List<String>? posts;
  Skills? skills;

  Get_Constants({this.departments, this.jobroles, this.posts, this.skills});

  Get_Constants.fromJson(Map<String, dynamic> json) {
    departments = json['departments'].cast<String>();
    jobroles = json['jobroles'] != null
        ? Jobroles.fromJson(json['jobroles'])
        : null;
    posts = json['posts'].cast<String>();
    skills =
        json['skills'] != null ? Skills.fromJson(json['skills']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['departments'] = departments;
    if (jobroles != null) {
      data['jobroles'] = jobroles!.toJson();
    }
    data['posts'] = posts;
    if (skills != null) {
      data['skills'] = skills!.toJson();
    }
    return data;
  }
}

class Jobroles {
  List<String>? businessDevelopment;
  List<String>? customerSupport;
  List<String>? financeAndAccounting;
  List<String>? humanResourcesHR;
  List<String>? informationTechnologyIT;
  List<String>? legalAndCompliance;
  List<String>? operations;
  List<String>? projectManagement;
  List<String>? qualityAssuranceQA;
  List<String>? researchAndDevelopmentRD;
  List<String>? salesAndMarketing;

  Jobroles(
      {this.businessDevelopment,
      this.customerSupport,
      this.financeAndAccounting,
      this.humanResourcesHR,
      this.informationTechnologyIT,
      this.legalAndCompliance,
      this.operations,
      this.projectManagement,
      this.qualityAssuranceQA,
      this.researchAndDevelopmentRD,
      this.salesAndMarketing});

  Jobroles.fromJson(Map<String, dynamic> json) {
    businessDevelopment = json['Business Development'].cast<String>();
    customerSupport = json['Customer Support'].cast<String>();
    financeAndAccounting = json['Finance and Accounting'].cast<String>();
    humanResourcesHR = json['Human Resources (HR)'].cast<String>();
    informationTechnologyIT =
        json['Information Technology (IT)'].cast<String>();
    legalAndCompliance = json['Legal and Compliance'].cast<String>();
    operations = json['Operations'].cast<String>();
    projectManagement = json['Project Management'].cast<String>();
    qualityAssuranceQA = json['Quality Assurance (QA)'].cast<String>();
    researchAndDevelopmentRD =
        json['Research and Development (R&D)'].cast<String>();
    salesAndMarketing = json['Sales and Marketing'].cast<String>();
  }

  List<String>? get role => null;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Business Development'] = businessDevelopment;
    data['Customer Support'] = customerSupport;
    data['Finance and Accounting'] = financeAndAccounting;
    data['Human Resources (HR)'] = humanResourcesHR;
    data['Information Technology (IT)'] = informationTechnologyIT;
    data['Legal and Compliance'] = legalAndCompliance;
    data['Operations'] = operations;
    data['Project Management'] = projectManagement;
    data['Quality Assurance (QA)'] = qualityAssuranceQA;
    data['Research and Development (R&D)'] = researchAndDevelopmentRD;
    data['Sales and Marketing'] = salesAndMarketing;
    return data;
  }
}

class Skills {
  BusinessDevelopment? businessDevelopment;
  BusinessDevelopment? customerSupport;
  BusinessDevelopment? financeAndAccounting;
  BusinessDevelopment? humanResourcesHR;
  BusinessDevelopment? informationTechnologyIT;
  BusinessDevelopment? legalAndCompliance;
  BusinessDevelopment? operations;
  BusinessDevelopment? projectManagement;
  BusinessDevelopment? qualityAssuranceQA;
  BusinessDevelopment? researchAndDevelopmentRD;
  BusinessDevelopment? salesAndMarketing;

  Skills(
      {this.businessDevelopment,
      this.customerSupport,
      this.financeAndAccounting,
      this.humanResourcesHR,
      this.informationTechnologyIT,
      this.legalAndCompliance,
      this.operations,
      this.projectManagement,
      this.qualityAssuranceQA,
      this.researchAndDevelopmentRD,
      this.salesAndMarketing});

  Skills.fromJson(Map<String, dynamic> json) {
    businessDevelopment = json['Business Development'] != null
        ? BusinessDevelopment.fromJson(json['Business Development'])
        : null;
    customerSupport = json['Customer Support'] != null
        ? BusinessDevelopment.fromJson(json['Customer Support'])
        : null;
    financeAndAccounting = json['Finance and Accounting'] != null
        ? BusinessDevelopment.fromJson(json['Finance and Accounting'])
        : null;
    humanResourcesHR = json['Human Resources (HR)'] != null
        ? BusinessDevelopment.fromJson(json['Human Resources (HR)'])
        : null;
    informationTechnologyIT = json['Information Technology (IT)'] != null
        ? BusinessDevelopment.fromJson(json['Information Technology (IT)'])
        : null;
    legalAndCompliance = json['Legal and Compliance'] != null
        ? BusinessDevelopment.fromJson(json['Legal and Compliance'])
        : null;
    operations = json['Operations'] != null
        ? BusinessDevelopment.fromJson(json['Operations'])
        : null;
    projectManagement = json['Project Management'] != null
        ? BusinessDevelopment.fromJson(json['Project Management'])
        : null;
    qualityAssuranceQA = json['Quality Assurance (QA)'] != null
        ? BusinessDevelopment.fromJson(json['Quality Assurance (QA)'])
        : null;
    researchAndDevelopmentRD = json['Research and Development (R&D)'] != null
        ? BusinessDevelopment.fromJson(
            json['Research and Development (R&D)'])
        : null;
    salesAndMarketing = json['Sales and Marketing'] != null
        ? BusinessDevelopment.fromJson(json['Sales and Marketing'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (businessDevelopment != null) {
      data['Business Development'] = businessDevelopment!.toJson();
    }
    if (customerSupport != null) {
      data['Customer Support'] = customerSupport!.toJson();
    }
    if (financeAndAccounting != null) {
      data['Finance and Accounting'] = financeAndAccounting!.toJson();
    }
    if (humanResourcesHR != null) {
      data['Human Resources (HR)'] = humanResourcesHR!.toJson();
    }
    if (informationTechnologyIT != null) {
      data['Information Technology (IT)'] =
          informationTechnologyIT!.toJson();
    }
    if (legalAndCompliance != null) {
      data['Legal and Compliance'] = legalAndCompliance!.toJson();
    }
    if (operations != null) {
      data['Operations'] = operations!.toJson();
    }
    if (projectManagement != null) {
      data['Project Management'] = projectManagement!.toJson();
    }
    if (qualityAssuranceQA != null) {
      data['Quality Assurance (QA)'] = qualityAssuranceQA!.toJson();
    }
    if (researchAndDevelopmentRD != null) {
      data['Research and Development (R&D)'] =
          researchAndDevelopmentRD!.toJson();
    }
    if (salesAndMarketing != null) {
      data['Sales and Marketing'] = salesAndMarketing!.toJson();
    }
    return data;
  }
}

class BusinessDevelopment {
  List<String>? nonTechnicalSkills;
  List<String>? technicalSkills;

  BusinessDevelopment({this.nonTechnicalSkills, this.technicalSkills});

  BusinessDevelopment.fromJson(Map<String, dynamic> json) {
    nonTechnicalSkills = json['Non-Technical Skills'].cast<String>();
    technicalSkills = json['Technical Skills'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Non-Technical Skills'] = nonTechnicalSkills;
    data['Technical Skills'] = technicalSkills;
    return data;
  }
}