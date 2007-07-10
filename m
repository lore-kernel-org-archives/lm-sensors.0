From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 10 Jul 2007 21:44:24 +0000
Subject: Re: [lm-sensors] fintek f71806f "support"
Message-Id: <4693FDB8.1050300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46913350.70300@hhs.nl>
In-Reply-To: <46913350.70300@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> 
> The F71805F has them there as well. Strange that the F71806F doesn't.

Maybe it does, but the datasheet is wrong / incomplete, in my experience that 
happens quite often (with Philips being one of the worst offenders).

> My f71805f driver doesn't use these registers yet though, so it's not a
> problem for now. But certainly something to keep in mind if we ever
> implement support for temperature offset registers in this driver.
> 

Thats good news then, but indeed something to keep in mind.

> Thanks for doing this datasheet comparison, it might prove useful in
> the future.
> 

Your welcome.

>> Notice that the identical device id means that sofar sensors-detect has been 
>> identifying the 71806 as a 71872, and most likely people have been loading and 
>> using the 71872 driver on this chip too, I assume that the 71872 driver uses 
>> the temp offset registers, and this could cause some troubles.
> 
> I'm not sure if there already are many F71806F chips in the wild. We
> did not have any request to support it, while we did have several
> requests to support the F71872F. But the fact that we did report both
> as a F71872F so far may explain it in part.
> 

>>                                                                 Unfortunately I 
>> haven't been able to find a way in the datasheets to find out which chip we are 
>> really dealing with.
> 
> As said above, the f71805f driver does not use these offset registers.
> If said offset registers are read-only on the F71806F, that would be a
> way to differentiate between both chips (arguably ugly, but...)
> 

Yes, but then again the F71806F may have those registers too.

> I just updated sensors-detect to mention the F71806FG. I also added
> detection for the F71862FG, now that its datasheet is available. And to
> be complete, I added an entry for the F71862FG to the Devices page on
> the wiki.
> 
Nice.

> Now, the f71805f driver (and documentation) would need to be updated to
> list the F71806F/FG as supported. Can you please submit such a patch,
> or do you want me to do it?
> 

Well since you are the maintainer of the f71805f driver, I think its best and 
easiest if you do it.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
