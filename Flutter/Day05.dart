class Dictionary {
  List wordBook = [];

  Map<String, String> newWord = {"term": "", "definition": ""};

  //단어 추가
  void add(String term, String definition) {
    newWord["term"] = term;
    newWord["definition"] = definition;
    print(newWord);
    wordBook.add(newWord);
  }

  dynamic get(String term) {
    for (var data in wordBook) {
      if (data["term"] == term) return data["definition"];
    }
    return "No Data Here!";
  }

  void delete(String term) {
    int index = 0;
    late int targetIndex;

    for (var data in wordBook) {
      if (data["term"] == term) targetIndex = index;
      index++;
    }

    wordBook.removeAt(targetIndex);
  }

  void update(String term, String newDefinition) {
    for (var data in wordBook) {
      if (data["term"] == term) data["definition"] = newDefinition;
    }
  }

  void showAll() {
    print(wordBook);
  }

  void count() {
    print(wordBook.length);
  }

  void upsert(String term, String newDefinition) {
    if (exists(term)) {
      update(term, newDefinition);
    } else {
      add(term, newDefinition);
    }
  }

  bool exists(String term) {
    for (var data in wordBook) {
      if (data["term"] == term) return true;
    }
    //if no data
    return false;
  }

  void bulkAdd(List) {}

  void bulkDelete() {}
}

void main() {
  Dictionary myDictionary = Dictionary();

  myDictionary.showAll();
  myDictionary.add("김치", "코리안 트레디셔나루 푸드");
  myDictionary.showAll();
  myDictionary.add("internet explore", "no more...");
  myDictionary.showAll();
  myDictionary.add("holly", "molly");
  myDictionary.showAll();

  print(myDictionary.get("김치"));
  print(myDictionary.get("파스타"));

  print(myDictionary.exists("김치") ? "있음" : "없음");
  print(myDictionary.exists("파스타") ? "있음" : "없음");

  myDictionary.showAll();
  myDictionary.count();

  myDictionary.delete("김치");

  myDictionary.showAll();
  myDictionary.count();

  myDictionary.update("internet explore", "dead...");

  myDictionary.showAll();
  myDictionary.count();

  myDictionary.upsert("김치", "코리안 트레디셔나루 푸드");
  myDictionary.upsert("internet explore", "his gone...");

  myDictionary.showAll();
  myDictionary.count();
}
