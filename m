From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Aug 2007 08:02:05 +0000
Subject: Re: [lm-sensors] [PATCH 4/6] libsensors4: Use strtoul
Message-Id: <20070816100205.7aaf7724@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070815174240.34ddf040@hyperion>
In-Reply-To: <20070815174240.34ddf040@hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 15 Aug 2007 18:59:25 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Use strtoul() instead of parsing integers on our own.
> 
> Erm, why all the < 0 checks on the return value of strtoul, are the variable in 
> which the return value gets stored signed and can we have a wrap?

Yes, this is the reason why I added these "< 0" checks.

> In that case wouldn't it be better to first store in an unsigned long and then 
> explicitly check the limits we want to enforce?

There's no specific limit I want to enforce, I only want to make sure
that we don't end up with a negative value due to a possible wrap. This
is pure paranoia, BTW, no sane user would ever trigger it. I agree that
letting the overflow happen and checking for it afterwards isn't very
elegant, but it works and it is efficient, so I am a bit reluctant to
make the code more complex than it needs be.

I could probably use strtol instead of strtoul if you prefer, though.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
