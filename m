From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 May 2008 20:06:26 +0000
Subject: Re: [lm-sensors] Test on chip at SMBus address 0x2e
Message-Id: <20080507220626.101e4708@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1210189663.3333.16.camel@debian-9850.ag-home.muc>
In-Reply-To: <1210189663.3333.16.camel@debian-9850.ag-home.muc>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

On Wed, 07 May 2008 21:47:43 +0200, achim wrote:
> >Will try 0x32 as a value after i submitted this mail. :)
> 
> You know what happend, the system froze and did not boot (stuck at C1).
> It did boot after i removed one dimm. And on the board that dimm did no longer work.
> I'm running this board with an other two dimm kit now, using the same slots as with the first kit.
> I tried the defect dimm in the GBT780G board and it did not work. I tried the other dimm of 
> that kit and it worked. Then i tried both and they work. 
> 
> So I went adventurous again. ;)
> 
> I know where to measure vdimm on the board.
> 
> >i2cget 0 0x2e 0x35 => 1,942V 
> ﻿>i2cget 0 0x2e 0x36 => 1,916V
> ﻿>i2cget 0 0x2e 0x37 => 1,892V

OK, so basically the chip is a VID controller but for memory not Vcore.
Good finding :)

> 
> That is nice to know but seem to be no good for detection, every change changes the vdimm atleast at about 0.024V.

Most probably 0.025V, that's the step value for many VID standards.

Not sure what you mean about detection here.

> Also the sensor chip shows the difference, 
> 
> vddr = NB-HT ﻿voltage
> in5 = SB voltage
> in6 = vdimm
> cpu0_vid seems to be the max cpu_vid.

1.550V is the max that can be encoded with the K8 VID standard. This
corresponds to all 5 bits at 0. In other words, it means that the VID
inputs are not wired, so you can ignore this value. Check the logs when
you load the it87 driver, there may be a note about VID pins not being
configured for VID function.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
