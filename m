From: Ville.Steudle@nokia.com (Ville.Steudle@nokia.com)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: lm_sensors on HP Visualize X-Class?
Message-Id: <264C7DF5751032419C3ED55FF3F546BF04FBC1@saebe007.nmp.nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear lm_sensors team,

I am trying to get the lm_sensors package working on the following hardware:

Name: HP Visualize X-Class (or XL-class if shipped with Linux), HP code is A1280
Mainboard: proprietary, rumours say it's manufactured by Tyan for HP
Chipset: Serverworks III WS
CPU: 2 * Pentium Coppermine (slot 1)
Busses: AGP, PCI-32, PCI-64

Note that this is not one of the "Kayak" stations but a bit newer.

The system does have a case LCD panel showing some kind of status info (e.g. "CPU temperature" if the CPU is too hot).

sensors-detect can find the i2c-piix4, but no sensor chips.

maxilife can be loaded, but does not seem to find any sensors, the same with lm75. (Or, that's always possible, I am doing something wrong here.)


Do you have any idea whether this hardware is supported by lm_sensors?

Any hints what I could/should try?


HP's end user support was of no help for me (as usual, unfortunately).


Thanks for reading & thinking.  :-)

Regards,
Ville
