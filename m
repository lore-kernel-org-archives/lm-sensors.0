From: dan@dogsbody.org (Dogsbody)
Date: Fri, 16 Jun 2006 14:43:14 +0000
Subject: [lm-sensors] ASUS K8V-X SE should be supported?
Message-Id: <4492C382.6090607@dogsbody.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <448F748D.5000703@dogsbody.org>
In-Reply-To: <448F748D.5000703@dogsbody.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


 > hmm, a step to install RedhatEL source code, for your reference.

Perfect, thank you.  I think this has worked fine! :-)


> Next time please do "make 2>&1 | tee make.out", give me the make.out :)

There wasn't much point before as I couldn't install the source (no 
/usr/src/linux).  However thanks to your help I have gotten much further!  it 
still errors though.... :-(

make -C /usr/src/linux M=/tmp/lm_sensors26/old modules
make[1]: Entering directory `/usr/src/redhat/BUILD/kernel-2.6.9/linux-2.6.9'
   CC [M]  /tmp/lm_sensors26/old/w83627ehf.o
In file included from /tmp/lm_sensors26/old/w83627ehf.c:44:
/tmp/lm_sensors26/old/wbplatform.h:47: error: conflicting types for 'gfp_t'
include/linux/gfp.h:134: error: previous declaration of 'gfp_t' was here
/tmp/lm_sensors26/old/wbplatform.h:49: error: conflicting types for 'kzalloc'
include/linux/slab.h:101: error: previous declaration of 'kzalloc' was here
/tmp/lm_sensors26/old/wbplatform.h:49: error: conflicting types for 'kzalloc'
include/linux/slab.h:101: error: previous declaration of 'kzalloc' was here
make[2]: *** [/tmp/lm_sensors26/old/w83627ehf.o] Error 1
make[1]: *** [_module_/tmp/lm_sensors26/old] Error 2
make[1]: Leaving directory `/usr/src/redhat/BUILD/kernel-2.6.9/linux-2.6.9'
make: *** [all] Error 2


I hope this helps!

Dan


