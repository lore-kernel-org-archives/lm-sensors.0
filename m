From: kyosti.malkki@welho.com (=?ISO-8859-1?Q?Ky=F6sti_M=E4lkki?=)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Need advice, writing new driver.
Message-Id: <Pine.LNX.4.53.0312112051110.4538@cosmos.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200312091903.hB9J3RP26691@sfendt.octagonsystems.com>
In-Reply-To: <200312091903.hB9J3RP26691@sfendt.octagonsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 9 Dec 2003, Sean S Fendt wrote:
>
> The group doing octagon's extended BIOS functions (extended int 17 calls) can
> access the device on the SM Bus, so the hardware is capable of the necessary
> commands. (They have discovered, however, they must do a block write, not a
> byte or word write for it to function correctly).
>
> The i801 driver which supports the SM Bus on our board, does not support
> i2c-level commands.  How much trouble will I have if I decide to extend this
> driver to allow at least some i2c-level commands?

Quickly browsing through i2c-i801.c, it seems to support the command
parameter I2C_SMBUS_I2C_BLOCK_DATA. If I only remember correctly, this
is a block transfer without the block length as the first byte after
chip address.

> Is there some other way I can support the 2-byte address EEPROMs without
> extending the driver to allow i2c-level commands?

A 2-byte address EEPROM user prog was recently contributed, the mailing
list has some discussion about this.

  http://archives.andrew.net.au/lm-sensors/msg05210.html

-- 
  Ky?sti M?lkki  <kyosti.malkki@welho.com>
