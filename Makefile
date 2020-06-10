multidev.box: provision.sh user_provision.sh packer.json clean
	packer build packer.json

.PHONY: clean
clean:
	# clear out the box so vagrant up uses the new one instead of its cached
	# copy
	-vagrant box remove -f multidev.box

.PHONY: publish 
publish: multidev.box
	# now upload the box to vagrant cloud
	vagrant cloud box show llimllib/multidev
	read -p "New version number: " version; \
	vagrant cloud publish --force --release llimllib/multidev $$version virtualbox multidev.box
	@# ( https://stackoverflow.com/a/12170504/42559 for the one-line @read trick)
