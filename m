From: =?ISO-8859-1?Q?Lars_Nood=E9n?= <lars.nooden@gmail.com>
Date: Thu, 03 Nov 2011 08:29:49 +0000
Subject: Re: [lm-sensors] Hardware running hot and without the fan
Message-Id: <4EB250FD.3070000@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4EB1108F.6070009@gmail.com> <20111103020301.GA22333@ericsson.com>
In-Reply-To: <20111103020301.GA22333@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Guenter Roeck <guenter.roeck@ericsson.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, Henrik Rydberg <rydberg@euromail.se>

On 11/03/2011 04:03 AM, Guenter Roeck wrote:
> From LKML:
>=20
> On Wed, Nov 02, 2011 at 05:42:39AM -0400, Lars Nood=E9n wrote:
>> There seem to be two problems here, one is that the hardware is=20
>> getting WAY too hot, another is that the fan is not turning on when
>> the hardware gets too hot.
>>=20
>> $ uname -a Linux xubuntu 3.1.0-999-generic #201110270406 SMP Thu=20
>> Oct 27 08:07:41 UTC 2011 x86_64 x86_64 x86_64 GNU/Linux
>>=20
>> I've reported the problem to Ubuntu=20
>> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/881593 and the
>> suggestion there was to report it upstream.
>>=20
>> On the notebook computer, parts become very hot to the touch while=20
>> running Ubuntu, but the fan does not run even after it gets hot.=20
>> When I boot back to OS X, the fan kicks in and runs until the=20
>> computer returns to being cool to the touch.  Similar for the=20
>> desktop, though I must follow the temperature with=20
>> /usr/bin/sensors.
>>=20
>> The notebook is a MacBookPro8,2 and the desktop is a Macmini3,1
>>=20
>> What metrics do I need to collect to help fix the problem?  I've=20
>> already reported the problem to Ubuntu[2] and the recommendation=20
>> was to try reporting upstream.
>>=20
>> Please CC me in the replies. /Lars
>>=20
>> [1] http://kernel.ubuntu.com/~kernel-ppa/mainline/daily/current/
>>=20
>> [2] https://bugs.launchpad.net/ubuntu/+source/linux/+bug/881593
>=20
> I see applesmc: : read arg fail in the dmesg log. No idea what that=20
> means. Maybe the driver maintainer or someone else on the lm-sensors
>  mailing list can help.
>=20
> Not sure I understand your comment about having to follow the output
>  of the sensors command. Can you clarify ?

That's to track the temperature manually.

> Also, do you get any output from the sensors command on the notebook?
> Thanks, Guenter

Yes.  It claims to have 24 temperature sensors.

/Lars



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
