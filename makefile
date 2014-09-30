include $(PQ_FACTORY)/factory.mk

$(call show_vars,pq-gmp-dir,pq-mpfr-dir)

pq_part_name := mpc-0.8.1
pq_part_file := $(pq_part_name).tar.gz

build-stamp: stage-stamp
	$(MAKE) -C $(pq_part_name) && \
	$(MAKE) -C $(pq_part_name) install DESTDIR=$(stage_dir) && \
	touch $@

stage-stamp: configure-stamp

configure-stamp: patch-stamp
	( \
		cd $(pq_part_name) && \
		./configure --prefix=$(part_dir) \
			    --with-gmp=$(pq-gmp-dir) \
			    --with-mpfr=$(pq-mpfr-dir) \
	) && touch $@

patch-stamp: unpack-stamp
	touch $@

unpack-stamp: $(pq_part_file)
	tar xf $(source_dir)/$(pq_part_file) && touch $@

