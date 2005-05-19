From: mvloon@anime-nl.net (Marco van Loon)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: lm_sensors & the /usr/src/linux mess...
Message-Id: <20030204162045.A514@anime-nl.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[an almost identical e-mail as the one I've sent to i2c; you seem to kind of
 share docs and Makefile structure...] 

Ugh, I hate it when different pieces of documentation say things that are 
completely contrary to each other... :(
The kernel README and IIRC also the glibc docs specifically say that
/usr/src/linux _shouldn't_ contain the header files of the current kernel,
but of the kernel that was installed at the moment the (glibc) library
was compiled...   Or in other words:
"Don't fsck with /usr/src/linux unless you're installing a new glibc"

Now the docs of lm_sensors mention "/usr/src/linux" in the role of
"current kernel sources" multiple times, which, as alredy said, 
_isn't_ correct according to the README of the kernel itself... :(


Some small comments about the Makefile:

would the makefile language allow for a kind of
$(shell if [ ! -d $(LINUX_HEADERS) ]; \
  then <abort the Makefile here>;
  fi)
type of construct to be inserted to do an early abort of the Makefile
if someone is silly enough to run the Makefile while
/lib/modules/$(KERNELVERSION)/build is a dangling symlink, so the 'grep's,
'cut's etc. don't go horribly wrong for lack of input(files) in such a case?..

Fortunately  $(shell if [ -L 
also sees _dangling_ symlinks as symlinks, so there's no disastrous fall-back
to /usr/src/linux if /lib/modules/$(KERNELVERSION)/build is dangling...
(my $(KERNELVERSION) is 2.4.20 , /usr/src/linux/include/ contains 2.4.19
 headers (see rant above))


Marco van Loon 
