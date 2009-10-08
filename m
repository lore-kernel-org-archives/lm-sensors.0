From: Ian Pilcher <arequipeno@gmail.com>
Date: Thu, 08 Oct 2009 13:46:57 +0000
Subject: [lm-sensors] 8-bit ADC, LSB = 8mV - 2.048V or 2.04V?
Message-Id: <hakqgi$q6$1@ger.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks to the nonsensical responses I'm getting from MSI, I'm digging in
to the W83627EHF datasheet to try to figure out what's connected to what
on my board.

According to the datasheet, this chip uses an 8-bit analog-to-digital
converter for voltage measurements, where the least significant bit
represents 8 mV.  They state that this results in a maximum measurement
of 2.048 V (2048 mV), but I can't figure out their math:

    bit 0 (LSB)       8 mV
    bit 1            16 mV
    bit 2            32 mV
    bit 3            64 mV
    bit 4           128 mV
    bit 5           256 mV
    bit 6           512 mV
    bit 7          1024 mV
                  ---------
                   2040 mv     (2.04 V)
                  ====
Am I missing something?

Thanks!

-- 
====================================
Ian Pilcher                                         arequipeno@gmail.com
====================================


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
