From: rhirst@levanta.com (Richard Hirst)
Date: Wed, 07 Sep 2005 23:36:58 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision!
Message-Id: <20050907213603.GW8392@levanta.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This is on an Intel motherboard running an FC3 2.6.10-1.766.FC3smp
kernel with these additional patches:

linux-ipmi-2.6.10-base.diff
linux-i2c-2.6.10-nonblock.diff
linux-i2c-2.6.10-i801_nonblock.diff
linux-ipmi-2.6.10-smb.diff
patch-linux-2.6.11.5-bmcsensors.diff

The board has an mBMC which is basically working in that I can read
the sensors either by 'ipmitool' or 'sensors'.

However, round about every 10 reboots or so, I get the Bus collision
message and the system locks up solid during boot after outputting a
few messages such as

i801_smbus 0000:00:1f.3: Bus collision!
i801_smbus 0000:00:1f.3: Reset failed! (01)
i801_smbus 0000:00:1f.3: Reset failed! (01)
i801_smbus 0000:00:1f.3: Reset failed! (01)
bmcsensors.o: Error 0xff on cmd 0xa/0x23; state = 2; probably fatal.
i801_smbus 0000:00:1f.3: Reset failed! (01)
i801_smbus 0000:00:1f.3: Reset failed! (01)
i801_smbus 0000:00:1f.3: Reset failed! (01)


I'm assuming this indicates that two things have tried to use the
i2c bus at the same time, and I guess one of them is the bmcsensors
code.

I also tried adding code to check 'd->in_use' at the beginning of
i801_start() because it looked to me like in_use should perhaps
normally be zero at that point.  Don't know if that is valid, but
I did get a few indications of i801_start() getting called with
d->in_use non-zero.

It's a single cpu box with hyperthreading, running an SMP kernel.

Anyway,

a) has anyone else seen problems like this?

b) is it a known problem that is likely fixed in later code?

c) could it be a bug triggered by the SMP kernel?

d) any suggestions as to where I go from here ;-)


Thanks,
  Richard

