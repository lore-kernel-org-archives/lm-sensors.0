From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Feb 2013 01:40:25 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <20130226014025.GB2290@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
 <51228D7A.8030608@gmx.de>
 <20130219010229.GA25124@roeck-us.net>
 <5123D4F5.5030001@gmx.de>
 <20130220012249.GA15948@roeck-us.net>
 <5128112C.4080909@gmx.de>
 <20130223201853.GA11055@roeck-us.net>
 <512BDFC6.8060504@gmx.de>
In-Reply-To: <512BDFC6.8060504@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Mon, Feb 25, 2013 at 11:03:50PM +0100, Hartmut Knaack wrote:
> Guenter Roeck schrieb:
> > On Sat, Feb 23, 2013 at 01:45:32AM +0100, Hartmut Knaack wrote:
> >> Guenter Roeck schrieb:
> >>> On Tue, Feb 19, 2013 at 08:39:33PM +0100, Hartmut Knaack wrote:
> >>>> Guenter Roeck schrieb:
> >>>>> On Mon, Feb 18, 2013 at 09:22:18PM +0100, Hartmut Knaack wrote:
> >>>>>> Lars-Peter Clausen schrieb:
> >>>>>>> Currently each time the temperature register is read the driver also reads the
> >>>>>>> threshold and hysteresis registers. This increases the amount of I2C traffic and
> >>>>>>> time needed to read the temperature by a factor of ~5. Neither the threshold nor
> >>>>>>> the hysteresis change on their own, so once we've read them, we should be able
> >>>>>>> to just use the cached value of the registers. This patch modifies the code
> >>>>>>> accordingly and only reads the threshold and hysteresis registers once during
> >>>>>>> probe.
> >>>>>> I have been thinking about this a lot, and I am concerned about data integrity. From what I know about I2C, there is no data integrity verification specified in the protocol. So, what the master sends is not necessarily what the slave receives (not to mention other devices on the bus, which could potentially mess around with the slaves, or even reset of the slave). Reading back just cached values makes it pretty hard to verify, if there are issues. I think it might be better to call a read-temperature function with a parameter that indicates, which temperature register is required.
> >>>>> I am not concerned about that, unless there is a known issue with the chip
> >>>>> and it is known to return bad data under some circumstances. I am doing the
> >>>>> same in the PMBus drivers, since there are simply too many limit registers
> >>>>> to read on some of the chips (there may literally be more than a hundred).
> >>>>> That works fine most of the time; if it does not work, it is a chip problem,
> >>>>> an i2c bus master problem, a hardware signal problem, or a combination of all.
> >>>>> I actually think it is better if the problem is exposed by cached bad readings.
> >>>> Could you please outline the last sentence? I'm having trouble to understand your intention with cached bad readings.
> >>> Someone will actually notice it (hopefully while testing) and provide feedback.
> >>> This gives a chance to fix the problem instead of having it linger around ...
> >>> which would likely be the case if the problem is not persistent.
> >>>
> >>> Guenter
> >> Well, think about a use case where you optically decouple your master and slave using PCA9600 (may it be using optical fibers to cover a big distance, or just to operate the slave in a hazardous environment), where the slave is powered from a different source. Now, if the slaves Vcc drops for a certain time, all its registers get reset (especially min, max and crit) - without the master noticing anything.
> >> Therefor I would prefer something like the following solution, where unnecessary load on the bus gets avoided and the cached values get used, until they expire and get read again from the sensor. This is mainly a draft, but do you see any reason against it?
> > Yes, it adds a lot of complexity. Also, at least in theory it would apply to all
> > i2c drivers, so solving the problem for one chip doesn't help much.
> >
> > A somewhat cleanly designed hardware should inform the software that a device went
> > offline, for example with an interrupt; otherwise its operation could be severely
> > affected and system behavior would be unpredictable.
> >
> > So the question here is if this is a practical problem in your use case, or a
> > theoretical problem. If it is a theoretical problem, we can address it for
> > affected drivers as it is seen. If it is a practical problem, I think we'll need
> > to come up with a simpler solution. The only one I can think of right now would
> > be a module parameter. If set, it the driver could re-load the cache each time
> > the temperature sensor is updated.
> >
> > Thanks,
> > Guenter
> >
> My intended use for this sensor type is just temperature logging, so it is just a theoretical problem for me. But I don't trust I2C any more than really necessary (and always keeping Murphy's law in mind) and feel somehow responsible for this driver.
> I can agree on having a 'paranoid' module parameter to force register reads, just for those folks who need it.
> 
If it is a theoretic problem, let's address it once/if it ever gets a real one.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
