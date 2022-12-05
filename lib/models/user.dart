class UserM {
  final String? name;
  final String? image;
  final bool isActive;
  final int? timeInCompany;
  UserM({
    required this.name,
    required this.image,
    required this.isActive,
    required this.timeInCompany,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'image': image,
        'isActive': isActive,
        'timeInCompany': timeInCompany,
      };

  static UserM fromJson(Map<String, dynamic> json) => UserM(
        name: json['name'],
        image: json['image'],
        isActive: json['isActive'],
        timeInCompany: json['timeInCompany'],
      );
}

final allUsers = [
  UserM(
    name: "Shubham Mamgain",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS4wkTPwUomJS3UgxWkRpVOTNCVfQ46PEdhCQ&usqp=CAU",
    isActive: true,
    timeInCompany: 4,
  ),
  UserM(
    name: "Mohit Khare",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWZGgZdWZSK7NBOIoLxc3gbBPtRoXEYF9f-g&usqp=CAU",
    isActive: false,
    timeInCompany: 7,
  ),
  UserM(
    name: "Vaibhav Singh",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQIwMIGTutu1jpkhgNCLM-Rd2gz3d0MRSXuPw&usqp=CAU",
    isActive: true,
    timeInCompany: 6,
  ),
  UserM(
    name: "Akash Arya",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe-nDXn1Xg8qOP0odcLuOkPZ7kpLzeGI-3FQ&usqp=CAU",
    isActive: false,
    timeInCompany: 1,
  ),
  UserM(
    name: "Sakshi Luthra",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQT60MyBMkcLfLBsjr8HyLmjKrCiPyFzyA-4Q&usqp=CAU",
    isActive: true,
    timeInCompany: 4,
  ),
  UserM(
    name: "Richa Chadda",
    image:
        "https://expertphotography.b-cdn.net/wp-content/uploads/2020/08/profile-photos-4.jpg",
    isActive: true,
    timeInCompany: 12,
  ),
  UserM(
    name: "Anmol Jindal",
    image:
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYH_VDaGfxQ_cPhkgDPyoxXJgnnKHzEw7kdg&usqp=CAU",
    isActive: false,
    timeInCompany: 3,
  ),
];
