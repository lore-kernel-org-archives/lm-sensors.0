From: romain.goyet@polytechnique.org (Romain Goyet)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Linux 2.6.3 i2c it87 sensor support
Message-Id: <CBF4B814-67DF-11D8-89D2-000393034272@polytechnique.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi I have a motherboard wich uses an it87. My problem is that the 
latest linux kernel (2.6.3) includes a driver for this chip, but that 
driver is older than the one included in latest lm_sensors : in effect, 
it lacks support for it87_reset, which is implemented in latest 
lm_sensors and which is really usefull. It also lacks FanGuardian (aka 
SmartFan), which is also really usefull, and already implemented in 
lm_sensors 2.8.4.

I ABSOLUTELY needed to be able to boot without reseting the it87, so I 
manually patched the vanilla kernel (I simply removed the corresponding 
line), but the SmartGuardian feature still isn't there.

Anyway; thanks for such an awesome project

Romain Goyet
