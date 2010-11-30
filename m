From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 30 Nov 2010 19:05:22 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <AANLkTik3f_KH-1TxUT6k8S64TAKyT4Kz1gQSzJWcxMhM@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0791047304705170078=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
To: lm-sensors@vger.kernel.org

--===============0791047304705170078==
Content-Type: multipart/alternative; boundary=90e6ba6e8752d860bc049649de93

--90e6ba6e8752d860bc049649de93
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Nov 30, 2010 at 1:17 AM, Jean Delvare <khali@linux-fr.org> wrote:

>
> > +             mutex_lock(&data->update_lock);
> > +             orig_div = data->fan_div[nr];
> > +             data->fan_div[nr] = DIV_FROM_REG(new_div);
> > +
> > +             if (nr < 4) { /* 0 <= nr < 4 */
> > +                     adm1026_write_value(client,
> ADM1026_REG_FAN_DIV_0_3,
> > +                                 (DIV_TO_REG(data->fan_div[0]) << 0) |
> > +                                 (DIV_TO_REG(data->fan_div[1]) << 2) |
> > +                                 (DIV_TO_REG(data->fan_div[2]) << 4) |
> > +                                 (DIV_TO_REG(data->fan_div[3]) << 6) );
> > +             } else { /* 3 < nr < 8 */
> > +                     adm1026_write_value(client,
> ADM1026_REG_FAN_DIV_4_7,
> > +                                 (DIV_TO_REG(data->fan_div[4]) << 0) |
> > +                                 (DIV_TO_REG(data->fan_div[5]) << 2) |
> > +                                 (DIV_TO_REG(data->fan_div[6]) << 4) |
> > +                                 (DIV_TO_REG(data->fan_div[7]) << 6) );
> > +             }
>
>
> Note: this is horribly inefficient. In my opinion, data->fan_div should
> hold split but un-decoded register values. Calling DIV_FROM_REG() is
> cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()
> shouldn't exist in the first place, as the conversion should happen in
> a single place. Again, this is material for a separate patch.
>
>
I humbly suggest that you are forgetting something.  With your
recommendation, the REG_TO_DIV function would be called many orders of
magnitute more times (thousands? millions?) than the DIV_TO_REG function
here.  REG_TO_DIV would have to be called every time the fan speed is _read_
but DIV_TO_REG only needs to be called the one or two times that the fan_div
is _written_  So while the macros might differ in complexity, the number of
times they are called swamps any economy gained by changing the fan_div from
divisor to register value.

The code above is clear in and appropriate in my opinion.

Phil P.

--90e6ba6e8752d860bc049649de93
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">On Tue, Nov 30, 2010 at 1:17 AM, Jean Delvare <s=
pan dir=3D"ltr">&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.or=
g</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-le=
ft: 1ex;">
<br><div class=3D"im">
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&amp;data-&gt;update_lock);<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 orig_div =3D data-&gt;fan_div[nr];<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 data-&gt;fan_div[nr] =3D DIV_FROM_REG(new_di=
v);<br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 if (nr &lt; 4) { /* 0 &lt;=3D nr &lt; 4 */<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_value(client, =
ADM1026_REG_FAN_DIV_0_3,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[0]) &lt;&lt; 0) |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[1]) &lt;&lt; 2) |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[2]) &lt;&lt; 4) |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[3]) &lt;&lt; 6) );<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 } else { /* 3 &lt; nr &lt; 8 */<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 adm1026_write_value(client, =
ADM1026_REG_FAN_DIV_4_7,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[4]) &lt;&lt; 0) |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[5]) &lt;&lt; 2) |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[6]) &lt;&lt; 4) |<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (DIV=
_TO_REG(data-&gt;fan_div[7]) &lt;&lt; 6) );<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 }<br>
<br>
</div><br>Note: this is horribly inefficient. In my opinion, data-&gt;fan_d=
iv should<br>
hold split but un-decoded register values. Calling DIV_FROM_REG() is<br>
cheap, calling DIV_TO_REG() is expensive. In fact DIV_TO_REG()<br>
shouldn&#39;t exist in the first place, as the conversion should happen in<=
br>
a single place. Again, this is material for a separate patch.<br>
<br></blockquote><div><br>I humbly suggest that you are forgetting somethin=
g.=A0 With your recommendation, the REG_TO_DIV function would be called man=
y orders of magnitute more times (thousands? millions?) than the DIV_TO_REG=
 function here.=A0 REG_TO_DIV would have to be called every time the fan sp=
eed is _read_ but DIV_TO_REG only needs to be called the one or two times t=
hat the fan_div is _written_=A0 So while the macros might differ in complex=
ity, the number of times they are called swamps any economy gained by chang=
ing the fan_div from divisor to register value.<br>
<br>The code above is clear in and appropriate in my opinion.<br><br>Phil P=
.<br></div></div>

--90e6ba6e8752d860bc049649de93--


--===============0791047304705170078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0791047304705170078==--
