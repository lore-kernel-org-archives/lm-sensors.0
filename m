From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 03 Jul 2010 15:11:56 +0000
Subject: Re: [lm-sensors] [PATCH/RFC v2] hwmon: Add support for W83667HG-B
Message-Id: <20100703151156.GA18122@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1278062606-29000-1-git-send-email-guenter.roeck@ericsson.com>
 <20100703103536.2fdd833e@hyperion.delvare>
In-Reply-To: <20100703103536.2fdd833e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Jim Cromie <jim.cromie@gmail.com>, H Hartley Sweeten <hsweeten@visionengravers.com>, Andrew Morton <akpm@linux-foundation.org>, Ethan Lawrence <e.law87@yahoo.com>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lars4910@hotmail.com" <lars4910@hotmail.com>, "birdie@permonline.ru" <birdie@permonline.ru>, "jadcock@cox.net" <jadcock@cox.net>, "binximeng@gmail.com" <binximeng@gmail.com>

On Sat, Jul 03, 2010 at 04:35:36AM -0400, Jean Delvare wrote:
[...]
> 
> Other than this, I have no objection, your patch looks sane.
> 
> After your next iteration, I'll publish a standalone driver with your
> patch, for easier testing.
> 
I submitted v3 a minute ago. I had to make a couple of additional changes,
so you'll have to at least browse through it again. This is still a single 
patch. There are some generic changes, though, so I plan to split it into 
a generic patch and a -B specific patch next time around. Would be great
to get some test feedback first, though.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
