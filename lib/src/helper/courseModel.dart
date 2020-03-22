class CourseModel {
  String name;
  String description;
  String university;
  String noOfCource;
  String tag1;
  String tag2;

  CourseModel(
      {this.name,
      this.description,
      this.noOfCource,
      this.university,
      this.tag1,
      this.tag2});
}

class CourseList {
  static List<CourseModel> list = [
    CourseModel(
        name: "March's Electricity Bill ",
        description:
            "Your outstanding Payment: zero dollars",
        university: "SOULAR",
        noOfCource: "29/03/2020",
        tag1: "Mar1",
        tag2: "Mar2"
        ),
    CourseModel(
        name: "Feburary's Electricity Bill ",
        description:
            "Your outstanding Payment: zero dollars",
        university: "SOULAR",
        noOfCource: "29/02/2020",
        tag1: "Feb1",
        tag2: "Feb2"
        ),
    CourseModel(
        name: "Big Data",
        description:
            "Drive better bussiness decision with an overview OF how big data is organised  and intepreted. Apply insight to real-world problems and question",
        university: "Us San Diego",
        noOfCource: "10 courses",
        tag1: "Data Data",
        tag2: "Apache Spark"),
  ];
}
