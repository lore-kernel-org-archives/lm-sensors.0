From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 23 May 2013 14:18:09 +0000
Subject: Re: [lm-sensors] [PATCH] fancontrol: Fix handling of absolute paths in config
Message-Id: <20130523161809.13055527@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87obebb9wd.fsf@sonatest.com>
In-Reply-To: <87obebb9wd.fsf@sonatest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 May 2013 09:42:02 -0400, Marc Ferland wrote:
> Jean Delvare <khali@linux-fr.org> writes:
> > This simply makes DEVPATH and DEVNAME mandatory when using relative
> > paths and DEVNAME optional when using absolute paths. Does it work for
> > you?
> 
> Yes. Just tested on my system and everything seems to run smoothly.

Thanks for testing. Patch committed and added to the list of
recommended patches.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
