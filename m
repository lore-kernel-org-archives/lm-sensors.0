From: cgagneraud@anfora.fr (gagneraud christian)
Date: Thu, 19 May 2005 06:23:34 +0000
Subject: lm_sensors-2.6.3: Make install failed with Mandrake-8.3
Message-Id: <1023438608.2692.2.camel@christian>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, 

Make install failed with my Mandrake-8.3, the reason is thier 
kernel's version.h that contain multiple UTS_REALEASE: 
--------8<-------------------------------------------- 
#include <linux/rhconfig.h> 
#if defined(__module__smp) 
#define UTS_RELEASE "2.4.18-6mdksmp" 
#elif defined(__module__enterprise) 
#define UTS_RELEASE "2.4.18-6mdkenterprise" 
#elif defined(__module__up) 
#define UTS_RELEASE "2.4.18-6mdk" 
#else 
#define UTS_RELEASE "2.4.18-6mdksecure" 
#endif 
#define LINUX_VERSION_CODE 132114 
#define KERNEL_VERSION(a,b,c) (((a) << 16) + ((b) << 8) + (c)) 
--------8<-------------------------------------------- 
and in lm's Makefile the: 
MODDIR := /lib/modules/`grep UTS_RELEASE
$(LINUX_HEADERS)/linux/version.h|cut -f 2 -d'"'`/misc 
returns: 
--------8<-------------------------------------------- 
2.4.18-6mdksmp 
2.4.18-6mdkenterprise 
2.4.18-6mdk 
2.4.18-6mdksecure 
--------8<-------------------------------------------- 

I've just replace in the lm's Makefile with: 
MODDIR := /lib/modules/`uname -r`/misc 


Congratulations for the package 

Christian



-- 
/**********************************************
* Christian Gagneraud
***********************************************
* cgagneraud@anfora.fr
***********************************************
* ANFORA
* bat Actys, Voie3
* 31313 Lab?ge Innopole
* FRANCE
***********************************************/
