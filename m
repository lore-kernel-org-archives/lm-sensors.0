From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 30 Nov 2010 19:19:34 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <AANLkTinTytRN=vzRZPPNWw1XDDAagtumRbW7wtL9zkge@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7190768972019418117=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
To: lm-sensors@vger.kernel.org

--===============7190768972019418117==
Content-Type: multipart/alternative; boundary=90e6ba6e83c4a8606a04964a11e9

--90e6ba6e83c4a8606a04964a11e9
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 30, 2010 at 11:10 AM, Gabriele Gorla <gorlik@penguintown.net>wrote:

> On Tue, Nov 30, 2010 at 10:17:13AM +0100, Jean Delvare wrote:
> > > +   if(val<1 || val>8) {
> > > +           return -EINVAL;
> >
> > As underlined by Phil already, this is a little inconsistent. You
> > should reject all invalid values, as documented at the end of
> > Documentation/hwmon/sysfs-interface. But this should be done in a
> > separate patch, as this isn't really a bug fix and changes the driver's
> > behavior on invalid input.
>
> Original code will reject 1 as input. I think this is a bug as div=1 is
> valid for adm1026.
> Anyway, if you think I should separate the patch and reject all invalid
> values it's ok for me.
>
>
Agree.  Thanks


> > +                   adm1026_write_value(client, ADM1026_REG_FAN_DIV_4_7,
> > > +                               (DIV_TO_REG(data->fan_div[4]) << 0) |
> > > +                               (DIV_TO_REG(data->fan_div[5]) << 2) |
> > > +                               (DIV_TO_REG(data->fan_div[6]) << 4) |
> > > +                               (DIV_TO_REG(data->fan_div[7]) << 6) );
> > > +           }
> >
> > Note: this is horribly inefficient. In my opinion, data->fan_div should
> > hold split but un-decoded register values. Calling DIV_FROM_REG() is
> > cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()
> > shouldn't exist in the first place, as the conversion should happen in
> > a single place. Again, this is material for a separate patch.
>
> agree.
>
>
NACK.

I disagree as I said before.  fan speed reading code gets called many more
times than the fan_div setting code and there is no savings in changing
fan_div from "div" to "reg" values.

Phil P.

--90e6ba6e83c4a8606a04964a11e9
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Nov 30, 2010 at 11:10 AM, Gabriele Gorla=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:gorlik@penguintown.net">gorlik@pen=
guintown.net</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" sty=
le=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204);=
 padding-left: 1ex;">
<div class=3D"im">On Tue, Nov 30, 2010 at 10:17:13AM +0100, Jean Delvare wr=
ote:<br>
</div><div><div class=3D"h5">&gt; &gt; + =A0 if(val&lt;1 || val&gt;8) {<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 return -EINVAL;<br>
&gt;<br>
&gt; As underlined by Phil already, this is a little inconsistent. You<br>
&gt; should reject all invalid values, as documented at the end of<br>
&gt; Documentation/hwmon/sysfs-interface. But this should be done in a<br>
&gt; separate patch, as this isn&#39;t really a bug fix and changes the dri=
ver&#39;s<br>
&gt; behavior on invalid input.<br>
<br>
</div></div>Original code will reject 1 as input. I think this is a bug as =
div=3D1 is<br>
valid for adm1026.<br>
Anyway, if you think I should separate the patch and reject all invalid<br>
values it&#39;s ok for me.<br>
<div class=3D"im"><br></div></blockquote><div><br>Agree.=A0 Thanks<br>=A0<b=
r><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt =
0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;"><div =
class=3D"im">

&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_value(client,=
 ADM1026_REG_FAN_DIV_4_7,<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DI=
V_TO_REG(data-&gt;fan_div[4]) &lt;&lt; 0) |<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DI=
V_TO_REG(data-&gt;fan_div[5]) &lt;&lt; 2) |<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DI=
V_TO_REG(data-&gt;fan_div[6]) &lt;&lt; 4) |<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DI=
V_TO_REG(data-&gt;fan_div[7]) &lt;&lt; 6) );<br>
&gt; &gt; + =A0 =A0 =A0 =A0 =A0 }<br>
&gt;<br>
&gt; Note: this is horribly inefficient. In my opinion, data-&gt;fan_div sh=
ould<br>
&gt; hold split but un-decoded register values. Calling DIV_FROM_REG() is<b=
r>
&gt; cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()<br>
&gt; shouldn&#39;t exist in the first place, as the conversion should happe=
n in<br>
&gt; a single place. Again, this is material for a separate patch.<br>
<br>
</div>agree.<br>
<br></blockquote><div>=A0</div><div>NACK. <br><br>I disagree as I said befo=
re.=A0 fan speed reading code gets called many more times than the fan_div =
setting code and there is no savings in changing fan_div from &quot;div&quo=
t; to &quot;reg&quot; values.<br>
</div></div><br>Phil P.<br>

--90e6ba6e83c4a8606a04964a11e9--


--===============7190768972019418117==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7190768972019418117==--
