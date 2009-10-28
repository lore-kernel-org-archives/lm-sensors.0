From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Oct 2009 12:44:09 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon-f71882fg: Add support for the
Message-Id: <20091028134409.35c26267@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4AE02F99.4060105@redhat.com>
In-Reply-To: <4AE02F99.4060105@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 28 Oct 2009 11:40:57 +0100, Hans de Goede wrote:
> On 10/28/2009 10:57 AM, Jean Delvare wrote:
> > On Thu, 22 Oct 2009 12:10:33 +0200, Hans de Goede wrote:
> >> +				break;
> >> +			case 0x03:
> >> +				data->temp_type[1] = 8 /* Intel Ibex */;
> >> +				break;
> >> +			}
> >
> > Types 7 and 8 are not listed in Documentation/hwmon/sysfs-interface,
> > and not supported by "sensors". That's not OK. Sensor types must be
> > standardized before use, not the other way around.
> >
> 
> You are right, sorry I was planning on doing a separate patch updating
> sysfs-interface, but I forgot.
> 
> > I am also very skeptical about the latter type. The Intel Ibex is a
> > chipset, as far as I know. It's not a sensor type. tempN_type is
> > supposed to describe the type of the sensor, not its location. This
> > certainly needs to be investigated and discussed.
> >
> 
> Ok lets discuss it then :)
> 
> First of all the new type 7, SST, is not really a sensor type,
> as much as it is a bus type, like PECI and AMDSI it is a digital
> serial bus used to communicate with sensors, SST actually seems quite
> interesting, see for example:
> http://www.powerdesignindia.co.in/STATIC/PDF/200608/PDIOL_2006AUG07_PTEST_PMNG_TA_01.pdf?SOURCES=DOWNLOAD
> 
> Ok, reading the F71889FG datasheet again (and also checking the F71882FG datasheet),
> this bit of the patch is clearly wrong, case 0x02 should simply always be PECI,
> the SST enable bit enables a SST slave / client interface on the F71889FG, which
> allows the ICH to read various sensor values from the F71889FG, so this bit does
> not matter for the temperature reading done by the F71889FG, my bad.
> 
> As for case 0x03, the Ibex case, the datasheet calls this "Intel PCH/smbus"
> in the register description, but in the pin description it uses:
> 
> 43 Clock output for INTEL PCH (IBex Peak) interface.
> 44 INTEL PCH (IBex Peak) data interface pin.
> 
> And in several other places there are more references to "IBex Peak", this seems
> to be a new Intel replacement for PECI, which looks a lot like AMDSI / smbus and
> which can be used to read both the chipset and the cpu temperature from the cpu
> resp. chipset.
> 
> We could also use type 6 for this, changing the meaning of 6 from Intel PECI,
> to "Intel specific digital serial bus" or shorter: "Intel PECI / Ibex", where
> Ibex can be replaced by the protocol name if we ever find the official name
> for the protocol. Or we could introduce a type 7 for this, but I think that
> using 6 for this makes more sense, esp. since I've not seen this actually being
> used yet.

I would use type 6 for now, at least until we learn more / more chips
implement the new protocol / at least one driver offers the possibility
to change the type.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
