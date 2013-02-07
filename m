From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 07 Feb 2013 09:05:51 +0000
Subject: Re: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <20130207100551.2eef6c63@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 Feb 2013 00:27:09 +0100 (CET), Dag Wieers wrote:
> > Could be, but for now all I see is that 0x3d = 0x3f - 0x02, i.e. only
> > one bit changed. You will need to take more samples before you can draw
> > a conclusion. Also compare when CU is idle and when it's busy.
> 
> So I have been reading out different values over time, but when 
> repeatedly asked it provides the same value:
> 
> ----
> root ~ # i2cget 0 0x48
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will read from device file /dev/i2c-0, chip address 0x48, current data
> address, using read byte.
> Continue? [Y/n]
> 0x3d
> 
> root ~ # gputemp
> 46 C
> ----
> 
> ----
> root ~ # i2cget 0 0x48
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will read from device file /dev/i2c-0, chip address 0x48, current data
> address, using read byte.
> Continue? [Y/n]
> 0x43
> 
> root ~ # gputemp
> 52 C
> ----
> 
> ----
> root ~ # i2cget 0 0x48
> WARNING! This program can confuse your I2C bus, cause data loss and worse!
> I will read from device file /dev/i2c-0, chip address 0x48, current data
> address, using read byte.
> Continue? [Y/n]
> 0x4b
> 
> root ~ # gputemp
> 58 C
> ----
> 
> It pretty much looks like a thermal sensor, much in sync with the GPU 
> temperature. How would I continue ?

I would suggest the following:
# i2cdump -r 0x3d-0x4b 0 0x48 b

This should be pretty safe, as even if the chip doesn't use 8-bit
register addressing, at least we know that values in the 0x3d-0x4b
range are fine for your system.

If this is a DS75 or DS1621 chip you should see some register values.
If this is an LM73 you won't.

Then try again:
# i2cget 0 0x48
If you don't get a value in the range you expect, play it safe and
power down the machine immediately, then cold boot it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
