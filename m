From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 03 Jun 2005 23:20:14 +0000
Subject: [lm-sensors] Linux kernel - i2c - eeprom module
Message-Id: <20050603232043.29ea8b1c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kosma, Ruik,

> > Lately I've been playing a lot with the kernel i2c modules. I want
> > to use the eeprom module to read/write eeproms. However, it only
> > has read support, and it supports only one size (256 bytes).

This is simply not true. The driver supports EEPROM sizes from 1kbit to
16kbit (ie 128 bytes to 2048 bytes). 256 byte ones (24C02) are the more
frequently found ones, and the "best supported" in that the driver will
create a single "eeprom" file of 256 bytes as one would expect. However,
128 byte EEPROMs will work just fine (simply ignore the upper 128 bytes
of the "eeprom" file), and larger EEPROMs up to 24C16 will simply appear
as 2, 4 or 8 different 256 byte EEPROMs. That's not exactly nice, but it
works.

If you have proposals to support the different sizes in a better way,
patches are welcome.

> Well this is quite dangerous. Athough SPD eeproms do have sometimes
> writeprotect lock this is not always true imho.

It is worth mentioning here that SPD are not the only EEPROMs found in
computers these days. Network adapters can have their MAC address stored
in an EEPROM. Some laptops have an EEPROM with serial number and product
information - writing to them can prevent boot, see the Thinkpad saga.
Displays have EDID EEPROMs. This means that relying on the write
protection the EEPROMs may have as per some standard is not the way to
go anyway.

If we want to add write support to the eeprom driver, we must make it so
that no accidental write to the EEPROM can ever happen. In other words,
just changing the eeprom file from read-only to read/write isn't going
to be accepted.

> My question is why you need kernel support for this and why you cannot
> use the userspace utils in lm_sensors packages for that?

I second this excellent question. The userspace tools seems to do just
fine for everyone needing to write to EEPROMs so far.

> Also when implemented I am for [ ] compile time feature that will
> clearly state that it is EXTREMLY DANGEROUS

I don't think a compile time feature is the way to go. Tagging something
as "extremely dangerous" means that no distribution will ever enable it
- so most people won't have the opportunity to use the feature, making
it not worth adding in the first place. But definitely an acceptable
solution should prevent any risk of accidental write. That being said, I
still need to be convinced that implementing write support in the eeprom
driver itself is needed.

Thanks,
-- 
Jean Delvare
