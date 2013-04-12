From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Fri, 12 Apr 2013 10:05:44 +0000
Subject: Re: [lm-sensors] [PATCH v8 0/5] Add ST-Ericsson AB8500 HWMON driver
Message-Id: <CAJLyvQxxvnA+BRQc47rpHP5K+_WVVeMJfAow7cEvkM-VzaUGSA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6634480866299555259=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1364991492-2421-1-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364991492-2421-1-git-send-email-hongbo.zhang@linaro.org>
To: lm-sensors@vger.kernel.org

--===============6634480866299555259==
Content-Type: multipart/alternative; boundary=f46d04016c39de54a304da270bde

--f46d04016c39de54a304da270bde
Content-Type: text/plain; charset=ISO-8859-1

Anton,
Guenter has acked [4/5] and [5/5], did you try to merge these patches?
If there is any conflict please let me know.
Thanks.



On 3 April 2013 20:18, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:

> Guenter and Anton,
> As suggested by Anton, I rebased these patches to his latest battery-2.6
> tree.
> Thanks.
>
> v7 -> v8 changes:
> - rebase these patches to Anton's latest battery-2.6 tree.
>
> v6 -> v7 changes:
> - move exporting symbols from [5/5] to [4/5], which was a mistake.
>
> v5 -> v6 changes:
> - add depend on AB8500_BM in Kconfig
> - fix wrong usage of clamp_val()
> - export symbols for module compiling
>
> v4 -> v5 changes:
> - split the old [2/3]-ab8500-re-arrange-ab8500-power-and-temperature-data
> into
>   new three [2/5], [3/5] and [4/5] patches.
> - hwmon driver minor coding style clean ups:
>   - {} usage in if-else statement in ab8500_read_sensor function
>   - index error fix in gpadc_monitor function
>   - fix issue of clamp_val() usage
>   - remove unnecessary else in function abx500_attrs_visible
>   - remove redundant print message about irq set up
>   - return the calling function return value directly in probe function
>
> v3 -> v4 changes:
> for patch [3/3]
> - define delays in HZ
> - update ab8500_read_sensor function, returning temp by parameter
> - remove ab8500_is_visible function
> - use clamp_val in set_min and set_max callback
> - remove unnecessary locks in remove and suspend functions
> - let abx500 and ab8500 use its own data structure
> for patch [2/3]
> - move the data tables from driver/power/ab8500_bmdata.c to
>   include/linux/power/ab8500.h
> - rename driver/power/ab8500_bmdata.c to driver/power/ab8500_bm.c
> - rename these variable names to eliminate CamelCase warnings
> - add const attribute to these data
>
> v2 -> v3 changes:
> - Add interface for converting voltage to temperature
> - Remove temp5 sensor since we cannot offer temperature read interface of
> it
> - Update hyst to use absolute temperature instead of a difference
> - Add the 3/3 patch
>
> v1 -> v2 changes:
> - Add Documentation/hwmon/abx500 and Documentation/hwmon/abx500
> - Make devices which cannot report milli-Celsius invisible
> - Add temp5_crit interface
> - Re-work the old find_active_thresholds() to threshold_updated()
> - Reset updated_min_alarm and updated_max_alarm at the end of each loop
> - Update the hyst mechamisn to make it works as real hyst
> - Remove non-stand attributes
> - Re-order the operations sequence inside probe and remove functions
> - Update all the lock usages to eliminate race conditions
> - Make attibutes index starts from 0
> also changes:
> - Since the old [1/2] "ARM: ux500: rename ab8500 to abx500 for hwmon
> driver"
>   has been merged by Samuel, so won't send it again.
> - Add another new patch "ab8500_btemp: export two symblols" as [2/2] of
> this
>   patch set.
>
> Hongbo Zhang (5):
>   ab8500_btemp: make ab8500_btemp_get* interfaces public
>   ab8500: power: eliminate CamelCase warning of some variables
>   ab8500: power: add const attributes to some data arrays
>   ab8500: power: export abx500_res_to_temp tables for hwmon
>   hwmon: add ST-Ericsson ABX500 hwmon driver
>
>  Documentation/hwmon/ab8500           |  22 ++
>  Documentation/hwmon/abx500           |  28 ++
>  drivers/hwmon/Kconfig                |  13 +
>  drivers/hwmon/Makefile               |   1 +
>  drivers/hwmon/ab8500.c               | 206 +++++++++++++++
>  drivers/hwmon/abx500.c               | 491
> +++++++++++++++++++++++++++++++++++
>  drivers/hwmon/abx500.h               |  69 +++++
>  drivers/power/ab8500_bmdata.c        |  44 ++--
>  drivers/power/ab8500_btemp.c         |   5 +-
>  drivers/power/ab8500_fg.c            |   4 +-
>  include/linux/mfd/abx500.h           |   6 +-
>  include/linux/mfd/abx500/ab8500-bm.h |   1 +
>  include/linux/power/ab8500.h         |  16 ++
>  13 files changed, 882 insertions(+), 24 deletions(-)
>  create mode 100644 Documentation/hwmon/ab8500
>  create mode 100644 Documentation/hwmon/abx500
>  create mode 100644 drivers/hwmon/ab8500.c
>  create mode 100644 drivers/hwmon/abx500.c
>  create mode 100644 drivers/hwmon/abx500.h
>  create mode 100644 include/linux/power/ab8500.h
>
> --
> 1.8.0
>
>

