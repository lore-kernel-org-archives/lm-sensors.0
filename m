From: quintela@mandrakesoft.com (Juan Quintela)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: lm_sensors-2.6.3: Make install failed with Mandrake-8.3
Message-Id: <m2lm9no4ao.fsf@demo.mitica>
List-Id: <lm-sensors.vger.kernel.org>
References: <1023438608.2692.2.camel@christian>
In-Reply-To: <1023438608.2692.2.camel@christian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>>>> "gagneraud" = gagneraud christian <cgagneraud@anfora.fr> writes:

gagneraud> Hi, 
gagneraud> Make install failed with my Mandrake-8.3, the reason is thier 
gagneraud> kernel's version.h that contain multiple UTS_REALEASE: 
gagneraud> --------8<-------------------------------------------- 
gagneraud> #include <linux/rhconfig.h> 
gagneraud> #if defined(__module__smp) 
gagneraud> #define UTS_RELEASE "2.4.18-6mdksmp" 
gagneraud> #elif defined(__module__enterprise) 
gagneraud> #define UTS_RELEASE "2.4.18-6mdkenterprise" 
gagneraud> #elif defined(__module__up) 
gagneraud> #define UTS_RELEASE "2.4.18-6mdk" 
gagneraud> #else 
gagneraud> #define UTS_RELEASE "2.4.18-6mdksecure" 
gagneraud> #endif 
gagneraud> #define LINUX_VERSION_CODE 132114 
gagneraud> #define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c)) 
gagneraud> --------8<-------------------------------------------- 
gagneraud> and in lm's Makefile the: 
gagneraud> MODDIR := /lib/modules/`grep UTS_RELEASE
gagneraud> $(LINUX_HEADERS)/linux/version.h|cut -f 2 -d'"'`/misc 
gagneraud> returns: 
gagneraud> --------8<-------------------------------------------- 
gagneraud> 2.4.18-6mdksmp 
gagneraud> 2.4.18-6mdkenterprise 
gagneraud> 2.4.18-6mdk 
gagneraud> 2.4.18-6mdksecure 
gagneraud> --------8<-------------------------------------------- 

gagneraud> I've just replace in the lm's Makefile with: 
gagneraud> MODDIR := /lib/modules/`uname -r`/misc 

Hi

I haven't had any problem compiling lm_sensors on Mandrake kernels
(and I compile it each time that I release a Mandarke kernel).  Notice
that When you included /usr/src/linux/include/version.h

#include <linux/rhconfig.h>
#if defined(__module__smp)
#define UTS_RELEASE "2.4.18-14mdksmp"
#elif defined(__module__enterprise)
#define UTS_RELEASE "2.4.18-14mdkenterprise"
#elif defined(__module__up)
#define UTS_RELEASE "2.4.18-14mdk"
#else
#define UTS_RELEASE "2.4.18-14mdksecure"
#endif
#define LINUX_VERSION_CODE 132114
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c))


and linux/rhconfig.h includes /boot/kernel.h, which has defined the
real __module_* thing for the kernel that you are running.

Later, Juan.



-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
