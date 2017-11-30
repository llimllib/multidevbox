.PHONY: package
package:
	packer build packer.json
	# next you upload multidev.box to vagrant cloud.... XXX figure out how to automate that
