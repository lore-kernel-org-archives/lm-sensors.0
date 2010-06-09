From: Michael Gerst <michaelpgerst@gmail.com>
Date: Wed, 09 Jun 2010 13:27:01 +0000
Subject: [lm-sensors] fintek f71869 driver - found a working configuration...
Message-Id: <AANLkTil1whGAQjrVOevmq9ZXsyj3mQ6uyf_WOi8dn7Ch@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7035211150006039498=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============7035211150006039498==
Content-Type: multipart/alternative; boundary=0016e657b03a77fc11048898dc34

--0016e657b03a77fc11048898dc34
Content-Type: text/plain; charset=ISO-8859-1

So, not sure who to submit this to, but I have the fintek f71869fg chipset
working.  After going over the specs, it's nearly identical to f1882fg

patched drivers/hwmon/f71882fg.c and set up sensors3.conf with the
following:

## BEGIN SENSORS3.CONF

chip "f71869fg-*"

    # Voltages

    label in0 "+3.3V"
    label in1 "core"
    label in2 "NB"
    label in3 "SB +5V"
    label in4 "Dimm"
    label in5 "+5V"
    label in6 "+12V"
    label in7 "SB +3V"
    label in8 "BAT"
    ignore in9

    compute in0 @*2, @/2
    compute in3 (@ * 3.7), ( @ / 3.7)
    compute in4 (@ * 1.5), ( @ / 1.5)
    compute in5 (@ * 3.7), ( @ / 3.7)
    compute in6 (@ * 11), ( @ / 11)
    compute in7 @*2, @/2
    compute in8 @*2, @/2

    # Temperature

    label temp1 "CPU"
    label temp2 "System"
    label temp3 "System"

    # Fans

    label fan1 "CPU Fan"
    label fan2 "Sys Fan 1"
    label fan3 "Sys Fan 2"

## END SENSORS3.CONF


## BEGIN PATCH

*** /root/f71882fg.c    2010-05-27 19:21:26.000000000 -0500
--- f71882fg.c  2010-02-06 16:17:12.000000000 -0600
***************
*** 48,54 ****
  #define SIO_F71858_ID         0x0507  /* Chipset ID */
  #define SIO_F71862_ID         0x0601  /* Chipset ID */
  #define SIO_F71882_ID         0x0541  /* Chipset ID */
- #define SIO_F71869_ID         0x0814  /* Chipset ID */
  #define SIO_F71889_ID         0x0723  /* Chipset ID */
  #define SIO_F8000_ID          0x0581  /* Chipset ID */

--- 48,53 ----
***************
*** 97,103 ****
  module_param(force_id, ushort, 0);
  MODULE_PARM_DESC(force_id, "Override the detected device ID");

! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000, f71869fg };

  static const char *f71882fg_names[] = {
        "f71858fg",
--- 96,102 ----
  module_param(force_id, ushort, 0);
  MODULE_PARM_DESC(force_id, "Override the detected device ID");

! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000 };

  static const char *f71882fg_names[] = {
        "f71858fg",
***************
*** 105,111 ****
        "f71882fg",
        "f71889fg",
        "f8000",
-       "f71869fg"
  };

  static struct platform_device *f71882fg_pdev;
--- 104,109 ----
***************
*** 1898,1904 ****
                                        ARRAY_SIZE(f71858fg_in_temp_attr));
                        break;
                case f71882fg:
