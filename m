From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 19 Jan 2012 16:23:50 +0000
Subject: Re: [lm-sensors] [PATCH 34/39] hwmon: (w83781d) Fix checkpatch issues
Message-Id: <1326990230.2649.143.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326703781-14272-35-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326703781-14272-35-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On Thu, 2012-01-19 at 08:54 -0500, Jean Delvare wrote:
> On Mon, 16 Jan 2012 00:49:36 -0800, Guenter Roeck wrote:
> > Fixed:
> > ERROR: code indent should use tabs where possible
> > ERROR: do not use assignment in if condition
> > ERROR: "foo* bar" should be "foo *bar"
> > ERROR: space prohibited after that open parenthesis '('
> > ERROR: space required after that ',' (ctx:VxV)
> > ERROR: spaces required around that '=' (ctx:VxV)
> > WARNING: line over 80 characters
> > WARNING: simple_strtol is obsolete, use kstrtol instead
> > WARNING: simple_strtoul is obsolete, use kstrtoul instead
> > WARNING: space prohibited between function name and open parenthesis '('
> > 
> > Not fixed (false positive):
> > ERROR: Macros with multiple statements should be enclosed in a do - while loop
> > ERROR: Macros with complex values should be enclosed in parenthesis
> > 
> > Not all fixed (code complexity):
> > ERROR: do not use assignment in if condition
> > 
> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > ---
> >  drivers/hwmon/w83781d.c |  146 +++++++++++++++++++++++++++++-----------------
> >  1 files changed, 92 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/hwmon/w83781d.c b/drivers/hwmon/w83781d.c
> > index 65b685e..816cc16 100644
> > --- a/drivers/hwmon/w83781d.c
> > +++ b/drivers/hwmon/w83781d.c
> > @@ -1,9 +1,9 @@
> >  /*
> >      w83781d.c - Part of lm_sensors, Linux kernel modules for hardware
> > -                monitoring
> > +		monitoring
> >      Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
> > -                               Philip Edelbrock <phil@netroedge.com>,
> > -                               and Mark Studebaker <mdsxyz123@yahoo.com>
> > +			       Philip Edelbrock <phil@netroedge.com>,
> > +			       and Mark Studebaker <mdsxyz123@yahoo.com>
> >      Copyright (c) 2007 - 2008  Jean Delvare <khali@linux-fr.org>
> >  
> >      This program is free software; you can redistribute it and/or modify
> 
> The actual reason why checkpatch complains here is because it thinks
> this is code, not a comment. The proper fix would be to use proper
> comment style.
> 
Good point. I did wonder about that. I thought it would be a lot of work
to fix the comments. so I didn't even try. I'll see if I can come up
with a script to automate it. If so, I'll submit a separate series of
patches to address it for all drivers.

> All the rest looks reasonable, so:
> 
> Acked-by: Jean Delvare <khali@linux-fr.org>
> 
Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
