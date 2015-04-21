From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 21 Apr 2015 15:24:00 +0000
Subject: Re: [lm-sensors] [PATCH v2 0/2] i8k.c => dell-smm-hwmon.c
Message-Id: <20150421152400.GA14723@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427538255-10860-1-git-send-email-pali.rohar@gmail.com>
 <1427633859-18596-1-git-send-email-pali.rohar@gmail.com>
 <551A1554.3090005@roeck-us.net>
 <20150331135601.GA8806@kroah.com>
 <20150409140224.GI12339@atrey.karlin.mff.cuni.cz>
 <20150421133036.GQ6515@pali>
 <55365369.5080306@roeck-us.net>
 <20150421135206.GA10347@kroah.com>
In-Reply-To: <20150421135206.GA10347@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.de>, Steven Honeyman <stevenhoneyman@gmail.com>, Valdis.Kletnieks@vt.edu, Jochen Eisinger <jochen@penguin-breeder.org>, Gabriele Mazzotta <gabriele.mzt@gmail.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, Apr 21, 2015 at 03:52:06PM +0200, Greg Kroah-Hartman wrote:
> On Tue, Apr 21, 2015 at 06:40:57AM -0700, Guenter Roeck wrote:
> > On 04/21/2015 06:30 AM, Pali Roh=E1r wrote:
> > >On Thursday 09 April 2015 16:02:24 Pali Roh=E1r wrote:
> > >>On Tuesday 31 March 2015 15:56:01 Greg Kroah-Hartman wrote:
> > >>>On Mon, Mar 30, 2015 at 08:32:36PM -0700, Guenter Roeck wrote:
> > >>>>On 03/29/2015 05:57 AM, Pali Roh=E1r wrote:
> > >>>>>This patch series moves drivers/char/i8k.c to drivers/hwmon/dell-s=
mm-hwmon.c
> > >>>>>and allows to compile hwmon driver without /proc/i8k file.
> > >>>>>
> > >>>>>Pali Roh=E1r (2):
> > >>>>>   hwmon: Rename i8k driver to dell-smm-hwmon and move it to hwmon=
 tree
> > >>>>>   hwmon: Allow to compile dell-smm-hwmon driver without /proc/i8k
> > >>>>>
> > >>>>>  MAINTAINERS                    |    4 +-
> > >>>>>  arch/x86/Kconfig               |   25 +-
> > >>>>>  drivers/char/Makefile          |    1 -
> > >>>>>  drivers/char/i8k.c             | 1005 --------------------------=
-------------
> > >>>>>  drivers/hwmon/Kconfig          |   11 +
> > >>>>>  drivers/hwmon/Makefile         |    1 +
> > >>>>>  drivers/hwmon/dell-smm-hwmon.c | 1025 ++++++++++++++++++++++++++=
++++++++++++++
> > >>>>>  7 files changed, 1049 insertions(+), 1023 deletions(-)
> > >>>>>  delete mode 100644 drivers/char/i8k.c
> > >>>>>  create mode 100644 drivers/hwmon/dell-smm-hwmon.c
> > >>>>>
> > >>>>I am ok with the series and would take it for 4.1 if Greg agrees.
> > >>>>
> > >>>>Greg, any comments ?
> > >>>
> > >>>Let me review it, it's in my queue...
> > >>
> > >>Hi Greg! Have you looked at it?
> > >>
> > >
> > >Greg & Guenter: ping. Will you include it into 4.1?
> > >
> > I don't see it in Greg's pull request, so presumably no (unless I misse=
d it).
>=20
> No, I missed it for this rc cycle, sorry.  If you want to include it in
> yours, by all means please do so.
>=20
Too late; I sent my pull request early last week. Also, since I don't have
the patch in my queue, it would not follow my own process, and I really
dislike doing that.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
