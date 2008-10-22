From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 22 Oct 2008 13:24:29 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] libsensors: Add support for current
Message-Id: <20081022152429.6b5be91e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081022135759.6ed045c0@hyperion.delvare>
In-Reply-To: <20081022135759.6ed045c0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean-Marc,

On Wed, 22 Oct 2008 09:22:46 -0400, Jean-Marc Spaggiari wrote:
> 2008/10/22 Hans de Goede <j.w.r.degoede@hhs.nl>:
> > Jean Delvare wrote:
> >> Add support for current sensors.
> >> ---
> >> The code for function print_chip_curr() is duplicated directly from
> >> print_chip_in() with IN subfeature names replaced by their CURR
> >> counterparts and V changed to A.
> >>
> >> Applies on top of the previous patch. I'd appreciate review and testing
> >> of this patch. Vincent, this should show you the current values you
> >> were missing so far.
> >>
> >>  doc/libsensors-API.txt |    9 ++++++
> >>  lib/sensors.h          |    9 ++++++
> >>  lib/sysfs.c            |   16 ++++++++++-
> >>  prog/sensors/chips.c   |   69 ++++++++++++++++++++++++++++++++++++++++++++++++
> >>  4 files changed, 102 insertions(+), 1 deletion(-)
> >>
> >
> > I've reviewed this and it looks good.
> 
> I compiled and installed successfuly path 1/2 and patch 2/2 on my
> system (2.6.27.2). Seems to be working fine. Don't see the difference
> with the previous version.

If you do not have any current sensor nor power sensor on your system,
this is the expected result. Thanks for testing!

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
