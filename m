From: pavel@suse.cz (Pavel Machek)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm sensors sysfs file structure
Message-Id: <20030328183410.GD5147@zaurus.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048582394.4774.7.camel@workshop.saharact.lan> <20030325175603.GG15823@kroah.com> <1048705473.7569.10.camel@nosferatu.lan> <3E82024A.4000809@portrix.net> <20030326202622.GJ24689@kroah.com> <3E82292E.536D9196@paradyne.com> <20030326225234.GA27436@kroah.com>
In-Reply-To: <20030326225234.GA27436@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>
Cc: Mark Studebaker <mds@paradyne.com>, Jan Dittmer <j.dittmer@portrix.net>, azarah@gentoo.org, KML <linux-kernel@vger.kernel.org>, Dominik Brodowski <linux@brodo.de>, sensors@Stimpy.netroedge.com

Hi!

> temp_min[1-3]	Temperature min or hysteresis value.
> 		Fixed point value in form XXXXX and should be divided by
> 		100 to get degrees Celsius.  This is preferably a

I believe floating point is nicer... It is
improbable to have miliKelvins around,
still I don'n see why fixedpoint...
				Pavel
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...
