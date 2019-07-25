.PHONY: package
package:
	packer build packer.json
	# now upload the box to vagrant cloud
	vagrant cloud box show llimllib/multidev
	read -p "New version number: " version; \
	vagrant cloud publish --force --release llimllib/multidev $$version virtualbox multidev.box
	@# ( https://stackoverflow.com/a/12170504/42559 for the one-line @read trick)
