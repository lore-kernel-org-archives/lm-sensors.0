From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 Apr 2007 12:24:53 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070409142453.880b9785.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 08 Apr 2007 15:51:02 +0200, Hans de Goede wrote:
> The abituguru3 driver, of which I've just submitted a second version for 
> review, has a new feature / sysfs file, which I would like to discuss, before 
> people think I'm trying to keep this new sysfs entry below the radar.
> 
> The abituguru3 has a register which contains a motherboard ID. The current 
> driver uses this ID, to look up info about the motherboard in a somewhat lenght 
> table in the driver. This is done this way because the uguru3 has 48 sensors, 
> and the only way to know which one are actually connected and wether they are 
> connected to voltage / temp / fan is by using this table. The added advantage 
> of this is that since we know exactly on which motherboard the driver is 
> running, additional stuff can be don. Like always correct values in mV / milli 
> degress celcius / RPM at the sysfs level without libsensors needing todo any 

As I already expressed further in the thread: this violates the design
decision all other hardware monitoring drivers are built upon.
Conversions, and motherboard support in general, belong to user-space.

> conversion. An other additional feature this enables, is telling userspace 
> which voltage / temp / fan is actually being monitored. So the abituguru3 
> driver has sysfs entries like:
> /sys/class/hwmon/hwmon0/in0_label
> 
> Catting this file will result (depependend on motherboard) in for example:
> CPU Core
> being returned
> 
> I personally like this, as with proper userspace support this makes the end 
> user experience pretty plug and play. so what do you think, good or bad?
> 
> Currently libsensors cannot handle this, but I don't think that is an argument 
> either way.

I am, however, fine with *_label entries in sysfs, as long as they are
used with care. The use of these entries should be limited to the case
where pin use can be probed by the driver from the hardware state.
BTW, the coretemp driver already creates these files, even though it is
not properly documented in Documentation/hwmon/sysfs-interface yet. And
I have plans to create some label files in the it87 driver too.

These sysfs files should not be seen as a replacement for sensors.conf's
label statements. They should only be created when the driver knows,
directly from the hardware, that a given input is used for a
well-defined function, and user-space couldn't know that.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
