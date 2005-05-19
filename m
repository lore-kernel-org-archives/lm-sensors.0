From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: Problem with eeprom module in 2.9.0
Message-Id: <20050106231216.6ef7495e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41DDAE4F.9030606@earthlink.net>
In-Reply-To: <41DDAE4F.9030606@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> As you can see, I've been doing a lot of testing of sensors lately...

I wouldn't complain, since you find real bugs and send real patches :)
You're our best tester.

> I have a number of servers that have been running the CVS version of
> i2c  and lm_sensors downloaded on October 25, 2004, plus the patch to
> add  DDR2 support.   This release of sensors has performed well.
> 
> I'm now trying to upgrade the version of sensors on these servers to 
> 2.9.1 for i2c and 2.9.0 plus the bmcsensors.c patch.   The servers are
> running Red Hat 9 (2.4.20-31.9.0bigmem with a few patches to add 
> additional hardware support).  This same version of kernel is used for
> both versions of lm_sensors and for both versions of server that I
> will  be discussing.

Note that this is really i2c 2.9.0, not 2.9.1.

> The lm87 and lm93 drivers are working OK, but the eeprom driver in
> 2.9.0  really does not like our newest servers. On the failing servers
> (Dual  XEON 3.2 Ghz, E7520 chipset, DDR2 memory), sensors stops
> providing  useful information as soon as the eeprom driver is loaded.
> 
> I loaded the appropriate drivers:
> i2c-core i2c-dev i2c-proc i2c-i801 eeprom
> 
> Running sensors gives bogus output:
> # sensors
> eeprom-i2c-0-53
> Adapter: SMBus I801 adapter at 0540
> Unknown EEPROM type (255).
> 
> eeprom-i2c-0-57
> Adapter: SMBus I801 adapter at 0540
> Unknown EEPROM type (255).
> 
> Running this command logs the following message to dmesg:
> PCI device 8086:25a4 (Intel Corp.): Reset failed! (21)
> eeprom.o: block read fail at 0x00!

255 is really -1, aka read error. At the moment you see this, your SMBus
is already locked.

> Removing modules using rmmod runs without error, but
> when the eeprom module is reloaded, it does not find any i2c devices.

Because the bus is locked.

OK, the big change here is most probably the support (or attempt
thereof) of I2C block read in i2c-i801. As far as I know you are the
first tester of this feature. The eeprom driver does make use of this
feature when possible, and it doesn't seem to work as intended for you.

What I find strange is that the lm93 driver does make use of the block
transfers too, and they seem to work for you (until the eeprom driver
trashes the whole bus). This suggests that the bug isn't in the i2c-i801
driver but it the eeprom driver, or maybe the eeprom and lm93 driver do
not use i2c block reads in the same way.

> I have 2.9.0 on a different server family (Dual XEON 2.4 Ghz, E7501 
> chipset, DDR memory) and the eeprom driver works fine.

What's the PCI ID of this one? Maybe block transfers work OK for the
E7501 but not for the E7520.

Can you please try the attached patch? It disables block reads in the
eeprom driver. If it solves the problem for you then we at least know
what is triggering the bug (although I still can't get why lm93 doesn't
trigger it).

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
-------------- next part --------------
Index: kernel/chips/eeprom.c
=================================RCS file: /home/cvs/lm_sensors2/kernel/chips/eeprom.c,v
retrieving revision 1.57
diff -u -r1.57 eeprom.c
--- kernel/chips/eeprom.c	29 Dec 2004 10:43:57 -0000	1.57
+++ kernel/chips/eeprom.c	6 Jan 2005 22:16:55 -0000
@@ -303,8 +303,7 @@
 		printk(KERN_DEBUG "eeprom.o: Starting update, slice %u\n", slice);
 #endif
 
-		if (i2c_check_functionality(client->adapter,
-		                            I2C_FUNC_SMBUS_READ_I2C_BLOCK))
+		if (0)
 		{
 			for (i = slice << 5; i < (slice + 1) << 5;
 			                            i += I2C_SMBUS_I2C_BLOCK_MAX)
