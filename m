From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 22 Jan 2007 08:36:45 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <20070122093645.c72e6c58.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 17 Jan 2007 13:59:46 +0100, Hans-J?rgen Koch wrote:
> This patch adds support for the MAX6650 fan controller. I'm not the author of 
> this module, just tested it on an i386 embedded system and cleaned up a bit.
> The patch is against 2.6.20-rc3.
> 
> Signed-off-by: Hans J. Koch <hjk at linutronix.de>

Anybody up for a driver review? It's a simple I2C device, the review
shouldn't be too hard. Things to pay attention too:
* Respect of the standard sysfs interface specifications
* Driver must be safe to use on any system
* Coding style

Thanks,
-- 
Jean Delvare

