From: =?ISO-8859-1?Q?Charles_Pr=E9vot?= <charlesprevot@gmail.com>
Date: Fri, 27 Nov 2009 22:32:35 +0000
Subject: Re: [lm-sensors] /sys/class/hwmon/ numbering
Message-Id: <18910e4d0911271432k735d23e9sd94f1ba0f0c47449@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5484427194303568567=="
List-Id: <lm-sensors.vger.kernel.org>
References: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
In-Reply-To: <18910e4d0911260014m5fe3445cmf423b25e6a68bf50@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============5484427194303568567==
Content-Type: multipart/alternative; boundary=00032555ad7e5544c1047961debf

--00032555ad7e5544c1047961debf
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 27, 2009 at 2:59 PM, Luca Tettamanti <kronos.it@gmail.com>wrote=
:

> On Fri, Nov 27, 2009 at 9:01 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > Bonjour Charles,
> > On Thu, 26 Nov 2009 09:14:45 +0100, Charles Pr=E9vot wrote:
> >> my motherboard is a Asus MN2 SLI DELUXE with AMD CPU
> >> below some results:
> [...]
> > This will indirectly solve your problem, although probably not the way
> > you would like: the asus_atk0110 driver doesn't offer manual fan speed
> > control facilities, instead you must select the automatic fan speed
> > control strategy in the BIOS.
> >
> > I'm not sure about the ACPI thermal zone, I thought Asus boards did not
> > have one. Luca, ever seen this before? Is it OK to use both the ACPI
> > thermal driver and the asus_atk0110 driver at the same time?
>
> Yes. I already have the DSDT of that board; internally TZ and ATK both
> use the same methods but the execution of the ACPI interpreter is
> serialized so there's no chance of conflict.
> On this particular board the it87 driver would interfere with TZ,
> regardless of whether asus_atk0110 is loaded or not: better not load
> it.
> Charles, the BIOS supports Q-FAN; in the DSDT I don't see the
> profiles, but a "Q-Fan Ratio". Check the manual (and the BIOS itself).
>
Exact, you were right. I don't know how I missed this one and then try to
use fancontrol...
Anyway, it solved my problems, and I learned a few things thanks to you all=
.
So thank you very much for your help Clemens, Jean and Luca.
(btw I disabled the it87 module)

>
> Luca
>

--00032555ad7e5544c1047961debf
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">On Fri, Nov 27, 2009 at 2:59 PM, Luca Te=
ttamanti <span dir=3D"ltr">&lt;<a href=3D"http://kronos.it">kronos.it</a>@<=
a href=3D"http://gmail.com">gmail.com</a>&gt;</span> wrote:<br><blockquote =
class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, 204, 204); m=
argin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div class=3D"im">On Fri, Nov 27, 2009 at 9:01 AM, Jean Delvare &lt;<a href=
=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt; wrote:<br>
</div><div class=3D"im">&gt; Bonjour Charles,<br>
&gt; On Thu, 26 Nov 2009 09:14:45 +0100, Charles Pr=E9vot wrote:<br>
</div><div class=3D"im">&gt;&gt; my motherboard is a Asus MN2 SLI DELUXE wi=
th AMD CPU<br>
&gt;&gt; below some results:<br>
</div>[...]<br>
<div class=3D"im">&gt; This will indirectly solve your problem, although pr=
obably not the way<br>
&gt; you would like: the asus_atk0110 driver doesn&#39;t offer manual fan s=
peed<br>
&gt; control facilities, instead you must select the automatic fan speed<br=
>
&gt; control strategy in the BIOS.<br>
&gt;<br>
&gt; I&#39;m not sure about the ACPI thermal zone, I thought Asus boards di=
d not<br>
&gt; have one. Luca, ever seen this before? Is it OK to use both the ACPI<b=
r>
&gt; thermal driver and the asus_atk0110 driver at the same time?<br>
<br>
</div>Yes. I already have the DSDT of that board; internally TZ and ATK bot=
h<br>
use the same methods but the execution of the ACPI interpreter is<br>
serialized so there&#39;s no chance of conflict.<br>
On this particular board the it87 driver would interfere with TZ,<br>
regardless of whether asus_atk0110 is loaded or not: better not load<br>
it.<br>
Charles, the BIOS supports Q-FAN; in the DSDT I don&#39;t see the<br>
profiles, but a &quot;Q-Fan Ratio&quot;. Check the manual (and the BIOS its=
elf).<br></blockquote><div>Exact, you were right. I don&#39;t know how I mi=
ssed this one and then try to use fancontrol... <br>Anyway, it solved my pr=
oblems, and I learned a few things thanks to you all. So thank you very muc=
h for your help Clemens, Jean and Luca.<br>
(btw I disabled the it87 module)<br></div><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
<font color=3D"#888888"><br>
Luca<br>
</font></blockquote></div><br>

--00032555ad7e5544c1047961debf--


--===============5484427194303568567==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5484427194303568567==--
