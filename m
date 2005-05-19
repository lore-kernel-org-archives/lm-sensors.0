From: jnareb@fuw.edu.pl (Jakub Narebski)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: Ticket #780, i2c-core sends output to console at reboot
Message-Id: <Pine.LNX.4.33.0201221623404.29636-100000@flow.fuw.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have the following problem with the sensors service I send you. The
lm_sensors modules sends information about registered and unregistered
drivers to somewhere. At startup (kernel/system loggers start _after_
sensors service) and during normal work the output is not send to
console. It can be seen via dmesg.

At reboot however i2c-core sends information about unregistered drivers to
the (only) console (sensors chip and bus drivers are removed using
modprobe -r -q). Kernel/system loggers are stopped at the time of stopping
sensors service.

It is a bug or did I make something wrong?

P.S. it should be rather prog/initscripts/sensors

-- 
Jakub Nar?bski
    Poland


