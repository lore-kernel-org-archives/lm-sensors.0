From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 20 Dec 2010 14:00:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/2 V3] applesmc: Use PnP rather
Message-Id: <20101220140032.GA23257@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101217221618.GA13207@ericsson.com> <1292624661-32474-1-git-send-email-mjg@redhat.com> <20101218042320.GA14104@ericsson.com> <20101218093719.GA1493@polaris.bitmath.org> <20101218110954.7a2ca190@endymion.delvare> <20101218103139.GA1668@polaris.bitmath.org> <878vzngvyn.fsf@sonic.technologeek.org> <20101218115742.GA2063@polaris.bitmath.org> <1292852674.2118.10.camel@mike-laptop>
In-Reply-To: <1292852674.2118.10.camel@mike-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mikael =?iso-8859-1?Q?Str=F6m?= <mikael@sesamiq.com>
Cc: Henrik Rydberg <rydberg@euromail.se>, Julien BLACHE <jb@jblache.org>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Mon, Dec 20, 2010 at 09:44:34PM +0800, Mikael Str=F6m wrote:
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

Yes, it's very broken. Walk /sys/class/hwmon and look for an entry with=20
an appropriate name, don't hardcode device paths. But given the=20
breakage, it might be easier to just keep the platform device for now.=20
I'll redo the patch with that in mind.

--=20
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
