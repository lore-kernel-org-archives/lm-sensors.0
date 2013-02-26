From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Feb 2013 01:39:06 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (adt7410) Don't re-read non-volatile registers
Message-Id: <20130226013906.GA2290@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361194739-16525-1-git-send-email-lars@metafoo.de>
 <51228D7A.8030608@gmx.de>
 <20130219010229.GA25124@roeck-us.net>
 <5123D4F5.5030001@gmx.de>
 <20130220012249.GA15948@roeck-us.net>
 <5128112C.4080909@gmx.de>
 <512B34E2.70709@metafoo.de>
 <512BD7F6.6040105@gmx.de>
In-Reply-To: <512BD7F6.6040105@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hartmut Knaack <knaack.h@gmx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Jean Delvare <khali@linux-fr.org>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Mon, Feb 25, 2013 at 10:30:30PM +0100, Hartmut Knaack wrote:
> Lars-Peter Clausen schrieb:
> > On 02/23/2013 01:45 AM, Hartmut Knaack wrote:
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
> >> Thanks
> >>
> > That's a bit of an artificially constructed situation, isn't it? Anyway,
> > wouldn't it be better to not cache at all in that case. For the cache to be
> > useful userspace would have to poll the file with period of less than 1.5
> > seconds. I don't think anybody is going to do this for the threshold properties.
> >
> > - Lars
> I could agree with not caching those registers - nobody would probably want to read them too often, intentionally (although bugged userspace code might DoS the bus). The other few i2c drivers I know also do uncached reads.

The "sensors" program always reads all attributes.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
