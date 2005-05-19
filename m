From: erik@oldconomy.com (Erik Slagter)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: sensors support for tyan S2466 (Tiger MPX) motherboard 2.8.0
Message-Id: <1069949632.14539.9.camel@skylla.oldconomy.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I've found out how to use lm_sensors (2.8.0) to obtain all information
from the motherboard. There is a starting point from Tyan for 2.7.0 but
it needs a little tweaking for 2.8.0 or you won't get the fan rates.

This is how I did it:

- install the sensors.conf file from the tyan web site
- also follow the instructions there to add modules etc.
- now edit the relevant options line in the modules.conf and remove
anything from "force_w83627hf" to the end of the line. This causes the
w83627hf not being detected using the amd smd bus, which is good because
it doesn't work ;-)
- now add modules to the init script / config file so you have this
list: i2c-amd756, i2c-isa, w83781d, w83627hf (eeprom)

Now it should work.

I saw there is a support request ticket regarding this.
