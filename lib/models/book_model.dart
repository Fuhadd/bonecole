class BookModel {
  String name;
  String author;
  String newPrice;
  String oldPrice;
  int pages;
  int timeInHours;
  int timeInMinutes;
  String imageUrl;

  BookModel({
    required this.name,
    required this.author,
    required this.newPrice,
    required this.oldPrice,
    required this.pages,
    required this.timeInHours,
    required this.timeInMinutes,
    required this.imageUrl,
  });
}

List<BookModel> bookList1 = [
  BookModel(
    name: "Anglais Terminales",
    author: "Kabinet Keita",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 29,
    timeInHours: 2,
    timeInMinutes: 21,
    imageUrl: 'assets/images/book1.jpeg',
  ),
  BookModel(
    name: "Biologie TSE",
    author: "Elhadj Oumar Bar",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 27,
    timeInHours: 5,
    timeInMinutes: 50,
    imageUrl: 'assets/images/book2.jpeg',
  ),
  BookModel(
    name: "Chimie 10e Année",
    author: "Abdoulaye Bangoura",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 10,
    timeInHours: 1,
    timeInMinutes: 09,
    imageUrl: 'assets/images/chemistry2.jpeg',
  ),
  BookModel(
    name: "Chimie TSE/TSM",
    author: "Bafodé Bangoura",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 28,
    timeInHours: 4,
    timeInMinutes: 08,
    imageUrl: 'assets/images/chemistry.jpeg',
  ),
];

List<BookModel> bookList2 = [
  BookModel(
    name: "Anglais Terminales",
    author: "Kabinet Keita",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 29,
    timeInHours: 2,
    timeInMinutes: 21,
    imageUrl: 'assets/images/book1.jpeg',
  ),
  BookModel(
    name: "Biologie TSE",
    author: "Elhadj Oumar Bar",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 27,
    timeInHours: 5,
    timeInMinutes: 50,
    imageUrl: 'assets/images/book2.jpeg',
  ),

  BookModel(
    name: "Chimie TSE/TSM",
    author: "Bafodé Bangoura",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 28,
    timeInHours: 4,
    timeInMinutes: 08,
    imageUrl: 'assets/images/chemistry.jpeg',
  ),
  BookModel(
    name: "Economie TSM",
    author: "Marc Aurel Touré",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 19,
    timeInHours: 3,
    timeInMinutes: 59,
    imageUrl: 'assets/images/graph.jpeg',
  ),
  BookModel(
    name: "Economie TSS",
    author: "Marc Aurel Touré",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 15,
    timeInHours: 4,
    timeInMinutes: 42,
    imageUrl: 'assets/images/money.jpeg',
  ),

  BookModel(
    name: "Français Terminales",
    author: "Alpha Amadou Diallo",
    newPrice: "30,000",
    oldPrice: "50,000",
    pages: 19,
    timeInHours: 2,
    timeInMinutes: 01,
    imageUrl: 'assets/images/tech.jpeg',
  ),

  // Add more BookModel objects here with different data
];
