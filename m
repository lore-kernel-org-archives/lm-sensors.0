From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Sat, 08 Aug 2009 17:40:20 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: Enhance the sysfs API for power
Message-Id: <20090808174020.GA29600@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090725004322.20709.96804.stgit@elm3a70.beaverton.ibm.com> <20090725004328.20709.57712.stgit@elm3a70.beaverton.ibm.com> <20090807180906.GD1728@ucw.cz>
In-Reply-To: <20090807180906.GD1728@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-acpi <linux-acpi@vger.kernel.org>, Zhang Rui <rui.zhang@intel.com>

On Fri, Aug 07, 2009 at 08:09:06PM +0200, Pavel Machek wrote:
> 
> > @@ -365,6 +373,16 @@ power[1-*]_average_lowest	Historical average minimum power use
> >  				Unit: microWatt
> >  				RO
> >  
> > +power[1-*]_average_max		A notification is sent when power use
> > +				rises above this value.
> > +				Unit: microWatt
> > +				RW
> > +
> 
> How is the notification sent?

ACPI Notify is sent to the kernel, which passes it to the ACPI netlink socket.

> > +power[1-*]_average_min		A notification is sent when power use
> > +				sinks below this value.
> > +				Unit: microWatt
> > +				RW
> 
> And what is this good for? Will it wake from sleep? Will it wake from
> C3?

All it really does is generates an ACPI Notify event, which is a hint to the OS
that it could re-read the power meter use.
> 
> ...seems like good way to prevent deep sleep states.
> 
> > +power[1-*]_cap			If power use rises above this limit, the
> > +				system should take action to reduce
> > power use.
> 
> System as in 'hw'? Or who? And how?

The ACPI spec is silent on this matter.  It's not clear if the OS is supposed
to monitor and take action on its own when power > cap, or if the hardware/BIOS
will take action, or possibly both...?

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
