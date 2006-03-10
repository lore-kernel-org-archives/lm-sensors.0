From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 10 Mar 2006 15:28:29 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <44119B1D.10100@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>
> Please check in your kernel configuration if you have some kernel-wide
> debugging option set. These options are under Kernel hacking > Kernel
> debugging (most of them are named CONFIG_DEBUG_*, but not all).
>
> I remember that Jim Cromie reported similarly incredible sizes when he
> was working on the pc87360 driver. I don't remember what the cause was
> (if I ever knew it).
>   

It never came up that they were 'incredible', but you did comment on 
DEBUG and
the validity of size comparisons.  Ive got various kernels lying around, 
the sizes of
the .ko files is either ~30kb or ~135kb.

Various DEBUG flags are strong determining factors, but Ive not turned 
the flags off,
as they dont interfere with checking sizes before & after other patches.

FWIW, /usr/bin/size gives more info than wc or ls -l, and it seems to 
eliminate
some of the 'noise' in the results, esp those due to CONFIG diffs

soekris:/lib/modules# size `find . -name pc87360.ko `
   text    data     bss     dec     hex filename
  14893    3400      16   18309    4785 
./2.6.16-rc5-mm2/kernel/drivers/hwmon/pc87360.ko
  13370    2780      16   16166    3f26 
./2.6.15-sk/kernel/drivers/hwmon/pc87360.ko
  12029    2972      16   15017    3aa9 
./2.6.15.1-ipipe-103-sony/kernel/drivers/hwmon/pc87360.ko 
  13876    3085      16   16977    4251 
./2.6.14-1.1656_FC4/kernel/drivers/hwmon/pc87360.ko
  12029    2972      16   15017    3aa9 
./2.6.15-ipipe-103-sony/kernel/drivers/hwmon/pc87360.ko
  13800    3085      16   16901    4205 
./2.6.15-1.1831_FC4/kernel/drivers/hwmon/pc87360.ko
  13806    2740      16   16562    40b2 
./2.6.16-rc5-sk/kernel/drivers/hwmon/pc87360.ko
  11894    3276      16   15186    3b52 
./2.6.16-rc1-sony/kernel/drivers/hwmon/pc87360.ko
  13800    3085      16   16901    4205 
./2.6.15-1.1830_FC4/kernel/drivers/hwmon/pc87360.ko
  13869    3368      16   17253    4365 
./2.6.15-mm4-sony/kernel/drivers/hwmon/pc87360.ko
  13117    2780      16   15913    3e29 
./2.6.15.6-sk/kernel/drivers/hwmon/pc87360.ko
  13117    2780      16   15913    3e29 
./2.6.15.6-ipipe-121-sk/kernel/drivers/hwmon/pc87360.ko
  14572    3176      16   17764    4564 
./2.6.16-rc5-mm2-sk/kernel/drivers/hwmon/pc87360.ko


BTW, I'll take this (on-topic) opportunity to remind you of  2 patches I 
sent on 1/26:

1. hwmon-pc87360-use-sensor-attr-2.patch

This converts SENSOR_ATTRs to SENSOR_ATTR_2s,
and add a bunch of #defines for the new member's values.

2. hwmon-pc87360-sysfs-combo-callbacks.patch

This combines individual  (show|set)_Sensor_Attr callbacks into
(show|set)_Sensor callbacks that handle all that Sensor's Attrs.

this results in a non-trivial size reduction (b4, after)
14588    3224      16   17828    45a4 A-2/drivers/hwmon/pc87360.ko
13124    3224      16   16364    3fec A-3/drivers/hwmon/pc87360.ko
ie about 10%

Combining all show_X (for all X) together is possible, but would 
compromise clarity,
and would save only ~ 1/5 th additional space.


hth ;-)
-jimc

