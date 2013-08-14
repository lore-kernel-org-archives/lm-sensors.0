From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Wed, 14 Aug 2013 05:32:45 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <CAAek22EgaXdWRZMLUYe8zqQ1BLvrnBO2+gcvtgxnRt-hyAJ+mg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2779493795769687903=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============2779493795769687903==
Content-Type: multipart/alternative; boundary=089e013cb6e4e8529e04e3e1afa6

--089e013cb6e4e8529e04e3e1afa6
Content-Type: text/plain; charset=ISO-8859-1

You may be able to compile the k10temp.c driver out of the kernel.  I've
had good success with that in the past.

If you have the kernel build environment, it's pretty straightforward.  You
just need a couple of files.

Phil P.


On Tue, Aug 13, 2013 at 10:17 PM, Kapil Dev <kapil_dev@brown.edu> wrote:

>
> On Aug 14, 2013, at 12:56 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> > On 08/13/2013 08:09 PM, Dev, Kapil wrote:
> >>
> >>
> >> On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck <linux@roeck-us.net<mailto:
> linux@roeck-us.net>> wrote:
> >>
> >>    On 08/13/2013 07:41 PM, Dev, Kapil wrote:
> >>
> >>        Thanks again Guenter!
> >>
> >>
> >>
> >>
> >>        On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck <
> linux@roeck-us.net <mailto:linux@roeck-us.net> <mailto:linux@roeck-us.net<mailto:
> linux@roeck-us.net>>> wrote:
> >>
> >>             On Tue, Aug 13, 2013 at 05:11:31PM -0400, Dev, Kapil wrote:
> >>              > Thanks for the response Guenter!
> >>              >
> >>              > I put the system on load and I noticed their value
> hardly changes. To my
> >>              > surprise, I ran a benchmark for 3 minutes and none of
> temp*  values changed
> >>              > during execution. The highest reported temperature is
> always 48C.
> >>              >
> >>              > I was expecting that the internal temperature would have
> "sensor = thermal
> >>              > diode" or "sensor = core" as a keyword. I thought
> "sensor=thermistor" means
> >>              > the corresponding sensor is on the motherboard and not
> the internal
> >>              > die-sensor.
> >>              >
> >>             Sure, but who knows if they put a sensor below the CPU for
> some reason ...
> >>
> >>             I am not familiar with the A10 CPUs. Are those similar to
> K10 ?
> >>             If so, maybe the k10temp driver works or could be extended
> to support it.
> >>             Can you give it a try ?
> >>
> >>             If it does not work out of the box, can you send me the
> output of "lspci -nn" ?
> >>
> >>
> >>        Kapil: I believe K10 corresponds to A8 seried, and A10 has
> Bulldozer architecture (
> http://www.cpu-world.com/__CPUs/Bulldozer/TYPE-A10-__Series.html <
> http://www.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html>). I am not
> sure how different they are though. I tried K10, but it did not work out of
> the box. I am looking into k10temp.c driver now. Also,I am attaching the
> output of "lspci -nn" command herewith; you might have to open it using
> wordpad for proper formatting..
> >>
> >>
> >>    Your lspci output includes
> >>
> >>    00:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] Device
> [1022:1403]
> >>
> >>    which is supported by the latest k10temp driver. Support was added
> early last year.
> >>    What is your kernel version, and can you switch to a more recent
> version ?
> >>
> >>
> >> Kapil: I have 2.6.39-020639-generic kernel. Is it too old kernel for
> k10temp driver to work? Which stable kernel should I upgrade to?
> >>
> >
> > You need 3.4 or later.
>
> Kapil: I was trying to avoid updating the kernel because my current kernel
> is setup for running different type of benchmarks etc. Seems like I can't
> avoid updating the kernel; I will do it..
>
> Just for my understanding: Currently, when I run "sensors" command, I am
> getting three values (apparently wrong), temp1-3. So, what do you think is
> happening that is causing these values wrong? And, how is it going to be
> fixed by updating the  kernel? Although we don't know yet, but, I am hoping
> that by updating the kernel and loading the k10temp kernel, I would be able
> to see readings from thermal-diode (core-temperature) along with the
> current readings from thermal-resistors.
>
> Thanks,
> Kapil
>
> >
> > Guenter
> >
>
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
>



-- 
Philip Pokorny, RHCE
Chief Technical Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

--089e013cb6e4e8529e04e3e1afa6
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">You may be able to compile the k10temp.c driver out of the=
 kernel.=A0 I&#39;ve had good success with that in the past.<br><br>If you =
