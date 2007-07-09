From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Jul 2007 16:53:51 +0000
Subject: Re: [lm-sensors] [PATCH] THMC50 support for 2.6 (3rd revision)
Message-Id: <20070709185351.6c1acbb3@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706215426.52e00d73.krzysztof.h1@wp.pl>
In-Reply-To: <20070706215426.52e00d73.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sun, 8 Jul 2007 21:37:06 +0200, Krzysztof Helt wrote:
> On Sun, 8 Jul 2007 17:53:37 +0200, Jean Delvare wrote:
> > On Fri, 6 Jul 2007 21:54:26 +0200, Krzysztof Helt wrote:
> > > The adm1022 has 3 temperature even in 2 temperature mode. It can be changed later if
> > > the 3 temperatures should be available only in 3 temperature mode. I don't know how
> > > lmsensors library handles the same sensor with two different number of temperatures.
> > 
> > It's pretty trivial to fix, simply use data->has_temp3 instead of
> > data->type to decide whether to create (and delete) the extra files or
> > not.
> 
> I know and I actually did this then removed. It can always be done
> later and I want to check if the lmsensors 2.x library is able to handle
> the same chip id "adm1022" with two different set of values to read.

Yes, it can handle this situation. Lots of other drivers do that and it
works just fine.

> It is simpler to ignore the unused value (through the config file) then
> to add it.

No. From the user's point of view, it's simpler if the driver only
exports the features the chip has, so no further configuration file
tweaking is needed.

> I will leave it as it is and it can be patched later.

I admit I have a hard time understanding why you insist on postponing a
fix which is needed and trivial.

> (...)
> It simply shows how the thmc50 2.4 driver is full of holes.

You're right. It seems that this driver was essentially left untouched
since it was written by Phil Edelbrock back in September 1999. It
probably has never been reviewed, and probably wasn't used much either.
The fact that "sensors" doesn't even support it says much.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
