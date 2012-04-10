From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 10 Apr 2012 00:37:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fam15h_power: fix bogus values with current BIOSes
Message-Id: <CAAek22EVNgw_m5zESpHjmAmhgENO=sMCNxVzWGxDHwavHdb15A@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7122077172500570284=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1333840079-13541-1-git-send-email-andre.przywara@amd.com>
To: lm-sensors@vger.kernel.org

--===============7122077172500570284==
Content-Type: multipart/alternative; boundary=0023544716f093800904bd4852ea

--0023544716f093800904bd4852ea
Content-Type: text/plain; charset=ISO-8859-1

Unfortunately, I think your entire premise with this driver is flawed.
I've made some measurements of a system with this driver and an intrumented
power supply that reports the system level power numbers.  This is a
dual-socket system with dual 6220 CPU's with 16 integer cores.  I plotted
the results here:

http://www.mindspring.com/~ppokorny/power-2.png

The left part of the graph is idle, followed by starting one "while : ; do
: ; done" infinite loop per integer core staggering the start by 6 sec.

The "TDP Margin" was read directly using a shell script that reads the 0xe0
register using "setpci" and decodes the result.  I've included the script
and data in a tarball you can get here:

http://www.mindspring.com/~ppokorny/power-2.tar.gz

You can see that the TDP Margin value varies widely (it's not scaled by the
"tdp to watts" value) where there is little or no change in system power.
I believe that we can't see it, but clock boost is in effect at idle and
for the first few jobs.  But with the boosted clock, the TDP margin is
quickly consumed and throttling reduces the "clock boost" which provides
increased margin without a corresponding change in the power draw.

I suggest we get some more data to correlate this "TDP Margin" value to
actual power draw.  I don't think it's going to be a reliable measure of
power, but it's still a useful value to present to users.  However, we
should *stop* scaling/subtracting it from the package TDP power number and
just present the scaled "TDP Margin" value instead.  Perhaps provide the
package TDP value in another parameter file.

Also, if you look at a system that is in a steady state, (6220 procs and
PowerNow! disabled) and adjust the time average interval using "setpci" to
write to 0xe0.l, you'll find that the value scales well, but that with
period settings below "0xb" the very act of reading the register (with a
shell script) is enough to affect the measurement. (NOTE: lower numbers on
this chart is _higher_ power draw and therefore lower margin available)

http://www.mindspring.com/~ppokorny/runavg-math.png
http://www.mindspring.com/~ppokorny/runavg-math.tar.gz

So I respectfully wonder if AMD's recommendation of 9 is such a good idea.
You can see in that same chart that 0xf saturates the counter.  We do
similar saturation detection on fan speeds and can change the fan speed
divisor automatically to get a fan speed reading that is in range.  Perhaps
something similar here would be better.  Average over the longest possible
period that doesn't generate a saturation value.

On Mon, Apr 9, 2012 at 2:55 PM, Andre Przywara <andre.przywara@amd.com>wrote:

> On 04/09/2012 07:39 PM, Jean Delvare wrote:
>
>> On Sun, 8 Apr 2012 01:07:59 +0200, Andre Przywara wrote:
>>
>>> Newer BKDG[1] versions recommend a different initialization value for
>>> the running average range register in the northbridge. This improves
>>> the power reading by avoiding counter saturations resulting in bogus
>>> values for anything below about 80% of TDP power consumption.
>>> Updated BIOSes will have this new value set up from the beginning,
>>> but meanwhile we correct this value ourselves.
>>> This needs to be done on all northbridges, even on those where the
>>> driver itself does not register at.
>>>
>>> This fixes the driver on all current machines to provide proper
>>> values for idle load.
>>>
>>

