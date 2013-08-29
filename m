From: Victor Severov <serverov@gmail.com>
Date: Thu, 29 Aug 2013 17:02:34 +0000
Subject: Re: [lm-sensors] Configuration file for ASUS P8H77-I motherboard
Message-Id: <CABFd1Faf9f3qnyin_QQ0Zk93RkUTrwzhDE3So3pjx3KsyQmX9w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0644991548133469947=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CABFd1FYhZNcVNWK-Z-BDgsgAuJrKNQqp5sWNxpp0BB18khpq5g@mail.gmail.com>
In-Reply-To: <CABFd1FYhZNcVNWK-Z-BDgsgAuJrKNQqp5sWNxpp0BB18khpq5g@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============0644991548133469947==
Content-Type: multipart/alternative; boundary=e89a8ffbaa2b8739aa04e51912f0

--e89a8ffbaa2b8739aa04e51912f0
Content-Type: text/plain; charset=ISO-8859-1

Hi Jean

> I have added it to the wiki:
> http://www.lm-sensors.org/wiki/Configurations/Asus/P8H77-I

Thank you!

>> ignore in7
> in7 is always VSB (+3.3V Stand-By) for this chip according to the
> driver's source code, so it should be labelled as such, not ignored.
> There's probably a note about this in the kernel logs when you load the
> it87 driver.
Unfortunately I can't find any scaling factor for VSB3 voltage. Sometimes
in7 = 5.98, sometimes in7 = 4.44 or even 3.91, and I can't see any
regularity for this values.
Still no ideas about this in7 parameter. :(

>> compute in0 @+0.06, @-0.06
> I've seen this a few times in the past but electrically it makes no
> sense.

My motherboard uses intel g2020 processor with nominal core voltage 0.92V.
Core voltage displays as 0,86V in lm-sensors by default.
In BIOS power management menu core voltage displays as 0.92V, In my guess
we needs a "+0.06" correction for this.
Maybe I'm wrong.

>> compute in2 @*(72/12), @/(72/12)
>> compute in3 @*(30/12), @/(30/12)
>> compute in4 @*(1978/1200), @/(1978/1200)
> I'm curious how you came up with this unusual scaling factor?

I used several reverse engineering tricks from this wonderful article:
http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling


>> set in4_min 3.3 * 0.90
>> set in4_max 3.3 * 1.05

> The ATX specifications sets the limit to +/-5 % so all these * 0.90
> should really be * 0.95 (or 0.94 if you want to take the resistor's
> imperfection into account.)
Yes, this is my mistake.

Thank you for your comments and recommendations.

-- 
Best regards!
/Serverov.

> I have added it to the wiki:
> http://www.lm-sensors.org/wiki/Configurations/Asus/P8H77-I



Thursday, August 29, 2013, 12:13:41 PM, you wrote:

> Hi Victor,

> On Thu, 29 Aug 2013 10:47:12 +0300, Victor Severov wrote:
>> Hi all!
>>
>> Here is my lm-sensors config file for Asus P8H77-I motherboard. This MB
>> uses undocumented it8771e chip for voltage, temp and fan speed
monitoring.
>>
>> I hope this config may be useful to someone.
>> Thank you.

> I have added it to the wiki:
> http://www.lm-sensors.org/wiki/Configurations/Asus/P8H77-I

> Some comments :

>> label in0 "Vcore"
>> label in1 "Vram"
>> label in2 "+12V"
>> label in3 "+5V"
>> label in4 "+3.3V"
>> ignore in5
>> ignore in6
>> ignore in7

> in7 is always VSB (+3.3V Stand-By) for this chip according to the
> driver's source code, so it should be labelled as such, not ignored.
> There's probably a note about this in the kernel logs when you load the
> it87 driver.

>>
>> compute in0 @+0.06, @-0.06

> I've seen this a few times in the past but electrically it makes no
> sense.

>> compute in2 @*(72/12), @/(72/12)
>> compute in3 @*(30/12), @/(30/12)
>> compute in4 @*(1978/1200), @/(1978/1200)

> I'm curious how you came up with this unusual scaling factor?

>> set in0_min 0.92 * 0.90
>> set in0_max 0.92 * 1.05

> Modern CPUs tend to have variable voltage so the above makes little
> sense. What CPU are you using?

>> set in1_min 1.5*0.90
>> set in1_max 1.5 * 1.05
>> set in2_min 12.0 * 0.90
>> set in2_max 12.0 * 1.05
>> set in3_min 5.0 * 0.90
>> set in3_max 5.0 * 1.05
>> set in4_min 3.3 * 0.90
>> set in4_max 3.3 * 1.05

> The ATX specifications sets the limit to +/-5 % so all these * 0.90
> should really be * 0.95 (or 0.94 if you want to take the resistor's
> imperfection into account.)

>>
>> label fan1 "CPU Fan"
>> label fan2 "Chassis Fan"
>>
>> label temp1 "CPU Temp"
>> label temp2 "M/B Temp"
>> ignore temp3

> Thanks for your contribution.

--e89a8ffbaa2b8739aa04e51912f0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Jean<br></div><div><br></div><div>
&gt; I have added it to the wiki:<br>&gt; <a href=3D"http://www.lm-sensors.=
org/wiki/Configurations/Asus/P8H77-I">http://www.lm-sensors.org/wiki/Config=
urations/Asus/P8H77-I</a>
</div><div><br></div><div>Thank you!</div><div><br></div><div>
&gt;&gt; ignore in7<br>&gt; in7 is always VSB (+3.3V Stand-By) for this chi=
p according to the<br>&gt; driver&#39;s source code, so it should be labell=
ed as such, not ignored.<br>&gt; There&#39;s probably a note about this in =
the kernel logs when you load the<br>
&gt; it87 driver.<br></div><div>Unfortunately I can&#39;t find any scaling =
factor for VSB3 voltage. Sometimes in7 =3D 5.98, sometimes in7 =3D 4.44 or =
even 3.91, and I can&#39;t see any regularity for this values. </div><div>S=
till no ideas about this in7 parameter. :(</div>
<div><br></div><div>
&gt;&gt; compute in0 @+0.06, @-0.06<br>&gt; I&#39;ve seen this a few times =
in the past but electrically it makes no<br>&gt; sense.
</div><div><br></div><div>My motherboard uses intel g2020 processor with no=
minal core voltage 0.92V. Core voltage displays as 0,86V in lm-sensors by d=
efault.=A0</div><div>In BIOS power management menu core voltage displays as=
 0.92V, In my guess we needs a &quot;+0.06&quot; correction for this.=A0</d=
iv>
<div>Maybe I&#39;m wrong.</div><div><br></div><div>&gt;&gt; compute in2 @*(=
72/12), @/(72/12)<br>&gt;&gt; compute in3 @*(30/12), @/(30/12)<br>&gt;&gt; =
compute in4 @*(1978/1200), @/(1978/1200)<br>&gt; I&#39;m curious how you ca=
me up with this unusual scaling factor?</div>
<div><br></div><div>I used several reverse engineering tricks from this won=
derful article:</div><div><a href=3D"http://www.lm-sensors.org/wiki/Voltage=
LabelsAndScaling">http://www.lm-sensors.org/wiki/VoltageLabelsAndScaling</a=
></div>
<div><br></div><div><br></div><div>
&gt;&gt; set in4_min 3.3 * 0.90<br>&gt;&gt; set in4_max 3.3 * 1.05<br><br>&=
gt; The ATX specifications sets the limit to +/-5 % so all these * 0.90<br>=
&gt; should really be * 0.95 (or 0.94 if you want to take the resistor&#39;=
s<br>
&gt; imperfection into account.)<br></div><div>Yes, this is my mistake.</di=
v><div><br></div><div>Thank you for your comments and recommendations.</div=
><div><br></div><div>
-- <br>Best regards!<br>/Serverov.
</div><div><br></div><div>
&gt; I have added it to the wiki:<br>&gt; <a href=3D"http://www.lm-sensors.=
org/wiki/Configurations/Asus/P8H77-I">http://www.lm-sensors.org/wiki/Config=
urations/Asus/P8H77-I</a><br></div><div><br></div><div><br></div><br>Thursd=
ay, August 29, 2013, 12:13:41 PM, you wrote:<br>
<br>&gt; Hi Victor,<br><br>&gt; On Thu, 29 Aug 2013 10:47:12 +0300, Victor =
Severov wrote:<br>&gt;&gt; Hi all!<br>&gt;&gt; <br>&gt;&gt; Here is my lm-s=
ensors config file for Asus P8H77-I motherboard. This MB<br>&gt;&gt; uses u=
ndocumented it8771e chip for voltage, temp and fan speed monitoring.<br>
&gt;&gt; <br>&gt;&gt; I hope this config may be useful to someone.<br>&gt;&=
gt; Thank you.<br><br>&gt; I have added it to the wiki:<br>&gt; <a href=3D"=
http://www.lm-sensors.org/wiki/Configurations/Asus/P8H77-I">http://www.lm-s=
ensors.org/wiki/Configurations/Asus/P8H77-I</a><br>
<br>&gt; Some comments :<br><br>&gt;&gt; label in0 &quot;Vcore&quot;<br>&gt=
;&gt; label in1 &quot;Vram&quot;<br>&gt;&gt; label in2 &quot;+12V&quot;<br>=
&gt;&gt; label in3 &quot;+5V&quot;<br>&gt;&gt; label in4 &quot;+3.3V&quot;<=
br>
&gt;&gt; ignore in5<br>&gt;&gt; ignore in6<br>&gt;&gt; ignore in7<br><br>&g=
t; in7 is always VSB (+3.3V Stand-By) for this chip according to the<br>&gt=
; driver&#39;s source code, so it should be labelled as such, not ignored.<=
br>
&gt; There&#39;s probably a note about this in the kernel logs when you loa=
d the<br>&gt; it87 driver.<br><br>&gt;&gt; <br>&gt;&gt; compute in0 @+0.06,=
 @-0.06<br><br>&gt; I&#39;ve seen this a few times in the past but electric=
ally it makes no<br>
&gt; sense.<br><br>&gt;&gt; compute in2 @*(72/12), @/(72/12)<br>&gt;&gt; co=
mpute in3 @*(30/12), @/(30/12)<br>&gt;&gt; compute in4 @*(1978/1200), @/(19=
78/1200)<br><br>&gt; I&#39;m curious how you came up with this unusual scal=
ing factor?<br>
<br>&gt;&gt; set in0_min 0.92 * 0.90<br>&gt;&gt; set in0_max 0.92 * 1.05<br=
><br>&gt; Modern CPUs tend to have variable voltage so the above makes litt=
le<br>&gt; sense. What CPU are you using?<br><br>&gt;&gt; set in1_min 1.5*0=
.90<br>
&gt;&gt; set in1_max 1.5 * 1.05<br>&gt;&gt; set in2_min 12.0 * 0.90<br>&gt;=
&gt; set in2_max 12.0 * 1.05<br>&gt;&gt; set in3_min 5.0 * 0.90<br>&gt;&gt;=
 set in3_max 5.0 * 1.05<br>&gt;&gt; set in4_min 3.3 * 0.90<br>&gt;&gt; set =
in4_max 3.3 * 1.05<br>
<br>&gt; The ATX specifications sets the limit to +/-5 % so all these * 0.9=
0<br>&gt; should really be * 0.95 (or 0.94 if you want to take the resistor=
&#39;s<br>&gt; imperfection into account.)<br><br>&gt;&gt; <br>&gt;&gt; lab=
el fan1 &quot;CPU Fan&quot;<br>
&gt;&gt; label fan2 &quot;Chassis Fan&quot;<br>&gt;&gt; <br>&gt;&gt; label =
temp1 &quot;CPU Temp&quot;<br>&gt;&gt; label temp2 &quot;M/B Temp&quot;<br>=
&gt;&gt; ignore temp3<br><br>&gt; Thanks for your contribution.<br><br>
=A0</div>

--e89a8ffbaa2b8739aa04e51912f0--


--===============0644991548133469947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0644991548133469947==--
