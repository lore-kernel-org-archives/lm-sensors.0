From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 10 Oct 2006 09:57:12 +0000
Subject: [lm-sensors] [patch 1.6.19-rc1+] hwmon/pc87360: separate {min,
Message-Id: <20061010115712.84d7c610.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4529A56C.1030507@gmail.com>
In-Reply-To: <4529A56C.1030507@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> implement separate min, max, alarms for each voltage input,
> and min, max, crit alarms for temps.

What about the fans?

> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>
> ---
> $ diffstat hwmon-pc87360-separate-alarms.patch
>  pc87360.c |  181 
> ++++++++++++++++++++++++++++++++++++++++++++++++--------------
>  1 files changed, 141 insertions(+), 40 deletions(-)
> 
> patch is against 19-rc1, you're accepting separate-alarms patches for 
> 2.6.20 now ?

Yes, I am even calling for them. I've done lm63, lm83, lm90 and f71805f
in 2.6.19 already, abituguru was already OK, and I have a patch pending
for w83627hf. All other drivers will need to be worked on, the sooner
the better.

> It passes this exersise:
> 
> #!/bin/bash
> sensors -s
> sensors
> cd /sys/class/hwmon/hwmon0/device
> function set_check {
>     local lim=$1
>     local setting=$2
>     local want=$3
>     echo $setting > $lim
>     sleep 2
>     local in=`cat ${lim}_alarm`
>     [ $in = $want ] && echo ok setting $lim $setting alarm ${lim}_alarm $in
> }
> # in8_input is 1477
> set_check in8_min 1500 1
> set_check in8_min 1400 0
> set_check in8_max 1400 1
> set_check in8_max 1500 0
> # temp3_input is 99000
> set_check temp3_min 101000 1
> set_check temp3_min 95000 0
> set_check temp3_max 95000 1
> set_check temp3_max 101000 0
> set_check temp3_crit 95000 1
> set_check temp3_crit 101000 0
> 
> The need for 'sleep 2' above made me think to reset data->valid when any 
> setter callback is called.

Hmm, I guess it makes some sense, but OTOH you don't know how much time
the hardware will take to trigger the new alarms if needed. So you may
still get a wrong reading if you rush, which means you'll still need to
sleep. There doesn't seem to be much benefit in practice.

> I didnt add it, but it seems the right thing to do.  My preference is to 
> add it into a forthcoming 2D-callback patch.

No, the preference is a different patch for every unrelated change.

> diff -ruNp -X dontdiff -X exclude-diffs 19rc1-0/drivers/hwmon/pc87360.c alarms-only/drivers/hwmon/pc87360.c
> --- 19rc1-0/drivers/hwmon/pc87360.c	2006-10-05 20:17:51.000000000 -0600
> +++ alarms-only/drivers/hwmon/pc87360.c	2006-10-08 14:43:01.000000000 -0600
> @@ -144,15 +144,14 @@ static inline u8 PWM_TO_REG(int val, int
>   * Voltage registers and conversions
>   */
>  
> +#define PC87365_REG_VID			0x06
>  #define PC87365_REG_IN_CONVRATE		0x07
>  #define PC87365_REG_IN_CONFIG		0x08
> +/* per-channel (0-13) registers */
> +#define PC87365_REG_IN_STATUS		0x0A
>  #define PC87365_REG_IN			0x0B
> -#define PC87365_REG_IN_MIN		0x0D
>  #define PC87365_REG_IN_MAX		0x0C
> -#define PC87365_REG_IN_STATUS		0x0A
> -#define PC87365_REG_IN_ALARMS1		0x00
> -#define PC87365_REG_IN_ALARMS2		0x01
> -#define PC87365_REG_VID			0x06
> +#define PC87365_REG_IN_MIN		0x0D

Please don't move things around that way, it hurts readbility. The
defines were sorted according to functionality, on purpose.

> -static ssize_t show_temp_alarms(struct device *dev, struct device_attribute *attr, char *buf)
> +static ssize_t show_temp_min_alarm(struct device *dev, struct device_attribute *devattr, char *buf)
>  {
> +	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
>  	struct pc87360_data *data = pc87360_update_device(dev);
> -	return sprintf(buf, "%u\n", data->temp_alarms);
> +	return sprintf(buf, "%u\n", (data->temp_status[attr->index] & 2) >> 1);
>  }
> -static DEVICE_ATTR(alarms_temp, S_IRUGO, show_temp_alarms, NULL);

No, it's not correct. We do not want to remove the old all-in-one alarm
files, it would break compatibility with lm-sensors. Even lm-sensors
2.10.1, which was released 2 weeks ago, doesn't support the new alarm
model yet!

So for now we are only adding the individual files. Then we teach
libsensors how to use them. Then, _much later_, we will drop the legacy
all-in-one alarm files.

As a nice side effect it will make your patch more readable :)

Thanks,
-- 
Jean Delvare

