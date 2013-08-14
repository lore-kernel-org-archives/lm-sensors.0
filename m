From: "Dev, Kapil" <kapil_dev@brown.edu>
Date: Wed, 14 Aug 2013 03:09:15 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAFSPGzT+5nd-Y2QsW_Mhs63d0-qAEwF_KciDXbAhMWNWcMRyfQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============6490722687264164987=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============6490722687264164987==
Content-Type: multipart/alternative; boundary=089e0163441eb974ec04e3dfaee2

--089e0163441eb974ec04e3dfaee2
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> On 08/13/2013 07:41 PM, Dev, Kapil wrote:
>
>> Thanks again Guenter!
>>
>>
>>
>>
>> On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <linux@roeck-us.net<mailto:
>> linux@roeck-us.net>> wrote:
>>
>>     On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil wrote:
>>      > Thanks for the response Guenter!
>>      >
>>      > I put the system on load and I noticed their value hardly changes.
>> To my
>>      > surprise, I ran a benchmark for 3 minutes and none of temp*
>>  values changed
>>      > during execution. The highest reported temperature is always 48C.
>>      >
>>      > I was expecting that the internal temperature would have "sensor =
>> thermal
>>      > diode" or "sensor = core" as a keyword. I thought
>> "sensor=thermistor" means
>>      > the corresponding sensor is on the motherboard and not the internal
>>      > die-sensor.
>>      >
>>     Sure, but who knows if they put a sensor below the CPU for some
>> reason ...
>>
>>     I am not familiar with the A10 CPUs. Are those similar to K10 ?
>>     If so, maybe the k10temp driver works or could be extended to support
>> it.
>>     Can you give it a try ?
>>
>>     If it does not work out of the box, can you send me the output of
>> "lspci -nn" ?
>>
>>
>> Kapil: I believe K10 corresponds to A8 seried, and A10 has Bulldozer
>> architecture (http://www.cpu-world.com/**CPUs/Bulldozer/TYPE-A10-**
>> Series.html<http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>).
>> I am not sure how different they are though. I tried K10, but it did not
>> work out of the box. I am looking into k10temp.c driver now. Also,I am
>> attaching the output of "lspci -nn" command herewith; you might have to
>> open it using wordpad for proper formatting..
>>
>>
> Your lspci output includes
>
> 00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1403]
>
> which is supported by the latest k10temp driver. Support was added early
> last year.
> What is your kernel version, and can you switch to a more recent version ?
>

Kapil: I have 2.6.39-020639-generic kernel. Is it too old kernel for
k10temp driver to work? Which stable kernel should I upgrade to?


>
> Thanks,
> Guenter
>
>
>
Thanks,
Kapil

--089e0163441eb974ec04e3dfaee2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Tue, Aug 13, 2013 at 11:02 PM, Guente=
r Roeck <span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=
=3D"_blank">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">
<div class=3D"im">On 08/13/2013 07:41 PM, Dev, Kapil wrote:<br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
Thanks again Guenter!<div class=3D"im"><br>
<br>
<br>
<br>
On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck &lt;<a href=3D"mailto:linux@=
roeck-us.net" target=3D"_blank">linux@roeck-us.net</a> &lt;mailto:<a href=
=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a>&gt;=
&gt; wrote:<br>

<br>
=A0 =A0 On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil wrote:<br>
=A0 =A0 =A0&gt; Thanks for the response Guenter!<br>
=A0 =A0 =A0&gt;<br>
=A0 =A0 =A0&gt; I put the system on load and I noticed their value hardly c=
hanges. To my<br>
=A0 =A0 =A0&gt; surprise, I ran a benchmark for 3 minutes and none of temp*=
 =A0values changed<br>
=A0 =A0 =A0&gt; during execution. The highest reported temperature is alway=
s 48C.<br>
=A0 =A0 =A0&gt;<br>
=A0 =A0 =A0&gt; I was expecting that the internal temperature would have &q=
uot;sensor =3D thermal<br>
=A0 =A0 =A0&gt; diode&quot; or &quot;sensor =3D core&quot; as a keyword. I =
thought &quot;sensor=3Dthermistor&quot; means<br>
=A0 =A0 =A0&gt; the corresponding sensor is on the motherboard and not the =
internal<br>
=A0 =A0 =A0&gt; die-sensor.<br>
=A0 =A0 =A0&gt;<br>
=A0 =A0 Sure, but who knows if they put a sensor below the CPU for some rea=
son ...<br>
<br>
=A0 =A0 I am not familiar with the A10 CPUs. Are those similar to K10 ?<br>
=A0 =A0 If so, maybe the k10temp driver works or could be extended to suppo=
rt it.<br>
=A0 =A0 Can you give it a try ?<br>
<br>
=A0 =A0 If it does not work out of the box, can you send me the output of &=
quot;lspci -nn&quot; ?<br>
<br>
<br>
Kapil: I believe K10 corresponds to A8 seried, and A10 has Bulldozer archit=
ecture (<a href=3D"http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.=
html" target=3D"_blank">http://www.cpu-world.com/<u></u>CPUs/Bulldozer/TYPE=
-A10-<u></u>Series.html</a>). I am not sure how different they are though. =
I tried K10, but it did not work out of the box. I am looking into k10temp.=
c driver now. Also,I am attaching the output of &quot;lspci -nn&quot; comma=
nd herewith; you might have to open it using wordpad for proper formatting.=
.<br>

<br>
</div></blockquote>
<br>
Your lspci output includes<br>
<br>
00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device [1022:1403]=
<br>
<br>
which is supported by the latest k10temp driver. Support was added early la=
st year.<br>
What is your kernel version, and can you switch to a more recent version ?<=
br></blockquote><div><br></div><div>Kapil: I have 2.6.39-020639-generic ker=
nel. Is it too old kernel for k10temp driver to work? Which stable kernel s=
hould I upgrade to?</div>
<div>=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">
<br>
Thanks,<br>
Guenter<br>
<br>
<br>
</blockquote></div><br><div>Thanks,</div><div>Kapil</div>

--089e0163441eb974ec04e3dfaee2--


--===============6490722687264164987==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============6490722687264164987==--
