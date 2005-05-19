From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: System hanging using CSB5 chip with 2.8.1 - No longer
Message-Id: <3FCBF8AD.8CE0D9CE@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
In-Reply-To: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Philip.

I wrote the xeontemp driver as a one-temperature driver,
since it was confusing to people using the adm1021 driver that they
had to ignore the local temp and look at the remote temp.

Khali, I'll update the docs myself using Philip's info,
to make recommendations.

Discrimination may be possible between a one-temperature xeon
and a two-temperature xeon with embedded adm1021,
if we could count on the unused registers being someting constant.

mds


Philip Pokorny wrote:
> 
> Some Xeons have honest to goodness, real live, actual MAX1617 chips on
> them.  Others Xeons made around the same time have other ADM1021
> compatible chips on them.  They are mounted on the CPU substrate along
> with the processor information EEPROM that is part of that generation of
> Xeon CPU's.
> 
> So it's basically impossible to tell a Xeon TEMP sensor from a MAX1617
> since they are in fact the same chip.  The Xeon Temperature sensors spec
> is just a stripped down register spec for the ADM1021 that says the
> "on-board" or "built-in" sensor registers are "reserved".  That way
> Intel could substitute whatever ADM1021 compatible chip was cheapest at
> the time when they built the CPU's.
> 
> The only reason to have the xeontemp driver is if, when Intel built your
> particular Xeon's, they didn't use any of the ADM1021 compatible chips
> that the ADM1021 driver recognizes.  In that case, using the xeontemp
> driver will get you the temperatures you want without potentially
> messing up something in the sensor.  I had a pair of Xeons that had
> sensors that weren't recognized, but I've long since stopped using them.
> 
> Unfortunately, the 533MHz FSB Xeon's, dropped the on-board sensor chip.
>  So these new Xeons require a sensor on the motherboard to be connected
> to the thermal diode to read the temperature.  But these 533MHz capable
> motherboards can also accept 400MHz CPU's with the on-board sensor so it
> gets confusing in a hury for motherboard vendors, user and us.
> 
> I would suggest that we say:
> 
> If you have 400MHz FSB P4 Xeon CPU's, you should have an on-CPU ADM1021
> compatible sensor at 0x18 or 0x19.  In that case, use the ADM1021 driver
> if it detects a chip at that address.  The CPU DIE temperature (Tj) will
> be the "REMOTE" temperature from this sensor.  The "Board" or "built-in"
> temperature from the ADM1021 will be the temperature of the ADM1021
> compatible itself which is one of the chips you see on the side of the CPU.
> 
> If you have sensors at 0x18 and 0x19 that are not detected by the
> ADM1021, and you have 400MHz Xeons, then you may want to try the
> xeontemp driver.
> 
> If you have 533MHZ FSB Xeons, then you do *not* have an on-board thermal
> sensor and you should look for CPU temperatures from the other sensors
> on your motherboard. (Winbond chip for example).
> 
> -------
> That's my two cents.
> :v)
> 
> Jean Delvare wrote:
> 
> >(MDS, question for you below.)
> >
> >
> >
> >>>Why did you use that force parameter? Was it suggested by
> >>>sensors-detect?
> >>>
> >>>
> >>The adm1021 text file in lm_sensors2/doc/chips suggest to get Xeon
> >>support that I should use the force_adm1021 module parameter.  Is
> >>this correct ?  Should I just use the module without any
> >>parameters?
> >>
> >>
> >
> >Probably something left from the past, I don't think it's true anymore.
> >Sensors-detect will detect these as MAX1617 chips, and the adm1021
> >drivers should load without the force parameter.
> >
> >What's more, we now have another driver, xeontemp, which I think is the
> >right driver to use in this case. Read doc/xeontemp for details.
> >
> >Looks like our adm1021 driver doc needs an update. Mark, if you confirm
> >my analysis is correct, I'll update the docs.
> >
> >Also, Mark, sensors-detect doesn't know about xeontemp. Is it because
> >it's difficult to differenciate from the MAX1617? According to the docs,
> >the temperature readings are not exaclty the same, so maybe we could use
> >some heuristics?
> >
> >
> >
> >>I have included 9 log files in this e-mail.
> >>This first file being the sensors-detect.log. The next 4 are
> >>i2cdump without force_adm1021 as a module paramter.  The next 4 are
> >>i2cdump with  the force_adm1021 as a module parameter.
> >>
> >>
> >
> >The force parameter doesn't do anything here. This parameter skips
> >detection while loading a driver. I2cdump reads the chips directly, it
> >doesn't use the driver (actually you are supposed to unload chip drivers
> >before dumping their contents).
> >
> >The chips at 0x18 and 0x29 could be MAX167 chips (or Xeon, if this is a
> >xeon system, in which case you should really give a try to the xeontemp
> >driver instead of the adm1021 driver).
> >
> >The chips at 0x2d and 0x2e could be LM87 (I don't know that chip very
> >well but sensors-detect seems to be fairly confident).
> >
> >All you have to do is load the drivers, run "sensors -s" and tweak
> >things to fix your needs, I think.
> >
> >
> >
