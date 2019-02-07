all: install

install: compile shippable
	cp -rf poll/* shippable

shippable:
	mkdir -p shippable

compile: zentaworkaround poll.compiled 

codedocs: shippable/poll-testcases.xml #shippable/poll-implementedBehaviours.xml shippable/poll-implementedBehaviours.html

shippable/poll-testcases.xml: poll.richescape shippable
	zenta-xslt-runner -xsl:generate_test_cases.xslt -s poll.richescape outputbase=shippable/poll-

#shippable/poll-implementedBehaviours.xml: shippable
#	zenta-xslt-runner -xsl:generate-behaviours.xslt -s target/test/javadoc.xml outputbase=shippable/poll-

include /usr/share/zenta-tools/model.rules

testenv:
	docker run --rm -p 5900:5900 -e PULL_REQUEST=false -e ORG_NAME=local -v $$(pwd):/poll -w /poll -it edemo/pdengine

clean:
	rm -rf inputs/ poll.consistency.stderr poll.consistencycheck poll.docbook poll.html poll.objlist poll.objlist.html\
     poll.rich poll.richescape poll.tabled.docbook poll.tabled.html shippable/ zentaworkaround  poll.docbook.repic\
      poll.pics/ poll.pdf poll.compiled poll

inputs/poll.issues.xml: shippable/poll-testcases.xml #shippable/poll-implementedBehaviours.xml 
	mkdir -p inputs
	getGithubIssues https://api.github.com "repo:magwas/humhub-modules-polls/&per_page=100" >inputs/poll.issues.xml

zentaworkaround:
	mkdir -p ~/.zenta/.metadata/.plugins/org.eclipse.e4.workbench/
	cp workbench.xmi ~/.zenta/.metadata/.plugins/org.eclipse.e4.workbench/
	touch zentaworkaround

