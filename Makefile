.PHONY: package
package: multidev.box
	# now upload the box to vagrant cloud
	vagrant cloud box show llimllib/multidev
	read -p "New version number: " version; \
	vagrant cloud publish --force --release llimllib/multidev $$version virtualbox multidev.box
	@# ( https://stackoverflow.com/a/12170504/42559 for the one-line @read trick)

multidev.box: provision.sh user_provision.sh packer.json
	packer build packer.json
	# clear out the box so vagrant up uses thte new one instead of its cached copy
	vagrant box remove multidev.box
