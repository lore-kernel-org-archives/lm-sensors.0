From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Wed, 31 Oct 2012 05:31:35 +0000
Subject: Re: [lm-sensors] coretemp.ko -- Sandy Bridge: temperature readings "biased" based on power consumpti
Message-Id: <CAAek22H+UQgiqp3g+h4=MES_WwS2bCXLwRAbmK42Z8hKiuO0kg@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7459373115267753835=="
List-Id: <lm-sensors.vger.kernel.org>
References: <50905C34.31182.67732CA0@Frantisek.Rysanek.post.cz>
In-Reply-To: <50905C34.31182.67732CA0@Frantisek.Rysanek.post.cz>
To: lm-sensors@vger.kernel.org

--===============7459373115267753835==
Content-Type: multipart/alternative; boundary=f46d044469254bf34404cd543734

--f46d044469254bf34404cd543734
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Oct 30, 2012 at 5:32 PM, Guenter Roeck <linux@roeck-us.net> wrote:

> Hi Frantisek,
>
> On Wed, Oct 31, 2012 at 12:01:08AM +0100, Frantisek Rysanek wrote:
> > Dear gentlemen,
> >
> > I've just tried looking at the CPU temperature via coretemp.ko on
> > some SandyBridge CPU's. I have a desktop-grade Core I3 at 3.3 GHz,
> > and a mobile Core i5 at 2.5 GHz. When I flip the CPU from "pretty
> > much idle" to "each core running a cpuburn instance", the temperature
> > reported by coretemp *jumps* up in a second. On the desktop CPU, the
> > jump is about 10*C. On the mobile CPU, the jump is about 25-30 *C !
> > It jumps up in a second after I launch the software load - and then
> > it proceeds to gradually inch up, as the massive heatsink starts to
> > warm up a bit (perhaps another degree C in twenty seconds to a
> > minute).
> >
> I think that is pretty normal. Keep in mind this is the temperature within
> the chip core, not at the external package.
>

And there is internal thermal paste inside the CPU package between the CPU
die itself and the integrated heat spreader.  That thermal material also
explains why the silicon die temperature can jump so quickly.  It has a
higher deg C/W than the IHS and the heatsink on top of that.

Phil P.

--f46d044469254bf34404cd543734
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Oct 30, 2012 at 5:32 PM, Guenter Roeck <=
span dir=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank=
">linux@roeck-us.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
">
Hi Frantisek,<br>
<div class=3D"im"><br>
On Wed, Oct 31, 2012 at 12:01:08AM +0100, Frantisek Rysanek wrote:<br>
&gt; Dear gentlemen,<br>
&gt;<br>
&gt; I&#39;ve just tried looking at the CPU temperature via coretemp.ko on<=
br>
&gt; some SandyBridge CPU&#39;s. I have a desktop-grade Core I3 at 3.3 GHz,=
<br>
&gt; and a mobile Core i5 at 2.5 GHz. When I flip the CPU from &quot;pretty=
<br>
&gt; much idle&quot; to &quot;each core running a cpuburn instance&quot;, t=
he temperature<br>
&gt; reported by coretemp *jumps* up in a second. On the desktop CPU, the<b=
r>
&gt; jump is about 10*C. On the mobile CPU, the jump is about 25-30 *C !<br=
>
&gt; It jumps up in a second after I launch the software load - and then<br=
>
&gt; it proceeds to gradually inch up, as the massive heatsink starts to<br=
>
&gt; warm up a bit (perhaps another degree C in twenty seconds to a<br>
&gt; minute).<br>
&gt;<br>
</div>I think that is pretty normal. Keep in mind this is the temperature w=
ithin<br>
the chip core, not at the external package.<br></blockquote><div><br>And th=
ere is internal thermal paste inside the CPU package between the CPU die it=
self and the integrated heat spreader.=A0 That thermal material also explai=
ns why the silicon die temperature can jump so quickly.=A0 It has a higher =
deg C/W than the IHS and the heatsink on top of that.<br>
<br>Phil P. <br></div></div>

--f46d044469254bf34404cd543734--


--===============7459373115267753835==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7459373115267753835==--
