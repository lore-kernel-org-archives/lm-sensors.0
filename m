From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Tue, 06 Sep 2011 18:14:06 +0000
Subject: Re: [lm-sensors] [PATCH 6/6 V4] hwmon: OMAP4: On die temperature
Message-Id: <CAJ6a13ZT_q1XYPebSLyLh7a7k6KeOsyERHfx+EKo+_u9bjxxMg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1314811510-15595-1-git-send-email-j-keerthy@ti.com>
	<1314811510-15595-7-git-send-email-j-keerthy@ti.com>
	<alpine.DEB.2.00.1108311810280.26173@utopia.booyaka.com>
	<20110901014939.GB21986@ericsson.com>
	<alpine.DEB.2.00.1108312200260.26173@utopia.booyaka.com>
	<20110901044047.GB25878@ericsson.com>
In-Reply-To: <20110901044047.GB25878@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: Paul Walmsley <paul@pwsan.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Thu, Sep 1, 2011 at 10:10 AM, Guenter Roeck
<guenter.roeck@ericsson.com> wrote:
> On Thu, Sep 01, 2011 at 12:09:14AM -0400, Paul Walmsley wrote:
>> On Wed, 31 Aug 2011, Guenter Roeck wrote:
>>
>> > On Wed, Aug 31, 2011 at 08:36:43PM -0400, Paul Walmsley wrote:
>> > > Hi
>> > >
>> > > Some comments.
>> > >
>> > > On Wed, 31 Aug 2011, Keerthy wrote:
>> > >
>> > [ ... ]
>> > >
>> > > > +}
>> > > > +
>> > > > +/* Sysfs hook functions */
>> > >
>> > > These should be conditionally compiled out if sysfs isn't compiled i=
n.
>> > >
>> > The whole point of the hwmon subsystem is to expose hardware monitorin=
g information
>> > to userland using sysfs. hwmon without sysfs doesn't make sense.
>> >
>> > So, if anything, it might make sense to disable the entire hwmon tree =
if sysfs is disabled.
>> > But please no conditionals in the code.
>>
>> Hmm. =A0This IP block is more than just a sensor. =A0It also can interru=
pt the
>> CPU and/or trigger a GPIO line (to shut down the chip) if the chip
>> temperature crosses some thresholds. =A0On some OMAPs, the thresholds are
>> fixed; on others, they are software-programmable. =A0That functionality
>> shouldn't require sysfs; it's almost closer to an x86 MCE.
>>
>> So based on your comments, it sounds like we should move that part of the
>> code to a different driver, and just leave the basic software thermal
>> monitoring here?
>>
> Good point. This definitely requires some thought. hwmon is meant to be h=
w monitoring,
> as the name says, not thermal management. Maybe this entire driver should=
 be a thermal driver
> instead ?

This driver is not taking any action on THSUT. This is not doing the thermal
management. It is a driver exposing configurable temperature thresholds.

>
> Guenter
>



--=20
Regards and Thanks,
Keerthy

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
