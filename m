From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: Problems with W83791D driver
Message-Id: <3ED99C0B.9040006@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm working on my ADM1026 patch for CVS and I've decided to work in something 
else that was bugging me.

Namely, the change in kernel/include/sensors.h that means the #define's are 
duplicated in sensors.h and in the individual drivers.  It's bugged me since I 
first heard about it.

I've modified the Module.mk in kernel/include to create sensors.h on the fly 
from the SYSCTL START/END stuff in each of the chips/*.c files.

It works great, except that the following #defines existed in the original 
sensors.h but not in any of the kernel/chips/*.c files.  The real problem 
though is that they *are* referenced in lib/chips.c!!!

lib/chips.c:1218: `W83781D_SYSCTL_IN9' undeclared here (not in a function)
lib/chips.c:1248: `W83781D_SYSCTL_IN9' undeclared here (not in a function)
lib/chips.c:1278: `W83781D_SYSCTL_IN9' undeclared here (not in a function)
lib/chips.c:1286: `W83781D_SYSCTL_FAN4' undeclared here (not in a function)
lib/chips.c:1288: `W83781D_SYSCTL_FAN5' undeclared here (not in a function)
lib/chips.c:1300: `W83781D_SYSCTL_FAN4' undeclared here (not in a function)
lib/chips.c:1303: `W83781D_SYSCTL_FAN5' undeclared here (not in a function)

These seem to be associated with the W837_9_1D support that was recently? 
commited.

Which leads to the next question which is...  Which chip driver actually 
implements support for the W83791D?  A grep for w83791d doesn't turn up any 
*actual* support...

[root@eng184 lm_sensors2]# find . -type f -print | xargs grep w83791d
./CHANGES:           add lm85 support; add w83791d support
./CHANGES:  Program sensors: add lm85 support; add w83791d support
./lib/chips.c:static sensors_chip_feature w83791d_features[] ./lib/chips.c: { SENSORS_W83791D_PREFIX, w83791d_features },
./lib/chips.h:#define SENSORS_W83791D_PREFIX "w83791d"
./prog/sensors/main.c:           (!strcmp(name.prefix,"w83791d")) ||

Which driver is supposed to support this chip?

And finally, why do both the w83627hf.c and w83781d.c drivers exist.  They use 
the *same* list of #define entries (W83781D) and appear to be 80% or more 
identical.  I know that the w83781d driver is complicated, but when did the 
w83627hf driver get created and what does it support?  The w83781d driver has 
"kind" types for the 627hf and 697hf which are they only kinds in the other 
driver.

:v)
