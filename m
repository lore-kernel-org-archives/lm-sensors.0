From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Jun 2005 20:19:11 +0000
Subject: [lm-sensors] Re: sclhi retval not tested in i2c-algo-bit.c
Message-Id: <20050604201931.4e533021.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karel,

> Hello Simon,

I wouldn't expect an answer from Simon. He left the i2c & lm_sensors
projects long ago. The lm_sensors mailing-list is the best place for
this kind of questions.

> drivers/i2c/algos/i2c-algo-bit.c sometimes tests return value of sclhi
> function and sometimes not. Shouldn't this always be tested?

I would guess so.

> I have a problem that I have an parport adapter which is optically
> isolated, and the isolated half is powered separately. The adapter
> supports SDA and SCL bidirectionally.
> 
> When the other half is not powered, the SDA/SCL readback doesn't of
> course work, neither the devices connected react. But I discovered
> that although the .timeout in the driver is HZ (=1sec), the delay
> introduced on kernel startup is 90 seconds.
> 
> That means that the timeout is left to timeout 90 times before the
> driver returns. I should that first timeout should cause the parport
> to be considered not mentally present and all operations on it
> immediately fail.

Is this with or without i2c_algo_bit.bit_test=1?

Without it, loading the i2c-parport driver should not introduce any kind
of delay. Trying access it would, but then the repeated timeouts you
observe could be caused by the process accessing it, whatever it is,
rather than i2c-algo-bit. I never experienced such long delays myself.
Can you please describe the devices found on the parallel port adapter,
and what is done to them at boot time?

> Looking into the driver, I am not wondering it is working this way :)
> I would like just to know your opinion if there isn't some deeper
> logic hidden behind what seems to me like omission.

I don't think so. Most probably it is that way just because it worked
for everyone so far. Patches to make it behave better are welcome.

Thanks,
-- 
Jean Delvare
