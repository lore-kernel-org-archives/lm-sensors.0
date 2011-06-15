From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Date: Wed, 15 Jun 2011 09:04:03 +0000
Subject: Re: [lm-sensors] [PATCH v9] drivers/hwmon NTC Thermistor Initial
Message-Id: <BANLkTik+3WkfLXxuysKffLBLAPTEC479fg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============3355510876260603122=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1308122532-9483-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1308122532-9483-1-git-send-email-dg77.kim@samsung.com>
To: lm-sensors@vger.kernel.org

--===============3355510876260603122==
Content-Type: multipart/alternative; boundary=bcaec54fbaf42fe1ea04a5bc44e0

--bcaec54fbaf42fe1ea04a5bc44e0
Content-Type: text/plain; charset=ISO-8859-1

Hi ,
Not a comment really was a bit curious.
Feel free to ignore such comments.

On Wed, Jun 15, 2011 at 12:52 PM, Donggeun Kim <dg77.kim@samsung.com> wrote:

> This patch adds support for NTC Thermistor series. In this release, the
> following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,
> and NCP15WL333. This driver is based on the datasheet of MURATA.
>
> The driver in the patch does conversion from the raw ADC value
> (either voltage or resistence) to temperature. In order to use
> voltage values as input, the circuit schematics should be provided
> with the platform data. A compensation table for each type of thermistor
> is provided for the conversion.
>
> Signed-off-by: Donggeun Kim <dg77.kim@samsung.com>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: KyungMin Park <kyungmin.park@samsung.com>
>
> --
> Updates
> v9
> - remove unnecessary variables(mintemp, maxtemp) and checking lines for
> them
> v8
> - remove compiler warning message
> - update Documentation/hwmon/ntc_thermistor
> - add EXPERIMENTAL Kconfig dependency
> v7
> - move header file location
> - rename header and driver file
> - style fixes
> v6
> - updated Documentation/hwmon/ntc
> - style fixes
> v5
> - use binary search on sorted table
> - removed unnecessary attributes
> - style fixes
> v4
> - put in alphabetic order in Kconfig/Makefile
> - handle additional error cases
> - remove the exported function
> v3
> - style fixes
> - removed symbol exports
> - avoid divide-by-zero
> - omitted files added (Kconfig/Makefile)
> - removed unnecessary codes
> - return error values, not default values for errors.
> v2
> - added Documentation/hwmon/ntc
> - followed hwmon sysfs
> - detached the monitoring service
> (thank you for the comments, Guenter Roeck)
> ---
>  Documentation/hwmon/ntc_thermistor           |   93 ++++++
>  drivers/hwmon/Kconfig                        |   14 +
>  drivers/hwmon/Makefile                       |    1 +
>  drivers/hwmon/ntc_thermistor.c               |  453
> ++++++++++++++++++++++++++
>  include/linux/platform_data/ntc_thermistor.h |   53 +++
>  5 files changed, 614 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/ntc_thermistor
>  create mode 100644 drivers/hwmon/ntc_thermistor.c
>  create mode 100644 include/linux/platform_data/ntc_thermistor.h
>
>
> <snip>
Why have a function starting with a  _




