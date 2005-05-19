From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: Via KT600 as I2C controller
Message-Id: <20031129174316.02c6b5eb.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031126235249.GA7632@gumby>
In-Reply-To: <20031126235249.GA7632@gumby>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have an A7V600 motherboard, which has a Via 8237 on it.
> It is not supported by current 2.6 kernels (test8, for example).
> I have added support by adding the following lines to vt596_ids[] in
> /usr/src/linux-2.6.0-test8/drivers/i2c/busses/i2c-viapro.c.
> 
>     {
>         .vendor     = PCI_VENDOR_ID_VIA,
>         .device     = PCI_DEVICE_ID_VIA_8237,
>         .subvendor  = PCI_ANY_ID,
>         .subdevice  = PCI_ANY_ID,
>         .driver_data    = SMBBA3
>     },
> 
> I have not observed any brokenness, having used it for several weeks.
> I could, of course, continue making the change to future kernel
> versions, but this would surely benefit others if in the regular dist.

I've added support in our CVS repository. I will also send a patch to
Greg KH for Linux 2.6. Don't expect it to be added before 2.6.0 final
though, since only bug fixes will be accepted for now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