have the kernel build environment, it&#39;s pretty straightforward.=A0 You =
just need a couple of files.<br>
<br>Phil P.<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Tue, Aug 13, 2013 at 10:17 PM, Kapil Dev <span dir=3D"ltr">&lt;<=
a href=3D"mailto:kapil_dev@brown.edu" target=3D"_blank">kapil_dev@brown.edu=
</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5"><br>
On Aug 14, 2013, at 12:56 AM, Guenter Roeck &lt;<a href=3D"mailto:linux@roe=
ck-us.net">linux@roeck-us.net</a>&gt; wrote:<br>
<br>
&gt; On 08/13/2013 08:09 PM, Dev, Kapil wrote:<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; On Tue, Aug 13, 2013 at 11:02 PM, Guenter Roeck &lt;<a href=3D"mai=
lto:linux@roeck-us.net">linux@roeck-us.net</a> &lt;mailto:<a href=3D"mailto=
:linux@roeck-us.net">linux@roeck-us.net</a>&gt;&gt; wrote:<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0On 08/13/2013 07:41 PM, Dev, Kapil wrote:<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0Thanks again Guenter!<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0On Tue, Aug 13, 2013 at 5:51 PM, Guenter Roeck &lt;=
<a href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a> &lt;mailto:<a =
href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt; &lt;mailto:<a=
 href=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a> &lt;mailto:<a hr=
ef=3D"mailto:linux@roeck-us.net">linux@roeck-us.net</a>&gt;&gt;&gt; wrote:<=
br>

&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 On Tue, Aug 13, 2013 at 05:11:31PM -0400, =
Dev, Kapil wrote:<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; Thanks for the response Guenter!<b=
r>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; I put the system on load and I not=
iced their value hardly changes. To my<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; surprise, I ran a benchmark for 3 =
minutes and none of temp* =A0values changed<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; during execution. The highest repo=
rted temperature is always 48C.<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; I was expecting that the internal =
temperature would have &quot;sensor =3D thermal<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; diode&quot; or &quot;sensor =3D co=
re&quot; as a keyword. I thought &quot;sensor=3Dthermistor&quot; means<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; the corresponding sensor is on the=
 motherboard and not the internal<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt; die-sensor.<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 Sure, but who knows if they put a sensor b=
elow the CPU for some reason ...<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 I am not familiar with the A10 CPUs. Are t=
hose similar to K10 ?<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 If so, maybe the k10temp driver works or c=
ould be extended to support it.<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 Can you give it a try ?<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0 =A0 =A0 If it does not work out of the box, can yo=
u send me the output of &quot;lspci -nn&quot; ?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0 =A0 =A0Kapil: I believe K10 corresponds to A8 seried, and =
A10 has Bulldozer architecture (<a href=3D"http://www.cpu-world.com/__CPUs/=
Bulldozer/TYPE-A10-__Series.html" target=3D"_blank">http://www.cpu-world.co=
m/__CPUs/Bulldozer/TYPE-A10-__Series.html</a> &lt;<a href=3D"http://www.cpu=
-world.com/CPUs/Bulldozer/TYPE-A10-Series.html" target=3D"_blank">http://ww=
w.cpu-world.com/CPUs/Bulldozer/TYPE-A10-Series.html</a>&gt;). I am not sure=
 how different they are though. I tried K10, but it did not work out of the=
 box. I am looking into k10temp.c driver now. Also,I am attaching the outpu=
t of &quot;lspci -nn&quot; command herewith; you might have to open it usin=
g wordpad for proper formatting..<br>

&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0Your lspci output includes<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A000:18.3 Host bridge [0600]: Advanced Micro Devices [AMD] De=
vice [1022:1403]<br>
&gt;&gt;<br>
&gt;&gt; =A0 =A0which is supported by the latest k10temp driver. Support wa=
s added early last year.<br>
&gt;&gt; =A0 =A0What is your kernel version, and can you switch to a more r=
ecent version ?<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; Kapil: I have 2.6.39-020639-generic kernel. Is it too old kernel f=
or k10temp driver to work? Which stable kernel should I upgrade to?<br>
&gt;&gt;<br>
&gt;<br>
&gt; You need 3.4 or later.<br>
<br>
</div></div>Kapil: I was trying to avoid updating the kernel because my cur=
rent kernel is setup for running different type of benchmarks etc. Seems li=
ke I can&#39;t avoid updating the kernel; I will do it..<br>
<br>
Just for my understanding: Currently, when I run &quot;sensors&quot; comman=
d, I am getting three values (apparently wrong), temp1-3. So, what do you t=
hink is happening that is causing these values wrong? And, how is it going =
to be fixed by updating the =A0kernel? Although we don&#39;t know yet, but,=
 I am hoping that by updating the kernel and loading the k10temp kernel, I =
would be able to see readings from thermal-diode (core-temperature) along w=
ith the current readings from thermal-resistors.<br>

<br>
Thanks,<br>
Kapil<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; Guenter<br>
&gt;<br>
<br>
<br>
_______________________________________________<br>
lm-sensors mailing list<br>
<a href=3D"mailto:lm-sensors@lm-sensors.org">lm-sensors@lm-sensors.org</a><=
br>
<a href=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors" target=
=3D"_blank">http://lists.lm-sensors.org/mailman/listinfo/lm-sensors</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br><span><font=
 color=3D"#888888">Philip Pokorny, RHCE<br>
Chief Technical Officer<br>
PENGUIN COMPUTING, Inc<br>
<a href=3D"http://www.penguincomputing.com/" target=3D"_blank">www.penguinc=
omputing.com</a><br>
</font></span>
</div>

--089e013cb6e4e8529e04e3e1afa6--


--===============2779493795769687903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2779493795769687903==--
