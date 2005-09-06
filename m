From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Sep 2005 21:09:56 +0000
Subject: [lm-sensors] [GIT PATCH] I2C patches for 2.6.13
Message-Id: <20050906210953.19b4b956.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050905214431.GA5897@kroah.com>
In-Reply-To: <20050905214431.GA5897@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Greg,

> Here are a bunch of I2C and HWMON patches that have been in the -mm
> tree for a while.  There is a bunch of hwmon and i2c driver split up
> changes, and some i2c api reworks to reduce the size of the
> structures, and the size of the kernel code (which accounts for all of
> the small changes to all of the sensor and i2c drivers across the
> whole kenel tree.)  There are also a few new drivers added to the
> tree.
> (...)
> The full patch series will sent to the sensors mailing list, if anyone
> wants to see them.

I checked against my own list, and it looks all OK to me. Thanks :)

There are two old patches I have and you don't, but it turns out that I
probably never sent them in the first place (I can't find a trace in the
mailing list archive.) I will send them now. These are really minor
changes anyway, nothing to worry about.

Thanks again,
-- 
Jean Delvare
