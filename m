From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 02 Aug 2006 16:50:23 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc2-mm1] hwmon: unchecked return
Message-Id: <20060802185023.c1b54b0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802130811.GF3141@jupiter.solarsys.private>
In-Reply-To: <20060802130811.GF3141@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> Here is asb100.c... I'll add lm75, lm78, smsc47b397, and w83627hf
> to this patch as I have time.  (Jean: don't apply yet.)

Very nice, I like it. The asb100 driver is probably an easy one,
supporting only one chip with no conditionals in sysfs file creations,
but it's still nice to see we can handle this case really easily.

> +ERROR4:
> +	sysfs_remove_group(&new_client->dev.kobj, &asb100_group);

The fact that we can (ab)use sysfs_remove_group to remove all files
without having to care which ones were actually created, will help us
much. Even where we can't use the group mecanism to create the files,
we can use it to remove them, so the error handling should not be too
awful.

I have a similar patch for drivers/i2c/chips/*.c, I'll post it on the
i2c list shortly.

-- 
Jean Delvare

