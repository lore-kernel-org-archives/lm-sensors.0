From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 12 Jun 2014 21:14:46 +0000
Subject: Re: [lm-sensors] [lm85] Sensors yields triplicate output
Message-Id: <20140612231446.399315ad@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGTLibq22gJ-GzaVagS7JDL=fNnHs6nhxTeD_OVKoMrHYPwhmw@mail.gmail.com>
In-Reply-To: <CAGTLibq22gJ-GzaVagS7JDL=fNnHs6nhxTeD_OVKoMrHYPwhmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mike,

So...

On Thu, 12 Jun 2014 10:36:09 -0600, Mike Dixon wrote:
> sensors-detect output with lm85 unloaded:
> 
> # sensors-detect revision 6248 (2014-05-12 09:14:50 +0200)
> # System: Sunware 0073351-01 05/16/2007 [SE7230NH1LX]
> # Board: Intel Corporation SE7230NH1LX
> (...)
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...               Yes
> Found `Nat. Semi. PC8374L Super IO Sensors'
>     (but not activated)

This chip is known to emulate a fake, non-functional LM96000 chip
(don't ask why, we have no idea.) That fake chip is found, and
discarded, later during the I2C/SMBus probing.

> (...)
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7
> 
> Next adapter: Radeon i2c bit bus DVI_DDC (i2c-0)
> Do you want to scan it? (yes/NO/selectively): y

Surprisingly nothing detected on this bus, even though the lm85 driver
managed to find something. This at least is in line with the failing
i2cdump.

This I2C bus is a DDC channel between the graphics card and the
display. It is possible that the connection is lost when the display is
off, or if the machine is behind a KVM, when the KVM channel is off.

> Next adapter: Radeon i2c bit bus VGA_DDC (i2c-1)
> Do you want to scan it? (yes/NO/selectively): y
> 
> Next adapter: Radeon i2c bit bus MONID (i2c-2)
> Do you want to scan it? (yes/NO/selectively): y
> 
> Next adapter: Radeon i2c bit bus CRT2_DDC (i2c-3)
> Do you want to scan it? (yes/NO/selectively): y
> 
> Next adapter: SMBus I801 adapter at 3000 (i2c-4)
> Do you want to scan it? (YES/no/selectively): y
> Client found at address 0x2c
> (...)
> Probing for `SMSC EMC6D100 or EMC6D101'...                  No
> Probing for `SMSC EMC6D102'...                              No
> Probing for `SMSC EMC6D103'...                              Success!
>     (confidence 7, driver `lm85')

This is a 1st LM85-compatible chip, an SMSC EMC6D103. It is fully
supported by the lm85 driver only since kernel 2.6.37.2. Thanks to the
generic detection code in the lm85 driver, it still works with your
kernel, but with limited capabilities (inaccurate frequency map for the
fan speed control and limited voltage and temperature resolution.)

> (...)
> Client found at address 0x2d
> (...)
> Probing for `Winbond WPCD377I'...                           Yes
>     (confidence 7, not a hardware monitoring chip)

The fake chip I mentioned before, correctly ignored by sensors-detect
and the lm85 driver.


> Client found at address 0x2e
> (...)
> Probing for `SMSC EMC6D100 or EMC6D101'...                  No
> Probing for `SMSC EMC6D102'...                              No
> Probing for `SMSC EMC6D103'...                              Success!
>     (confidence 7, driver `lm85')

And a second EMC6D103 chip. That's not surprising: an EMC6D103 can
handle 4 fans while your board documentation mentions up to 8 fans.

> (...)
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
> 
> Driver `lm85':
>   * Bus `SMBus I801 adapter at 3000'
>     Busdriver `i2c_i801', I2C address 0x2c
>     Chip `SMSC EMC6D103' (confidence: 7)
>   * Bus `SMBus I801 adapter at 3000'
>     Busdriver `i2c_i801', I2C address 0x2e
>     Chip `SMSC EMC6D103' (confidence: 7)

Looks good. The driver I provided should work just fine.

BTW, you may also try this one:
http://elrepo.org/tiki/kmod-lm85
It might be easier for you.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
