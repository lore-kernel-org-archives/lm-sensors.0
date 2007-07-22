From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 22 Jul 2007 16:24:28 +0000
Subject: Re: [lm-sensors] Proposal: howto handle sysfs attribute writes with
Message-Id: <20070722182428.4b1b144b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <469F7CFC.4040306@hhs.nl>
In-Reply-To: <469F7CFC.4040306@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Thu, 19 Jul 2007 17:02:20 +0200, Hans de Goede wrote:
> Since there was some discussion about how I'm handling sysfs attr writes with 
> invalid values in the f71882fg driver, and since I've seen other discussions 
> about it, here is a proposal to try and create a standard way to handle this.
> 
> This is intended to become a part of Documentation/hwmon/sysfs eventually.
> 
> ---
> 
> Howto check the validity of user written values to sysfs attributes:
> 
> hwmon sysfs attributes always contain numbers, so the first thing todo is to
> convert the input to a number, there are 2 ways todo this depending wether

s/todo/to do/, s/wether/whether/

> the number can be negative or not:
> unsigned long u = simple_strtoul(buf, NULL, 10);
> long s = simple_strtol(buf, NULL, 10);
> 
> With buf being the buffer with the user input being passed by the kernel.
> Notice that we do not use the second argument of strto[u]l, and thus cannot
> tell when 0 is returned, if this was really 0 or is caused by invalid input.
> This is done deliberately as checking this everywhere would add a lot of
> code to the kernel. We do need to document clearly that writing a non-number 
> will be seen as writing 0.

Agreed.

> Notice that it is important to always store the converted value in an unsigned 
> long or long, so that no wrap around can happen before any further checking.

True.

> After conversion and storing the converted value in the right type, and 
> preferably before any conversions on the value, the value should be checked if 

Not sure about the "preferably before any conversions on the value". In
some cases it's easy to get it wrong that way, and converting first is
more obvious.

> it its acceptable. For example if its a temperature limit being stored in an 

   s/its/is/                      s/its/it is/

> unsigned 8 bit register, we should have something like this:

Probably not a very good example, as temperature values are almost
never u8. s8 is much more frequent.

> 
> unsigned long u = simple_strtoul(buf, NULL, 10);
> if (u > 255000)
> 	return -EINVAL;
> 
> One could argue to clamp instead of returning EINVAL, but what todo then when 

As said it another thread, I indeed believe that continuous values
should be clamped. We even have a helper function for this,
SENSORS_LIMIT(), which you may want to mention. This is how the
majority of hwmon drivers behave right now.

> something that is not a continues range like temp sensor type gets written? In 
> the not a continues range scenario returning -EINVAL is the only thing that 
> makes sense, so we do this in the continues range scenario too to be consistent.

I see no problem making different rules for different case. The lists
aren't that long so we could even be explicit:

* temperature, fan and voltage limits: clamp.
* fan div, pwm... well, all the rest: error.

> 
> ---
> 
> So does this make sense? I know that many drivers are currently doing this 
> different, some clamp, some don't check at all, thus effectively wrapping 
> around in most cases, all these different ways are exactly the reason for me 
> writing this proposal.

Yes, I think this is a good idea.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
