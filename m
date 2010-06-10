From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 10 Jun 2010 08:29:45 +0000
Subject: Re: [lm-sensors] fintek f71869 driver - found a working
Message-Id: <4C10A279.20304@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <AANLkTimC0IPJLYpsV5nq_0PfbGefhiv3utklwArZcJK9@mail.gmail.com>
In-Reply-To: <AANLkTimC0IPJLYpsV5nq_0PfbGefhiv3utklwArZcJK9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Can you please supply your patch in unified diff format (diff -u) then
I'll take a closer look at it. Most likely some more changes will be
needed but it is a start (all fintek devices tend to be nearly identical,
yet not identical at all).

Regards,

Hans


On 06/09/2010 03:27 PM, Michael Gerst wrote:
> So, not sure who to submit this to, but I have the fintek f71869fg
> chipset working.  After going over the specs, it's nearly identical to
> f1882fg
>
> patched drivers/hwmon/f71882fg.c and set up sensors3.conf with the
> following:
>
> ## BEGIN SENSORS3.CONF
>
> chip "f71869fg-*"
>
>      # Voltages
>
>      label in0 "+3.3V"
>      label in1 "core"
>      label in2 "NB"
>      label in3 "SB +5V"
>      label in4 "Dimm"
>      label in5 "+5V"
>      label in6 "+12V"
>      label in7 "SB +3V"
>      label in8 "BAT"
>      ignore in9
>
>      compute in0 @*2, @/2
>      compute in3 (@ * 3.7), ( @ / 3.7)
>      compute in4 (@ * 1.5), ( @ / 1.5)
>      compute in5 (@ * 3.7), ( @ / 3.7)
>      compute in6 (@ * 11), ( @ / 11)
>      compute in7 @*2, @/2
>      compute in8 @*2, @/2
>
>      # Temperature
>
>      label temp1 "CPU"
>      label temp2 "System"
>      label temp3 "System"
>
>      # Fans
>
>      label fan1 "CPU Fan"
>      label fan2 "Sys Fan 1"
>      label fan3 "Sys Fan 2"
>
> ## END SENSORS3.CONF
>
>
> ## BEGIN PATCH
>
> *** /root/f71882fg.c    2010-05-27 19:21:26.000000000 -0500
> --- f71882fg.c  2010-02-06 16:17:12.000000000 -0600
> ***************
> *** 48,54 ****
>    #define SIO_F71858_ID         0x0507  /* Chipset ID */
>    #define SIO_F71862_ID         0x0601  /* Chipset ID */
>    #define SIO_F71882_ID         0x0541  /* Chipset ID */
> - #define SIO_F71869_ID         0x0814  /* Chipset ID */
>    #define SIO_F71889_ID         0x0723  /* Chipset ID */
>    #define SIO_F8000_ID          0x0581  /* Chipset ID */
>
> --- 48,53 ----
> ***************
> *** 97,103 ****
>    module_param(force_id, ushort, 0);
>    MODULE_PARM_DESC(force_id, "Override the detected device ID");
>
> ! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000, f71869fg };
>
>    static const char *f71882fg_names[] = {
> "f71858fg",
> --- 96,102 ----
>    module_param(force_id, ushort, 0);
>    MODULE_PARM_DESC(force_id, "Override the detected device ID");
>
> ! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000 };
>
>    static const char *f71882fg_names[] = {
> "f71858fg",
> ***************
> *** 105,111 ****
> "f71882fg",
> "f71889fg",
> "f8000",
> - "f71869fg"
>    };
>
>    static struct platform_device *f71882fg_pdev;
> --- 104,109 ----
> ***************
> *** 1898,1904 ****
>                                          ARRAY_SIZE(f71858fg_in_temp_attr));
>                          break;
>                  case f71882fg:
> -               case f71869fg:
>                  case f71889fg:
>                          err = f71882fg_create_sysfs_files(pdev,
>                                          fxxxx_in1_alarm_attr,
> --- 1896,1901 ----
> ***************
> *** 1937,1943 ****
>                          err = (data->pwm_enable & 0x15) != 0x15;
>                          break;
>                  case f71882fg:
> -               case f71869fg:
>                  case f71889fg:
>                          err = 0;
>                          break;
> --- 1934,1939 ----
> ***************
> *** 1959,1965 ****
>                          goto exit_unregister_sysfs;
>
>                  if (data->type = f71862fg || data->type = f71882fg ||
> !                   data->type = f71889fg || data->type = f71869fg ) {
>                          err = f71882fg_create_sysfs_files(pdev,
>                                          fxxxx_fan_beep_attr, nr_fans);
>                          if (err)
> --- 1955,1961 ----
>                          goto exit_unregister_sysfs;
>
>                  if (data->type = f71862fg || data->type = f71882fg ||
> !                   data->type = f71889fg) {
>                          err = f71882fg_create_sysfs_files(pdev,
>                                          fxxxx_fan_beep_attr, nr_fans);
>                          if (err)
> ***************
> *** 2054,2060 ****
>                                          ARRAY_SIZE(f71858fg_in_temp_attr));
>                          break;
>                  case f71882fg:
> -               case f71869fg:
>                  case f71889fg:
>                          f71882fg_remove_sysfs_files(pdev,
>                                          fxxxx_in1_alarm_attr,
> --- 2050,2055 ----
> ***************
> *** 2078,2084 ****
>                                  ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
>
>                  if (data->type = f71862fg || data->type = f71882fg ||
> !                   data->type = f71889fg || data->type = f71869fg )
>                          f71882fg_remove_sysfs_files(pdev,
>                                          fxxxx_fan_beep_attr, nr_fans);
>
> --- 2073,2079 ----
>                                  ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);
>
>                  if (data->type = f71862fg || data->type = f71882fg ||
> !                   data->type = f71889fg)
>                          f71882fg_remove_sysfs_files(pdev,
>                                          fxxxx_fan_beep_attr, nr_fans);
>
> ***************
> *** 2133,2141 ****
>          case SIO_F71882_ID:
>                  sio_data->type = f71882fg;
>                  break;
> -       case SIO_F71869_ID:
> -               sio_data->type = f71869fg;
> -               break;
>          case SIO_F71889_ID:
>                  sio_data->type = f71889fg;
>                  break;
> --- 2128,2133 ----
>
> ## END PATCH
>
> Again, sorry if I'm blasting this to the wrong contact.
>
>
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
