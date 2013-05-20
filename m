From: Robert Coulson <rob.coulson@gmail.com>
Date: Mon, 20 May 2013 21:50:04 +0000
Subject: Re: [lm-sensors] Call for lm-sensors 3.3.4
Message-Id: <CAEZKy8Kb++sP_RxW_NFfhT-+v2E2bFtCCyEvaLAaRb3TyjpaFQ@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0006144155837898710=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20130507080052.4171493c@endymion.delvare>
In-Reply-To: <20130507080052.4171493c@endymion.delvare>
To: lm-sensors@vger.kernel.org

--===============0006144155837898710==
Content-Type: multipart/alternative; boundary=20cf3071ca32c2e67b04dd2d5037

--20cf3071ca32c2e67b04dd2d5037
Content-Type: text/plain; charset=ISO-8859-1

On Mon, May 20, 2013 at 6:28 AM, Guenter Roeck <linux@roeck-us.net> wrote:

> On Mon, May 20, 2013 at 02:10:15PM +0200, Jean Delvare wrote:
> > Hi Robert,
> >
> > Adding the list back, there's really no reason to keep this discussion
> > private.
> >
> > On Fri, 17 May 2013 07:51:13 -0700, Robert Coulson wrote:
> > > As you know, the ds1631 device cannot be uniquely identified,
> > > but it is displayed if a ds1621 device is detected; my thought is to
> > > remove the DS1631 and replace it DS1625. This change would
> > > provide more accurate device information for the user.
> > >
> > > If you agree, then I can submit a small patch for it, so please let me
> know.
> >
> > I'm afraid I don't quite understand what the problem is nor how you
> > intend to solve it. A patch showing your point might be the best
> > explanation.
> >
> > All these DS16xx devices are hard if not impossible to detect reliably,
> > because they lack device and vendor identification registers. If
> > anything I'd rather drop detection of these from sensors-detect
> > altogether. This script is really only meant to detect sensor chips on
> > PC systems, and I don't think any DS16xx was ever used on a consumer PC
> > system.
> >
> > Detection should probably be dropped from the ds1621 driver too, the
> > proper way to instantiate these devices is explicitly.
> >
> Agreed.
>
> Robert, can you send a patch ?
>
> Thanks,
> Guenter
>

Yes, I will send one shortly.

thanks again,

Rob.

--20cf3071ca32c2e67b04dd2d5037
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Mon, May 20, 2013 at 6:28 AM, Guenter Roeck <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@roeck-us.net</a=
>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div><div>On Mon, May 20, 2013 at 02:10:15PM=
 +0200, Jean Delvare wrote:<br>
&gt; Hi Robert,<br>
&gt;<br>
&gt; Adding the list back, there&#39;s really no reason to keep this discus=
sion<br>
&gt; private.<br>
&gt;<br>
&gt; On Fri, 17 May 2013 07:51:13 -0700, Robert Coulson wrote:<br>
&gt; &gt; As you know, the ds1631 device cannot be uniquely identified,<br>
&gt; &gt; but it is displayed if a ds1621 device is detected; my thought is=
 to<br>
&gt; &gt; remove the DS1631 and replace it DS1625. This change would<br>
&gt; &gt; provide more accurate device information for the user.<br>
&gt; &gt;<br>
&gt; &gt; If you agree, then I can submit a small patch for it, so please l=
et me know.<br>
&gt;<br>
&gt; I&#39;m afraid I don&#39;t quite understand what the problem is nor ho=
w you<br>
&gt; intend to solve it. A patch showing your point might be the best<br>
&gt; explanation.<br>
&gt;<br>
&gt; All these DS16xx devices are hard if not impossible to detect reliably=
,<br>
&gt; because they lack device and vendor identification registers. If<br>
&gt; anything I&#39;d rather drop detection of these from sensors-detect<br=
>
&gt; altogether. This script is really only meant to detect sensor chips on=
<br>
&gt; PC systems, and I don&#39;t think any DS16xx was ever used on a consum=
er PC<br>
&gt; system.<br>
&gt;<br>
&gt; Detection should probably be dropped from the ds1621 driver too, the<b=
r>
&gt; proper way to instantiate these devices is explicitly.<br>
&gt;<br>
</div></div>Agreed.<br>
<br>
Robert, can you send a patch ?<br>
<br>
Thanks,<br>
Guenter<br>
</blockquote></div><br></div><div class=3D"gmail_extra">Yes, I will send on=
e shortly.</div><div class=3D"gmail_extra"><br></div><div class=3D"gmail_ex=
tra">thanks again,</div><div class=3D"gmail_extra"><br>
</div><div class=3D"gmail_extra">Rob.=A0</div></div>

--20cf3071ca32c2e67b04dd2d5037--


--===============0006144155837898710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0006144155837898710==--
