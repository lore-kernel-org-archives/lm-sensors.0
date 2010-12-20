From: "Henrik Rydberg" <rydberg@euromail.se>
Date: Mon, 20 Dec 2010 14:23:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather than
Message-Id: <20101220142344.GA19566@polaris.bitmath.org>
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
 <20101220145721.4c58ff3e@endymion.delvare>
In-Reply-To: <20101220145721.4c58ff3e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Jean Delvare <khali@linux-fr.org>
Cc: Mikael =?iso-8859-1?Q?Str=F6m?= <mikael@sesamiq.com>, Julien BLACHE <jb@jblache.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Matthew Garrett <mjg@redhat.com>

On Mon, Dec 20, 2010 at 02:57:21PM +0100, Jean Delvare wrote:
> On Mon, 20 Dec 2010 21:44:34 +0800, Mikael Str=F6m wrote:
> > Hi,
> >=20
> > I know nothing about the background to the mail below, but if it's of
> > any help, macfanctld uses the following hardwired paths,
> >=20
> > reading:
> >=20
> > /sys/devices/platform/applesmc.768/temp<n>_input
> >=20
> > and writing:
> >=20
> > /sys/devices/platform/applesmc.768/fan1_min
> > /sys/devices/platform/applesmc.768/fan2_min
> > /sys/devices/platform/applesmc.768/fan1_manual
> > /sys/devices/platform/applesmc.768/fan2_manual
> >=20
> > If any of those are to be broken, please advice in advance so i can
> > update the source before you break it, avoiding that the users fry their
> > MacBooks.
>=20
> I would expect the kernel driver to behave sanely in the absence of a
> user-space application. Isn't it the case? If not, I consider it a
> serious bug in the driver, which should be addressed ASAP.

The macbook overheat problems goes way back. All models have automatic
heat protection, but it kicks in at temperatures uncomfortable to most
users. The severity also depends on when the model was made. The
current solution is to use the macfanctld driver, which disables
automatic fan control, replacing it with a control loop yielding more
workable temperatures. A fan control solution in the kernel would
certainly be well received.

Henrik

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
