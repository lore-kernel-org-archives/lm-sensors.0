From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Jun 2008 08:10:15 +0000
Subject: Re: [lm-sensors] Reported fan speed oscillates 730 RPM -> 337500
Message-Id: <20080602101015.603cc796@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1211960385.4093.18.camel@localhost.localdomain>
In-Reply-To: <1211960385.4093.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simon,

On Mon, 02 Jun 2008 07:00:19 +0200, simon wrote:
> Your analysis appears absolutely correct. The fan is speed controlled
> and problem is pronounced when it is running slowly. Normal speed is
> around 750-800rpm. The problem appears to diminish as the speed rises;
> above ~1000 rpm, the readings appear stable.
>  
> I would assume that Gigabyte have used the automatic control facilities
> of the it8718 chip. Where is this going to be set up - from the bios? Is
> there anywhere in the linux system that this can be done? Or is it all
> automatic.

Yes, most probably the BIOS is setting things up at boot time. The
Linux it87 driver doesn't let the user control the settings yet. That's
somewhere deep in my to-do list... All you can do is disable the
automatic control mode by writing 0 to pwmN_enable sysfs files - but I
doubt you want to do that other than for testing purposes.

You might also be able to mitigate the problem by changing the
frequency of the PWM signal (sysfs files pwmN_freq, since kernel
2.6.21). I guess that lower frequencies should help the chip monitor
the speed.

> At any rate the thing seems to work, so I don't really want to play with
> it (let sleeping dogs lie etc). It's just the oscillating reading is a
> bit annoying. Wouldn't there be anyway of filtering out such values in
> lm-sensors? (Maybe a configuration setting)

This has been discussed many times but was never implemented. I'm not
even sure where this would fit best: applications, libsensors or the
kernel drivers. libsensors is the best place if we want to address the
problem once and for all, but OTOH not all applications use libsensors,
for example the fancontrol daemon doesn't.

We didn't have that many reports, so I wonder if only a limited subset
of devices is affected. Some devices might filter out bogus values
themselves. And some devices (e.g. SMSC EMC6D102) have an "enhanced"
monitoring mode which will stretch PWM pulses as needed to be able to
keep monitoring even at low speeds.

If only a few drivers need it, maybe we can filter out the unlikely
values there. Here's a proposal for the it87 driver, which should fix
your problem:

Subject: hwmon: (it87) Filter out unlikely 16-bit fan speed values

Filter out 16-bit fan speed values above 100000 RPM. These can be
reported by the chip when a fan is being controlled at low speed. The
tachometer signal gets too weak and the chip fails to monitor the
speed properly, but unfortunately it reports unreasonably high values
instead of 0 RPM, which is quite confusing.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |    9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

--- linux-2.6.26-rc4.orig/drivers/hwmon/it87.c	2008-06-01 11:33:11.000000000 +0200
+++ linux-2.6.26-rc4/drivers/hwmon/it87.c	2008-06-02 09:55:33.000000000 +0200
@@ -196,12 +196,15 @@ static inline u16 FAN16_TO_REG(long rpm)
 {
 	if (rpm = 0)
 		return 0xffff;
-	return SENSORS_LIMIT((1350000 + rpm) / (rpm * 2), 1, 0xfffe);
+	return SENSORS_LIMIT((1350000 + rpm) / (rpm * 2), 7, 0xfffe);
 }
 
 #define FAN_FROM_REG(val,div) ((val)=0?-1:(val)=255?0:1350000/((val)*(div)))
-/* The divider is fixed to 2 in 16-bit mode */
-#define FAN16_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:1350000/((val)*2))
+/* The divider is fixed to 2 in 16-bit mode
+   We filter out speed values > 100000 RPM, which could be reported when
+   a fan is controlled at low speed. */
+#define FAN16_FROM_REG(val)	((val) <= 6 || (val) = 0xffff ? 0 : \
+				 1350000 / ((val) * 2))
 
 #define TEMP_TO_REG(val) (SENSORS_LIMIT(((val)<0?(((val)-500)/1000):\
 					((val)+500)/1000),-128,127))

One issue with this approach is that the ALARM flag for the fan in
question will still not trigger (because the chip things the fan is
running at a very high speed so it's definitely above the limit). So we
have a little inconsistency between the displayed speed and the ALARM
flag. Not much we can do about this though, and the patch only makes
the problem more visible but it was already there before.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
