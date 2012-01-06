From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Fri, 06 Jan 2012 08:35:05 +0000
Subject: Re: [lm-sensors] [PATCH] drivers/hwmon: fix trailing whitespace
Message-Id: <CACW_hTa+yB2qwE6fQtZnk=Oze9MiT99yGN0BFvxxUvu8QwkhJA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7070771224795554851=="
List-Id: <lm-sensors.vger.kernel.org>
References: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325798636-11819-1-git-send-email-fransmeulenbroeks@gmail.com>
To: lm-sensors@vger.kernel.org

--===============7070771224795554851==
Content-Type: multipart/alternative; boundary=f46d0434beee0529b904b5d7ed67

--f46d0434beee0529b904b5d7ed67
Content-Type: text/plain; charset=ISO-8859-1

2012/1/6 Jean Delvare <khali@linux-fr.org>

> Hi Frans,
>
> [...]


> > > not have any checkpatch errors or warnings.
> > (...)
> > Probably i should explain a little bit on my way of working.
> > For me the most efficient way to tackle this is to only fix one error
> type
> > at a time.
> > This reduces the chance of mistakes (like mixing up simple_strtoul and
> > strict_strtoul), and also makes doing the edits simpler.
>
> That's a bad example IMHO. These two changes should really go in the
> same commit, as they are so similar. You can easily generate them
> separately and then merge them together before sending.
>
> > However the side effect of this is that not all problems in a file are
> > solved.
>
> I definitely prefer doing it the other way around: take one driver and
> fix all (or most) style issues. While it is slightly more time
> consuming to review, it has advantages:
> * When backporting a driver to an older kernel, you can pick all
>  patches touching the driver, without having to filter out all changes
>  affecting other drivers.
> * Checkpatch is happy on every patch, which compensates for the harder
>  review.
> * Per-driver patches are easier for me and Guenter to handle. We tend
>  to each concentrate on a subset of the drivers for each release
>  cycle, so that our trees don't collide in linux-next. With
>  cross-driver patches we can't do that, which basically puts all the
>  handling burden on a single one of us for the whole release cycle.
> * It makes the history of each individual driver much easier to read.
>  Having 10 patches in the history to clean up 10 different style
>  issues doesn't exactly help.
>
> > PS: note that I don't own most of the hardware, so i cannot really
> run-time
> > verify my work, only do a compile-test.
>
> And so:
> * Testing by people with the hardware is much easier.
>
> If you still prefer cross-driver patches, I guess that's better than
> not getting contributions from you at all, but then please at least
> ensure that checkpatch doesn't complain about your patches, even if
> that means fixing more than one issue at once. BTW, all whitespace
> fixes can go in the same patch to start with, it makes sense to group
> them IMHO.
>
> Hi Jean,

Thanks for your feedback.
I did not really consider things from the perspective of the reviewer and
user.
Please ignore this patch. I'll revert back to file specific patches.
Note that I am not planning to clean all files with checkpatch problems,
but I'll probably do a few more inbetween other things (e.g. waiting for a
kernel rebuild).

Best regards, Frans

--f46d0434beee0529b904b5d7ed67
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/6 Jean Delvare <span dir=3D"ltr">=
&lt;<a href=3D"mailto:khali@linux-fr.org">khali@linux-fr.org</a>&gt;</span>=
<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<br><div class=3D"im"></div></blockquote><div>[...]<br>=A0<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0pt 0pt 0pt 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex"><div class=3D"im">
&gt; &gt; not have any checkpatch errors or warnings.<br>
</div>&gt; (...)<br>
<div class=3D"im">&gt; Probably i should explain a little bit on my way of =
working.<br>
&gt; For me the most efficient way to tackle this is to only fix one error =
type<br>
&gt; at a time.<br>
&gt; This reduces the chance of mistakes (like mixing up simple_strtoul and=
<br>
&gt; strict_strtoul), and also makes doing the edits simpler.<br>
<br>
</div>That&#39;s a bad example IMHO. These two changes should really go in =
the<br>
same commit, as they are so similar. You can easily generate them<br>
separately and then merge them together before sending.<br>
<div class=3D"im"><br>
&gt; However the side effect of this is that not all problems in a file are=
<br>
&gt; solved.<br>
<br>
</div>I definitely prefer doing it the other way around: take one driver an=
d<br>
fix all (or most) style issues. While it is slightly more time<br>
consuming to review, it has advantages:<br>
* When backporting a driver to an older kernel, you can pick all<br>
 =A0patches touching the driver, without having to filter out all changes<b=
r>
 =A0affecting other drivers.<br>
* Checkpatch is happy on every patch, which compensates for the harder<br>
 =A0review.<br>
* Per-driver patches are easier for me and Guenter to handle. We tend<br>
 =A0to each concentrate on a subset of the drivers for each release<br>
 =A0cycle, so that our trees don&#39;t collide in linux-next. With<br>
 =A0cross-driver patches we can&#39;t do that, which basically puts all the=
<br>
 =A0handling burden on a single one of us for the whole release cycle.<br>
* It makes the history of each individual driver much easier to read.<br>
 =A0Having 10 patches in the history to clean up 10 different style<br>
 =A0issues doesn&#39;t exactly help.<br>
<div class=3D"im"><br>
&gt; PS: note that I don&#39;t own most of the hardware, so i cannot really=
 run-time<br>
&gt; verify my work, only do a compile-test.<br>
<br>
</div>And so:<br>
* Testing by people with the hardware is much easier.<br>
<br>
If you still prefer cross-driver patches, I guess that&#39;s better than<br=
>
not getting contributions from you at all, but then please at least<br>
ensure that checkpatch doesn&#39;t complain about your patches, even if<br>
that means fixing more than one issue at once. BTW, all whitespace<br>
fixes can go in the same patch to start with, it makes sense to group<br>
them IMHO.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br></font></span></blockquo=
te><div>Hi Jean,<br><br>Thanks for your feedback.<br>I did not really consi=
der things from the perspective of the reviewer and user.<br>Please ignore =
this patch. I&#39;ll revert back to file specific patches.<br>
Note that I am not planning to clean all files with checkpatch problems, bu=
t I&#39;ll probably do a few more inbetween other things (e.g. waiting for =
a kernel rebuild).<br><br>Best regards, Frans <br></div></div><br>

--f46d0434beee0529b904b5d7ed67--


--===============7070771224795554851==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7070771224795554851==--