--f46d04016c39de54a304da270bde
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Anton,<div><span style=3D"font-family:arial,sans-serif;fon=
t-size:13px">Guenter has acked [4/5] and [5/5], did you try to merge these =
patches?</span></div><div style><span style=3D"font-family:arial,sans-serif=
;font-size:13px">If there is any conflict please let me know.</span></div>
<div style><span style=3D"font-family:arial,sans-serif;font-size:13px">Than=
ks.</span></div><div style><span style=3D"font-family:arial,sans-serif;font=
-size:13px"><br></span></div></div><div class=3D"gmail_extra"><br><br><div =
class=3D"gmail_quote">
On 3 April 2013 20:18, Hongbo Zhang <span dir=3D"ltr">&lt;<a href=3D"mailto=
:hongbo.zhang@linaro.org" target=3D"_blank">hongbo.zhang@linaro.org</a>&gt;=
</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">
Guenter and Anton,<br>
As suggested by Anton, I rebased these patches to his latest battery-2.6 tr=
ee.<br>
Thanks.<br>
<br>
v7 -&gt; v8 changes:<br>
- rebase these patches to Anton&#39;s latest battery-2.6 tree.<br>
<br>
v6 -&gt; v7 changes:<br>
- move exporting symbols from [5/5] to [4/5], which was a mistake.<br>
<br>
v5 -&gt; v6 changes:<br>
- add depend on AB8500_BM in Kconfig<br>
- fix wrong usage of clamp_val()<br>
- export symbols for module compiling<br>
<br>
v4 -&gt; v5 changes:<br>
- split the old [2/3]-ab8500-re-arrange-ab8500-power-and-temperature-data i=
nto<br>
=A0 new three [2/5], [3/5] and [4/5] patches.<br>
- hwmon driver minor coding style clean ups:<br>
=A0 - {} usage in if-else statement in ab8500_read_sensor function<br>
=A0 - index error fix in gpadc_monitor function<br>
=A0 - fix issue of clamp_val() usage<br>
=A0 - remove unnecessary else in function abx500_attrs_visible<br>
=A0 - remove redundant print message about irq set up<br>
=A0 - return the calling function return value directly in probe function<b=
r>
<br>
v3 -&gt; v4 changes:<br>
for patch [3/3]<br>
- define delays in HZ<br>
- update ab8500_read_sensor function, returning temp by parameter<br>
- remove ab8500_is_visible function<br>
- use clamp_val in set_min and set_max callback<br>
- remove unnecessary locks in remove and suspend functions<br>
- let abx500 and ab8500 use its own data structure<br>
for patch [2/3]<br>
- move the data tables from driver/power/ab8500_bmdata.c to<br>
=A0 include/linux/power/ab8500.h<br>
- rename driver/power/ab8500_bmdata.c to driver/power/ab8500_bm.c<br>
- rename these variable names to eliminate CamelCase warnings<br>
- add const attribute to these data<br>
<br>
v2 -&gt; v3 changes:<br>
- Add interface for converting voltage to temperature<br>
- Remove temp5 sensor since we cannot offer temperature read interface of i=
t<br>
- Update hyst to use absolute temperature instead of a difference<br>
- Add the 3/3 patch<br>
<br>
v1 -&gt; v2 changes:<br>
- Add Documentation/hwmon/abx500 and Documentation/hwmon/abx500<br>
- Make devices which cannot report milli-Celsius invisible<br>
- Add temp5_crit interface<br>
- Re-work the old find_active_thresholds() to threshold_updated()<br>
- Reset updated_min_alarm and updated_max_alarm at the end of each loop<br>
- Update the hyst mechamisn to make it works as real hyst<br>
- Remove non-stand attributes<br>
- Re-order the operations sequence inside probe and remove functions<br>
- Update all the lock usages to eliminate race conditions<br>
- Make attibutes index starts from 0<br>
also changes:<br>
- Since the old [1/2] &quot;ARM: ux500: rename ab8500 to abx500 for hwmon d=
river&quot;<br>
=A0 has been merged by Samuel, so won&#39;t send it again.<br>
- Add another new patch &quot;ab8500_btemp: export two symblols&quot; as [2=
/2] of this<br>
=A0 patch set.<br>
<br>
Hongbo Zhang (5):<br>
=A0 ab8500_btemp: make ab8500_btemp_get* interfaces public<br>
=A0 ab8500: power: eliminate CamelCase warning of some variables<br>
=A0 ab8500: power: add const attributes to some data arrays<br>
=A0 ab8500: power: export abx500_res_to_temp tables for hwmon<br>
=A0 hwmon: add ST-Ericsson ABX500 hwmon driver<br>
<br>
=A0Documentation/hwmon/ab8500 =A0 =A0 =A0 =A0 =A0 | =A022 ++<br>
=A0Documentation/hwmon/abx500 =A0 =A0 =A0 =A0 =A0 | =A028 ++<br>
=A0drivers/hwmon/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A013 +<br>
=A0drivers/hwmon/Makefile =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0 1 +<br>
=A0drivers/hwmon/ab8500.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 206 +++++++++++++++=
<br>
=A0drivers/hwmon/abx500.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 | 491 +++++++++++++++=
++++++++++++++++++++<br>
=A0drivers/hwmon/abx500.h =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A069 +++++<br>
=A0drivers/power/ab8500_bmdata.c =A0 =A0 =A0 =A0| =A044 ++--<br>
=A0drivers/power/ab8500_btemp.c =A0 =A0 =A0 =A0 | =A0 5 +-<br>
=A0drivers/power/ab8500_fg.c =A0 =A0 =A0 =A0 =A0 =A0| =A0 4 +-<br>
=A0include/linux/mfd/abx500.h =A0 =A0 =A0 =A0 =A0 | =A0 6 +-<br>
=A0include/linux/mfd/abx500/ab8500-bm.h | =A0 1 +<br>
=A0include/linux/power/ab8500.h =A0 =A0 =A0 =A0 | =A016 ++<br>
=A013 files changed, 882 insertions(+), 24 deletions(-)<br>
=A0create mode 100644 Documentation/hwmon/ab8500<br>
=A0create mode 100644 Documentation/hwmon/abx500<br>
=A0create mode 100644 drivers/hwmon/ab8500.c<br>
=A0create mode 100644 drivers/hwmon/abx500.c<br>
=A0create mode 100644 drivers/hwmon/abx500.h<br>
=A0create mode 100644 include/linux/power/ab8500.h<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
1.8.0<br>
<br>
</font></span></blockquote></div><br></div>

--f46d04016c39de54a304da270bde--


--===============6634480866299555259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6634480866299555259==--
