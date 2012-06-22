From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 22 Jun 2012 15:19:23 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Honeywell Humidicon HIH-6130/HIH-6131 humidity and temperature senso
Message-Id: <20120622151923.GA8350@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE1E507.9040108@gmail.com>
In-Reply-To: <4FE1E507.9040108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Iain,

On Fri, Jun 22, 2012 at 12:38:11PM +0000, Iain Paton wrote:
> On 06/21/2012 06:42 PM, Guenter Roeck wrote:
> 
[ ... ]
> 
> >> +	 * Formula T = ( ticks / ( 2^14 - 2 ) ) * 165 -40 from data sheet section 5.0,
> >> +	 */
> >> +	return ((ticks * 165000) / 16382) - 40000;
> > 
> > Would DIV_ROUND_CLOSEST make sense here ? Also, is it guaranteed that you don't
> > get an integer overflow ?
> 
> I didn't know about DIV_ROUND_CLOSEST, so yes I can use it.  What do I gain from 
> doing so ?  If I read it right it'll force a round up rather than a round down ?  

It is rounding to the closest result, so neither strictly up or down.

> The stated accuracy of the sensor, 5% RH and +-1C, seems like a round up or round 
> down would be lost in the noise.
> So what's preferred ?  Either way seems fine to me - unless I'm missing something. 
> 
> For the integer overflow I was thinking it was ok, but I can see that with a 
> 32 bit signed int the ticks * 165000 could end up giving me a negative number.
> So let me try re-arranging this.
> 
> On the subject of using int, I suppose I've assumed an int will never be less 
> than 32 bits. Is that valid across different arches ?  Or should I be using a 
> different type like s32 or s64 to ensure it'll always work ?
> 
At least across used architectures. I don't think Linux runs on an architecture
where it is less.

> >> +	return (ticks * 100000) / 16382;
> > 
> > Would DIV_ROUND_CLOSEST make sense here ?
> > Is it guaranteed that there won't be an integer overflow ?
> 
> the ticks value can only ever be max 2^14, so I don't believe there's a problem 
> with this one. Same question as above on whether I should use a fixed type to avoid 
> problems if the size of int changes.
> 
> I guess nothing in here is fast path, especially with i2c and a 40ms delay, but I 
> assume just changing these to 64 bit is going to incurr some penalty on a 
> 32 bit arch. Is there a preferred way to deal with this ?
> 
Just make sure you can not get an overflow.

> >> +	/*
> >> +	 * Unlike the SHT2x the HIH-613x datasheet doesn't give limits on the number of
> >> +	 * measurements per second we can make. However it makes no sense to allow polling
> >> +	 * for humidity or temperature more than a couple of times a second anyway.
> >> +	 */
> > 
> > It isn't really relevant what SHT2x does here. More important would be to
> > mention that a measurement takes a long time, so you want to limit it. Since a
> > measurement cycle takes 40 ms, you might actually want to consider increasing
> > the timeout to HZ or even HZ + HZ/2.
> 
> I was originally going to leave this out altogether, but a couple of things made me 
> keep it.
> You do a single i2c read to get 4 bytes that includes humidity and temperature, you 
> can do a 2 byte read to get just humidity, but can't get temperature on it's own.
> Testing my patch to the sensors command to add humidity display showed three reads 
> going out onto the bus within ~180ms, all getting essentially the same data. 
> So rather than do that it seemed better to put this in.
> 
Definitely agree. Note that I was referring to the comment, not to the timeout.

> So thinking about this again, and re-reading the datasheet, essentially the 
> 40ms is probably irrelevant in the larger picture. I can't find anything to say 
> that there's any problem with requesting a reading every 40ms, however there's 
> response times for given volume of airflow of up to 8 seconds for humidity and 
> 30 seconds for temperature.
> So it's clear that we're not going to get anything meaningful by reading every 40ms 
> and if the rate of change required that frequency then you probably need a better 
> sensor and a real-time OS. So I'll change and re-word the comment.
> 
> > Also, is there another accuracy ? I didn't find it in the documentation.
> > If the measurement cycle can be longer based on the configuration, reading
> > the measurement results might always fail, which would be bad.
> 
> There are hints in the docs that either the device is capable of more or perhaps 
> they will release a different sensor with different capabilities.
> For example there's at least one mention of being able to configure it for SPI, 
> but no details on how to do that. 
> If there is another accuracy setting it'll most likely be configured by one of the 
> reserved EEPROM locations, the actual measurement and data read are somewhat simple
> and don't give much in the way of options.
> As we'd have to enter command mode within either 3ms or 10ms of sensor power on, 
> doing this isn't possible without additional hardware.
> 
> There's only one mention of the measurement cycle time that I could find and I'd 
> say it's meaning is somewhat ambiguous.
> So we could maybe add a loop, with a limited number of retries, check the status 
> bits and break on valid data. How many retries to use would be a guess though.
> 
I would say don't bother at this time. If it turns out to be a problem we'll
have to fix it. Thinking about it, it is unlikely that it will ever be slower,
so if anything we could optimize the code at some point to do a wait loop. Since
that means more slow i2c bus accesses, I would not bother doing it right now.

> >> +		t = (tmp[0]<<8) + tmp[1];
> > 
> > Coding style: spaces before and after <<
> 
> I don't remember checkpatch complaining about it, but ok :)

One of those odd ones where it does not complain. Documentation/CodingStyle
still applies, though.

> Also I wasn't sure if these would be properly portable, is there a helper function 
> that can take care of that for me?  I couldn't find one, but I can't believe nobody 
> else does this.
> 
scripts/Lindent, but after you run that you'll have to do some manual cleanup.

> >> +static ssize_t hih613x_show_temperature(struct device *dev,
> >> +	struct device_attribute *attr,
> >> +	char *buf)
> > I don't really like the alignment here. I would suggest to align with (, and use
> > one less line.
> 
> Hmm, like this:
> static ssize_t hih6130_show_temperature(struct device *dev,
>                                         struct device_attribute *attr, char *buf)
> 
> makes an 82 char line and checkpatch hates me :)
> 
Then you would stick with three lines ;).

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