-               case f71869fg:
                case f71889fg:
                        err = f71882fg_create_sysfs_files(pdev,
                                        fxxxx_in1_alarm_attr,
--- 1896,1901 ----
***************
*** 1937,1943 ****
                        err = (data->pwm_enable & 0x15) != 0x15;
                        break;
                case f71882fg:
-               case f71869fg:
                case f71889fg:
                        err = 0;
                        break;
--- 1934,1939 ----
***************
*** 1959,1965 ****
                        goto exit_unregister_sysfs;

                if (data->type == f71862fg || data->type == f71882fg ||
!                   data->type == f71889fg || data->type == f71869fg ) {
                        err = f71882fg_create_sysfs_files(pdev,
                                        fxxxx_fan_beep_attr, nr_fans);
                        if (err)
--- 1955,1961 ----
                        goto exit_unregister_sysfs;

                if (data->type == f71862fg || data->type == f71882fg ||
!                   data->type == f71889fg) {
                        err = f71882fg_create_sysfs_files(pdev,
                                        fxxxx_fan_beep_attr, nr_fans);
                        if (err)
***************
*** 2054,2060 ****
                                        ARRAY_SIZE(f71858fg_in_temp_attr));
                        break;
                case f71882fg:
-               case f71869fg:
                case f71889fg:
                        f71882fg_remove_sysfs_files(pdev,
                                        fxxxx_in1_alarm_attr,
--- 2050,2055 ----
***************
*** 2078,2084 ****
                                ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);

                if (data->type == f71862fg || data->type == f71882fg ||
!                   data->type == f71889fg || data->type == f71869fg )
                        f71882fg_remove_sysfs_files(pdev,
                                        fxxxx_fan_beep_attr, nr_fans);

--- 2073,2079 ----
                                ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);

                if (data->type == f71862fg || data->type == f71882fg ||
!                   data->type == f71889fg)
                        f71882fg_remove_sysfs_files(pdev,
                                        fxxxx_fan_beep_attr, nr_fans);

***************
*** 2133,2141 ****
        case SIO_F71882_ID:
                sio_data->type = f71882fg;
                break;
-       case SIO_F71869_ID:
-               sio_data->type = f71869fg;
-               break;
        case SIO_F71889_ID:
                sio_data->type = f71889fg;
                break;
--- 2128,2133 ----

## END PATCH

Again, sorry if I'm blasting this to the wrong contact.

--0016e657b03a77fc11048898dc34
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

So, not sure who to submit this to, but I have the fintek f71869fg chipset =
working. =A0After going over the specs, it&#39;s nearly identical to f1882f=
g<div><br></div><div>patched drivers/hwmon/f71882fg.c and set up sensors3.c=
onf with the following:</div>
<div><br></div><div>## BEGIN SENSORS3.CONF</div><div><div><br></div><div>ch=
ip &quot;f71869fg-*&quot;</div><div><br></div><div>=A0=A0 =A0# Voltages</di=
v><div><br></div><div>=A0=A0 =A0label in0 &quot;+3.3V&quot;</div><div>=A0=
=A0 =A0label in1 &quot;core&quot;</div>
<div>=A0=A0 =A0label in2 &quot;NB&quot;</div><div>=A0=A0 =A0label in3 &quot=
;SB +5V&quot;</div><div>=A0=A0 =A0label in4 &quot;Dimm&quot;</div><div>=A0=
=A0 =A0label in5 &quot;+5V&quot;</div><div>=A0=A0 =A0label in6 &quot;+12V&q=
uot;</div><div>=A0=A0 =A0label in7 &quot;SB +3V&quot;</div>
<div>=A0=A0 =A0label in8 &quot;BAT&quot;</div><div>=A0=A0 =A0ignore in9</di=
v><div><br></div><div>=A0=A0 =A0compute in0 @*2, @/2</div><div>=A0=A0 =A0co=
mpute in3 (@ * 3.7), ( @ / 3.7)</div><div>=A0=A0 =A0compute in4 (@ * 1.5), =
( @ / 1.5)</div><div>=A0=A0 =A0compute in5 (@ * 3.7), ( @ / 3.7)</div>
<div>=A0=A0 =A0compute in6 (@ * 11), ( @ / 11)</div><div>=A0=A0 =A0compute =
in7 @*2, @/2</div><div>=A0=A0 =A0compute in8 @*2, @/2</div><div><br></div><=
div>=A0=A0 =A0# Temperature</div><div><br></div><div>=A0=A0 =A0label temp1 =
&quot;CPU&quot;</div><div>
=A0=A0 =A0label temp2 &quot;System&quot;</div><div>=A0=A0 =A0label temp3 &q=
uot;System&quot;</div><div><br></div><div>=A0=A0 =A0# Fans</div><div><br></=
div><div>=A0=A0 =A0label fan1 &quot;CPU Fan&quot;</div><div>=A0=A0 =A0label=
 fan2 &quot;Sys Fan 1&quot;</div>
<div>=A0=A0 =A0label fan3 &quot;Sys Fan 2&quot;</div><div><br></div></div><=
div>## END SENSORS3.CONF</div><div><br></div><div><br></div><div>## BEGIN P=
ATCH</div><div><br></div><div><div>*** /root/f71882fg.c =A0 =A02010-05-27 1=
9:21:26.000000000 -0500</div>
<div>--- f71882fg.c =A02010-02-06 16:17:12.000000000 -0600</div><div>******=
*********</div><div>*** 48,54 ****</div><div>=A0=A0#define SIO_F71858_ID =
=A0 =A0 =A0 =A0 0x0507 =A0/* Chipset ID */</div><div>=A0=A0#define SIO_F718=
62_ID =A0 =A0 =A0 =A0 0x0601 =A0/* Chipset ID */</div>
<div>=A0=A0#define SIO_F71882_ID =A0 =A0 =A0 =A0 0x0541 =A0/* Chipset ID */=
</div><div>- #define SIO_F71869_ID =A0 =A0 =A0 =A0 0x0814 =A0/* Chipset ID =
*/</div><div>=A0=A0#define SIO_F71889_ID =A0 =A0 =A0 =A0 0x0723 =A0/* Chips=
et ID */</div><div>=A0=A0#define SIO_F8000_ID =A0 =A0 =A0 =A0 =A00x0581 =A0=
/* Chipset ID */</div>
<div><br></div><div>--- 48,53 ----</div><div>***************</div><div>*** =
97,103 ****</div><div>=A0=A0module_param(force_id, ushort, 0);</div><div>=
=A0=A0MODULE_PARM_DESC(force_id, &quot;Override the detected device ID&quot=
;);</div>
<div><br></div><div>! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, =
f8000, f71869fg };</div><div><br></div><div>=A0=A0static const char *f71882=
fg_names[] =3D {</div><div>=A0=A0 =A0 =A0 =A0&quot;f71858fg&quot;,</div><di=
v>--- 96,102 ----</div>
<div>=A0=A0module_param(force_id, ushort, 0);</div><div>=A0=A0MODULE_PARM_D=
ESC(force_id, &quot;Override the detected device ID&quot;);</div><div><br><=
/div><div>! enum chips { f71858fg, f71862fg, f71882fg, f71889fg, f8000 };</=
div>
<div><br></div><div>=A0=A0static const char *f71882fg_names[] =3D {</div><d=
iv>=A0=A0 =A0 =A0 =A0&quot;f71858fg&quot;,</div><div>***************</div><=
div>*** 105,111 ****</div><div>=A0=A0 =A0 =A0 =A0&quot;f71882fg&quot;,</div=
><div>=A0=A0 =A0 =A0 =A0&quot;f71889fg&quot;,</div>
<div>=A0=A0 =A0 =A0 =A0&quot;f8000&quot;,</div><div>- =A0 =A0 =A0 &quot;f71=
869fg&quot;</div><div>=A0=A0};</div><div><br></div><div>=A0=A0static struct=
 platform_device *f71882fg_pdev;</div><div>--- 104,109 ----</div><div>*****=
**********</div><div>
*** 1898,1904 ****</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(f71858fg_in_temp_attr));</di=
v><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;</div><div>=
=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71882fg:</div><div>- =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 case f71869fg:</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71889fg:</div><div>=A0=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D f71882fg_create_sysfs_files(=
pdev,</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0fxxxx_in1_alarm_attr,</div><div>--- 1896,1901 ----</=
div><div>
***************</div><div>*** 1937,1943 ****</div><div>=A0=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D (data-&gt;pwm_enable &amp; 0x15) !=
=3D 0x15;</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break=
;</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71882fg:</div><div>- =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 case f71869fg:</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71889fg:</div><div>=A0=A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D 0;</div><div>=A0=A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;</div><div>--- 1934,1939 ----</div=
><div>***************</div><div>*** 1959,1965 ****</div><div>=A0=A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_unregister_sysfs;</div>
<div><br></div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data-&gt;type =3D=
=3D f71862fg || data-&gt;type =3D=3D f71882fg ||</div><div>! =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 data-&gt;type =3D=3D f71889fg || data-&gt;type =3D=
=3D f71869fg ) {</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0err =3D f71882fg_create_sysfs_files(pdev,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0fxxxx_fan_beep_attr, nr_fans);</div><div>=A0=A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)</div><div>--- 1955,1961 ----</div><div=
>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto exit_unregister_sys=
fs;</div><div><br>
</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data-&gt;type =3D=3D f7186=
2fg || data-&gt;type =3D=3D f71882fg ||</div><div>! =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 data-&gt;type =3D=3D f71889fg) {</div><div>=A0=A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D f71882fg_create_sysfs_files(pdev,</d=
iv>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0fxxxx_fan_beep_attr, nr_fans);</div><div>=A0=A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err)</div><div>***************</div><div>**=
* 2054,2060 ****</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(f71858fg_in_temp_attr));</div=
>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;</div><div>=A0=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case f71882fg:</div><div>- =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 case f71869fg:</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0case=
 f71889fg:</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0f718=
