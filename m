From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Mar 2010 12:23:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: driver for TI tmp102 temperature
Message-Id: <20100307132338.25f4060c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201002031723.49976.sfking@fdwdc.com>
In-Reply-To: <201002031723.49976.sfking@fdwdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Steven,

On Sat, 6 Mar 2010 08:16:54 -0800, Steven King wrote:
> On Saturday 06 March 2010 12:35:21 Jean Delvare wrote:
> > I did not review it. And testing it doesn't seem positive. First of
> > all, I get the following in my logs after loading the driver:
> >
> >  (null): not a tmp102
> >
> > Which suggests the use of an uninitialized device struct. Also, the
> > detection fails early, I don't think the detection routine works.
> > Looking at the code, it doesn't seem to correspond to the TMP102
> > register map at all (assuming the dump I got from Steven is really from
> > a TMP102) Steven, did you ever test it? Honestly, I don't think it
> > makes sense to have a detect routine for this chip, given that it lacks
> > identification registers. We relied on ugly detection quirks for the
> > LM75 only because that chip was very popular on PC motherboards at one
> > point in time. For devices used on embedded designs and which are
> > always enumerated, we don't need detection routines.
> 
> For my specific use the part is connected to an embedded system and is always 
> enumerated; as lm-sensors doesnt build for this target I wasnt aware of any 

Out of curiosity, why is lm-sensors not building? What is missing?

> way to test the detection code.  I certainly wouldnt have any problem with 
> removing the detection routine entirely...

I'm fine with this.

> > Then, using the tmp102 driver on the dump sent by Steven produces the
> > following "sensors" output:
> >
> > tmp102-i2c-3-48
> > Adapter: SMBus stub driver
> > temp1:        +2.6°C  (high = +15.0°C, hyst =  +9.0°C)
> >
> > These values are suspiciously low and smell like the wrong base unit is
> > used (1/100 °C instead of 1/1000 °C). Quick code examination seems to
> > confirm this.
> 
> Doh!  My bad.
> 
> > So, no, I am not OK with the patch as-is, it needs more work.
> 
> Okay, so besides removing the detect routine, incorporating Andrew's patch and 
> fixing the base for the temperature conversion, was there anything else I 
> need to do for v2?

Nothing spotted by my quick look, but I didn't actually review your
code. If you post an updated version of your patch, I could review it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
