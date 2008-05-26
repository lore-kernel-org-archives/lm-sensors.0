From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 26 May 2008 23:37:03 +0000
Subject: Re: [lm-sensors] dme1737 under CentOS 2.6.18 kernel
Message-Id: <191fb4ca0805261637j7f80612ax48fa3f0a057bea2d@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============1675064731519122406=="
List-Id: <lm-sensors.vger.kernel.org>
References: <9557.11526-6111-934845850-1211828908@email.cz>
In-Reply-To: <9557.11526-6111-934845850-1211828908@email.cz>
To: lm-sensors@vger.kernel.org

--===============1675064731519122406==
Content-Type: multipart/alternative; 
	boundary="----=_Part_3185_2340489.1211845023998"

------=_Part_3185_2340489.1211845023998
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jaroslav,


On Mon, May 26, 2008 at 12:08 PM, Jaroslav Vacha <vacha@email.cz> wrote:

> Hi,
>   I'm trying to compile dme1737 driver under  CentOS 5.1 with
> 2.6.18-53.1.21.el5 kernel to support VIA EPIA-SN 18000G motherboard sensors.
>   Followed Juerg's instruction from post
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022166.html
>
>   Code compiled with warnings:
>
> #make all
> make -C /lib/modules/`uname -r`/build M=/install/lm_sensors/driver modules
> make[1]: Entering directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686'
>   CC [M]  /install/lm_sensors/driver/dme1737.o
> /install/lm_sensors/driver/dme1737.c:55: warning: initialization discards
> qualifiers from pointer target type
> /install/lm_sensors/driver/dme1737.c: In function 'dme1737_i2c_detect':
> /install/lm_sensors/driver/dme1737.c:2139: warning: assignment from
> incompatible pointer type
> /install/lm_sensors/driver/dme1737.c: In function
> 'dme1737_i2c_detach_client':
> /install/lm_sensors/driver/dme1737.c:2172: warning: passing argument 1 of
> 'hwmon_device_unregister' from incompatible pointer type
> /install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_probe':
> /install/lm_sensors/driver/dme1737.c:2324: warning: assignment from
> incompatible pointer type
> /install/lm_sensors/driver/dme1737.c: In function 'dme1737_isa_remove':
> /install/lm_sensors/driver/dme1737.c:2348: warning: passing argument 1 of
> 'hwmon_device_unregister' from incompatible pointer type
>   Building modules, stage 2.
>   MODPOST
>   CC      /install/lm_sensors/driver/dme1737.mod.o
>   LD [M]  /install/lm_sensors/driver/dme1737.ko
> make[1]: Leaving directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686'
> [root@server driver]#
>
>   dme1737.ko module is created and copied in
> /lib/modules/2.6.18-53.1.21.el5/kernel/drivers/hwmon path. But when I tried
> to insert this module into kernel, module is not loaded with following error
> message:
>
> #insmod dme1737.ko
> insmod: error inserting 'dme1737.ko': -1 Unknown symbol in module
>
> Do you have any idea where is a mistake? Thanks for your reply
>

The dme1737 driver depends on i2c-core and hwmon-vid. My guess is one or
both of those aren't loaded. Do 'depmod -a' and then 'modprobe dme1737
probe_all_addr=1' to load the driver an all the modules it depends upon.
Note that for the driver to correctly work on a SN18000 board, you need to
have the following patch applied (hence the probe_all_addr option):
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022802.html

...juerg



> Jaroslav
>
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>

------=_Part_3185_2340489.1211845023998
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jaroslav,<br><br><br><div class="gmail_quote">On Mon, May 26, 2008 at 12:08 PM, Jaroslav Vacha &lt;<a href="mailto:vacha@email.cz">vacha@email.cz</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Hi, <br>
&nbsp; I&#39;m trying to compile dme1737 driver under&nbsp; CentOS 5.1 with
2.6.18-53.1.21.el5 kernel to support VIA EPIA-SN 18000G motherboard
sensors.<br>
&nbsp; Followed Juerg&#39;s instruction from post <a href="http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022166.html" target="_blank">http://lists.lm-sensors.org/pipermail/lm-sensors/2007-December/022166.html</a><br>

<br>
&nbsp; Code compiled with warnings:<br>
<br>
#make all<br>
make -C /lib/modules/`uname -r`/build M=/install/lm_sensors/driver modules<br>
make[1]: Entering directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686&#39;<br>
&nbsp; CC [M]&nbsp; /install/lm_sensors/driver/dme1737.o<br>
/install/lm_sensors/driver/dme1737.c:55: warning: initialization discards qualifiers from pointer target type<br>
/install/lm_sensors/driver/dme1737.c: In function &#39;dme1737_i2c_detect&#39;:<br>
/install/lm_sensors/driver/dme1737.c:2139: warning: assignment from incompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function &#39;dme1737_i2c_detach_client&#39;:<br>
/install/lm_sensors/driver/dme1737.c:2172: warning: passing argument 1
of &#39;hwmon_device_unregister&#39; from incompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function &#39;dme1737_isa_probe&#39;:<br>
/install/lm_sensors/driver/dme1737.c:2324: warning: assignment from incompatible pointer type<br>
/install/lm_sensors/driver/dme1737.c: In function &#39;dme1737_isa_remove&#39;:<br>
/install/lm_sensors/driver/dme1737.c:2348: warning: passing argument 1
of &#39;hwmon_device_unregister&#39; from incompatible pointer type<br>
&nbsp; Building modules, stage 2.<br>
&nbsp; MODPOST<br>
&nbsp; CC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /install/lm_sensors/driver/dme1737.mod.o<br>
&nbsp; LD [M]&nbsp; /install/lm_sensors/driver/dme1737.ko<br>
make[1]: Leaving directory `/usr/src/kernels/2.6.18-53.1.21.el5-i686&#39;<br>
[root@server driver]#<br>
<br>
&nbsp; dme1737.ko module is created and copied in
/lib/modules/2.6.18-53.1.21.el5/kernel/drivers/hwmon path. But when I
tried to insert this module into kernel, module is not loaded with
following error message:<br>
<br>
#insmod dme1737.ko<br>
insmod: error inserting &#39;dme1737.ko&#39;: -1 Unknown symbol in module<br>
<br>
Do you have any idea where is a mistake? Thanks for your reply<br><font color="#888888"></font></blockquote><div><br>The dme1737 driver depends on i2c-core and hwmon-vid. My guess is one or both of those aren&#39;t loaded. Do &#39;depmod -a&#39; and then &#39;modprobe dme1737 probe_all_addr=1&#39; to load the driver an all the modules it depends upon.<br>
Note that for the driver to correctly work on a SN18000 board, you need to have the following patch applied (hence the probe_all_addr option):<br><a href="http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022802.html">http://lists.lm-sensors.org/pipermail/lm-sensors/2008-April/022802.html</a><br>
<br>...juerg<br><br>&nbsp;</div><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><font color="#888888">
Jaroslav<br>
<br>
<p>&nbsp;</p></font><br>_______________________________________________<br>
lm-sensors mailing list<br>
<a href="mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><br>
<a href="http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target="_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br></blockquote></div><br>

------=_Part_3185_2340489.1211845023998--


--===============1675064731519122406==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============1675064731519122406==--
