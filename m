From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: #1353 still error!!
Message-Id: <20030801103525.3f260ba3.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> OK, start from the beginning...
> I've checked on http://mbm.livewiredev.com/ that there's an ASB100
> chip inside my Asus TUSL2-C motherboard, then I've looked on 
> http://www2.lm-sensors.nu/~lm78/newdrivers.html for ASB100 and it
> says: Chip: ASB100 Bach, recognized as a as99127f, driver: w83781d,
> patched by mkpatch: yes. So this means the program knows my
> sensor-chip. I've started lm_sensors but it can't find any chip in my
> computer and I don't know why. So I attach it's whole output here
> because I can't solve this problem, I've tried almost everything (to
> the best of my knowledge)... I hope you aren't fed up with me. Please
> help me!

You *already* told us this, and you *already* sent the very same log.
What do you expect except the very same answer?

So I have to repeat myself. Sensors-detect can't detect your ASB100
until it is able to load the driver for the I2C bus your ASB100 is on.
You can see in the log you sent:

Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: 
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters, 
including invalid IO or IRQ parameters
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: insmod 
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o failed
/lib/modules/2.4.18-4GB/kernel/drivers/i2c/busses/i2c-i801.o: insmod 
i2c-i801 failed
Loading failed... skipping.

The problem is *here* and as long as we can't solve it, we won't go any
further.

So I ask my question again: ANY MESSAGE IN THE LOGS?

Take a look at /var/log/messages, /var/log/syslog or wherever your
system logs this kind of information. You should see something like:

i2c-core.o: i2c core module version 2.8.0 (20030714)
i2c-i801 version 2.8.0 (20030714)

And hopefully some useful error messages.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
