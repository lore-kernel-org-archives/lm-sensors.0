From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 07 May 2008 15:58:50 +0000
Subject: Re: [lm-sensors] How to adjust sensors.conf for a Super Micro X7DA8
Message-Id: <20080507175850.21a90522@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <24825AE3-0B15-4A0D-8AD5-36EE7815F8F4@utk.edu>
In-Reply-To: <24825AE3-0B15-4A0D-8AD5-36EE7815F8F4@utk.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Daniel,

On Fri, 2 May 2008 15:05:01 -0400, Daniel Lucio wrote:
> I ran a tool called Super Doctor II on a Super Micro X7DA8  
> motherboard, and i noticed that some of values where different for  
> the following measurements returned by lm-sensors:
> 
> w83793-i2c-0-2e
> Adapter: SMBus I801 adapter at 1100
> -12V:       -11.38 V	- compute in3 (((@/8)*18500)/256)-16, (((@+16) 
> *256)/18500)*8
> +5V:         +5.12 V	-No scaling
> 5VSB:        +5.12 V	-No scaling
> 
> SuperDoctorII returned for the same measurements:
> -12V:  -12.21
> +5V:     4.97
> +5Vsb:   4.97
> 
> My question is, how should I scale the values read by lm-sensors to  
> return the correct value?

First of all: you should not assume that SuperDoctorII is always
correct. I've seen enough buggy vendor-provided software and buggy BIOS
to say that you should treat them as valuable hints, but should not
trust them blindly.

For +5V and +5VSB: the w83793 driver applies a +150 mV offset to the
register readings. We do that because it's documented that way in the
datasheet. It never made much sense to me from a physical point of
view, but I tend to trust Winbond's datasheet. So my guess is that
SuperDoctorII misses the offset, and the w83793 driver is correct. The
best way to make sure would be to measure the actual value with an
external voltmeter if you have one - 150 mV is significant enough to be
measured I think.

For -12V: where did you get your compute formula? It seems to be the
same as Romain Dolbeau (Cc'd) posted a few days ago for another
SuperMicro motherboard, but I had never seen it before. Me, I am using:
   compute in3 (5.14*@)-14.91, (@+14.91)/5.14
Give it a try, it should provide a result similar to what SuperDoctorII
says. The exact formula depends on the resistors and reference voltage
used on your specific board. Only SuperMicro knows what they used.

> Also, I noticed that SuperDoctorII displayed other information like:
> 
> Chassis Intrusion                                      Bad  Warning!
> Power Supply Failure                                  Good
> 
> How can I find out which sensor read by lm-sensors maps to these two  
> readings?

The first one is exposed as file "chassis"
in /sys/class/hwmon/hwmon*/device. We don't have support for this
feature in libsensors, which is why you don't see it in "sensors. Maybe
we could standardize it if there is enough requests for this feature.

The second one is probably not implemented by the w83793 driver, to be
honest I don't even know what it is supposed to correspond to.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
