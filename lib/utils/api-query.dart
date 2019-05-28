class ApiQuery {

  static getThings() {
    return """
        query getThings {
          things {
            id
            text
          }
        }
      """;
  }

  static createThing() {

  }

}
