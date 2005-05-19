From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: i801 driver broken?
Message-Id: <3EDF4C53.9EAA995C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030605104127.2b87307a.khali@linux-fr.org>
In-Reply-To: <20030605104127.2b87307a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

most of the PCI drivers in kernel/busses are broken because they
don't have the pci_device_id tables populated.
I'm fixing them one at a time by backporting from kernel 2.5.
I should get to i2c-i801 this weekend - I'm trying to
actualy test each driver before I check it in but
I have to shuffle motherboards, monitors, etc. around to do that.

Jean Delvare wrote:
> 
> Hi there,
> 
> I just checked i2c (lk2-4) and lm_sensors2 out, and it turns out to be
> broken, at least for my chipset (i801). The i2c-i801 modules fails to
> load:
> 
> arrakis:/home/khali/devel/lm_sensors/cvs/lm_sensors2> insmod i2c-i801
> Using /lib/modules/2.4.21-rc4/kernel/drivers/i2c/busses/i2c-i801.o
> /lib/modules/2.4.21-rc4/kernel/drivers/i2c/busses/i2c-i801.o:
> init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters,
> including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> 
> Actually, the only thing dmesg reveals is that i2c-core and i2c-proc are
> version 2.7.0 while i2c-i801 (and eeprom, if that matters) are version
> 2.8.0-CVS.
> 
> i2c-core.o: i2c core module version 2.7.0 (20021208)
> i2c-i801.o version 2.8.0-CVS (2003????)
> i2c-core.o: i2c core module version 2.7.0 (20021208)
> i2c-proc.o version 2.7.0 (20021208)
> eeprom.o version 2.8.0-CVS (2003????)
> 
> Kernel is 2.4.20-rc4, gcc is 2.95.3. I2c and lm_sensors 2.7.0 were
> working OK so far.
> 
> Is it supposed to be know and related to the various PCI issues we are
> having these days?
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
