From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Single fan sensor not detected
Message-Id: <20040512214143.3e8a02fc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40A042B0.6060907@greystate.com>
In-Reply-To: <40A042B0.6060907@greystate.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> All is working now. Thanks again. Do the it87 series of chips ever
> support pwm?

Yes, the chip supports and even has automatic fan speed control. The 2.4
driver has support for both. Takeru was working on adding support to the
2.6 driver but suddenly vanished. I hope he's OK...

Recently, Jonas Munsin started from Takeru's preliminary patch and
completed the work. You can see his patch here:
  http://people.debian.org/~jmunsin/it87.patch2

Hopefully this will be integrated into the main driver soon. Testing is
welcome!

> Driver `it87' (should be inserted but causes problems):
>   Detects correctly:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE 8705F Super IO Sensors' (confidence: 9)
>   Misdetects:
>   * ISA bus address 0x0290 (Busdriver `i2c-isa')
>     Chip `ITE IT8705F / IT8712F / SiS 950' (confidence: 8)

BTW I have fixed this horrible bug in CVS. Sensors-detect should now be
more clever and see that this is the same driver for the same chip and
display only one. Care to test?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/
