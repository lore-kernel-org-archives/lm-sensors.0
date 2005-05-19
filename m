From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <3E1F905C.50501@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

looks good to me

Albert Cranford wrote:
> Mark Studebaker wrote:
> 
>>Kyosti Malkki wrote:
>>
>>>On Sat, 4 Jan 2003, Mark Studebaker wrote:
>>>
>>>
>>>
>>>>The patch for i2c-amd756, i2c-amd8111, adm1021, and lm75,
>>>>submitted by Pavel Machek, has been included,
>>>>with modifications, in kernel 2.5.54 by Cristoph Hellwig.
>>>
>>>
>>>Attached patch removes unnecessary include of i2c header files
>>>at few locations. With luck it still compiles. Should..
>>>
>>>It seems that sysctl enumeration has moved out of sensors.h, but
>>>libsensors depends on this. While the list is long and boring, so is
>>>linux/sysctl.h. I believe we want it back.
>>>
>>
>>agreed
>>
> 
> Let me see if I can get sensors.h into the kernel along
> with changes below to adm1021.c and lm75.c.  What do you
> think?  I need to tweek sensors.h. OK?
> Albert
> --- lm_sensors-2.7.0/kernel/include/sensors.h   2002-11-15 21:02:44.000000000 -0500
> +++ linux/include/linux/sensors.h       2003-01-07 21:45:33.000000000 -0500
> @@ -18,8 +18,11 @@
>      Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>  */
>  
> -#ifndef SENSORS_NSENSORS_H
> -#define SENSORS_NSENSORS_H
> +#ifndef _LINUX_SENSORS_H
> +#define _LINUX_SENSORS_H
> +
> +#define LM_DATE "20021208"
> +#define LM_VERSION "2.7.0"
>  
>  #include <linux/i2c-proc.h>
>  
> @@ -690,4 +693,4 @@
>  #define BMC_SYSCTL_ALARMS 5000
>  
>  
> -#endif                         /* def SENSORS_SENSORS_H */
> +#endif /* _LINUX_SENSORS_H */
> --- linux-2.5.54/drivers/i2c/chips/adm1021.c.orig       2003-01-07 22:09:46.000000000 -0500
> +++ linux/drivers/i2c/chips/adm1021.c   2003-01-07 22:28:38.000000000 -0500
> @@ -23,21 +23,9 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-proc.h>
> +#include <linux/sensors.h>
>  #include <linux/init.h>
>  
> -/* Registers */
> -#define ADM1021_SYSCTL_TEMP            1200
> -#define ADM1021_SYSCTL_REMOTE_TEMP     1201
> -#define ADM1021_SYSCTL_DIE_CODE                1202
> -#define ADM1021_SYSCTL_ALARMS          1203
> -
> -#define ADM1021_ALARM_TEMP_HIGH                0x40
> -#define ADM1021_ALARM_TEMP_LOW         0x20
> -#define ADM1021_ALARM_RTEMP_HIGH       0x10
> -#define ADM1021_ALARM_RTEMP_LOW                0x08
> -#define ADM1021_ALARM_RTEMP_NA         0x04
> -
>  /* Addresses to scan */
>  static unsigned short normal_i2c[] = { SENSORS_I2C_END };
>  static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
> --- linux-2.5.54/drivers/i2c/chips/lm75.c.orig  2003-01-07 22:04:47.000000000 -0500
> +++ linux/drivers/i2c/chips/lm75.c      2003-01-07 22:28:52.000000000 -0500
> @@ -22,12 +22,10 @@
>  #include <linux/module.h>
>  #include <linux/slab.h>
>  #include <linux/i2c.h>
> -#include <linux/i2c-proc.h>
> +#include <linux/sensors.h>
>  #include <linux/init.h>
>  
>  
> -#define LM75_SYSCTL_TEMP 1200  /* Degrees Celcius * 10 */
> -
>  /* Addresses to scan */
>  static unsigned short normal_i2c[] = { SENSORS_I2C_END };
>  static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
