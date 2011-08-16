From: Eddi De Pieri <eddi@depieri.net>
Date: Tue, 16 Aug 2011 07:26:06 +0000
Subject: Re: [lm-sensors] looking for help with W83795ADG
Message-Id: <CAKdnbx66xn5xPx+n8w6QQ-_Fz6iPZ+ZP62TErJkW45-2bVcSng@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7925005816717640820=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
In-Reply-To: <20101022135607.6996731s0m2gcr48@webmail.mnet-online.de>
To: lm-sensors@vger.kernel.org

--===============7925005816717640820==
Content-Type: multipart/alternative; boundary=000e0cd18394278bdf04aa9a4cf2

--000e0cd18394278bdf04aa9a4cf2
Content-Type: text/plain; charset=ISO-8859-1

Hi Jean...

The bios show fan rpm and temperature. Since my own proliant
microserver lacks of ipmi card, I doubt the bios give me the results
using ipmi call.

The HP Proliant Microserver chipset (SB820M) have a multiplexed smbus like your.

http://support.amd.com/it/Embedded_TechDocs/47283_sb820m_ds_pub_2.00.pdf

Here is technical document from amd...

at p52/53 they say:

(1) The SDA1 and SCL1 SMBus interface is dedicated for ASF devices
only. It should not be used to
connect to any other devices.
(2) There are only two SMBus controllers. The SCL1/SDA1 pair is
controlled by SMBus controller 1.


SCL0/SDA0, SCL2/SDA2, SCL3/SDA3 and SCL4/SDA4 are multiplexed pins
that are all controlled by
SMBus controller 0, and only 1 pair of those pins can be active at any time.

I can't understand how to enable 2, 3 and 4 muxed bus..

If you consolidate a solution for i2c-i801.c I hope we can be
replicated for i2c-piix4.c too..



Hi Karsten,

On Fri, 22 Oct 2010 16:04:10 +0200, karsten at maxi-dsl.de
<http://lists.lm-sensors.org/mailman/listinfo/lm-sensors> wrote:
>* hi Jean,
*>* > The w83795 driver uses the same detection mechanism used in

*>* > sensors-detect. So if sensors-detect doesn't see your chip, I am not
*>* > surprised that the driver didn't either.
*>*
*>* > The full output of sensors-detect is needed to diagnose your problem

*>* > further. It could be that your SMBus controller isn't supported, or
*>* > maybe you are supposed to access the chip through IPMI.
*>*
*>* IPMI is probably the key..

*>*
*>*  From the sensors-detect output:
*>* "Warning: the required module ipmisensors is not currently installed
*>* on your system. If it is built into the kernel then it's OK.

*>* Otherwise, check http://www.lm-sensors.org/wiki/Devices for
*>* driver availability" (full ouput attached)
*>*
*>* I did see the output before, but didn't really understand the
*>* implications (IPMI seems to be an alternative way of accessing the
*>* monitoring chips?)
*
Yes. The strength of IPMI access is that it can be used remotely too,
for example from a BMC plugged into your system.


