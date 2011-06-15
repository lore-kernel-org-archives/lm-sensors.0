From: Shubhrajyoti Datta <omaplinuxkernel@gmail.com>
Date: Wed, 15 Jun 2011 06:12:34 +0000
Subject: Re: [lm-sensors] [PATCH v8] drivers/hwmon NTC Thermistor Initial
Message-Id: <BANLkTi=LkUvOu-fM7TYK4JJis0=UWcRC4A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0483153523247035900=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1308113381-23409-1-git-send-email-dg77.kim@samsung.com>
In-Reply-To: <1308113381-23409-1-git-send-email-dg77.kim@samsung.com>
To: lm-sensors@vger.kernel.org

--===============0483153523247035900==
Content-Type: multipart/alternative; boundary=90e6ba539fa8f1f81c04a5b9de6c

--90e6ba539fa8f1f81c04a5b9de6c
Content-Type: text/plain; charset=ISO-8859-1

Hello Kim,

On Wed, Jun 15, 2011 at 10:19 AM, Donggeun Kim <dg77.kim@samsung.com> wrote:

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
>  Documentation/hwmon/ntc_thermistor           |   93 +++++
>  drivers/hwmon/Kconfig                        |   14 +
>  drivers/hwmon/Makefile                       |    1 +
>  drivers/hwmon/ntc_thermistor.c               |  477
> ++++++++++++++++++++++++++
>  include/linux/platform_data/ntc_thermistor.h |   53 +++
>  5 files changed, 638 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/hwmon/ntc_thermistor
>  create mode 100644 drivers/hwmon/ntc_thermistor.c
>  create mode 100644 include/linux/platform_data/ntc_thermistor.h
>
>
> <Snip>

