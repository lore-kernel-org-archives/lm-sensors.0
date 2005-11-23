From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Wed, 23 Nov 2005 16:46:05 +0000
Subject: [lm-sensors] Re: hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <43848E98.7070303@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

Rudolf Marek wrote:
> Please can you test attached patch? Because I cant see how it can fail.
When compiling I get:

# patch -p1 < /mnt/samba/download/linux/patches/via_vrm_patch_test7
(Stripping trailing CRs from patch.)
patching file drivers/hwmon/hwmon-vid.c
(Stripping trailing CRs from patch.)
patching file include/linux/hwmon-vid.h
[root@epia linux]# make bzImage modules modules_install install
  CHK     include/linux/version.h
  CHK     include/linux/compile.h
  CHK     usr/initramfs_list
  CC [M]  drivers/hwmon/hwmon-vid.o
drivers/hwmon/hwmon-vid.c:166: error: conflicting types for ?vid_which_vrm?
include/linux/hwmon-vid.h:27: error: previous declaration of
?vid_which_vrm? was here
make[2]: *** [drivers/hwmon/hwmon-vid.o] Error 1
make[1]: *** [drivers/hwmon] Error 2
make: *** [drivers] Error 2
[root@epia linux]#

This is on a 2.6.14.2 kernel.

Any ideas?
Maybe just put in the right code file (i.e.: replace)?

Kind regards,
Udo

