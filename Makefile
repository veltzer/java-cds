##############
# parameters #
##############
# do you want to show the commands executed ?
DO_MKDBG:=0
# do you want dependency on the Makefile itself ?
DO_ALLDEP:=1


JSA_FILE=classes.jsa
# JSA_FILE=/usr/lib/jvm/java-11-openjdk-amd64/lib/server/classes.jsa


.PHONY: all
all: dump
	@true

settings:
	java -XshowSettings:all 2> settings

.PHONY: time
time:
	sudo sysctl vm.drop_caches=1
	time ./wrap.py java -Xshare:off -jar sample.jar
	sudo sysctl vm.drop_caches=1
	time ./wrap.py java -Xshare:auto -XX:SharedArchiveFile=$(JSA_FILE) -jar sample.jar

.PHONY: dump_list_classes
dump_list_classes:
	java -XX:DumpLoadedClassList=classes.list -jar sample.jar

.PHONY: create_archive_from_classes
create_archive_from_classes:
	java -Xshare:dump -XX:SharedClassListFile=classes.list -XX:SharedArchiveFile=$(JSA_FILE) --class-path sample.jar
.PHONY: dump
dump: $(JSA_FILE)

$(JSA_FILE): sample.jar
	java -Xshare:dump -XX:SharedArchiveFile=$(JSA_FILE) sample.jar

.PHONY: clean
clean:
	$(info doing [$@])
	@rm -f $(JSA_FILE)
.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	@git clean -qffxd

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
