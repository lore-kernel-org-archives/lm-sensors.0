From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 Jul 2010 15:03:28 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (pc87360) Fix device resource
Message-Id: <20100707170328.63848c30@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100707145841.58052281@hyperion.delvare>
In-Reply-To: <20100707145841.58052281@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Wed, 7 Jul 2010 08:52:01 -0600, Jim Cromie wrote:
> On Wed, Jul 7, 2010 at 6:58 AM, Jean Delvare <khali@linux-fr.org> wrote:
> > It's not OK to call platform_device_add_resources() multiple times
> > in a row. Despite its name, this functions sets the resources, it
> > doesn't add them. So we have to prepare an array with all the
> > resources, and then call platform_device_add_resources() once.
> >
> > Before this fix, only the last I/O resource would be actually
> > registered. The other I/O resources were leaked.
> >
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Jim Cromie <jim.cromie@gmail.com>
> > Cc: stable@kernel.org
> > ---
> > Jim, do you still have your system with a PC8736x device? If you do,
> > can you please test this fix and report? Thanks.
> 
> Its not handy, but I see about arranging access.
> 
> Did you catch this by inspection?
> was there another thread that triggered your recollection/association ?
> Any simple check for this ?

I copied this code to the pc87427 driver yesterday, as I am in the
process of adding support for temperature monitoring to that driver
(currently it only supports fans). The pc87427 driver code is slightly
cleaner than the pc87360 driver code, in that it doesn't use a global
array to carry the multiple I/O addresses of the logical devices.
Instead, it retrieves them using platform_get_resource(). I found it
worked OK for the first resource, and returned NULL for the second.
Which made me realize that my two calls to
platform_device_add_resources() had resulted in a single resource being
registered. Further code inspection (of platform_device_add_resources)
revealed that both had been allocated, but the first one got lost when
the second was added.

I've fixed the pc87427 driver already, and now it's the pc87360
driver's turn.

> I dont suppose a /proc/<file> is gonna shout RESOURCE LEAK ..

Indeed not. I know it leaked memory by code inspection, I didn't
witness it. Unless you cycle the pc87360 driver, the leak of a few
dozen bytes is unnoticeable.

> that said, I'll look before&after for something more subtle.

You should definitely see a difference in /proc/ioports before and
after my fix.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
