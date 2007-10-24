From: Riku Voipio <riku.voipio@iki.fi>
Date: Wed, 24 Oct 2007 11:50:34 +0000
Subject: Re: [lm-sensors] hwmon/f75375s.c: buggy if()
Message-Id: <20071024115034.GA5797@kos.to>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071017195439.GD3778@stusta.de> <20071017204508.GA32110@kos.to> <20071018133744.GC3526@jupiter.solarsys.private> <20071019143754.0aa4483b@hyperion.delvare>
In-Reply-To: <20071019143754.0aa4483b@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Adrian Bunk <bunk@kernel.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, Oct 19, 2007 at 02:37:54PM +0200, Jean Delvare wrote:
> Riku, can you please submit a patch fixing this? The attribute should
> be declared read-only, and then you can use sysfs_chmod_file() to
> change it to read-write where supported. 

Thanks, this was good suggestion. Patch attached.

> Take a look at the w83781d
> driver for an example.

Btw, I think your example code has a indentation bug:

		if (kind != w83781d)
			err = sysfs_chmod_file(&dev->kobj,
				&sensor_dev_attr_temp3_alarm.dev_attr.attr,
				S_IRUGO | S_IWUSR);
			if (err)
				return err;

-- 
"rm -rf" only sounds scary if you don't have backups

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
