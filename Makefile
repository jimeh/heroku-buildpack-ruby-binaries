#
# Functions
#

# Targets to download, checksum and sign checksum.
define buildcurl
$(4)/$(2)-%.tgz:
	curl -L --get --fail --retry 3 buildcurl.com \
		-d recipe=$(3) -d version="$$*" -d target=$(5) -o "$$@"

$(4)/$(2)-%.tgz.sha512:
	shasum -b -a 512 "$(4)/$(2)-$$*.tgz" > "$$@"

$(4)/$(2)-%.tgz.sha512.gpg:
	gpg --sign "$(4)/$(2)-$$*.tgz.sha512"

$(4)/$(2)-%.md:
	echo "# $(1) $$*" > "$$@" \
	&& echo '' >> "$$@" \
	&& echo "Downloaded from buildcurl.com on $$(shell date +%Y-%m-%d) with:" >> "$$@" \
	&& echo '' >> "$$@" \
	&& echo '```' >> "$$@" \
	&& echo "curl -L --get --fail --retry 3 buildcurl.com -d recipe=$(3) -d version=$$* -d target=$(5) -o \"$(2)-$$*.tgz\"" >> "$$@" \
	&& echo '```' >> "$$@"
endef

# Target to download for each supported platform.
define fetch
$$(eval $$(call buildcurl,$(1),$(2),$(3),el-7,el:7))
$$(eval $$(call buildcurl,$(1),$(2),$(3),ubuntu-12.04,ubuntu:12.04))

.PHONY: $(2)-%
$(2)-%:
	make "el-7/$(2)-$$*.tgz" \
	&& make "el-7/$(2)-$$*.tgz.sha512" \
	&& make "el-7/$(2)-$$*.tgz.sha512.gpg" \
	&& make "el-7/$(2)-$$*.md"
	make "ubuntu-12.04/$(2)-$$*.tgz" \
	&& make "ubuntu-12.04/$(2)-$$*.tgz.sha512" \
	&& make "ubuntu-12.04/$(2)-$$*.tgz.sha512.gpg" \
	&& make "ubuntu-12.04/$(2)-$$*.md"
endef

#
# Define fetchables
#

$(eval $(call fetch,LibYAML,libyaml,libyaml))
$(eval $(call fetch,Ruby Bundler,bundler,rubygem-bundler))
$(eval $(call fetch,Ruby,ruby,ruby))
