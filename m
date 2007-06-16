From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 16 Jun 2007 19:40:42 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <46743CBA.7070009@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Hans:
> 
>> Jean Delvare wrote:
>>> This is absolutely not different from all other hardware monitoring
>>> drivers. And all other drivers handle it in user-space, because that's
>>> the right design. I see no valid reason why it would be different for
>>> your abituguru3 driver. All you need is one configuration file per
>>> motherboard.
> 
> * Hans de Goede <j.w.r.degoede@hhs.nl> [2007-04-09 14:50:03 +0200]:
>> Oh and yet another thing, since when should all conversions be done in 
>> userspace? I did exactly that with the abituguru 1/2 driver and there I had to 
>> change it to give the return the actual pin values in Volts and not register 
>> values, iow do the conversion in the driver.
>> [...]
> 
> The kernel-to-userspace interface for hwmon is the *measured* value at the
> *pin*, in natural units.
> 
> If the pin on a chip can measure e.g. 0.0-5.0 volts, then the sysfs file will
> report that voltage.
> 
> If that same pin is wired into a circuit which is used for measuring a 12V
> power supply (and thus needs further conversion) that is *irrelevant* to the
> driver.  The hwmon driver for a well-documented and general purpose sensor chip
> need not concern itself with external circuitry.
> 
> (It cannot, short of moving all of libsensors or its equivalent into the kernel,
> which would be horrible.  Even if we could track all mainboard types and
> somehow update the kernel with all that info, you still need a way for embedded
> people to reconfigure it for their custom boards or whatever.  *That* is why
> we keep libsensors out of the kernel.  Not because of "if it can be done in
> userspace, it should" or any nonsense like that.)
> 
> A chip like uguru breaks this model, because we have *no* *idea* what it might
> be measuring at the *pin*.  But it turns out, it doesn't matter.  It's so
> tightly coupled to the mainboard that we can treat the whole thing as a "chip".
> The embedded case goes away (like I mentioned in another thread) because nobody
> is designing the uguru into custom boards anyway.
> 
> I hope this rationale for the kernel/userspace API is clear now.
> 

It is and always was, but as you say the uguru is a bit of a special case here.

I've got some good news about the fintek f77882fg / epox ep1308 chipb btw, my 
student (Hans Edgington) has returned the motherboard and last friday I build a 
system with it. I also compiled his driver and I've added / fixed reading of 
the voltages, There I'm doing exactly what you describe above, return a sysfs 
reading between 0 and 2.048 volts, and then let libsensors scale it depending 
on the attached divider circuit.

I still need to merge the patch for true fintek / msi board support and then 
I'll post an initial version.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
