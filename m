From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 11 Apr 2007 13:49:08 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <461CE754.1010404@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hans,
> 
> On Mon, 09 Apr 2007 14:26:06 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> This is absolutely not different from all other hardware monitoring
>>> drivers. And all other drivers handle it in user-space, because that's
>>> the right design. I see no valid reason why it would be different for
>>> your abituguru3 driver. All you need is one configuration file per
>>> motherboard.
>> Actually it is _very_ different. The uguru is not a chip, its more a piece of 
>> software (looking from the driver POV) then a chip, thus sensors which aren't 
>> there really aren't there, they are not just unconnected pins, they _really_ 
>> aren't there.
> 
> You don't have to convince me that Abit "chips" are crap, I know that
> already ;)
> 

Actually they are quite nice, but unfortunately not documented. Being able to 
correctly provide all info to userspace without needing any further 
configuration / conversion is a feature. Also they tend to give very stable / 
non erratic readings.

> More seriously, I'm sorry but I just can't see the difference. Other
> hardware monitoring chips can have pins used for different functions.
> Their drivers have to create the sysfs files which match the hardware
> reality, and they do it in a motherboard-independent way. Your
> abituguru3 driver must do the same. If you can't get the wiring
> information from the hardware (or embedded software), this a major
> design flaw from Abit, or the price to pay for writing a driver for an
> undocumented device.
> 

I can get the wiring info from the chip and I do, thats why the motherboard ID 
register is there, in essence the abituguru 3 is a familiy of many different 
chips, with the motherboard ID register telling you the exact model of the 
chip. Think of it as a model/stepping/chip identification register instead of a 
motherboard id register if you must.

Once I know which model of the abituguru3 family the driver us running on, then 
I look at my table describing all the models of the abituguru3 chip family and 
in that way find out what features this model has and thus which sysfs entries 
to create.

> Remember how I told you months ago that I did not want us to support
> undocumented chips because I knew it would be painful? Here you are.
> 

Actually writing the driver has been pretty painless, defending the (in my mind 
completely sane) table approach OTOH indeed is painful.

>> And afaik some drivers have magic and or module options to not generate 
>> generate certain sysfs entries in certain cases, this is no different.
> 
> What kind of "magic" are you thinking of? Many drivers are reading
> their configuration registers to find out wiring information, but
> there's nothing magic about that.
> 

So is this one, its reading the configuration register which tells the driver 
which model/stepping we are running on.

> Oh, and of course the abituguru driver has lots of module parameters to
> control a whole lot of things. But you know about that one already ;)
> 

Yes the abituguru (rev 1/2) driver is a pain as the autodetect code doesn't 
work on revision 1 motherboards. I've been thinking about identifying the 2 
revision 1 motherboards using dmi and then those options will no longer be needed.

> Anyway, the main point here is that none of our drivers include
> motherboard-specific information. Except hdaps, granted, and it is a
> pain to maintain, which is why I don't want other drivers to do the
> same.
> 

I don't know about the hdaps driver, but I can promise you for the abituguru3 
this won't be a pain to maintain:
1) new motherboard gets released
2) download updated windows software
3) read ini file for new motherboard and add additional entry to table
    in abituguru3.c
4) done

>> Also this is they way how Abit handles this. The windows software comes with an 
>> ini-files, each named with the hex value of the ID, and that is used to 
>> determine how to talk to the uguru (which addresses to use) and what to ask.
> 
> So they have a user-space tool which reprograms the driver depending on
> the ID. This is quite different from what you proposed, isn't it?
> 

No they have a "driver" allowing port banging and do everything else in userspace.

>> Last but not least, this way (with libsensors-support and/or dyn chip support), 
>> the experience is truely plug and play, isn't that what we want in the end?
> 
> What we want is not to have to update the kernel drivers each time a
> new motherboard is released. Of course, the less effort is needed from
> the end user, the better, but this doesn't mean everything is in the
> driver. This might as well mean a better infrastructure in user-space,
> which is exactly what some of your students have been, and are, working
> on.
> 

Yes, and my previous students have been working on dyn chipsupport, which is 
meant to dynamicly build a list of features. What is the point in:
1) creating sysfs entries for features which aren't there
2) dynamicly creating a list of features for this chip in libsensors based on
    sysfs entries which then will contain features which aren't there
3) having to create / find / install through dmi magic a /etc/sensors.conf
    telling libsensors to ignore the features which aren't there?

Really I see no point in this. Actually when I use the generic printing 
routines with the k8temp driver and a stock /etc/sensors.conf I get 3 errors 
because my chip only has 1 temp sensor. Now if I comment the k8temp entry in 
lib/chips.c so that it uses the dyn chip code, then it will work fine out of 
the box with the generic print code. The k8temp specific print code works 
around this be silently ignoring get_feature errors.

This for example also happens with gkrellm compiled with libsensors support + 
k8temp + stock /etc/sensors.conf. With the static entry in lib/chips.c I get 4 
k8temp entries in gkrellm of which 3 show an error. With the dyn chip support 
it works as advertised. As the k8temp driver does the right thing and doesn't 
create sysfs entries for sensors which aren't there. Because in my vision, 
sysfs should represent the actual wiring of a chip as accurate as possible

When I wrote the abituguru3 driver I've thought about where to put this 
information for a couple of days before deciding todo things this way, here is 
my chain of thoughts as far as I remember it:

1) sysfs should represent the actual wiring of the chips as accurate as
    possible
2) for this I need a table with model/stepping/chip id's and per model which
    sensors are at which "addresses" and what type they have
3) since I need that table anyways I might as well at the conversion and
    label info, so that all this information is in one place

I think we agree on 1), you yourself said you're fine with this as long as this 
is done using chip configuration registers. So then the discussion becomes is 
the abituguru3 ID register a configuration register or not?

I say it is, I guess I should maybe change the text / kprints to make this 
clear. Actually I can proof that this register does not identify the 
motherboard but rather the sensor config / layout as both the "Abit AT8" and 
the "Abit AT8 32x" contain 0x0011 in this register (and have identical sensors) 
but they are 2 completely different motherboards, 1 uses the ati RD480 chipset 
and the other the ati RD580, see:
http://www.abit-usa.com/products/mb/techspec.php?categories=1&model09
http://www.abit-usa.com/products/mb/techspec.php?categories=1&model11

> With the approach you are advocating, I fear that pretty much
> every problem we might encounter (bug in the feature defintions, new
> motherboard model, new revision of a supported motherboard model,
> etc...) will take a driver update to solve. This is what I would like
> to avoid.
> 

I understand, but this is not a black and white issue. As said I believe that 
it is important that sysfs represents the actual wiring of the chips as 
accurate as possible. To me this is more important then having to update the 
driver for new motherboards now and then (its not like Abit does a new 
motherboard every month). Also the driver will simply refuse to work with newer 
motherboards atm, however it could be changed to just export all sensors for 
unknown motherboards as you want it todo for all motherboards, although I don't 
know if this is a food idea.

Regards,

Hans




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
