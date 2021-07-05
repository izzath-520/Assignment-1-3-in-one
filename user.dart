class User {                 //for getting logged in user id

  final String uid;
  
  User({ this.uid });

}

class UserData {             //for getting logged in userdata in my account body & settings page

  final String url;
  final String uid;
  final String username;
  final String profession;
  final String workplace;

  UserData({ this.url, this.uid, this.username, this.profession, this.workplace });

}

class UserPost {
  final String url;
  UserPost({this.url});
}

class anyPost {
  final String url;
  anyPost({this.url});
}

class userDescription {
  final String description;
  userDescription ({this.description});
}
