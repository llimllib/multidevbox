.PHONY: package
package:
	packer build packer.json
	# next you upload multidev.box to vagrant cloud.... XXX figure out how to automate that
	# it's gonna be something with vagrant cloud publish, like:
	#
	# vagrant cloud box show llimllib/multidev
	# @read -p "New version:" version; \
	# vagrant cloud publish --force --release llimllib/multidev $$version virtualbox multidev.box
	#
	# ( https://stackoverflow.com/a/12170504/42559 for the one-line @read trick)
