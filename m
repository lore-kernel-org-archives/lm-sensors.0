From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 15 Jul 2005 19:58:19 +0000
Subject: [lm-sensors] Adding ICH6 support to the i2c-i801 module, kernel
Message-Id: <20050715195746.6b9f15cc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1fbc035c05071509545b7501b5@mail.gmail.com>
In-Reply-To: <1fbc035c05071509545b7501b5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Craig,

> I have a system with an ICH6M chipset (915GM) which has to run kernel
> 2.6.5.  There are a couple devices on the SMBus which I would like to
> get to, an LM63 and a TC655 (fan controller).

Not to disappoint you, but LM63 supports was added much later, in
2.6.10. And I don't think there is a driver for the TC655.

> The i2c-i801 module supports this in 2.6.7, so I back-ported the
> changes (basically the PCI Id) and sensors-detect now finds the bus. 
> Here is the output of i2cdetect:
> 
>   Installed I2C busses:
>     i2c-1       unknown         SMBus I801 adapter at 0400            
>  Algorithm unavailable
>     i2c-0       dummy           ISA main adapter                      
>  ISA bus algorithm
> 
> I have 2 questions/issues -
> 
> First, is the 'unknown' and 'Algorithm unavailable' normal, or did I
> miss something in my backport?

It's normal, the 2.6 kernel exports less information than the 2.4 kernel
did, so user-space utilities can't report the missing information. I
plan to modify the user-space utilities to stop displaying the
information (or lack thereof), so as to not confuse the user.

> Second, if I try to access any of the devices on the SMBus, I will
> quickly get a collision/buslock.  I did not change the i2c_delay()
> code to match the msleep() in the backport, could this be affecting
> it?  The bus does scan, and I see devices where I'd expect them, so
> it's -really- close to working...

Most probably unrelated.

Asus board?

If some device on the bus misbehaves, there's not much you can do,
unfortunately, unless you can get control over this device. This would
require a full knowledge of the bus topology, which manufacturers
usually don't disclose easily.

-- 
Jean Delvare
