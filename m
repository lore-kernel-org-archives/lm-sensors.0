From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 24 Oct 2010 15:35:48 +0000
Subject: Re: [lm-sensors] [PATCH 00/12] lis3 accelerator feature update
Message-Id: <20101024153548.GA14303@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
 <4CC44B3D.5030404@tremplin-utc.net>
In-Reply-To: <4CC44B3D.5030404@tremplin-utc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: =?iso-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>
Cc: Samu Onkalo <samu.p.onkalo@nokia.com>, "khali@linux-fr.org" <khali@linux-fr.org>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Sun, Oct 24, 2010 at 11:05:33AM -0400, =C9ric Piel wrote:
> Op 22-10-10 13:57, Samu Onkalo schreef:
> > Changes are tested only with I2C interface using 8bit sensor since I do=
n't
> > have other possibilities. Some features are not enabled
> > by default since I can't test them with all possible configurations.
> > Platform data contains field which controls new features.
> Thanks Samu for persevering with the automatic power down feature.=20
> Hopefully I'll find also some time to activate it on the hp_accel side.
>=20
> For now, I've reviewed the changes and everything looked fine, as well=20
> as tested them on my HP laptop (with a 12 bits sensor). Although most of =

> the changes are not visible on this platform, at least there shouldn't=20
> be any regression.
>=20
Great, thanks.

Unfortunately, the patches don't apply to my staging branch, probably
because of the other pending lis3 changes.

Samu, please rebase your patches to=20
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-next
and resubmit.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
