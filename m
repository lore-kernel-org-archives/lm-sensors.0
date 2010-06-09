From: Roman Evstifeev <someuniquename@gmail.com>
Date: Wed, 09 Jun 2010 16:44:36 +0000
Subject: Re: [lm-sensors] fintek f71869 driver - found a working
Message-Id: <AANLkTimC0IPJLYpsV5nq_0PfbGefhiv3utklwArZcJK9@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

2010/6/9 Michael Gerst <michaelpgerst@gmail.com>
>
> So, not sure who to submit this to, but I have the fintek f71869fg chipse=
t working. =A0After going over the specs, it's nearly identical to f1882fg
> patched drivers/hwmon/f71882fg.c and set up sensors3.conf with the follow=
ing:
> ## BEGIN SENSORS3.CONF
> chip "f71869fg-*"
> =A0=A0 =A0# Voltages
> =A0=A0 =A0label in0 "+3.3V"
> =A0=A0 =A0label in1 "core"
> =A0=A0 =A0label in2 "NB"
> =A0=A0 =A0label in3 "SB +5V"
> =A0=A0 =A0label in4 "Dimm"
> =A0=A0 =A0label in5 "+5V"
> =A0=A0 =A0label in6 "+12V"
> =A0=A0 =A0label in7 "SB +3V"
> =A0=A0 =A0label in8 "BAT"
> =A0=A0 =A0ignore in9
> =A0=A0 =A0compute in0 @*2, @/2
> =A0=A0 =A0compute in3 (@ * 3.7), ( @ / 3.7)
> =A0=A0 =A0compute in4 (@ * 1.5), ( @ / 1.5)
> =A0=A0 =A0compute in5 (@ * 3.7), ( @ / 3.7)
> =A0=A0 =A0compute in6 (@ * 11), ( @ / 11)
> =A0=A0 =A0compute in7 @*2, @/2
> =A0=A0 =A0compute in8 @*2, @/2
> =A0=A0 =A0# Temperature
> =A0=A0 =A0label temp1 "CPU"
> =A0=A0 =A0label temp2 "System"
> =A0=A0 =A0label temp3 "System"
> =A0=A0 =A0# Fans
> =A0=A0 =A0label fan1 "CPU Fan"
> =A0=A0 =A0label fan2 "Sys Fan 1"
> =A0=A0 =A0label fan3 "Sys Fan 2"
> ## END SENSORS3.CONF
>
> ## BEGIN PATCH
> *** /root/f71882fg.c =A0 =A02010-05-27 19:21:26.000000000 -0500
> --- f71882fg.c =A02010-02-06 16:17:12.000000000 -0600
> ***************
> *** 48,54 ****
> =A0=A0#define SIO_F71858_ID =A0 =A0 =A0 =A0 0x0507 =A0/* Chipset ID */
> =A0=A0#define SIO_F71862_ID =A0 =A0 =A0 =A0 0x0601 =A0/* Chipset ID */
> =A0=A0#define SIO_F71882_ID =A0 =A0 =A0 =A0 0x0541 =A0/* Chipset ID */
> - #define SIO_F71869_ID =A0 =A0 =A0 =A0 0x0814 =A0/* Chipset ID */
> =A0=A0#define SIO_F71889_ID =A0 =A0 =A0 =A0 0x0723 =A0/* Chipset ID */
> =A0=A0#define SIO_F8000_ID =A0 =A0 =A0 =A0 =A00x0581 =A0/* Chipset ID */
> --- 48,53 ----
> ***************
> *** 97,103 ****
> =A0=A0module_param(force_id, ushort, 0);
> =A0=A0MODULE_PARM_DESC(force_id, "Override the detected device ID");
> ! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000, f71869fg };
> =A0=A0static const char *f71882fg_names[] =3D {
> =A0=A0 =A0 =A0 =A0"f71858fg",
> --- 96,102 ----
> =A0=A0module_param(force_id, ushort, 0);
> =A0=A0MODULE_PARM_DESC(force_id, "Override the detected device ID");
> ! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000 };
> =A0=A0static const char *f71882fg_names[] =3D {
> =A0=A0 =A0 =A0 =A0"f71858fg",
> ***************
> *** 105,111 ****
> =A0=A0 =A0 =A0 =A0"f71882fg",
> =A0=A0 =A0 =A0 =A0"f71889fg",
> =A0=A0 =A0 =A0 =A0"f8000",
> - =A0 =A0 =A0 "f71869fg"
> =A0=A0};
> =A0=A0static struct platform_device *f71882fg_pdev;
> --- 104,109 ----
> ***************
> *** 1898,1904 ****
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0ARRAY_SIZE(f71858fg_in_temp_attr));
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71882fg:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case f71869fg:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71889fg:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D f71882fg_create=
_sysfs_files(pdev,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0fxxxx_in1_alarm_attr,
> --- 1896,1901 ----
> ***************
> *** 1937,1943 ****
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D (data->pwm_enab=
le & 0x15) !=3D 0x15;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71882fg:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case f71869fg:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71889fg:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> --- 1934,1939 ----
> ***************
> *** 1959,1965 ****
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_unregister_sy=
sfs;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data->type =3D f71862fg || data->ty=
pe =3D f71882fg ||
> ! =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->type =3D f71889fg || data->ty=
pe =3D f71869fg ) {
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D f71882fg_create=
_sysfs_files(pdev,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0fxxxx_fan_beep_attr, nr_fans);
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> --- 1955,1961 ----
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_unregister_sy=
sfs;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data->type =3D f71862fg || data->ty=
pe =3D f71882fg ||
> ! =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->type =3D f71889fg) {
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D f71882fg_create=
_sysfs_files(pdev,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0fxxxx_fan_beep_attr, nr_fans);
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)
> ***************
> *** 2054,2060 ****
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0ARRAY_SIZE(f71858fg_in_temp_attr));
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71882fg:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 case f71869fg:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71889fg:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f71882fg_remove_sysfs_f=
iles(pdev,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0fxxxx_in1_alarm_attr,
> --- 2050,2055 ----
> ***************
> *** 2078,2084 ****
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_S=
IZE(fxxxx_fan_attr[0]) * nr_fans);
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data->type =3D f71862fg || data->ty=
pe =3D f71882fg ||
> ! =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->type =3D f71889fg || data->ty=
pe =3D f71869fg )
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f71882fg_remove_sysfs_f=
iles(pdev,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0fxxxx_fan_beep_attr, nr_fans);
> --- 2073,2079 ----
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_S=
IZE(fxxxx_fan_attr[0]) * nr_fans);
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data->type =3D f71862fg || data->ty=
pe =3D f71882fg ||
> ! =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->type =3D f71889fg)
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f71882fg_remove_sysfs_f=
iles(pdev,
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0fxxxx_fan_beep_attr, nr_fans);
> ***************
> *** 2133,2141 ****
> =A0=A0 =A0 =A0 =A0case SIO_F71882_ID:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sio_data->type =3D f71882fg;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> - =A0 =A0 =A0 case SIO_F71869_ID:
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data->type =3D f71869fg;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0=A0 =A0 =A0 =A0case SIO_F71889_ID:
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sio_data->type =3D f71889fg;
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> --- 2128,2133 ----
> ## END PATCH
> Again, sorry if I'm blasting this to the wrong contact.
>

1) Strange patch... it just removes all the f71869fg stuff from
driver, and does not touch f71889fg.
Are you sure, that you created diff right?

2) Can you please confirm, that you are able to control fan speed
(writing to pwm sysfs files really changes voltage) ? With current
version from 2.6.34 i am not able to do that (seee
http://lists.lm-sensors.org/pipermail/lm-sensors/2010-June/028676.html
)

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
