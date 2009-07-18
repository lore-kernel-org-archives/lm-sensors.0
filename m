From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sat, 18 Jul 2009 10:47:48 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add WM835x PMIC hardware monitoring
Message-Id: <20090718104747.GA11121@opensource.wolfsonmicro.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1247862795-22547-1-git-send-email-broonie@opensource.wolfsonmicro.com> <20090718111712.78771b36@hyperion.delvare> <20090718095917.GA10160@opensource.wolfsonmicro.com> <20090718123951.34c776ca@hyperion.delvare>
In-Reply-To: <20090718123951.34c776ca@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, Jonathan Cameron <jic23@cam.ac.uk>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Sat, Jul 18, 2009 at 12:39:51PM +0200, Jean Delvare wrote:
> On Sat, 18 Jul 2009 10:59:17 +0100, Mark Brown wrote:

> > The reason it's formatted like that is that the AUXADC input names match
> > the names of the supplies that are being monitored so the second parameter
> > is also used to provide a label to userspace.

> This isn't how I read the code. I see a look-up table for labels, so the
> macro implementation is just a detail which shouldn't matter.

Oh, yes, you're right.  Originally I'd implemented it the way I describe
but changed the code later - I'd forgotten that I'd done so when
replying to your mail.

I'll send a revised version out on Monday.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
