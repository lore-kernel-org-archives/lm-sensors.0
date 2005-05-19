From: ARendahl@tricord.com (Rendahl, Aaron)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: adm1031 driver
Message-Id: <6DEE94132593D41182D200508BDCA590A2C19F@mail.tricord.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm working on a driver for the adm1031 chip, as on the web page it says
that this driver is not planned and there have been no requests.

However, I just found the "new_drivers" documentation, so am belatedly
writing to check if anyone else is working on it.

I don't anticipate the driver using the full capability of the chip (there
are options to control the fan speed that I don't think I'll need), but it
does read the temperature and fan measurements.

If that's useful enough to be included, please reserve an ID for this chip
in i2c-id.h.  Also, it's OK to put my name on the "New Drivers" page.

Thanks for all of your terrific work.

Aaron Rendahl
Tricord Systems
arendahl@tricord.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020306/80e4bf83/attachment.html
