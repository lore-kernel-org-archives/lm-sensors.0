From: Andrew Morton <akpm@linux-foundation.org>
Date: Thu, 18 Sep 2008 08:25:39 +0000
Subject: Re: [lm-sensors] +
Message-Id: <20080918012539.560374e8.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <48D20D60.4030001@linutronix.de>
In-Reply-To: <48D20D60.4030001@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 18 Sep 2008 10:15:43 +0200 Sebastian Siewior <bigeasy@linutronix.de> wrote:

> akpm@linux-foundation.org wrote:
> > The patch titled
> >      hwmon: add support for MAX1618 in MAX1619 driver
> > has been added to the -mm tree.  Its filename is
> >      hwmon-add-support-for-max1618-in-max1619-driver.patch
> > 
> Andrew, what about Jean Delvare's issues which came up during the review? 

What issues?

<investigates>

You sent:

From: Sebastian Siewior <bigeasy@linutronix.de>
To: lm-sensors@lm-sensors.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Tobias Himmer <tobias@himmer-online.de>
Subject: [PATCH] i2c: add support for MAX1618 in MAX1619 driver
Date: Tue, 16 Sep 2008 15:35:42 +0200


and Jean sent:

From: Jean Delvare <khali@linux-fr.org>
To: lm-sensors@lm-sensors.org
Cc: Sebastian Siewior <bigeasy@linutronix.de>, Tobias Himmer <tobias@himmer-online.de>
Subject: Re: [lm-sensors] [PATCH] i2c: add support for MAX1618 in MAX1619 driver
Date: Tue, 16 Sep 2008 19:29:20 +0200


I got removed from the Cc so I of course didn't see the comments :(


> Or will this remain in -mm until his issues got fixed up?
> 

Thos ecomments looks significant enough for me to drop the patch and
await v2.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
