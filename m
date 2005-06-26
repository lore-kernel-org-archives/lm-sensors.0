From: jcromie@divsol.com (Jim Cromie)
Date: Sun, 26 Jun 2005 02:21:17 +0000
Subject: [lm-sensors] code question on pc87360 module
Message-Id: <42BDF4E6.1010303@divsol.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

folks,

Im working on a gpio driver for pc87366, and having trouble
writing to the pins - reading is fine - im seeing what I expect,
and can read results of touching pins to ground (theyre pulled hi when open)

So im trying to grok what Im missing by looking at pc87360,
particularly, I was looking for ioremap() calls that might explain the 
no-write
to 0x6600-2f (SIO writes work).

soekris:~# modprobe pc87360
pc87360: Device 0x09 not activated
pc87360 0-6620: VLM conversion set to1s period, 160us delay
soekris:~#
soekris:~# more /proc/ioports |grep pc87360
6620-662f : pc87360
6640-664f : pc87360

the last 2 lines arent there until modprobed, but I cant find where/how 
they're
inserted - I grepped all i2c code for an ioremap, theyre all in i2c/busses/,
none of which appear to match these modules, or the objects which 
comprise them.

i2c_sensor              4480  1 pc87360
i2c_isa                 2304  0
i2c_core               23696  3 pc87360,i2c_sensor,i2c_isa

anybody got a clue for the needy ?


