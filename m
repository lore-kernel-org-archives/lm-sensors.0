From: "Philip Pokorny" <ppokorny@penguincomputing.com>
Date: Thu, 26 Jul 2007 20:03:52 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <654FA770A883FB43BAF3CB0B1E1DAC8C8320C9@orca.penguincomputing.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C7CFC0.167E2253"
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

--===============8985833807290501701==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7CFC0.167E2253"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7CFC0.167E2253
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

The trick of not reading the limits was something I did in the LM85 =
driver...

The read function has two time stamps.  One to trigger reading of the =
dynamic values if they haven't been read recently (1-2 second) and =
another that triggers reading the limits but no more often than 10 to 60 =
seconds.

:v)

--=20
Philip Pokorny, RHCE
Director of Field Engineering=20
Penguin Computing  http://www.penguincomputing.com

 -----Original Message-----
From: 	Hans de Goede [mailto:j.w.r.degoede@hhs.nl]
Sent:	Thursday, July 26, 2007 10:01 AM Pacific Standard Time
To:	Darrick J. Wong
Cc:	Vadim Zeitlin; LM Sensors
Subject:	Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically =
via timer to avoid blocking

Darrick J. Wong wrote:
> On Thu, Jul 26, 2007 at 08:08:09AM -0700, Juerg Haefliger wrote:
>> Hi Darrick,
>>
>> I guess I'm not seeing the big picture :-) The problem you're trying
>> to solve is that the reading of the registers takes a long time and
>> needs to be able to sleep?
>=20
> Yes, and also that sleeping in the sysfs read function is not =
desirable.
> Personally, I was fine with that, but Mr. de Goede was concerned about
> it, so I decided to try to fix it.  I admit, the =
dual-delayed-workqueue
> method is a bit strange, but it solves the reading problem at a slight
> cost of waking up the CPU even if nobody's watching the sensors.
>=20

I just read in another thread, that other hwmon drivers suffer from =
similar=20
problems, so I guess userspace will just have to be able to deal with =
this, and=20
the best fix is not to fix it. Sorry to waist everybody's time on this.

Regards,

Hans


p.s.

You could still try to shave some time off by not reading all the limits =
etc=20
each update.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

------_=_NextPart_001_01C7CFC0.167E2253
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<TITLE>Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via =
timer to avoid blocking</TITLE>
</HEAD>
<BODY>
<!-- Converted from text/plain format -->

<P><FONT SIZE=3D2>The trick of not reading the limits was something I =
did in the LM85 driver...<BR>
<BR>
The read function has two time stamps.&nbsp; One to trigger reading of =
the dynamic values if they haven't been read recently (1-2 second) and =
another that triggers reading the limits but no more often than 10 to 60 =
seconds.<BR>
<BR>
:v)<BR>
<BR>
--<BR>
Philip Pokorny, RHCE<BR>
Director of Field Engineering<BR>
Penguin Computing&nbsp; <A =
HREF=3D"http://www.penguincomputing.com">http://www.penguincomputing.com<=
/A><BR>
<BR>
&nbsp;-----Original Message-----<BR>
From: &nbsp; Hans de Goede [<A =
HREF=3D"mailto:j.w.r.degoede@hhs.nl">mailto:j.w.r.degoede@hhs.nl</A>]<BR>=

Sent:&nbsp;&nbsp; Thursday, July 26, 2007 10:01 AM Pacific Standard =
Time<BR>
To:&nbsp;&nbsp;&nbsp;&nbsp; Darrick J. Wong<BR>
Cc:&nbsp;&nbsp;&nbsp;&nbsp; Vadim Zeitlin; LM Sensors<BR>
Subject:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Re: [lm-sensors] =
[PATCH] adt7470: Update sensors periodically via timer to avoid =
blocking<BR>
<BR>
Darrick J. Wong wrote:<BR>
&gt; On Thu, Jul 26, 2007 at 08:08:09AM -0700, Juerg Haefliger =
wrote:<BR>
&gt;&gt; Hi Darrick,<BR>
&gt;&gt;<BR>
&gt;&gt; I guess I'm not seeing the big picture :-) The problem you're =
trying<BR>
&gt;&gt; to solve is that the reading of the registers takes a long time =
and<BR>
&gt;&gt; needs to be able to sleep?<BR>
&gt;<BR>
&gt; Yes, and also that sleeping in the sysfs read function is not =
desirable.<BR>
&gt; Personally, I was fine with that, but Mr. de Goede was concerned =
about<BR>
&gt; it, so I decided to try to fix it.&nbsp; I admit, the =
dual-delayed-workqueue<BR>
&gt; method is a bit strange, but it solves the reading problem at a =
slight<BR>
&gt; cost of waking up the CPU even if nobody's watching the =
sensors.<BR>
&gt;<BR>
<BR>
I just read in another thread, that other hwmon drivers suffer from =
similar<BR>
problems, so I guess userspace will just have to be able to deal with =
this, and<BR>
the best fix is not to fix it. Sorry to waist everybody's time on =
this.<BR>
<BR>
Regards,<BR>
<BR>
Hans<BR>
<BR>
<BR>
p.s.<BR>
<BR>
You could still try to shave some time off by not reading all the limits =
etc<BR>
each update.<BR>
<BR>
<BR>
_______________________________________________<BR>
lm-sensors mailing list<BR>
lm-sensors@lm-sensors.org<BR>
<A =
HREF=3D"http://lists.lm-sensors.org/mailman/listinfo/lm-sensors">http://l=
ists.lm-sensors.org/mailman/listinfo/lm-sensors</A><BR>
</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C7CFC0.167E2253--


--===============8985833807290501701==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8985833807290501701==--
