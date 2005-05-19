From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: lm_sensors2/kernel/chips lm75.c
Message-Id: <4218B8CC.7030703@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050220112406.78febb39.khali@linux-fr.org>
In-Reply-To: <20050220112406.78febb39.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

good points
thanks for reviewing

Jean Delvare wrote:
>>Modified Files:
>>	lm75.c 
>>Log Message:
>>(mds) only initialize CMP/INT bit, and only if necessary
> 
> 
> I am not happy with that change.
> 
> For one thing, if the chip was in shutdown mode, you leave it there.
> This means that the temperature will never be updated, making the driver
> useless.
> 

I missed the shutdown bit.

> For another, changing the CMP/INT bit is NOT a good idea. It's fine to
> change the mode when it only affects alarm bits. However in this case
> what it affects is the OS output, and you don't know what is wired to
> that output. If the chip was programmed to INT mode, which is not the
> default, there must be a reason, and that reason must be that whatever
> is wired to the OS output expects interrupts and not comparator mode. By
> arbitrarily changing the mode (and with no reason at that) you probably
> screw the hardware overtemperature control mechanism.
> 

I forgot the LM75 doesn't have an alarm bit, so there's no use changing the
CMP/INT bit.

This is similar to what we do in other drivers,
but for those chips, the CMP/INT mode setting affects
the output pin AND the alarm bits, with no harm done
as far as I know.
But in this case, it's  pointless, since there's no alarm bit.

mds
