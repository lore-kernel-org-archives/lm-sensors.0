From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:32 +0000
Subject: R: i2c-sis5595.c, kernel 2.6.10
Message-Id: <20050122192536.08fb5248.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sebastian,

> I am currently debugging your i2c-sis5595 module because my brother 
> asked me why his sis540/5595 chipset is not recognized by this module.
> I figured out that your setup code _may_ contain bugs especially when 
> reading from pci config registers. I searched the web an found out
> that  pci_read_config_xxx() returns 0 on success and negative values
> on error. IMHO if you check the result like this:
> 
> if (!pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
>   goto error;
> 
> the if-clause fails on successful reads, too!
> I changed this to:
> myret = pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val);
> 
> and printed myret and val to stdout. As expected myret is 0 and val 
> contains 0xF8 which is the correct value for acpi and other stuff
> enabled.
> 
> Maybe you should consider to check for values lower than 0 !?
> 
> Please correct me if I am wrong, because I am not very firm at C and 
> device driver development ;)

As incredible as it may sound, I think you are right and the tests are
wrong in i2c-sis5595. Most probably this driver never worked in the 2.6
Linix kernel. It's really odd that nobody ever complained.

FYI, pci errors are not necessarily negative, some of them are positive.
The only success value is PCIBIOS_SUCCESSFUL, AKA 0.

I've prepared a patch that should hopefully fix the i2c-sis5595 driver.
Could you please give it a try and confirm that the driver works once
you apply it?

http://jdelvare.net1.nerim.net/sensors/linux-2.6.11-rc2-i2c-sis5595-pci-logic.diff

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
