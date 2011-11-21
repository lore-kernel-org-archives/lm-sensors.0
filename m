From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 21 Nov 2011 16:10:11 +0000
Subject: Re: [lm-sensors] [PATCH v2 2/2] hwmon: (lm63) Add support for
Message-Id: <20111121171011.0d1040fa@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1321830618-15817-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Mon, 21 Nov 2011 05:48:25 -0800, Guenter Roeck wrote:
> On Mon, Nov 21, 2011 at 08:07:07AM -0500, Jean Delvare wrote:
> > On Mon, 21 Nov 2011 10:43:39 +0100, Jean Delvare wrote:
> > > What about bit 3 (USF) in this enhanced configuration register? When
> > > set, it would affect the way we encode and decode _max and _crit
> > > temperature limits, right?
> >=20
> > BTW, if you agree but don't have time to work on this, I would be
> > perfectly fine with a check at probe time that would complain (and
> > eventually bail out) if the way the chip is configured is not properly
> > supported by the driver. If anyone needs the feature, it can be added
> > later.
> >=20
> Gives me something to do if I need some distraction ;). It will need
> some thinking, so I may choose the complain option for now and submit
> a patch later. Bailing out seems a bit harsh - as are temperatures
> above 127 C anyway.

Temperatures above 127=B0C are frequent in high-end graphics cards. I
would never want any of these in my own machines, but gamers do.

I am more surprised by the implementation. I'd have expected a single
configuration but to change the range of all temperature-related
registers, not just the high and critical limits. Other chips do this.

> Do you remember why you did not add support for the remote temperature
> offset registers ?

Probably because nobody ever asked for it. Also, originally we did not
have a standard sysfs file name for this feature, so it was often left
out of driver submissions. For some drivers it was added later when
a standard name was defined, for others it was not. Feel free to add it
if you want. I don't expect any difficulty.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