>* The suggested ipmisensors driver however does not seem to be available, right?
*>* (http://lm-sensors.org/wiki/Devices says "(2004-12-12)  Port to Linux

*>* 2.6 in progress by Yani Ioannou")
*
That project is essentially dead. At the time being, the best way to
retrieve IPMI-based sensor values is using "ipmitool sensor". The
drawback is that this isn't integrated with libsensors, so the usually


monitoring applications won't work.

If you have a BMC or are otherwise already using IPMI on your machine,
just use ipmitool and you're done.

If not, then it might be worth trying ipmitool once, and then try


sensors-detect again. There is a small chance that, once ipmitool
managed to access the monitoring device, sensors-detect will see it. My
own mainboard which has a W83795ADG chip has a multiplexed SMBus, and I
can only see the W83795ADG in sensors-detect when the multiplexer is


set properly. Otherwise I would see the memory modules, which _do_
appear in your sensors-detect output. So maybe your board has a
multiplexed SMBus too.

If the trick doesn't work, you may want to try the new jc42 driver


which can monitor the temperature of some DDR3 memory modules. I
suspect your memory modules have such sensors. A more recent version of
sensors-detect would confirm that:
  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect


I also see that sensors-detect suggested to use the k10temp driver,
which your kernel doesn't have. You can try the standalone flavor of
the drivers which I maintain at:
  http://khali.linux-fr.org/devel/misc/k10temp/


The accuracy of the CPU internal sensors is limited, but that's still
better than nothing.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

--000e0cd18394278bdf04aa9a4cf2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<pre>Hi Jean...<br><br>The bios show fan rpm and temperature. Since my own =
proliant microserver lacks of ipmi card, I doubt the bios give me the resul=
ts using ipmi call.<br><br>The HP Proliant Microserver chipset (SB820M) hav=
e a multiplexed smbus like your.<br>

<br><a href=3D"http://support.amd.com/it/Embedded_TechDocs/47283_sb820m_ds_=
pub_2.00.pdf" target=3D"_blank">http://support.amd.com/it/Embedded_TechDocs=
/47283_sb820m_ds_pub_2.00.pdf</a><br><br>Here is technical document from am=
d...<br>

<br>at p52/53 they say:<br><br>(1) The SDA1 and SCL1 SMBus interface is ded=
icated for ASF devices only. It should not be used to<br>connect to any oth=
er devices.<br>(2) There are only two SMBus controllers. The SCL1/SDA1 pair=
 is controlled by SMBus controller 1.<br>


SCL0/SDA0, SCL2/SDA2, SCL3/SDA3 and SCL4/SDA4 are multiplexed pins that are=
 all controlled by<br>SMBus controller 0, and only 1 pair of those pins can=
 be active at any time.<br><br>I can&#39;t understand how to enable 2, 3 an=
d 4 muxed bus..<br>

<br>If you consolidate a solution for i2c-i801.c I hope we can be replicate=
d for i2c-piix4.c too..<br>
<br><br><br>Hi Karsten,<br><br>On Fri, 22 Oct 2010 16:04:10 +0200, <a href=
=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=3D"_bla=
nk">karsten at maxi-dsl.de</a> wrote:<br>&gt;<i> hi Jean,<br></i>&gt;<i> &g=
t; The w83795 driver uses the same detection mechanism used in<br>


</i>&gt;<i> &gt; sensors-detect. So if sensors-detect doesn&#39;t see your =
chip, I am not<br></i>&gt;<i> &gt; surprised that the driver didn&#39;t eit=
her.<br></i>&gt;<i> <br></i>&gt;<i> &gt; The full output of sensors-detect =
is needed to diagnose your problem<br>


</i>&gt;<i> &gt; further. It could be that your SMBus controller isn&#39;t =
supported, or<br></i>&gt;<i> &gt; maybe you are supposed to access the chip=
 through IPMI.<br></i>&gt;<i> <br></i>&gt;<i> IPMI is probably the key..<br=
>


</i>&gt;<i> <br></i>&gt;<i>  From the sensors-detect output:<br></i>&gt;<i>=
 &quot;Warning: the required module ipmisensors is not currently installed<=
br></i>&gt;<i> on your system. If it is built into the kernel then it&#39;s=
 OK.<br>


</i>&gt;<i> Otherwise, check <a href=3D"http://www.lm-sensors.org/wiki/Devi=
ces" target=3D"_blank">http://www.lm-sensors.org/wiki/Devices</a> for<br></=
i>&gt;<i> driver availability&quot; (full ouput attached)<br></i>&gt;<i> <b=
r>

</i>&gt;<i> I did see the output before, but didn&#39;t really understand t=
he  <br>
</i>&gt;<i> implications (IPMI seems to be an alternative way of accessing =
the  <br></i>&gt;<i> monitoring chips?)<br></i><br>Yes. The strength of IPM=
I access is that it can be used remotely too,<br>for example from a BMC plu=
gged into your system.<br>


<br>&gt;<i> The suggested ipmisensors driver however does not seem to be av=
ailable, right?<br></i>&gt;<i> (<a href=3D"http://lm-sensors.org/wiki/Devic=
es" target=3D"_blank">http://lm-sensors.org/wiki/Devices</a> says &quot;(20=
04-12-12)  Port to Linux  <br>


</i>&gt;<i> 2.6 in progress by Yani Ioannou&quot;)<br></i><br>That project =
is essentially dead. At the time being, the best way to<br>retrieve IPMI-ba=
sed sensor values is using &quot;ipmitool sensor&quot;. The<br>drawback is =
that this isn&#39;t integrated with libsensors, so the usually<br>


monitoring applications won&#39;t work.<br><br>If you have a BMC or are oth=
erwise already using IPMI on your machine,<br>just use ipmitool and you&#39=
;re done.<br><br>If not, then it might be worth trying ipmitool once, and t=
hen try<br>


sensors-detect again. There is a small chance that, once ipmitool<br>manage=
d to access the monitoring device, sensors-detect will see it. My<br>own ma=
inboard which has a W83795ADG chip has a multiplexed SMBus, and I<br>can on=
ly see the W83795ADG in sensors-detect when the multiplexer is<br>


set properly. Otherwise I would see the memory modules, which _do_<br>appea=
r in your sensors-detect output. So maybe your board has a<br>multiplexed S=
MBus too.<br><br>If the trick doesn&#39;t work, you may want to try the new=
 jc42 driver<br>


which can monitor the temperature of some DDR3 memory modules. I<br>suspect=
 your memory modules have such sensors. A more recent version of<br>sensors=
-detect would confirm that:<br>  <a href=3D"http://dl.lm-sensors.org/lm-sen=
sors/files/sensors-detect" target=3D"_blank">http://dl.lm-sensors.org/lm-se=
nsors/files/sensors-detect</a><br>


<br>I also see that sensors-detect suggested to use the k10temp driver,<br>=
which your kernel doesn&#39;t have. You can try the standalone flavor of<br=
>the drivers which I maintain at:<br>  <a href=3D"http://khali.linux-fr.org=
/devel/misc/k10temp/" target=3D"_blank">http://khali.linux-fr.org/devel/mis=
c/k10temp/</a><br>


The accuracy of the CPU internal sensors is limited, but that&#39;s still<b=
r>better than nothing.<br><br>-- <br>Jean Delvare<br><a href=3D"http://khal=
i.linux-fr.org/wishlist.html" target=3D"_blank">http://khali.linux-fr.org/w=
ishlist.html</a><br>


</pre>

--000e0cd18394278bdf04aa9a4cf2--


--===============7925005816717640820==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7925005816717640820==--
