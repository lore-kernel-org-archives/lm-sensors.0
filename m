From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 19 Jul 2007 15:32:10 +0000
Subject: [lm-sensors] Proposal: remove watchdog support from fscher and
Message-Id: <469F83FA.1020409@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

As you all know I've been working lately on moving the fscher driver to 
individual alarm files and on merging the fscpos driver into the fscher driver.

While typing a reply to Jean's review of the fscpos support for the fscher 
driver, I came to the conclusion that it might be best to remove the watchdog 
supporting sysfs attr from these 2 drivers, These sysfs attr are nothing more 
then a raw export of the watchdog registers. If people want raw access they can 
and should use i2c-dev. Thus I think it would best to just remove the watchdog 
sysfs attr, reducing the driver size and complexity. Notice that there are no 
userspace programs which are currently using these sysfs attr.

Maybe in the future a proper watchdog driver can be written for the watchdog 
functions on these chips, under the same subsystem as the other watchdog 
drivers, since its an i2c chip, sharing it with other drivers should not be a 
problem (I think).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
