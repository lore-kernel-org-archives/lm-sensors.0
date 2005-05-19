From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: flex scanner jammed
Message-Id: <20030806175430.30978fca.zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806172523.6ac44fe9.zdavatz@ywesee.com>
In-Reply-To: <20030806172523.6ac44fe9.zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Aug 2003 17:45:33 +0200
Jean Delvare <khali@linux-fr.org> wrote:

> This could mean you have some other driver already handling these chips.
> I would expect the dmasound_pmac module to be one of them. Maybe you
> could unload it, then re-run sensors detect. Try lsmod, and if any
> module pretends to use i2c-core, it should be unloaded before running
> sensors-detect.
lsmod gives me:

Module                  Size  Used by    Not tainted
i2c-dev                 4820   0
i2c-keywest             7164   0  (autoclean)
dmasound_pmac          65168   0  (autoclean)
dmasound_core          12784   0  (autoclean) [dmasound_pmac]
soundcore               4040   3  (autoclean) [dmasound_core]
ds                      8284   1
yenta_socket           11600   1
irtty                   6772   2  (autoclean)
irda                  102124   0  (autoclean) [irtty]
hfs                    80620   0  (unused)
hfsplus                46480   0  (unused)
ohci1394               28056   0  (unused)
ieee1394              193760   0  [ohci1394]
ppp_synctty             6672   0  (unused)
mpoa                   22212   0  (unused)
pcmcia_core            44216   0  [ds yenta_socket]
eeprom                  4172   0  (unused)
lm75                    3912   0  (unused)
i2c-proc                8992   0  [eeprom lm75]
i2c-core               17704   0  [i2c-dev i2c-keywest dmasound_pmac eeprom lm75 i2c-proc]
visor                  10860   0  (unused)
usbserial              19592   0  [visor]

rmmod i2c-core gives me:
i2c-core: Device or resource busy


> 
> > When I type sensors now I get:
> > flex scanner jammed
> 
> I think this is caused by the "old" (but too recent now) sensors.conf
> file in /etc. Copy etc/sensors.conf.eg from lm_sensors-2.7.0 to
> /etc/sensors.conf, and the message should go.
Ok, done that. Now I get:
lm75-i2c-0-48
Adapter: uni-n 0
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

lm75-i2c-0-49
Adapter: uni-n 0
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

eeprom-i2c-0-50
Adapter: uni-n 0
Algorithm: Keywest i2c

lm75-i2c-1-48
Adapter: uni-n 1
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

lm75-i2c-1-49
Adapter: uni-n 1
Algorithm: Keywest i2c
temp:       -1.0?C  (limit =  -1.0?C, hysteresis =  -1.0?C)

eeprom-i2c-1-50
Adapter: uni-n 1
Algorithm: Keywest i2c

eeprom-i2c-2-56
Adapter: mac-io 0
Algorithm: Keywest i2c
Machine name:
Serial number:

Thanks for Feedback.

Zeno
