From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Ticket #: 1955
Message-Id: <20050419204758.35371365.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1980615917@web.de>
In-Reply-To: <1980615917@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

I am the author of the pc87360 hardware monitoring driver.

> I checked the versions like you told me:
> siggi:~# sensors -v
> sensors version 2.9.0 with libsensors version 2.9.0

The problem you have is expected, and is caused by a recent fix I made
to the pc87360 driver. The PC8736x chips can have their fan speed
controller disabled. I changed the pc87360 driver to *not* create sysfs
files for disabled fans, as they would always read 0 anyway.

The Soekris net4801 has no fans AFAIK, which explains why the fan
controllers are disabled.

By the time I changed the driver, I made a change to the "sensors"
program so that it doesn't complain on apprently missing fan files, but
that was after lm_sensors 2.9.0 was released.

So, either upgrade to 2.9.1, or add the following lines in your
sensors.conf file:

  ignore fan1
  ignore fan2
  ignore fan3

(If your Soekris board *does* have fans connected and you think the
PC87366 chip should be able to monitor them, we'll of course
investigate.)

-- 
Jean Delvare
