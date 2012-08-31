From: Krystian Garbaciak <krystian.garbaciak@diasemi.com>
Date: Fri, 31 Aug 2012 10:00:00 +0000
Subject: Re: [lm-sensors] [RFC PATCH 2/8] regulator: Add Dialog DA906x voltage regulators support.
Message-Id: <201208311100@sw-eng-lt-dc-vm2>
List-Id: <lm-sensors.vger.kernel.org>
References: <201208241450@sw-eng-lt-dc-vm2>
 <201208241455@sw-eng-lt-dc-vm2>
 <20120825151020.GB6520@opensource.wolfsonmicro.com>
 <201208291550@sw-eng-lt-dc-vm2>
 <20120830174738.GH4356@opensource.wolfsonmicro.com>
In-Reply-To: <20120830174738.GH4356@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, lm-sensors@lm-sensors.org, linux-input@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-leds@vger.kernel.org, Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Alessandro Zummo <a.zummo@towertech.it>, Jean Delvare <khali@linux-fr.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Andrew Jones <drjones@redhat.com>, Donggeun Kim <dg77.kim@samsung.com>, Philippe =?iso-8859-1?Q?R=E9tornaz?= <philippe.retornaz@epfl.ch>, Wim Van Sebroeck <wim@iguana.be>, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Anthony Olech <anthony.olech@diasemi.com>

> On Wed, Aug 29, 2012 at 03:50:00PM +0100, Krystian Garbaciak wrote:
> 
> > Because, for some regulators, this is required: val += fvol->offset,
> > I was only able to reduce it to the following form.
> 
> What on earth makes you say this?  The above is obviously linear.
> 
> Besides, you're missing several points here.  One is that you should be
> using the framework features, another is that you should be implementing
> _sel.

Sorry, I've missed an obvious thing here. Instead of adding selector offset at
runtime, I can substract apropriate voltage from .min_uV. Thanks for pointing
this out.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
