From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 19 Jun 2007 08:31:01 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <46779445.9030202@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Sat, 16 Jun 2007 21:50:20 +0200, Hans de Goede wrote:
>> Mark M. Hoffman wrote:
>>> There is another way to look at it: the uguru3 is not a single chip, it is a
>>> *family* of chips.  With that model, we would end up with a compromise between
>>> your positions that has precedent in other drivers.
>>>
>>> I.e. Append the motherboard ID to the chip name, and also use that to create
>>> the needed sysfs files.  Voila, you don't need "label" sysfs files anymore
>>> because you can put a section in sensors.conf for each variant of uguru3.
>>>
>>> It's not that I'm against the label files per se.  But IMHO this suggestion
>>> is the closest fit to the existing model of operation.
>> I could do that, actually making the ID available in some way to userspace is a 
>> good idea, however I'm still in favor of the fooX_label approach because:
>>
>> 1) The driver will need the table it currently has no matter what, to determine
>>     which inputs the model / this specific member of the family has, and at
>>     which addresses these inputs reside and what type they have.
> 
> Agreed to some extent, but see below.
> 
>>     Since the table is already there, I might as well at the labels there and
>>     have all info in a single place = less maintainance / no sync problems
> 
> Not agreed. A few posts before in this thread, you were writing: "its
> not like Abit does a new motherboard every month", to explain that it
> wasn't a problem that adding support required patching the kernel. And
> now you explain that putting everything in the kernel (rather than
> having a part in user-space) is better for exactly the opposite reason.
> That's not fair.
> 
> Quite frankly, once the user has gone through the pain of upgrading
> his/her kernel, I doubt that changing a user-space configuration file
> will frighten him/her much.
>

However most user don't go through this pain themselves, the just get a kernel 
update from the distro, atleast one distro I know of (Fedora) syncs its kernel 
to upstream quite regulary, even for the stable release.

This whole argument is about making things "just work" (tm), with the table in 
the driver, dynchip support + generic chip printing, when a user gets a new 
kernel (through yum update) which comes with support for this motherboard, then 
things will "just work" and yes I plan to add support for foo#_label to the 
libsensors 3.0.0 code.

You agree below that the table is needed, but can be made smaller. However if 
the table is needed, then things automatically will not work for a newer 
motherboard without a new kernel. Thus lets make things so that only a newer 
kernel is needed and nothing else. Also it is very important to me to keep all 
info in one place as this is way easier to maintain. So if we need a table lets 
put everything in there.

>>                     but I see big pain (mainly for me) in having to maintain the 
>> needed table partly in the driver and partly in sensors.conf, since the driver 
>> will need a table anyways, why not put all the info in one place?
> 
> First of all, the current version of libsensors doesn't support
> driver-provided labels yet. So your proposal implies that we implement
> this first, otherwise your driver will not work properly.
>

Yes I plan on implementing this in the 3.x tree.

> One reason (not to put everything in the driver) is to keep the driver
> small. Currently, the description table in your abituguru3 driver
> accounts for more than 55% of the total driver size [2]. Most of the
> size is for the labels and scaling factors as far as I can see.
> 

1) Abit motherboards are not used in embedded setups so 13K of code is
    neglectible.
2) If this really is seen as an issue, all of the table, except for the entry
    of the detected motherboard can be freed after init.

> Also, sysfs files have a cost. I find it funny that you were arguing
> against individual alarm files a few months ago because you didn't want
> too many sysfs files to be created, and now you want to create a label
> file for every input.
> 

Well you yourself have argued / shown that the price of sysfs files is small, 
so I say this argument is mute.

> Lastly, note that users will need a configuration file anyway, if they
> want to set limits, or ignore some input, or change labels because the
> driver-provided ones don't please them.
> 

Yes, power users may need one, more power to them, in the mean time lets try to 
make things easier / "just work" for normal users.

>> I've feeling we're arguing about 2 different things at once here, so here is a 
>> try to split them:
>>
>> 1) do we want foo#_label sysfs entries for devices were we can give a sensible
>>     label to userspace, like cpu temp drivers
> 
> Note that my original intention with foo#_label sysfs entries was
> slightly different. My plan was to use them only when the driver can
> give a sensible label _and_ user-space can't. In the case of the k8temp
> driver, for example, we decided _not_ to create label files, because
> these labels would have been always the same, so user-space can do it
> just as well.
>

Actually I think the k8temp driver should provide tempX_label,
what if a dual core processor with only one tempsensor per core shows up?

Does the sensor in the second core then gets called temp3, thus temp2 gets 
skipped to match the labels currently in sensors.conf? What about quad core's?

Howto differentitatie between multiple core's in one die, and multiple sockets?

Also the current k8temp setup is broken, as with 2.10.4 with the default 
sensors.conf it will print 3 missing temp errors in gkrellm as libsensors says 
there are 4 temp sensors, thus one needs to add ignore lines for 3. With 
dynchip support this problem will no longer exist, and when combined with 
foo#_label files and PCI-id based k8temp loading (already happening) this will 
make the end user experience truely plug and play, which is exactly what we want.

---

Yet another problem, is that I can currently add support for new abituguru3 
motherboards as soon as abit releases a new windows uguru software supporting 
them. With your approach, to get plug and play support dmi based config will 
have to be integrated (planned) and then I need to wait for a user to contact 
me with the dmi strings for this new motherboard, only then can I get a new 
mobo truely supported. So the chain changes from:

-New mobo release
-Download windows software, add info to kernel driver table
-As soon as user gets new kernel through distro everything will work

to:

-New mobo release
-Download windows software, add info to kernel driver table
-Wait for user to start complaining that things don't work
-Ask dmi strings
-Add dmi strings + hand written config file to dmi - configfile database
-User must get both new kernel and new config-file database through distro,
  before things start to work.

Notice how the second scenario contains all the steps of the first + many more 
steps.

---

To be honest I'm getting somewhat sick about this discussion. Having all the 
info in the driver is just easier for both the end-user and the driver maintainer.

Your only argument OTOH is it doesn't fit with our current practices well I say 
<beep> our current practices. Our current practices are actually pretty broken 
in many aspects. For example the whole libsensors needing to know about chips 
instead of querying the driver for what the chip can do was a serious design 
mistake from day one.

You're acting as if I'm breaking the kernel/userspace ABI or something as holy 
as that, which I'm not even close too. All I'm trying is to make things just 
work for the end user, and really the easiest way todo that is to have all the 
needed info in one place. Fragmenting this info can only lead to problems where 
  sensors.conf and the driver get out of sync. For example what happens when 
the in kernel driver table skips the temp sensor with address 25 because that 
seemed right and later that turns out to be a bug? Then all tempX with X > 1 
will become temp(X+1), with all the info in the driver, things will still work 
fine, with things spit, all the labels but for temp1 will be wrong.

Scattering all this info around over many files is just wrong, just as wrong as 
  libsensors not using a query the chip for what it can do model from day one.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
