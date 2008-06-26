From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jun 2008 07:05:48 +0000
Subject: [lm-sensors] fscpos and fscher drivers
Message-Id: <20080626090548.3024bab0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

Do you have a plan to phase out the fscpos and fscher drivers? Now that
your fschmd driver supports all known FSC hardware monitoring chips, it
would be great if we could get rid of the legacy fscpos and fscher
drivers to make the configuration, maintenance and support easier.

A first step could be to mark both drivers DEPRECATED in Kconfig, and
add an entry for their removal in
Documentation/feature-removal-schedule.txt. You could also add a
warning message when these drivers are loaded, pointing the user to the
replacement fschmd driver. I don't think these chips are very popular
so it will take some time before your new driver gets enough testing
and we can safely remove the legacy drivers. But the earlier we ask
the users to migrate, the earlier we will be able to remove the legacy
drivers.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
