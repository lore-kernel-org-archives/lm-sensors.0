From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Tue, 30 Nov 2010 02:29:08 +0000
Subject: Re: [lm-sensors] [PATCH] adm1026: fix setting fan_div
Message-Id: <AANLkTikurDrgZxtAU-Q4-04nMW=ikGon-Fa489JKaSjr@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============5734468589537722333=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20101130014623.GA26439@penguintown.net>
In-Reply-To: <20101130014623.GA26439@penguintown.net>
To: lm-sensors@vger.kernel.org

--===============5734468589537722333==
Content-Type: multipart/alternative; boundary=90e6ba6e83c40bf19704963bf4a3

--90e6ba6e83c40bf19704963bf4a3
Content-Type: text/plain; charset=ISO-8859-1

Thanks for the patch.

On Mon, Nov 29, 2010 at 5:49 PM, Gabriele Gorla <gorlik@penguintown.net>wrote:

> Prevent setting fan_div from stomping on other fans that share the same i2c
> register.
>

Ugh...  Wow, that was clearly wrong logic now that you point it out...


> Also allow div=1 (this is allowed in the ADM1026 datasheet)


The old code didn't throw an EINVAL on most invalid divisors, it just
silently converted them to the next reasonable value in the way that
DIV_TO_REG worked.  If you're going to change the behavior and throw EINVAL
for divisors greater than 8, perhaps you should check explicilty for the
four legal values (val != 1 && val != 2 && val != 4 && val != 8)

Then you could eliminate the new_div DIV_TO_REG/REG_TO_DIV conversions and
just test fan_div[nr] against val.  That would eliminate the "new_div"
variable which would be good since it doesn't actually hold a "div" but a
"reg" value, so it's somewhat mis-named.


> and prevent the mutex lock
> when no update is necessary.
>
>
If you don't take the mutex before testing the fan_div, then isn't there a
possible race where you test first, but then it changes before you take the
mutex to "change" it?  Is there any possible harm?  If multiple threads are
trying to set the same divisor or different divisors for the same or
different fans?  Just thinking out loud...

Phil P.

--90e6ba6e83c40bf19704963bf4a3
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks for the patch.<br><br><div class=3D"gmail_quote">On Mon, Nov 29, 201=
0 at 5:49 PM, Gabriele Gorla <span dir=3D"ltr">&lt;<a href=3D"mailto:gorlik=
@penguintown.net">gorlik@penguintown.net</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1=
px solid rgb(204, 204, 204); padding-left: 1ex;">
Prevent setting fan_div from stomping on other fans that share the same i2c=
 register.<br></blockquote><div><br>Ugh...=A0 Wow, that was clearly wrong l=
ogic now that you point it out...<br>=A0<br></div><blockquote class=3D"gmai=
l_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; border-left: 1px solid rgb(204=
, 204, 204); padding-left: 1ex;">

Also allow div=3D1 (this is allowed in the ADM1026 datasheet) </blockquote>=
<div><br>The old code didn&#39;t throw an EINVAL on most invalid divisors, =
it just silently converted them to the next reasonable value in the way tha=
t DIV_TO_REG worked.=A0 If you&#39;re going to change the behavior and thro=
w EINVAL for divisors greater than 8, perhaps you should check explicilty f=
or the four legal values (val !=3D 1 &amp;&amp; val !=3D 2 &amp;&amp; val !=
=3D 4 &amp;&amp; val !=3D 8)<br>
<br>Then you could eliminate the new_div DIV_TO_REG/REG_TO_DIV conversions =
and just test fan_div[nr] against val.=A0 That would eliminate the &quot;ne=
w_div&quot; variable which would be good since it doesn&#39;t actually hold=
 a &quot;div&quot; but a &quot;reg&quot; value, so it&#39;s somewhat mis-na=
med.<br>
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8=
ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">and prev=
ent the mutex lock<br>
when no update is necessary.<br><br></blockquote><div><br>If you don&#39;t =
take the mutex before testing the fan_div, then isn&#39;t there a possible =
race where you test first, but then it changes before you take the mutex to=
 &quot;change&quot; it?=A0 Is there any possible harm?=A0 If multiple threa=
ds are trying to set the same divisor or different divisors for the same or=
 different fans?=A0 Just thinking out loud...<br>
<br>Phil P. <br></div></div>

--90e6ba6e83c40bf19704963bf4a3--


--===============5734468589537722333==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============5734468589537722333==--