--0023544716f093800904bd4852ea
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Unfortunately, I think your entire premise with this driver is flawed.=A0 I=
&#39;ve made some measurements of a system with this driver and an intrumen=
ted power supply that reports the system level power numbers.=A0 This is a =
dual-socket system with dual 6220 CPU&#39;s with 16 integer cores.=A0 I plo=
tted the results here:<br>
<br><a href=3D"http://www.mindspring.com/~ppokorny/power-2.png">http://www.=
mindspring.com/~ppokorny/power-2.png</a><br><br>The left part of the graph =
is idle, followed by starting one &quot;while : ; do : ; done&quot; infinit=
e loop per integer core staggering the start by 6 sec.<br>
<br>The &quot;TDP Margin&quot; was read directly using a shell script that =
reads the 0xe0 register using &quot;setpci&quot; and decodes the result.=A0=
 I&#39;ve included the script and data in a tarball you can get here:<br>
<br><a href=3D"http://www.mindspring.com/~ppokorny/power-2.tar.gz">http://w=
ww.mindspring.com/~ppokorny/power-2.tar.gz</a><br><br>You can see that the =
TDP Margin value varies widely (it&#39;s not scaled by the &quot;tdp to wat=
ts&quot; value) where there is little or no change in system power.=A0 I be=
lieve that we can&#39;t see it, but clock boost is in effect at idle and fo=
r the first few jobs.=A0 But with the boosted clock, the TDP margin is quic=
kly consumed and throttling reduces the &quot;clock boost&quot; which provi=
des increased margin without a corresponding change in the power draw.<br>
<br>I suggest we get some more data to correlate this &quot;TDP Margin&quot=
; value to actual power draw.=A0 I don&#39;t think it&#39;s going to be a r=
eliable measure of power, but it&#39;s still a useful value to present to u=
sers.=A0 However, we should *stop* scaling/subtracting it from the package =
TDP power number and just present the scaled &quot;TDP Margin&quot; value i=
nstead.=A0 Perhaps provide the package TDP value in another parameter file.=
<br>
<br>Also, if you look at a system that is in a steady state, (6220 procs an=
d PowerNow! disabled) and adjust the time average interval using &quot;setp=
ci&quot; to write to 0xe0.l, you&#39;ll find that the value scales well, bu=
t that with period settings below &quot;0xb&quot; the very act of reading t=
he register (with a shell script) is enough to affect the measurement. (NOT=
E: lower numbers on this chart is _higher_ power draw and therefore lower m=
argin available)<br>
<br><a href=3D"http://www.mindspring.com/~ppokorny/runavg-math.png">http://=
www.mindspring.com/~ppokorny/runavg-math.png</a><br><a href=3D"http://www.m=
indspring.com/~ppokorny/runavg-math.tar.gz">http://www.mindspring.com/~ppok=
orny/runavg-math.tar.gz</a><br>
<br>So I respectfully wonder if AMD&#39;s recommendation of 9 is such a goo=
d idea.=A0 You can see in that same chart that 0xf saturates the counter.=
=A0 We do similar saturation detection on fan speeds and can change the fan=
 speed divisor automatically to get a fan speed reading that is in range.=
=A0 Perhaps something similar here would be better.=A0 Average over the lon=
gest possible period that doesn&#39;t generate a saturation value.<br>
<br><div class=3D"gmail_quote">On Mon, Apr 9, 2012 at 2:55 PM, Andre Przywa=
ra <span dir=3D"ltr">&lt;<a href=3D"mailto:andre.przywara@amd.com">andre.pr=
zywara@amd.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 04/09/2012 07:39 PM, Jean Delvar=
e wrote:<br>
</div></div><blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0=
.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div cla=
ss=3D"h5">
On Sun, 8 Apr 2012 01:07:59 +0200, Andre Przywara wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
Newer BKDG[1] versions recommend a different initialization value for<br>
the running average range register in the northbridge. This improves<br>
the power reading by avoiding counter saturations resulting in bogus<br>
values for anything below about 80% of TDP power consumption.<br>
Updated BIOSes will have this new value set up from the beginning,<br>
but meanwhile we correct this value ourselves.<br>
This needs to be done on all northbridges, even on those where the<br>
driver itself does not register at.<br>
<br>
This fixes the driver on all current machines to provide proper<br>
values for idle load.<br></blockquote></div></div></blockquote></blockquote=
></div>

--0023544716f093800904bd4852ea--


--===============7122077172500570284==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7122077172500570284==--
