From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 09 Dec 2007 16:57:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Let the user override the detected
Message-Id: <20071209165739.GA2653@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071109161111.451bd208@hyperion.delvare>
In-Reply-To: <20071109161111.451bd208@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-12-06 23:13:42 +0100]:
> Oops, sorry. That line comes from the acpi vs. hwmon conflict checking
> patch that I have at the bottom of my local stack. I've now moved it at
> the top so that the patches I send to you will apply properly on top of
> your own stack. Here's an updated patch:
> 
> * * * * *
> 
> While it is possible to force SMBus-based hardware monitoring chip
> drivers to drive a not officially supported device, we do not have this
> possibility for Super-I/O-based drivers. That's unfortunate because
> sometimes newer chips are fully compatible and just forcing the driver
> to load would work. Instead of that we have to tell the users to
> recompile the kernel driver, which isn't an easy task for everyone.
> 
> So, I propose that we add a module parameter to all Super-I/O based
> hardware monitoring drivers, letting advanced users force the driver
> to load on their machine. The user has to provide the device ID of a
> supposedly compatible device. This requires looking at the source code or
> a datasheet, so I am confident that users can't randomly force a driver
> without knowing what they are doing. Thus this should be relatively safe.
> 
> As you can see from the code, the implementation is pretty simple and
> unintrusive.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
> ---
>  drivers/hwmon/dme1737.c    |    6 +++++-
>  drivers/hwmon/f71805f.c    |    6 +++++-
>  drivers/hwmon/f71882fg.c   |    6 +++++-
>  drivers/hwmon/it87.c       |    6 +++++-
>  drivers/hwmon/pc87360.c    |    6 +++++-
>  drivers/hwmon/pc87427.c    |    6 +++++-
>  drivers/hwmon/smsc47b397.c |    6 +++++-
>  drivers/hwmon/smsc47m1.c   |    6 +++++-
>  drivers/hwmon/vt1211.c     |    8 +++++++-
>  drivers/hwmon/w83627ehf.c  |   11 +++++++++--
>  drivers/hwmon/w83627hf.c   |    6 +++++-
>  11 files changed, 61 insertions(+), 12 deletions(-)

This is a really nice idea.  Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
