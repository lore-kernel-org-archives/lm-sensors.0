From: henk@god.dyndns.org (henk)
Date: Wed, 07 Mar 2007 16:46:19 +0000
Subject: [lm-sensors] Can I help out on supporting chip id 0x3c00?
Message-Id: <20070307164619.GA21547@god.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,

I am running on an Acer Travelmate 4650 and was wondering if I could add
some support for sensors package.

Can anyone point me in the right direction wich chip should be in there,
as I am a bit reluctant to open up the laptop.


Does
	Probing Super-I/O at 0x2e/0x2f:
	Found unknown chip with ID 0x3c00

sound familiar to you?

regards
henk


here is my somewhat condensed sensors detect output:

Next adapter: SMBus I801 adapter at 1400 (i2c-3)
	Probin fordapter: SMBus I801 adapter at 1400 (i2c-3)
	Client found at address 0x44
	Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
	Client found at address 0x52
	Handled by driver `eeprom' (already loaded), chip type `eeprom'

Next adapter: nvidia #2 (i2c-2)
	Client found at address 0x50
	Handled by driver `eeprom' (already loaded), chip type `eeprom'

Super-I/O at 0x2e/0x2f
	Trying family `ITE'...                                      Yes
	Found unknown chip with ID 0x3c00
	Trying family `National Semiconductor'...                   No
	Trying family `SMSC'...                                     Yes
	Found unknown chip with ID 0x3c00
	Trying family `VIA/Winbond/Fintek'...                       No
	Probing for Super-I/O at 0x4e/0x4f
	Trying family `ITE'...                                      No
	Trying family `National Semiconductor'...                   No
	Trying family `SMSC'...                                     No
	Trying family `VIA/Winbond/Fintek'...                       No


