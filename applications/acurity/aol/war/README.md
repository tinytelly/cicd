### Acurity AOL.war
This is the aol.war file directly copied from the IRess ftp.
The files split up to fit into Bitbucket.

#### To split up aol.war
aol.war is a large file (150mb). Often a git repo will reject large files, so you will need to split them into smaller parts.  To [split up a large file](https://askubuntu.com/questions/54579/how-to-split-larger-files-into-smaller-parts) do this.
```
split --bytes=80M aol.war aol-war-parts
```
to join them back together do this
```
cat aol-war-parts* > aol.war
```