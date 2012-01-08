From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:15:22 +0000
Subject: Re: [lm-sensors] next 17 checkpatch patches
Message-Id: <CACW_hTYkaj1PmUBkLLwTx7hG4vM5rcj8PTKnr3CmOUEUQJG=yA@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============7073628101828576268=="
List-Id: <lm-sensors.vger.kernel.org>
References: <CACW_hTZ1cYLXJS3cpsQ8fDTrr40PqPc654892a7FRR7VNng9GA@mail.gmail.com>
In-Reply-To: <CACW_hTZ1cYLXJS3cpsQ8fDTrr40PqPc654892a7FRR7VNng9GA@mail.gmail.com>
To: lm-sensors@vger.kernel.org

--===============7073628101828576268==
Content-Type: multipart/alternative; boundary=f46d0434beeeea9e6404b60843b4

--f46d0434beeeea9e6404b60843b4
Content-Type: text/plain; charset=ISO-8859-1

2012/1/8 Guenter Roeck <guenter.roeck@ericsson.com>

> Hi Frans,
>
> On Sun, Jan 08, 2012 at 11:23:29AM -0500, Frans Meulenbroeks wrote:
> > Hi all,
> >
> > I've examined some more files for checkpatch problems.
> > After this I'll post 17 patches.
> > checkpatch lists no problems with them
> > They are all compile tested
> >
> > Within the files I address some problems are not resolved:
> >
> > There were a few places where lines were a few chars too long but were
> not easy
> > to break
> > (e.g. because it was a long URL).
> >
> > There was one place where a macro needed a do while(0); didn't peek at
> that one
> > yet
> >
> > And on a place there were two assignments in an if. Previously on a
> different
> > case Jean told me
> > it was intentional, therefore I did not touch it
> > (I did touch a few places where there was a single assignment within an
> if).
> >
> > I might be doing a few more of these later today or next few days.
> > There are still about 50 files with errors or warning left. However, I
> have
> > kinda picked the low hanging fruit (= the files that only have a few
> errors).
> >
> > Best regards, Frans
> >
> > PS: I did not bother to report the details of the checkpatch errors that
> were
> > fixed in the commit message.
>
> Would be great if you could do that, though. Not in the headline, but in
> the text.
> Otherwise, I or Jean would have to do it, for which we don't necessarily
> have the time.
>
> > For some of the files that still are to be done that would result in
> commit
> > messages of > 100 lines (and not too useful).
>
> That is why you do it in the explanation, not in the headline ...
>
> Another nitpick: We commonly use
>
> hwmon: (drivername) This is a commit message
>
> as commit headline. Not much difference, but it would save us a couple of
> minutes
> if you could do that as well.
>
> Patches look good, except for the last one for which I sent you separate
> feedback.
> Would be great if you could resubmit the series with the above changes.
>
> Thanks,
> Guenter
>

Will fix, thanks for the quick reply.
It'll take an hour or so, I need to revert all paches and regenerate the
checkpatch output (I already nuked that one)

--f46d0434beeeea9e6404b60843b4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><br><div class=3D"gmail_quote">2012/1/8 Guenter Roeck <span dir=3D"ltr"=
>&lt;<a href=3D"mailto:guenter.roeck@ericsson.com">guenter.roeck@ericsson.c=
om</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
Hi Frans,<br>
<div class=3D"im"><br>
On Sun, Jan 08, 2012 at 11:23:29AM -0500, Frans Meulenbroeks wrote:<br>
&gt; Hi all,<br>
&gt;<br>
&gt; I&#39;ve examined some more files for checkpatch problems.<br>
&gt; After this I&#39;ll post 17 patches.<br>
&gt; checkpatch lists no problems with them<br>
&gt; They are all compile tested<br>
&gt;<br>
&gt; Within the files I address some problems are not resolved:<br>
&gt;<br>
&gt; There were a few places where lines were a few chars too long but were=
 not easy<br>
&gt; to break<br>
&gt; (e.g. because it was a long URL).<br>
&gt;<br>
&gt; There was one place where a macro needed a do while(0); didn&#39;t pee=
k at that one<br>
&gt; yet<br>
&gt;<br>
&gt; And on a place there were two assignments in an if. Previously on a di=
fferent<br>
&gt; case Jean told me<br>
&gt; it was intentional, therefore I did not touch it<br>
&gt; (I did touch a few places where there was a single assignment within a=
n if).<br>
&gt;<br>
&gt; I might be doing a few more of these later today or next few days.<br>
&gt; There are still about 50 files with errors or warning left. However, I=
 have<br>
&gt; kinda picked the low hanging fruit (=3D the files that only have a few=
 errors).<br>
&gt;<br>
&gt; Best regards, Frans<br>
&gt;<br>
&gt; PS: I did not bother to report the details of the checkpatch errors th=
at were<br>
&gt; fixed in the commit message.<br>
<br>
</div>Would be great if you could do that, though. Not in the headline, but=
 in the text.<br>
Otherwise, I or Jean would have to do it, for which we don&#39;t necessaril=
y have the time.<br>
<div class=3D"im"><br>
&gt; For some of the files that still are to be done that would result in c=
ommit<br>
&gt; messages of &gt; 100 lines (and not too useful).<br>
<br>
</div>That is why you do it in the explanation, not in the headline ...<br>
<br>
Another nitpick: We commonly use<br>
<br>
hwmon: (drivername) This is a commit message<br>
<br>
as commit headline. Not much difference, but it would save us a couple of m=
inutes<br>
if you could do that as well.<br>
<br>
Patches look good, except for the last one for which I sent you separate fe=
edback.<br>
Would be great if you could resubmit the series with the above changes.<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br>Will fix, thanks for the quick reply.<br>It&#39;ll t=
ake an hour or so, I need to revert all paches and regenerate the checkpatc=
h output (I already nuked that one)<br>

--f46d0434beeeea9e6404b60843b4--


--===============7073628101828576268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============7073628101828576268==--
