From: dorphell@gmx.net (dorphell)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: lm_sensors issue/problem
Message-Id: <20020311181949.2689585c.dorphell@gmx.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I've been having a certain problem installing lm_sensors/i2c. Here is some information about my hardware and setup to begin with:
Mainboard: Abit-KG7
Kernel: 2.4.18-xfs (plain vanilla kernel, patched by myself)
Distro: Slackware 8.0

In kernel config, here is  I2C support  ---> 
<M> I2C support
< > I2C bit-banging interfaces
< > I2C PCF 8584 interfaces 
<M> I2C device interface
<M> I2C /proc interface (required for hardware sensors)


After following the installation instructions, the devices /dev/i2c-*** were created and  the sensor-detect script instructed me to add the following to my module loading script (in Slackware it is /etc/rc.d/rc.modules)
--------------------------------\
# I2C adapter drivers
modprobe i2c-isa

# I2C chip drivers  
modprobe lm80
modprobe eeprom
modprobe via686a
--------------------------------/

--> NOTE: This was detected using the CURRENT-CVS i2c/lm_sensor. (Today's Date: 03/09/02)
and the following to /etc/modules.conf:
--------------------------------\
# I2C module options
alias char-major-89 i2c-dev
--------------------------------/

I firstly tried to install the 2.6.2 release ver which did not detect my  via686a as I expected (the lm_sensor homepage said to upgrade to current CVS)
Of course, before running the sensor-detect i did `depmod -a` [and ldconfig] which reported "i2c-philips-par.o" to be Unresolved symbol (I don't think this is a major issue, i simply removed the module since i didn't find it being probed anyways) So far, so good, no prob.

Now comes your love:
I tried to start sensor and here is the error:
--------------------------------\
Can't access /proc file
/proc/sys/dev/sensors/chips or /proc/bus/i2c unreadable;
Make sure you have done 'modprobe i2c-proc'!
--------------------------------/

I then tried to modprobe or manually insmod i2c-proc and got the following:
--------------------------------\
/lib/modules/2.4.18-xfs/kernel/drivers/i2c/i2c-proc.o: init_module: Cannot allocate memory
/lib/modules/2.4.18-xfs/kernel/drivers/i2c/i2c-proc.o: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18-xfs/kernel/drivers/i2c/i2c-proc.o: insmod /lib/modules/2.4.18-xfs/kernel/drivers/i2c/i2c-proc.o failed
/lib/modules/2.4.18-xfs/misc/i2c-proc.o: init_module: Operation not permitted
/lib/modules/2.4.18-xfs/misc/i2c-proc.o: Hint: insmod errors can be caused by incorrect module parameters, including invalid IO or IRQ parameters
/lib/modules/2.4.18-xfs/misc/i2c-proc.o: insmod /lib/modules/2.4.18-xfs/misc/i2c-proc.o failed
/lib/modules/2.4.18-xfs/misc/i2c-proc.o: insmod i2c-proc failed
--------------------------------/

This seems like an i2c-kernel problem to me, it's able to laod the i2c-core but not the i2c-proc (result is that the via686a won't probe), here's an lsmod of the modues that probed:
--------------------------------\
Module                  Size  Used by
i2c-isa                 1216   0  (unused)
i2c-core               12448   0  [i2c-isa]
--------------------------------/

I'm sure I've forgotten some info that you may find important about my system so feel free to reply or better yet, I am on IRC/ICQ/AIM around the clock, if that is easier for you, just tell me where, when, and who. =]

Please forward to the correct person if this does not pertain to you, 
Thank you very much.
