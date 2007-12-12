From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Dec 2007 12:22:35 +0000
Subject: Re: [lm-sensors] Intel Core voltage monitoring
Message-Id: <20071212132235.169a2d42@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <475BDA45.70400@googlemail.com>
In-Reply-To: <475BDA45.70400@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Dec 2007 13:05:08 +0100, Peter Ganzhorn wrote:
> This sounds quite interesting to me - do you think it should be possible 
> to find out what's the matter about the removal of the driver and would 
> I have been able to access my smbus and the hwmon chip in my laptop with it?
> It would be great to have a driver for this stuff, but it should work 
> flawlessly of course...and if it was removed I suppose there was a 
> problem with it :(

Please ask Len Brown directly (and let me know his answer, I'm
curious.) I know that the i2c_ec driver was added at the same time as
the sbs driver, and the sbs driver was originally making use of the
i2c_ec driver, but then the sbs driver was rewritten to no longer
depend on i2c_ec. I don't know the details, but maybe this was enough
for Len to decide that the i2c_ec driver was no longer needed at all.
Either way, he should really have put a comment in that removal commit.

Whether or not the driver would have helped you depends on the presence
of the ACPI0001 device in your DSDT. If your DSDT doesn't define this
device than the driver in question wouldn't have worked for you anyway.

> But thanks for the info, please keep me up2date if you're going to 
> investigate a bit more!

Unlikely, I don't really have the time at the moment.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
