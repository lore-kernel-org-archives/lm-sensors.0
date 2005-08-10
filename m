From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 10 Aug 2005 23:06:42 +0000
Subject: [lm-sensors] Re: I2C block reads with i2c-viapro: testers wanted
Message-Id: <20050810230633.0cb8737b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809231328.0726537b.khali@linux-fr.org>
	<42FA6406.4030901@cetrtapot.si>
In-Reply-To: <42FA6406.4030901@cetrtapot.si>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hinko Kocevar <hinko.kocevar@cetrtapot.si>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Hinko,

> > In order to verify whether I2C block reads work for you, just
> > compare the contents of this file:
> >   /sys/bus/i2c/devices/0-0050/eeprom
> 
> I've tested your patch on gericom X5 with VIA chipset and it works
> fine without/with your patch (no diff in eeprom contents).
> (...)
> 0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8233 PCI to ISA Bridge

This is a surprising result, as the VT8233 datasheet didn't mention the
I2C block mode. I'll add this model to the list. This also suggests that
the VT8233A may support it as well - if someone could test that.

I have to admit I don't know exactly in which order the different south
bridges were designed and released by VIA. I think the following order
is correct:

VT82C596
VT82C596B
VT82C686A
VT82C686B
VT8235
VT8237

But I don't know where the VT8231, VT8233 and VT8233A should be inserted
in this list. If anyone can tell me...

Could you try running "i2cdump 0 0x50" and "i2cdump 0 0x50 i" (with the
patch still applied), and compare both the outputs and the time each
command takes? You should see similar outputs, but the second command
should be magnitudes faster. This would confirm that the I2C block mode
works as intended on your VT8233 chip.

(0 and 0x50 may be different values on your system, please adapt
depending on where in the sysfs tree the eeprom file appeared.)

Thanks for the tests.
-- 
Jean Delvare
