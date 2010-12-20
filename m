From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 20 Dec 2010 13:57:21 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101220145721.4c58ff3e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com>
	<1292624661-32474-1-git-send-email-mjg@redhat.com>
	<20101218042320.GA14104@ericsson.com>
	<20101218093719.GA1493@polaris.bitmath.org>
	<20101218110954.7a2ca190@endymion.delvare>
	<20101218103139.GA1668@polaris.bitmath.org>
	<878vzngvyn.fsf@sonic.technologeek.org>
	<20101218115742.GA2063@polaris.bitmath.org>
	<1292852674.2118.10.camel@mike-laptop>
In-Reply-To: <1292852674.2118.10.camel@mike-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mikael =?ISO-8859-1?B?U3Ry9m0=?= <mikael@sesamiq.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Julien BLACHE <jb@jblache.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

On Mon, 20 Dec 2010 21:44:34 +0800, Mikael Str=F6m wrote:
> Hi,
>=20
> I know nothing about the background to the mail below, but if it's of
> any help, macfanctld uses the following hardwired paths,
>=20
> reading:
>=20
> /sys/devices/platform/applesmc.768/temp<n>_input
>=20
> and writing:
>=20
> /sys/devices/platform/applesmc.768/fan1_min
> /sys/devices/platform/applesmc.768/fan2_min
> /sys/devices/platform/applesmc.768/fan1_manual
> /sys/devices/platform/applesmc.768/fan2_manual
>=20
> If any of those are to be broken, please advice in advance so i can
> update the source before you break it, avoiding that the users fry their
> MacBooks.

I would expect the kernel driver to behave sanely in the absence of a
user-space application. Isn't it the case? If not, I consider it a
serious bug in the driver, which should be addressed ASAP.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