82fg_remove_sysfs_files(pdev,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0fxxxx_in1_alarm_attr,</div><div>--- 2050,2055 ----</div><div>**=
*************</div><div>*** 2078,2084 ****</div><div>=A0=A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(fxxxx_fan_attr[0]) *=
 nr_fans);</div>
<div><br></div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data-&gt;type =3D=
=3D f71862fg || data-&gt;type =3D=3D f71882fg ||</div><div>! =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 data-&gt;type =3D=3D f71889fg || data-&gt;type =3D=
=3D f71869fg )</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
f71882fg_remove_sysfs_files(pdev,</div>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0fxxxx_fan_beep_attr, nr_fans);</div><div><br></div><div>--- 207=
3,2079 ----</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0ARRAY_SIZE(fxxxx_fan_attr[0]) * nr_fans);</div><div><br></di=
v>
<div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (data-&gt;type =3D=3D f71862fg ||=
 data-&gt;type =3D=3D f71882fg ||</div><div>! =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 data-&gt;type =3D=3D f71889fg)</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0f71882fg_remove_sysfs_files(pdev,</div><div>=A0=A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
fxxxx_fan_beep_attr, nr_fans);</div>
<div><br></div><div>***************</div><div>*** 2133,2141 ****</div><div>=
=A0=A0 =A0 =A0 =A0case SIO_F71882_ID:</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0sio_data-&gt;type =3D f71882fg;</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0break;</div><div>- =A0 =A0 =A0 case SIO_F71869_ID:</div>
<div>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 sio_data-&gt;type =3D f71869fg;</div><di=
v>- =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;</div><div>=A0=A0 =A0 =A0 =A0case SIO=
_F71889_ID:</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0sio_data-&gt;type =
=3D f71889fg;</div><div>=A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;</div><div>
--- 2128,2133 ----</div></div><div><br></div><div>## END PATCH</div><div><b=
r></div><div>Again, sorry if I&#39;m blasting this to the wrong contact.=A0=
</div><div><br></div><div><br></div><div><br></div>

--0016e657b03a77fc11048898dc34--


--===============7035211150006039498==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7035211150006039498==--
