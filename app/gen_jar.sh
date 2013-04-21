javac -classpath /opt/hadoop-1.0.4/hadoop-core-1.0.4.jar -d wordcount_classes WordCount.java
jar -cvf wordcount.jar -C wordcount_classes/ .
