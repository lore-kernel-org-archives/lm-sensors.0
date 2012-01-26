From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jan 2012 19:03:02 +0000
Subject: Re: [lm-sensors] [PATCH 3/4] drivers/hwmon/lm80.c: added error handling
Message-Id: <20120126200302.75fe733c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
In-Reply-To: <1325502203-10525-3-git-send-email-fransmeulenbroeks@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Jan 2012 15:52:41 +0100, Frans Meulenbroeks wrote:
> 2012/1/5 Jean Delvare <khali@linux-fr.org>
> > Are you really still using  LM80 chips? These are pretty old and I did
> > not expect anyone to be still using them. And certainly not for new
> > designs... The device (at least the incarnations that existed in
> > 1998-2000) was not reputed for its reliability...
>
> Yes, we still have them and I need to support them (just like LM75).
> (acutally we're using LM96080). They are not on my board, but we have
> external fan units that contain these chips, and my board needs to support
> these fan units.

Frans, could you please provide a register dump of your LM96080 chip?
I'd like to add that to my collection. You can get such a dump using
the i2c-dev driver + i2cdump (from package i2c-tools.)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
