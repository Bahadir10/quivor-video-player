enum Strings {
  home('Home'),
  search('Search'),
  playlists('Playlists'),
  recently('Recently'),
  openFolder('Open Folder'),
  openFile('Open File'),
  continueT('Continue'),
  create('Create'),
  playSpeed('Play Speed'),
  ;

  const Strings(this.value);
  final String value;

  String call() => value;
}
