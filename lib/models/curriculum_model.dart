enum CurriculumType {
  video,
  audio,
}

class CurriculumModel {
  String title;
  String time;
  String fileUrl;
  CurriculumType type;

  CurriculumModel({
    required this.title,
    required this.time,
    required this.fileUrl,
    required this.type,
  });
}

List<CurriculumModel> curriculumList = [
  CurriculumModel(
      title: "1. Dissociation et produit ionique",
      time: "08:00",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-30s.mp4"),
  CurriculumModel(
    title: "3. Les acides forts et les bases fortes",
    time: "08:22",
    type: CurriculumType.audio,
    fileUrl:
        "https://firebasestorage.googleapis.com/v0/b/bonecole-2f0f4.appspot.com/o/4-things-i-wish-i-knew-in-my-20s-128-ytshorts.savetube.me.mp3?alt=media&token=a592f319-9ae1-441b-9979-a6bad33812ff",
  ),
  CurriculumModel(
      title: "4. Acide faible et base faible",
      time: "09:22",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-20s.mp4"),
  CurriculumModel(
      title: "5. Bases et classification",
      time: "10:51",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-15s.mp4"),
  CurriculumModel(
      title: "6. Réaction entre un acide fort et une base forte",
      time: "09:53",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-10s.mp4"),
  CurriculumModel(
      title: "7. Réaction entre un acide faible et une base forte",
      time: "09:31",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-30s.mp4"),
  CurriculumModel(
      title: "8. Réaction entre un acide fort et une base faible",
      time: "09:57",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-30s.mp4"),
  CurriculumModel(
      title: "9. Dosage acido-basique",
      time: "07:34",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-30s.mp4"),
  CurriculumModel(
      title: "10. Solution tampon lère partie",
      time: "07:50",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-30s.mp4"),
  CurriculumModel(
      title: "11. Solution tampon 2ème partie",
      time: "08:02",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-30s.mp4"),
  CurriculumModel(
      title: "11. Solution tampon 2ème partie",
      time: "",
      type: CurriculumType.video,
      fileUrl: "https://download.samplelib.com/mp4/sample-30s.mp4"),
];
