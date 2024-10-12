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
  createNew('Create New'),
  empty('Empty'),
  fromFolder('From Folder'),
  selectFolder('Select Folder'),
  ;

  const Strings(this.value);
  final String value;

  String call() => value;
}
