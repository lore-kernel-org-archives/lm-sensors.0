From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Date: Thu, 17 Jan 2013 21:03:58 +0000
Subject: Re: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <8649d873-66ef-4b0f-a22d-8480e5aa1ead@email.android.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============4055655125448016507=="
List-Id: <lm-sensors.vger.kernel.org>
References: <20121124052707.GA17392@roeck-us.net> <50B09EDC.4020200@kernel.org> <20130116054918.GA7056@roeck-us.net> <50F667C9.6000106@jic23.retrosnub.co.uk> <20130117204549.GB22045@roeck-us.net>
In-Reply-To: <20130117204549.GB22045@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

--===============4055655125448016507==
Content-Type: multipart/alternative; boundary="----PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8"

------PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8
Content-Type: text/plain;
 charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Good point. New use case for us so suggestions on how to do the associati=
on cleanly would be most welcome. Is there anything similar out there? We=
 could add a per iio device sysfs interface to add additional mappings bu=
t it is a little uggly...

--=20
Sent from my Android phone with K-9 Mail. Please excuse my brevity.

Guenter Roeck <linux@roeck-us.net> wrote:

On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrote:
> On 16/01/13 05:49, Guenter Roeck wrote:
> >On Sat, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:
> >>On 11/24/2012 05:27 AM, Guenter Roeck wrote:
> >>>Hi all,
> >>Hi Guenter,
> >>>
> >>>What would it take to move the MAX1363 driver out of staging ?
> >>>
> >>Nothing given it is already out of staging in linux-next (though only=
 has been
> >>for about a week)
> >>
> >>>Background is that I need a hardware monitoring driver for MAX1139, =
and would
> >>>like to avoid using a driver from staging if possible (after all, it=
 might
> >>>go away anytime). Another option would be to submit a hwmon driver f=
or it,
> >>>but that doesn't seem to be the best approach.
> >>
> >>The hwmon driver client driver for iio devices is still in staging, b=
ut mainly
> >>because I haven't had a chance to take a last look at it before posti=
ng it to
> >>the hmwon list. IIRC you were more or less happy with what went into =
staging
> >>in the first place, so hopefully not too much left to do.
> >>
> >Jonathan,
> >
> >can you educate me how to actually use iio_hwmon ? I get it loaded,
> >which registers the platform driver, but I have no idea how to instant=
iate it.
> >
> http://marc.info/?l=3Dlinux-iio&m=3D132933525705497&w=3D2
>=20
> [PATCH 6/6] stargate2: example of map configuration for iio to hwmon
> example.
>=20
Hi Jonathan,

In other words, I can not test it on a PC unless I write a driver to
instantiate it. Not too helpful :(. It means that iio drivers can not
be used / instantiated for hardware monitoring on PCs.

Thanks,
Guenter


------PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8
Content-Type: text/html;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head></head><body><br>
Good point.  New use case for us so suggestions on how to do the associat=
ion cleanly would be most welcome.  Is there anything similar out there? =
We could add a per iio device sysfs interface to add additional mappings =
but it is a little uggly...<br>
<br>
-- <br>
Sent from my Android phone with K-9 Mail. Please excuse my brevity.<br><b=
r><div class=3D"gmail_quote">Guenter Roeck &lt;linux@roeck-us.net&gt; wro=
te:<blockquote class=3D"gmail_quote" style=3D"margin: 0pt 0pt 0pt 0.8ex; =
border-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">
<pre style=3D"white-space: pre-wrap; word-wrap:break-word; font-family: m=
onospace">On Wed, Jan 16, 2013 at 08:41:45AM +0000, Jonathan Cameron wrot=
e:<br />&gt; On 16/01/13 05:49, Guenter Roeck wrote:<br />&gt; &gt;On Sat=
, Nov 24, 2012 at 10:18:04AM +0000, Jonathan Cameron wrote:<br />&gt; &gt=
;&gt;On 11/24/2012 05:27 AM, Guenter Roeck wrote:<br />&gt; &gt;&gt;&gt;H=
i all,<br />&gt; &gt;&gt;Hi Guenter,<br />&gt; &gt;&gt;&gt;<br />&gt; &gt=
;&gt;&gt;What would it take to move the MAX1363 driver out of staging ?<b=
r />&gt; &gt;&gt;&gt;<br />&gt; &gt;&gt;Nothing given it is already out o=
f staging in linux-next (though only has been<br />&gt; &gt;&gt;for about=
 a week)<br />&gt; &gt;&gt;<br />&gt; &gt;&gt;&gt;Background is that I ne=
ed a hardware monitoring driver for MAX1139, and would<br />&gt; &gt;&gt;=
&gt;like to avoid using a driver from staging if possible (after all, it =
might<br />&gt; &gt;&gt;&gt;go away anytime). Another option would be to =
submit a hwmon driver for it,<br />&gt;
&gt;&gt;&gt;but that doesn't seem to be the best approach.<br />&gt; &gt;=
&gt;<br />&gt; &gt;&gt;The hwmon driver client driver for iio devices is =
still in staging, but mainly<br />&gt; &gt;&gt;because I haven't had a ch=
ance to take a last look at it before posting it to<br />&gt; &gt;&gt;the=
 hmwon list.  IIRC you were more or less happy with what went into stagin=
g<br />&gt; &gt;&gt;in the first place, so hopefully not too much left to=
 do.<br />&gt; &gt;&gt;<br />&gt; &gt;Jonathan,<br />&gt; &gt;<br />&gt; =
&gt;can you educate me how to actually use iio_hwmon ? I get it loaded,<b=
r />&gt; &gt;which registers the platform driver, but I have no idea how =
to instantiate it.<br />&gt; &gt;<br />&gt; <a href=3D"http://marc.info/?=
l=3Dlinux-iio&amp;m=3D132933525705497&amp;w=3D2">http://marc.info/?l=3Dli=
nux-iio&amp;m=3D132933525705497&amp;w=3D2</a><br />&gt; <br />&gt; [PATCH=
 6/6] stargate2: example of map configuration for iio to hwmon<br />&gt; =
example.<br />&gt; <br />Hi Jonathan,<br /><br />In other
words, I can not test it on a PC unless I write a driver to<br />instanti=
ate it. Not too helpful :(. It means that iio drivers can not<br />be use=
d / instantiated for hardware monitoring on PCs.<br /><br />Thanks,<br />=
Guenter<br /></pre></blockquote></div></body></html>
------PRP77NSC6KHQ3QFZY5KVYDSKLYDXV8--



--===============4055655125448016507==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============4055655125448016507==--

