From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 16:33:41 +0000
Subject: Re: [lm-sensors] Proposal: remove watchdog support from fscher and
Message-Id: <20070722183341.13aca245@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <469F83FA.1020409@hhs.nl>
In-Reply-To: <469F83FA.1020409@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 19 Jul 2007 17:32:10 +0200, Hans de Goede wrote:
> As you all know I've been working lately on moving the fscher driver to 
> individual alarm files and on merging the fscpos driver into the fscher driver.
> 
> While typing a reply to Jean's review of the fscpos support for the fscher 
> driver, I came to the conclusion that it might be best to remove the watchdog 
> supporting sysfs attr from these 2 drivers, These sysfs attr are nothing more 
> then a raw export of the watchdog registers. If people want raw access they can 
> and should use i2c-dev. Thus I think it would best to just remove the watchdog 
> sysfs attr, reducing the driver size and complexity.

(Repeating what I wrote in another thread, as this new thread is a
better place:)

I agree that the current watchdog implementation is poor, but you can't
rip it away right now without offering a replacement. Either deprecate
it and plan it for removal at a later point in time, or replace it with
a proper implementation (or both.)

Having i2c-dev and a kernel driver access the same chip isn't a good
idea, and might no longer work in the future.

>                                                      Notice that there are no 
> userspace programs which are currently using these sysfs attr.

How can you be sure? Just because nothing in the lm-sensors package
uses them, doesn't mean that some users don't have dedicated script
using them directly.

> Maybe in the future a proper watchdog driver can be written for the watchdog 
> functions on these chips, under the same subsystem as the other watchdog 
> drivers, since its an i2c chip, sharing it with other drivers should not be a 
> problem (I think).

As the i2c subsystem is being improved to better follow the driver
model, "sharing it with other drivers" doesn't sound good. But nothing
prevents you from having a single driver handling both the hardware
monitoring function and the watchdog function. The problem with the
current driver isn't that it handles both, but only the non-standard
watchdog interface.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
