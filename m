From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Wed, 14 Aug 2013 17:20:57 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzSPWFL1jT8T5JVzfRH89uXXDSxRcKNUUDctP_Z1Dv4qaw@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2917418507709888638=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2917418507709888638==
Content-Type: multipart/alternative; boundary=001a11c28efa9f5e4504e3eb94dd

--001a11c28efa9f5e4504e3eb94dd
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Aug 14, 2013 at 1:30 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On 08/13/2013 10:17 PM, Kapil Dev wrote:
>
>>
>> On Aug 14, 2013, at 12:56 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>>  On 08/13/2013 08:09 PM, Dev, Kapil wrote:
>>>
>>>>
>>>>
>>>> On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck <linux@roeck-us.net<mailto:
>>>> linux@roeck-us.net>> wrote:
>>>>
>>>>     On 08/13/2013 07:41 PM, Dev, Kapil wrote:
>>>>
>>>>         Thanks again Guenter!
>>>>
>>>>
>>>>
>>>>
>>>>         On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <
>>>> linux@roeck-us.net <mailto:linux@roeck-us.net> <mailto:
>>>> linux@roeck-us.net <mailto:linux@roeck-us.net>>> wrote:
>>>>
>>>>              On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil wrote:
>>>>               > Thanks for the response Guenter!
>>>>               >
>>>>               > I put the system on load and I noticed their value
>>>> hardly changes. To my
>>>>               > surprise, I ran a benchmark for 3 minutes and none of
>>>> temp*  values changed
>>>>               > during execution. The highest reported temperature is
>>>> always 48C.
>>>>               >
>>>>               > I was expecting that the internal temperature would
>>>> have "sensor = thermal
>>>>               > diode" or "sensor = core" as a keyword. I thought
>>>> "sensor=thermistor" means
>>>>               > the corresponding sensor is on the motherboard and not
>>>> the internal
>>>>               > die-sensor.
>>>>               >
>>>>              Sure, but who knows if they put a sensor below the CPU for
>>>> some reason ...
>>>>
>>>>              I am not familiar with the A10 CPUs. Are those similar to
>>>> K10 ?
>>>>              If so, maybe the k10temp driver works or could be extended
>>>> to support it.
>>>>              Can you give it a try ?
>>>>
>>>>              If it does not work out of the box, can you send me the
>>>> output of "lspci -nn" ?
>>>>
>>>>
>>>>         Kapil: I believe K10 corresponds to A8 seried, and A10 has
>>>> Bulldozer architecture (http://www.cpu-world.com/__**
>>>> CPUs/Bulldozer/TYPE-A10-__**Series.html<http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.html><
>>>> http://www.cpu-world.com/**CPUs/Bulldozer/TYPE-A10-**Series.html<http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>>).
>>>> I am not sure how different they are though. I tried K10, but it did not
>>>> work out of the box. I am looking into k10temp.c driver now. Also,I am
>>>> attaching the output of "lspci -nn" command herewith; you might have to
>>>> open it using wordpad for proper formatting..
>>>>
>>>>
>>>>     Your lspci output includes
>>>>
>>>>     00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device
>>>> [1022:1403]
>>>>
>>>>     which is supported by the latest k10temp driver. Support was added
>>>> early last year.
>>>>     What is your kernel version, and can you switch to a more recent
>>>> version ?
>>>>
>>>>
>>>> Kapil: I have 2.6.39-020639-generic kernel. Is it too old kernel for
>>>> k10temp driver to work? Which stable kernel should I upgrade to?
>>>>
>>>>
>>> You need 3.4 or later.
>>>
>>
>> Kapil: I was trying to avoid updating the kernel because my current
>> kernel is setup for running different type of benchmarks etc. Seems like I
>> can't avoid updating the kernel; I will do it..
>>
>>  Alternative would be to back-port the k10temp driver from a later
> kernel. Then you can keep running the old one.
>
>
Kapil: Not sure how to do that. I am already taking the k10temp driver from
here: http://khali.linux-fr.org/devel/lm-sensors/drivers/k10temp/ and
compiling and using it.


>
>  Just for my understanding: Currently, when I run "sensors" command, I am
>> getting three values (apparently wrong), temp1-3. So, what do you think is
>> happening that is causing these values wrong? And, how is it going to be
>> fixed by updating the  kernel? Although we don't know yet, but, I am hoping
>> that by updating the kernel and loading the k10temp kernel, I would be able
>> to see readings from thermal-diode (core-temperature) along with the
>> current readings from thermal-resistors.
>>
>>  Not wrong; those are probably different chassis and/or board
> temperatures. Does the BIOS report
> any matching temperatures ?
>
> In BIOS, under PC health, I see only one temperature, named CPU Tctl
(control temperature). Its value is in 30s (between 29-36 or so). I believe
this value denotes the distance from a specific maximum temperature (Tmax).
Finding that Tmax would be another challenge; but,  I not at that stage yet.

Thanks,
Kapil



> Guenter
>
>

--001a11c28efa9f5e4504e3eb94dd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Wed, Aug 14, 2013 at 1:30 AM, Guenter=
 Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">On 08/13/2013 10:17 PM, Kapil Dev w=
rote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
On Aug 14, 2013, at 12:56 AM, Guenter Roeck &lt;<a href=3D"mailto:linux@roe=
ck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt; wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
On 08/13/2013 08:09 PM, Dev, Kapil wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
<br>
<br>
On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck &lt;<a href=3D"mailto:linux=
@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a> &lt;mailto:<a href=
=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;=
&gt; wrote:<br>

<br>
=A0 =A0 On 08/13/2013 07:41 PM, Dev, Kapil wrote:<br>
<br>
=A0 =A0 =A0 =A0 Thanks again Guenter!<br>
<br>
<br>
<br>
<br>
=A0 =A0 =A0 =A0 On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck &lt;<a href=
=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a> &lt=
;mailto:<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck=
-us.net</a>&gt; &lt;mailto:<a href=3D"mailto:linux@roeck-us.net" target=3D"=
_blank">linux@roeck-us.net</a> &lt;mailto:<a href=3D"mailto:linux@roeck-us.=
net" target=3D"_blank">linux@roeck-us.net</a>&gt;&gt;&gt; wrote:<br>

<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, K=
apil wrote:<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; Thanks for the response Guenter!<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; I put the system on load and I noticed the=
ir value hardly changes. To my<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; surprise, I ran a benchmark for 3 minutes =
and none of temp* =A0values changed<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; during execution. The highest reported tem=
perature is always 48C.<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; I was expecting that the internal temperat=
ure would have &quot;sensor =3D thermal<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; diode&quot; or &quot;sensor =3D core&quot;=
 as a keyword. I thought &quot;sensor=3Dthermistor&quot; means<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; the corresponding sensor is on the motherb=
oard and not the internal<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt; die-sensor.<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &gt;<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0Sure, but who knows if they put a sensor below t=
he CPU for some reason ...<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0I am not familiar with the A10 CPUs. Are those s=
imilar to K10 ?<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0If so, maybe the k10temp driver works or could b=
e extended to support it.<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0Can you give it a try ?<br>
<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0If it does not work out of the box, can you send=
 me the output of &quot;lspci -nn&quot; ?<br>
<br>
<br>
=A0 =A0 =A0 =A0 Kapil: I believe K10 corresponds to A8 seried, and A10 has =
Bulldozer architecture (<a href=3D"http://www.cpu-world.com/__CPUs/Bulldoze=
r/TYPE-A10-__Series.html" target=3D"_blank">http://www.cpu-world.com/__<u><=
/u>CPUs/Bulldozer/TYPE-A10-__<u></u>Series.html</a> &lt;<a href=3D"http://w=
ww.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html" target=3D"_blank">htt=
p://www.cpu-world.com/<u></u>CPUs/Bulldozer/TYPE-A10-<u></u>Series.html</a>=
&gt;). I am not sure how different they are though. I tried K10, but it did=
 not work out of the box. I am looking into k10temp.c driver now. Also,I am=
 attaching the output of &quot;lspci -nn&quot; command herewith; you might =
have to open it using wordpad for proper formatting..<br>

<br>
<br>
=A0 =A0 Your lspci output includes<br>
<br>
=A0 =A0 00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [10=
22:1403]<br>
<br>
=A0 =A0 which is supported by the latest k10temp driver. Support was added =
early last year.<br>
=A0 =A0 What is your kernel version, and can you switch to a more recent ve=
rsion ?<br>
<br>
<br>
Kapil: I have 2.6.39-020639-generic kernel. Is it too old kernel for k10tem=
p driver to work? Which stable kernel should I upgrade to?<br>
<br>
</blockquote>
<br>
You need 3.4 or later.<br>
</blockquote>
<br>
Kapil: I was trying to avoid updating the kernel because my current kernel =
is setup for running different type of benchmarks etc. Seems like I can&#39=
;t avoid updating the kernel; I will do it..<br>
<br>
</blockquote></div></div>
Alternative would be to back-port the k10temp driver from a later kernel. T=
hen you can keep running the old one.<div class=3D"im"><br></div></blockquo=
te><div><br></div><div>Kapil: Not sure how to do that. I am already taking =
the k10temp driver from here:=A0<a href=3D"http://khali.linux-fr.org/devel/=
lm-sensors/drivers/k10temp/">http://khali.linux-fr.org/devel/lm-sensors/dri=
vers/k10temp/</a>=A0and compiling and using it.</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><div class=3D"im">
<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
Just for my understanding: Currently, when I run &quot;sensors&quot; comman=
d, I am getting three values (apparently wrong), temp1-3. So, what do you t=
hink is happening that is causing these values wrong? And, how is it going =
to be fixed by updating the =A0kernel? Although we don&#39;t know yet, but,=
 I am hoping that by updating the kernel and loading the k10temp kernel, I =
would be able to see readings from thermal-diode (core-temperature) along w=
ith the current readings from thermal-resistors.<br>

<br>
</blockquote></div>
Not wrong; those are probably different chassis and/or board temperatures. =
Does the BIOS report<br>
any matching temperatures ?<span class=3D"HOEnZb"><font color=3D"#888888"><=
br>
<br></font></span></blockquote><div>In BIOS, under PC health, I see only on=
e temperature, named CPU Tctl (control temperature). Its value is in 30s (b=
etween 29-36 or so). I believe this value denotes the distance from a speci=
fic maximum temperature (Tmax). Finding that Tmax would be another challeng=
e; but, =A0I not at that stage yet.</div>
<div><br></div><div>Thanks,</div><div>Kapil</div><div><br></div><div>=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><span class=3D"HOEnZb"><font color=3D"#88=
8888">
Guenter<br>
<br>
</font></span></blockquote></div><br>

--001a11c28efa9f5e4504e3eb94dd--


--===============2917418507709888638==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2917418507709888638==--
