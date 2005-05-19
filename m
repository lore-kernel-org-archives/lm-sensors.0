From: drewie@freemail.hu (Andras BALI)
Date: Thu, 19 May 2005 06:25:03 +0000
Subject: lm77 on national sc1100
Message-Id: <1088690691.2862.25.camel@null>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

referencing to #1710 and #1714, I figured out that the LM77
sensor is not compatible with the LM75, though it's similar.

Attached is a driver for the LM77 that works for me. It gives
read access to the temperature register (temp1_input) and
read+write access to t_hyst, t_crit, t_high, t_low. The config
register is not made available, nor are the status bits, but
it should be really easy to add these if required. The code is
a shameless copy of the lm75 module -- all credits go to Frodo
Looijaard.

The detection is a bit problematic: the lm77 module should not
install itself for anything else but an lm77, but the lm75
driver will recognize an lm77 as an lm75. It could be patched to
check if the chip in question is an lm77 (and skip it if yes),
but I'm not sure if it's appropriate. Ideas are welcome.

I have this LM77 sensor on the secondary I2C bus of a National
SC1100 system. The bus is driven by the scx200_acb (stock kernel
2.6.7) module, which I had to patch in order to get it work: on
line 461, the following should be added:
	
	adapter->class = I2C_CLASS_HWMON;

-- otherwise the sensors will not try to detect devices on this
bus (thanks Khali). I also had to change the ACCESS.bus base
addresses from 0x820, 0x840 to 0x810, 0x820 (line 46), but YMMV.

I would be really glad to see this module included in the
lm_sensors package.

Please CC me all replies to this message, I'm not subscribed to
this mailing list.

Best regards,
Andras

-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm77.c
Type: text/x-csrc
Size: 9583 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040701/957be51a/lm77.bin