> +
> +static int __devinit ntc_thermistor_probe(struct platform_device *pdev)
> +{
> +       struct ntc_data *data;
> +       struct ntc_thermistor_platform_data *pdata =
> pdev->dev.platform_data;
> +       int ret = 0, i;
> +
> +       if (!pdata) {
> +               dev_err(&pdev->dev, "No platform init data supplied.\n");
> +               return -ENODEV;
> +       }
> +
> +       /* Either one of the two is required. */
> +       if (!pdata->read_uV && !pdata->read_ohm) {
> +               dev_err(&pdev->dev, "Both read_uV and read_ohm missing."
> +                               "Need either one of the two.\n");
> +               return -EINVAL;
> +       }
> +
> +       if (pdata->read_uV && pdata->read_ohm) {
> +               dev_warn(&pdev->dev, "Only one of read_uV and read_ohm "
> +                               "is needed; ignoring read_uV.\n");
> +               pdata->read_uV = NULL;
> +       }
> +
> +       if (pdata->read_uV && (pdata->pullup_uV == 0 ||
> +                               (pdata->pullup_ohm == 0 && pdata->connect
> ==
> +                                NTC_CONNECTED_GROUND) ||
> +                               (pdata->pulldown_ohm == 0 && pdata->connect
> ==
> +                                NTC_CONNECTED_POSITIVE) ||
> +                               (pdata->connect != NTC_CONNECTED_POSITIVE
> &&
> +                                pdata->connect != NTC_CONNECTED_GROUND)))
> {
> +               dev_err(&pdev->dev, "Required data to use read_uV not "
> +                               "supplied.\n");
> +               return -EINVAL;
> +       }
> +
> +       data = kzalloc(sizeof(struct ntc_data), GFP_KERNEL);
> +       if (!data)
> +               return -ENOMEM;
> +
> +       data->dev = &pdev->dev;
> +       data->pdata = pdata;
> +       strncpy(data->name, pdev->id_entry->name, PLATFORM_NAME_SIZE);
> +
> +       switch (pdev->id_entry->driver_data) {
> +       case TYPE_NCPXXWB473:
> +               data->comp = ncpXXwb473;
> +               data->n_comp = ARRAY_SIZE(ncpXXwb473);
> +               break;
> +       case TYPE_NCPXXWL333:
> +               data->comp = ncpXXwl333;
> +               data->n_comp = ARRAY_SIZE(ncpXXwl333);
> +               break;
> +       default:
> +               dev_err(&pdev->dev, "Unknown device type: %lu(%s)\n",
> +                               pdev->id_entry->driver_data,
> +                               pdev->id_entry->name);
> +               ret = -EINVAL;
> +               goto err;
> +       }
> +
> +       data->mintemp = INT_MAX;
> +       data->maxtemp = INT_MIN;
> +
> +       /*
> +        * The compensation table is sorted by ohm value. Although it is
> +        * normally assumed that the temperature value monotonically
> +        * increases or decreases with the ohm value, but there could be
> +        * different thermistors.
> +        */
> +       for (i = 0; i < data->n_comp; i++) {
> +               if (data->comp[i].temp_C > data->maxtemp)
> +                       data->maxtemp = data->comp[i].temp_C;
> +               if (data->comp[i].temp_C < data->mintemp)
> +                       data->mintemp = data->comp[i].temp_C;
> +       }
> +
> +       if (data->mintemp != INT_MAX || data->maxtemp != INT_MIN) {
> +               dev_err(data->dev, "error in compensation table\n");
> +               ret = -EINVAL;
> +               goto err;
> +       }
>
Didnt understand this check. Shouldn't the  compensation table allowed to
modify this?

+
> +       platform_set_drvdata(pdev, data);
> +
> +       ret = sysfs_create_group(&data->dev->kobj, &ntc_attr_group);
> +       if (ret) {
> +               dev_err(data->dev, "unable to create sysfs files\n");
> +               goto err;
> +       }
> +
> +       data->hwmon_dev = hwmon_device_register(data->dev);
> +       if (IS_ERR_OR_NULL(data->hwmon_dev)) {
> +               dev_err(data->dev, "unable to register as hwmon
> device.\n");
> +               ret = -EINVAL;
> +               goto err_after_sysfs;
> +       }
> +
> +       dev_info(&pdev->dev, "Thermistor %s:%d (type: %s/%lu) successfully
> probed.\n",
> +                       pdev->name, pdev->id, pdev->id_entry->name,
> +                       pdev->id_entry->driver_data);
> +       return 0;
> +err_after_sysfs:
> +       sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
> +err:
> +       kfree(data);
> +       return ret;
> +}
> +
> +static int __devexit ntc_thermistor_remove(struct platform_device *pdev)
> +{
> +       struct ntc_data *data = platform_get_drvdata(pdev);
> +
> +       hwmon_device_unregister(data->hwmon_dev);
> +       sysfs_remove_group(&data->dev->kobj, &ntc_attr_group);
> +       platform_set_drvdata(pdev, NULL);
> +
> +       kfree(data);
> +
> +       return 0;
> +}
> +
> +static const struct platform_device_id ntc_thermistor_id[] = {
> +       { "ncp15wb473", TYPE_NCPXXWB473 },
> +       { "ncp18wb473", TYPE_NCPXXWB473 },
> +       { "ncp21wb473", TYPE_NCPXXWB473 },
> +       { "ncp03wb473", TYPE_NCPXXWB473 },
> +       { "ncp15wl333", TYPE_NCPXXWL333 },
> +       { },
> +};
> +
> +static struct platform_driver ntc_thermistor_driver = {
> +       .driver = {
> +               .name = "ntc-thermistor",
> +               .owner = THIS_MODULE,
> +       },
> +       .probe = ntc_thermistor_probe,
> +       .remove = __devexit_p(ntc_thermistor_remove),
> +       .id_table = ntc_thermistor_id,
> +};
> +
> +static int __init ntc_thermistor_init(void)
> +{
> +       return platform_driver_register(&ntc_thermistor_driver);
> +}
> +
> +module_init(ntc_thermistor_init);
> +
> +static void __exit ntc_thermistor_cleanup(void)
> +{
> +       platform_driver_unregister(&ntc_thermistor_driver);
> +}
> +
> +module_exit(ntc_thermistor_cleanup);
> +
> +MODULE_DESCRIPTION("NTC Thermistor Driver");
> +MODULE_AUTHOR("MyungJoo Ham <myungjoo.ham@samsung.com>");
> +MODULE_LICENSE("GPL");
> +MODULE_ALIAS("platform:ntc-thermistor");
> diff --git a/include/linux/platform_data/ntc_thermistor.h
> b/include/linux/platform_data/ntc_thermistor.h
> new file mode 100644
> index 0000000..abd2862
> --- /dev/null
> +++ b/include/linux/platform_data/ntc_thermistor.h
> @@ -0,0 +1,53 @@
> +/*
> + * ntc_thermistor.h - NTC Thermistors
> + *
> + *  Copyright (C) 2010 Samsung Electronics
> + *  MyungJoo Ham <myungjoo.ham@samsung.com>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
>  USA
> + */
> +#ifndef _LINUX_NTC_H
> +#define _LINUX_NTC_H
> +
> +enum ntc_thermistor_type {
> +       TYPE_NCPXXWB473,
> +       TYPE_NCPXXWL333,
> +};
> +
> +struct ntc_thermistor_platform_data {
> +       /*
> +        * One (not both) of read_uV and read_ohm should be provided and
> only
> +        * one of the two should be provided.
> +        * Both functions should return negative value for an error case.
> +        *
> +        * pullup_uV, pullup_ohm, pulldown_ohm, and connect are required to
> use
> +        * read_uV()
> +        *
> +        * How to setup pullup_ohm, pulldown_ohm, and connect is
> +        * described at Documentation/hwmon/ntc
> +        *
> +        * pullup/down_ohm: 0 for infinite / not-connected
> +        */
> +       int (*read_uV)(void);
> +       unsigned int pullup_uV;
> +
> +       unsigned int pullup_ohm;
> +       unsigned int pulldown_ohm;
> +       enum { NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND } connect;
> +
> +       int (*read_ohm)(void);
> +};
> +
> +#endif /* _LINUX_NTC_H */
> --
> 1.7.4.1
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

--90e6ba539fa8f1f81c04a5b9de6c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br>Hello Kim,<br><br><div class=3D"gmail_quote">On Wed, Jun 15, 2011 at 10=
:19 AM, Donggeun Kim <span dir=3D"ltr">&lt;<a href=3D"mailto:dg77.kim@samsu=
ng.com">dg77.kim@samsung.com</a>&gt;</span> wrote:<br><blockquote class=3D"=
gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb=
(204, 204, 204); padding-left: 1ex;">
This patch adds support for NTC Thermistor series. In this release, the<br>
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
=A0Documentation/hwmon/ntc_thermistor =A0 =A0 =A0 =A0 =A0 | =A0 93 +++++<br=
>
=A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =
=A0 14 +<br>
=A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0=
 =A01 +<br>
=A0drivers/hwmon/ntc_thermistor.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0477 ++++=
++++++++++++++++++++++<br>
=A0include/linux/platform_data/ntc_thermistor.h | =A0 53 +++<br>
=A05 files changed, 638 insertions(+), 0 deletions(-)<br>
=A0create mode 100644 Documentation/hwmon/ntc_thermistor<br>
=A0create mode 100644 drivers/hwmon/ntc_thermistor.c<br>
=A0create mode 100644 include/linux/platform_data/ntc_thermistor.h<br>
<br>
<br></blockquote><div>&lt;Snip&gt; <br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204=
, 204); padding-left: 1ex;">
+<br>
+static int __devinit ntc_thermistor_probe(struct platform_device *pdev)<br=
>
+{<br>
+ =A0 =A0 =A0 struct ntc_data *data;<br>
+ =A0 =A0 =A0 struct ntc_thermistor_platform_data *pdata =3D pdev-&gt;dev.p=
latform_data;<br>
+ =A0 =A0 =A0 int ret =3D 0, i;<br>
+<br>
+ =A0 =A0 =A0 if (!pdata) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;No platform =
init data supplied.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENODEV;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 /* Either one of the two is required. */<br>
+ =A0 =A0 =A0 if (!pdata-&gt;read_uV &amp;&amp; !pdata-&gt;read_ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Both read_uV=
 and read_ohm missing.&quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;Need ei=
ther one of the two.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (pdata-&gt;read_uV &amp;&amp; pdata-&gt;read_ohm) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_warn(&amp;pdev-&gt;dev, &quot;Only one of=
 read_uV and read_ohm &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;is need=
ed; ignoring read_uV.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdata-&gt;read_uV =3D NULL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (pdata-&gt;read_uV &amp;&amp; (pdata-&gt;pullup_uV =3D=3D =
0 ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-&gt;pu=
llup_ohm =3D=3D 0 &amp;&amp; pdata-&gt;connect =3D=3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NTC_CONNEC=
TED_GROUND) ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-&gt;pu=
lldown_ohm =3D=3D 0 &amp;&amp; pdata-&gt;connect =3D=3D<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0NTC_CONNEC=
TED_POSITIVE) ||<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (pdata-&gt;co=
nnect !=3D NTC_CONNECTED_POSITIVE &amp;&amp;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pdata-&gt;=
connect !=3D NTC_CONNECTED_GROUND))) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Required dat=
a to use read_uV not &quot;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;supplie=
d.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 data =3D kzalloc(sizeof(struct ntc_data), GFP_KERNEL);<br>
+ =A0 =A0 =A0 if (!data)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;<br>
+<br>
+ =A0 =A0 =A0 data-&gt;dev =3D &amp;pdev-&gt;dev;<br>
+ =A0 =A0 =A0 data-&gt;pdata =3D pdata;<br>
+ =A0 =A0 =A0 strncpy(data-&gt;name, pdev-&gt;id_entry-&gt;name, PLATFORM_N=
AME_SIZE);<br>
+<br>
+ =A0 =A0 =A0 switch (pdev-&gt;id_entry-&gt;driver_data) {<br>
+ =A0 =A0 =A0 case TYPE_NCPXXWB473:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;comp =3D ncpXXwb473;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;n_comp =3D ARRAY_SIZE(ncpXXwb473);<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 case TYPE_NCPXXWL333:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;comp =3D ncpXXwl333;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;n_comp =3D ARRAY_SIZE(ncpXXwl333);<b=
r>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
+ =A0 =A0 =A0 default:<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&amp;pdev-&gt;dev, &quot;Unknown devi=
ce type: %lu(%s)\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;id_e=
ntry-&gt;driver_data,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;id_e=
ntry-&gt;name);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 data-&gt;mintemp =3D INT_MAX;<br>
+ =A0 =A0 =A0 data-&gt;maxtemp =3D INT_MIN;<br>
+<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* The compensation table is sorted by ohm value. Although =
it is<br>
+ =A0 =A0 =A0 =A0* normally assumed that the temperature value monotonicall=
y<br>
+ =A0 =A0 =A0 =A0* increases or decreases with the ohm value, but there cou=
ld be<br>
+ =A0 =A0 =A0 =A0* different thermistors.<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 for (i =3D 0; i &lt; data-&gt;n_comp; i++) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;comp[i].temp_C &gt; data-&gt;max=
temp)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;maxtemp =3D data-&gt=
;comp[i].temp_C;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data-&gt;comp[i].temp_C &lt; data-&gt;min=
temp)<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;mintemp =3D data-&gt=
;comp[i].temp_C;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 if (data-&gt;mintemp !=3D INT_MAX || data-&gt;maxtemp !=3D IN=
T_MIN) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data-&gt;dev, &quot;error in compensa=
tion table\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
+ =A0 =A0 =A0 }<br></blockquote><div>Didnt understand this check. Shouldn&#=
39;t the=A0 compensation table allowed to modify this?<br><br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left:=
 1px solid rgb(204, 204, 204); padding-left: 1ex;">

