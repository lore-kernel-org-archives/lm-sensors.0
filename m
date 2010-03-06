From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Mar 2010 08:35:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <20100306093521.4b4f2fa8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com>
In-Reply-To: <201002031723.49976.sfking@fdwdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

Adding back Steven and the lm-sensors list...

On Fri, 5 Mar 2010 11:53:42 -0800, Andrew Morton wrote:
> So you're OK with the patch as-is?

I did not review it. And testing it doesn't seem positive. First of
all, I get the following in my logs after loading the driver:

 (null): not a tmp102

Which suggests the use of an uninitialized device struct. Also, the
detection fails early, I don't think the detection routine works.
Looking at the code, it doesn't seem to correspond to the TMP102
register map at all (assuming the dump I got from Steven is really from
a TMP102) Steven, did you ever test it? Honestly, I don't think it
makes sense to have a detect routine for this chip, given that it lacks
identification registers. We relied on ugly detection quirks for the
LM75 only because that chip was very popular on PC motherboards at one
point in time. For devices used on embedded designs and which are
always enumerated, we don't need detection routines.

Then, using the tmp102 driver on the dump sent by Steven produces the
following "sensors" output:

tmp102-i2c-3-48
Adapter: SMBus stub driver
temp1:        +2.6°C  (high = +15.0°C, hyst =  +9.0°C)  

These values are suspiciously low and smell like the wrong base unit is
used (1/100 °C instead of 1/1000 °C). Quick code examination seems to
confirm this.

So, no, I am not OK with the patch as-is, it needs more work.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
