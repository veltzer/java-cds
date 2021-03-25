JSA_FILE=classes.jsa
# JSA_FILE=/usr/lib/jvm/java-11-openjdk-amd64/lib/server/classes.jsa


.PHONY: all
all: dump

settings:
	java -XshowSettings:all 2> settings

.PHONY: time
time:
	time ./wrap.py java -Xshare:off -XX:SharedArchiveFile=$(JSA_FILE) -jar sample.jar
	time ./wrap.py java -Xshare:auto -XX:SharedArchiveFile=$(JSA_FILE) -jar sample.jar

.PHONY: dump
dump: $(JSA_FILE)

$(JSA_FILE): sample.jar
	java -Xshare:dump -XX:SharedArchiveFile=$(JSA_FILE) sample.jar

.PHONY: clean
clean:
	rm -f $(JSA_FILE)
