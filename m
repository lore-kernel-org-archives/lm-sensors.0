From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 19 Dec 2005 19:15:28 +0000
Subject: [lm-sensors] report: ATI IXP use via i2c-piix4
Message-Id: <43A706D0.7080200@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <43A700F5.4020606@hassard.net>
In-Reply-To: <43A700F5.4020606@hassard.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Stephen Hassard wrote:
> I've got an MSI RS482M4-ILD motherboard that I've managed to get going 
> with lm-sensors.

Good.
> [ALARM]
> Dec 19 10:38:38 localhost sensord:   beep_enable: Sound alarm enabled
> Dec 19 10:38:38 localhost sensord: Chip: eeprom-i2c-0-51
> Dec 19 10:38:38 localhost sensord: Adapter: SMBus PIIX4 adapter at 0b00
> Dec 19 10:38:38 localhost sensord: Algorithm: Unavailable from sysfs
> Dec 19 10:38:38 localhost sensord:   Memory type: DDR SDRAM DIMM SPD
> Dec 19 10:38:38 localhost sensord:   Memory size (MB): Invalid 13 10 2 4

Hmm I dont like this.

Will the sensors command produce correct result?

Can you please provide dumps in this order:

i2cdump 0 0x51
i2cdump 0 0x51 c
i2cdump 0 0x51

Thank you

Regards
Rudolf

