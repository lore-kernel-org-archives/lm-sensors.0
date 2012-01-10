From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 10 Jan 2012 16:47:29 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm63) Fix checkpatch errors and
Message-Id: <1326214049.2649.77.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1326074356-2033-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1326074356-2033-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2012-01-10 at 11:04 -0500, Jean Delvare wrote:
> Hi Guenter,
> 
> On Sun,  8 Jan 2012 17:59:16 -0800, Guenter Roeck wrote:
> > From: Guenter Roeck <guenter.roeck@ericsson.com>
> > 
> > Fix the following checkpatch errors and warnings:
> > 
> > WARNING: simple_strtoul is obsolete, use kstrtoul instead
> > ERROR: trailing whitespace
> > WARNING: line over 80 characters
> > ERROR: do not use assignment in if condition
> > 
> > Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> > ---
> >  drivers/hwmon/lm63.c |   74 +++++++++++++++++++++++++++++++++++--------------
> >  1 files changed, 53 insertions(+), 21 deletions(-)
> > (...)
> 
> I already reviewed and accepted this patch from you:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2011-November/034261.html
> 
> It's pending in my hwmon queue:
> http://khali.linux-fr.org/devel/linux-3/jdelvare-hwmon/hwmon-lm63-01-fix-checkpatch-errors.patch

Yes, I remembered after I sent it out.

When you send your patches to Linus, would be great if you could update
the MAINTAINERS entry to point to the new location of your patch queue.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