> +static int _ntc_thermistor_read(struct ntc_data *data, int *temp)
> +{
> +       int ret;
> +       int read_ohm, read_uV;
> +       unsigned int ohm = 0;
> +
> +       if (data->pdata->read_ohm) {
> +               read_ohm = data->pdata->read_ohm();
>

Is the platform function posted?
What errors could these functions return ?
Should we mask the errors here?


> +               if (read_ohm < 0)
> +                       return -EINVAL;
> +               ohm = (unsigned int)read_ohm;
> +       }
> +
> +       if (data->pdata->read_uV) {
> +               read_uV = data->pdata->read_uV();
>
same here

> +               if (read_uV < 0)
> +                       return -EINVAL;
> +               ohm = get_ohm_of_thermistor(data, (unsigned int)read_uV);
> +       }
> +
>

--bcaec54fbaf42fe1ea04a5bc44e0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi ,<br>Not a comment really was a bit curious.<br>Feel free to ignore such=
 comments.<br><br><div class=3D"gmail_quote">On Wed, Jun 15, 2011 at 12:52 =
PM, Donggeun Kim <span dir=3D"ltr">&lt;<a href=3D"mailto:dg77.kim@samsung.c=
om">dg77.kim@samsung.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">This patch adds s=
upport for NTC Thermistor series. In this release, the<br>
following thermistors are supported: NCP15WB473, NCP18WB473, NCP03WB473,<br=
>
and NCP15WL333. This driver is based on the datasheet of MURATA.<br>
<br>
The driver in the patch does conversion from the raw ADC value<br>
(either voltage or resistence) to temperature. In order to use<br>
voltage values as input, the circuit schematics should be provided<br>
with the platform data. A compensation table for each type of thermistor<br=
>
is provided for the conversion.<br>
<br>
Signed-off-by: Donggeun Kim &lt;<a href=3D"mailto:dg77.kim@samsung.com">dg7=
7.kim@samsung.com</a>&gt;<br>
Signed-off-by: MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsung.com"=
>myungjoo.ham@samsung.com</a>&gt;<br>
Signed-off-by: KyungMin Park &lt;<a href=3D"mailto:kyungmin.park@samsung.co=
m">kyungmin.park@samsung.com</a>&gt;<br>
<br>
--<br>
Updates<br>
v9<br>
- remove unnecessary variables(mintemp, maxtemp) and checking lines for the=
m<br>
v8<br>
- remove compiler warning message<br>
- update Documentation/hwmon/ntc_thermistor<br>
- add EXPERIMENTAL Kconfig dependency<br>
v7<br>
- move header file location<br>
- rename header and driver file<br>
- style fixes<br>
v6<br>
- updated Documentation/hwmon/ntc<br>
- style fixes<br>
v5<br>
- use binary search on sorted table<br>
- removed unnecessary attributes<br>
- style fixes<br>
v4<br>
- put in alphabetic order in Kconfig/Makefile<br>
- handle additional error cases<br>
- remove the exported function<br>
v3<br>
- style fixes<br>
- removed symbol exports<br>
- avoid divide-by-zero<br>
- omitted files added (Kconfig/Makefile)<br>
- removed unnecessary codes<br>
- return error values, not default values for errors.<br>
v2<br>
- added Documentation/hwmon/ntc<br>
- followed hwmon sysfs<br>
- detached the monitoring service<br>
(thank you for the comments, Guenter Roeck)<br>
---<br>
=A0Documentation/hwmon/ntc_thermistor =A0 =A0 =A0 =A0 =A0 | =A0 93 ++++++<b=
r>
=A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 14 +<br>
=A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +<br>
=A0drivers/hwmon/ntc_thermistor.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0453 ++++=
++++++++++++++++++++++<br>
=A0include/linux/platform_data/ntc_thermistor.h | =A0 53 +++<br>
=A05 files changed, 614 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 Documentation/hwmon/ntc_thermistor<br>
=A0create mode 100644 drivers/hwmon/ntc_thermistor.c<br>
=A0create mode 100644 include/linux/platform_data/ntc_thermistor.h<br>
<br>
<br></blockquote><div>&lt;snip&gt;<br>Why have a function starting with a=
=A0 _=A0 <br><br><br><br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); paddin=
g-left: 1ex;">

<br>
+static int _ntc_thermistor_read(struct ntc_data *data, int *temp)<br>
+{<br>
+ =A0 =A0 =A0 int ret;<br>
+ =A0 =A0 =A0 int read_ohm, read_uV;<br>
+ =A0 =A0 =A0 unsigned int ohm =3D 0;<br>
+<br>
+ =A0 =A0 =A0 if (data-&gt;pdata-&gt;read_ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_ohm =3D data-&gt;pdata-&gt;read_ohm();<b=
r></blockquote><div><br>Is the platform function posted?<br>What errors cou=
ld these functions return ?<br>Should we mask the errors here?<br>=A0<br></=
div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; b=
order-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (read_ohm &lt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohm =3D (unsigned int)read_ohm;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (data-&gt;pdata-&gt;read_uV) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_uV =3D data-&gt;pdata-&gt;read_uV();<br>=
</blockquote><div>same here <br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204);=
 padding-left: 1ex;">

+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (read_uV &lt; 0)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ohm =3D get_ohm_of_thermistor(data, (unsigned=
 int)read_uV);<br>
+ =A0 =A0 =A0 }<br>
+<br></blockquote></div><br>

--bcaec54fbaf42fe1ea04a5bc44e0--


--===============3355510876260603122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============3355510876260603122==--