+<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, data);<br>
+<br>
+ =A0 =A0 =A0 ret =3D sysfs_create_group(&amp;data-&gt;dev-&gt;kobj, &amp;n=
tc_attr_group);<br>
+ =A0 =A0 =A0 if (ret) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data-&gt;dev, &quot;unable to create =
sysfs files\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 data-&gt;hwmon_dev =3D hwmon_device_register(data-&gt;dev);<b=
r>
+ =A0 =A0 =A0 if (IS_ERR_OR_NULL(data-&gt;hwmon_dev)) {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(data-&gt;dev, &quot;unable to registe=
r as hwmon device.\n&quot;);<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EINVAL;<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_after_sysfs;<br>
+ =A0 =A0 =A0 }<br>
+<br>
+ =A0 =A0 =A0 dev_info(&amp;pdev-&gt;dev, &quot;Thermistor %s:%d (type: %s/=
%lu) successfully probed.\n&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;name, pdev-&gt;id, p=
dev-&gt;id_entry-&gt;name,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdev-&gt;id_entry-&gt;driver_=
data);<br>
+ =A0 =A0 =A0 return 0;<br>
+err_after_sysfs:<br>
+ =A0 =A0 =A0 sysfs_remove_group(&amp;data-&gt;dev-&gt;kobj, &amp;ntc_attr_=
group);<br>
+err:<br>
+ =A0 =A0 =A0 kfree(data);<br>
+ =A0 =A0 =A0 return ret;<br>
+}<br>
+<br>
+static int __devexit ntc_thermistor_remove(struct platform_device *pdev)<b=
r>
+{<br>
+ =A0 =A0 =A0 struct ntc_data *data =3D platform_get_drvdata(pdev);<br>
+<br>
+ =A0 =A0 =A0 hwmon_device_unregister(data-&gt;hwmon_dev);<br>
+ =A0 =A0 =A0 sysfs_remove_group(&amp;data-&gt;dev-&gt;kobj, &amp;ntc_attr_=
group);<br>
+ =A0 =A0 =A0 platform_set_drvdata(pdev, NULL);<br>
+<br>
+ =A0 =A0 =A0 kfree(data);<br>
+<br>
+ =A0 =A0 =A0 return 0;<br>
+}<br>
+<br>
+static const struct platform_device_id ntc_thermistor_id[] =3D {<br>
+ =A0 =A0 =A0 { &quot;ncp15wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp18wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp21wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp03wb473&quot;, TYPE_NCPXXWB473 },<br>
+ =A0 =A0 =A0 { &quot;ncp15wl333&quot;, TYPE_NCPXXWL333 },<br>
+ =A0 =A0 =A0 { },<br>
+};<br>
+<br>
+static struct platform_driver ntc_thermistor_driver =3D {<br>
+ =A0 =A0 =A0 .driver =3D {<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .name =3D &quot;ntc-thermistor&quot;,<br>
+ =A0 =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,<br>
+ =A0 =A0 =A0 },<br>
+ =A0 =A0 =A0 .probe =3D ntc_thermistor_probe,<br>
+ =A0 =A0 =A0 .remove =3D __devexit_p(ntc_thermistor_remove),<br>
+ =A0 =A0 =A0 .id_table =3D ntc_thermistor_id,<br>
+};<br>
+<br>
+static int __init ntc_thermistor_init(void)<br>
+{<br>
+ =A0 =A0 =A0 return platform_driver_register(&amp;ntc_thermistor_driver);<=
br>
+}<br>
+<br>
+module_init(ntc_thermistor_init);<br>
+<br>
+static void __exit ntc_thermistor_cleanup(void)<br>
+{<br>
+ =A0 =A0 =A0 platform_driver_unregister(&amp;ntc_thermistor_driver);<br>
+}<br>
+<br>
+module_exit(ntc_thermistor_cleanup);<br>
+<br>
+MODULE_DESCRIPTION(&quot;NTC Thermistor Driver&quot;);<br>
+MODULE_AUTHOR(&quot;MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsun=
g.com">myungjoo.ham@samsung.com</a>&gt;&quot;);<br>
+MODULE_LICENSE(&quot;GPL&quot;);<br>
+MODULE_ALIAS(&quot;platform:ntc-thermistor&quot;);<br>
diff --git a/include/linux/platform_data/ntc_thermistor.h b/include/linux/p=
latform_data/ntc_thermistor.h<br>
new file mode 100644<br>
index 0000000..abd2862<br>
--- /dev/null<br>
+++ b/include/linux/platform_data/ntc_thermistor.h<br>
@@ -0,0 +1,53 @@<br>
+/*<br>
+ * ntc_thermistor.h - NTC Thermistors<br>
+ *<br>
+ * =A0Copyright (C) 2010 Samsung Electronics<br>
+ * =A0MyungJoo Ham &lt;<a href=3D"mailto:myungjoo.ham@samsung.com">myungjo=
o.ham@samsung.com</a>&gt;<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or modify<br=
>
+ * it under the terms of the GNU General Public License as published by<br=
>
+ * the Free Software Foundation; either version 2 of the License, or<br>
+ * (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program; if not, write to the Free Software<br>
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA =A002111-1307 =
=A0USA<br>
+ */<br>
+#ifndef _LINUX_NTC_H<br>
+#define _LINUX_NTC_H<br>
+<br>
+enum ntc_thermistor_type {<br>
+ =A0 =A0 =A0 TYPE_NCPXXWB473,<br>
+ =A0 =A0 =A0 TYPE_NCPXXWL333,<br>
+};<br>
+<br>
+struct ntc_thermistor_platform_data {<br>
+ =A0 =A0 =A0 /*<br>
+ =A0 =A0 =A0 =A0* One (not both) of read_uV and read_ohm should be provide=
d and only<br>
+ =A0 =A0 =A0 =A0* one of the two should be provided.<br>
+ =A0 =A0 =A0 =A0* Both functions should return negative value for an error=
 case.<br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* pullup_uV, pullup_ohm, pulldown_ohm, and connect are req=
uired to use<br>
+ =A0 =A0 =A0 =A0* read_uV()<br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* How to setup pullup_ohm, pulldown_ohm, and connect is<br=
>
+ =A0 =A0 =A0 =A0* described at Documentation/hwmon/ntc<br>
+ =A0 =A0 =A0 =A0*<br>
+ =A0 =A0 =A0 =A0* pullup/down_ohm: 0 for infinite / not-connected<br>
+ =A0 =A0 =A0 =A0*/<br>
+ =A0 =A0 =A0 int (*read_uV)(void);<br>
+ =A0 =A0 =A0 unsigned int pullup_uV;<br>
+<br>
+ =A0 =A0 =A0 unsigned int pullup_ohm;<br>
+ =A0 =A0 =A0 unsigned int pulldown_ohm;<br>
+ =A0 =A0 =A0 enum { NTC_CONNECTED_POSITIVE, NTC_CONNECTED_GROUND } connect=
;<br>
+<br>
+ =A0 =A0 =A0 int (*read_ohm)(void);<br>
+};<br>
+<br>
+#endif /* _LINUX_NTC_H */<br>
<font color=3D"#888888">--<br>
1.7.4.1<br>
<br>
<br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><=
br>
<a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=
=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</font></blockquote></div><br>

--90e6ba539fa8f1f81c04a5b9de6c--


--===============0483153523247035900==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0483153523247035900==--
