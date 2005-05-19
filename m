From: peb@mppmu.mpg.de (Peter Breitenlohner)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c-1.8.4 and lm_sensors-2.8.5 -- a comment
Message-Id: <Pine.LNX.4.58.0404201404510.1296@pcl321.mppmu.mpg.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Your lm_sensors-2.8.5/Makefile contains rules for "make install" which print
a warning:
	*** The depmod command below may generate errors. We are aware of the
	*** problem and are working on a solution.
This warning applies in particular to the case that $(DESTDIR) != "", when
there are lots of warnings about files not owned by root (while I have seen
no warnings in the other case). Running depmod is a typical post-install
action and I think there is no way to get it right with $(DESTDIR) != "".

Instead of running "/sbin/depmod -a -b $(DESTDIR)" and producing a bunch of
useless modules.* files, I would like to suggest that you omit this and
instead print a warning that depmod must be run after the modules have been
installed in their final location (as far as I know most/all Linux
distributions run depmod early in their boot sequence) as follows:

replace
##########################################
install :: all user_install
	@echo "*** The depmod command below may generate errors. We are aware of the"
	@echo "*** problem and are working on a solution."
ifeq ($(DESTDIR),)
	-/sbin/depmod -a
else
	-/sbin/depmod -a -b $(DESTDIR)
endif
##########################################
by
##########################################
install :: all user_install
ifeq ($(DESTDIR),)
	@echo "*** The depmod command below may generate errors. We are aware of the"
	@echo "*** problem and are working on a solution."
	-/sbin/depmod -a
else
	@echo "*** This is a staged install using \"$(DESTDIR)\" as prefix. Once"
	@echo "*** the modules have been moved to their final destination you must"
	@echo "*** run the command \"/sbin/depmod -a\". This may generate errors."
	@echo "*** We are aware of the problem and are working on a solution."
endif
##########################################
and do something analogous for i2c-2.8.4.

regards
Peter Breitenlohner <peb@mppmu.mpg.de>
