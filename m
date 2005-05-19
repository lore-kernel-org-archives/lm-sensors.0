From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: More flash eeprom fun on a Thinkpad
Message-Id: <20020721144141.C11600@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I found this interesting.  A guy took apart his Thinkpad 600X (one of
the lm-sensors vulnerable ones) and pulled out the Atmel Flash EEPROM 
to reflash it:

http://www.ja.olm.net/unlock/key_for_600x.htm

You can get the datasheet for the AT24RF08C RFID flash eeprom here:

http://www.ja.olm.net/unlock/key_for_600e.htm

Strange serial eeprom device.  It lives in 0x54-0x57.  It's not clear 
to me how the chip responds to 'quick' SMBus accesses we use during 
probing, or how it would like being driven by our eeprom module.

Anyways, note that people who have had their Thinkpad 240's killed by 
Lm_sensors get the error: 0188: Invalid RFID Serialization Area

Could we simply blacklist the 0x54-0x57 area unless the user 
explicitly 'forces' regular usage of that area?


Phil


-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
