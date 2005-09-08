From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 08 Sep 2005 02:06:20 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision!
Message-Id: <20050908000553.GA8062@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050907213603.GW8392@levanta.com>
In-Reply-To: <20050907213603.GW8392@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Richard:

* Richard Hirst <rhirst@levanta.com> [2005-09-07 22:36:03 +0100]:
> This is on an Intel motherboard running an FC3 2.6.10-1.766.FC3smp
> kernel with these additional patches:
> 
> linux-ipmi-2.6.10-base.diff
> linux-i2c-2.6.10-nonblock.diff
> linux-i2c-2.6.10-i801_nonblock.diff
> linux-ipmi-2.6.10-smb.diff
> patch-linux-2.6.11.5-bmcsensors.diff

I assume these patches came from here:
http://openipmi.sourceforge.net/

> The board has an mBMC which is basically working in that I can read
> the sensors either by 'ipmitool' or 'sensors'.
> 
> However, round about every 10 reboots or so, I get the Bus collision
> message and the system locks up solid during boot after outputting a
> few messages such as
> 
> i801_smbus 0000:00:1f.3: Bus collision!
> i801_smbus 0000:00:1f.3: Reset failed! (01)
> i801_smbus 0000:00:1f.3: Reset failed! (01)
> i801_smbus 0000:00:1f.3: Reset failed! (01)
> bmcsensors.o: Error 0xff on cmd 0xa/0x23; state = 2; probably fatal.
> i801_smbus 0000:00:1f.3: Reset failed! (01)
> i801_smbus 0000:00:1f.3: Reset failed! (01)
> i801_smbus 0000:00:1f.3: Reset failed! (01)
> 
> 
> I'm assuming this indicates that two things have tried to use the
> i2c bus at the same time, and I guess one of them is the bmcsensors
> code.
> 
> I also tried adding code to check 'd->in_use' at the beginning of
> i801_start() because it looked to me like in_use should perhaps
> normally be zero at that point.  Don't know if that is valid, but
> I did get a few indications of i801_start() getting called with
> d->in_use non-zero.

I looked at the patch *very* briefly... I don't think 'd->in_use' is used to
prevent concurrent accesses.  It looks like a kind of adapter ref-count to me.

I would suggest you use either of sensors or ipmitool, but not both.  If you're
using ipmitool, perhaps make sure you're *not* loading any of the sensors drivers:
eeprom, lm78, etc.

> It's a single cpu box with hyperthreading, running an SMP kernel.
> 
> Anyway,
> 
> a) has anyone else seen problems like this?
> 
> b) is it a known problem that is likely fixed in later code?
> 
> c) could it be a bug triggered by the SMP kernel?
> 
> d) any suggestions as to where I go from here ;-)

Have you tried the openipmi mailing list?
http://lists.sourceforge.net/lists/listinfo/openipmi-developer

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

