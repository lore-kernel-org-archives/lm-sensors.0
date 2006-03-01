From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 01 Mar 2006 11:21:31 +0000
Subject: [lm-sensors] 2.6.15.1 Kernel patch for hardware monitoring
Message-Id: <kaOO0buc.1141212091.3279100.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602272321260.3095@Laila>
In-Reply-To: <Pine.LNX.4.63.0602272321260.3095@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Hartmut,

On 2006-02-28, Hartmut Rick wrote:
> > 1* The LPC47M192 chip has two sampling modes, which can be selected
> > using the bit 1 of register 0x4F. Currently your driver leaves the
> > chip in the mode in which it was found. However, given that we do not
> > allow the user to refresh the data more often than every 1.5 second,
> > wouldn't it make sense to switch the device to "cycle mode" so as to
> > save some power?
>
> I have to admit that I've been a bit sloppy at my first attempt at the
> chip driver. I didn't bother to worry about power consumption, since
> the hardware monitoring block needs typically 1.2mA at a voltage of
> 3.3V, which makes a total of about 4mW. And it needs about half a second
> in order to complete all the conversions, so there is not much time
> during which it would not be active anyway.
>
> But of course you're right, as long as we don't read it more often
> anyway we don't need it to sample more frequently.
> I will change that.

Your analysis is correct and I admit it won't change that much the
overall power consumption. But every saving we can get for free is good,
so let's do it still.

> There are more options, the sampling can be completed 8 times faster,
> with fewer conversions averaged. One could imagine to give the user
> access to configuration registers in order to choose these things. You
> could read the faster and (probably) noisier value and average in
> software in order to increase the resolution beyond the 1 degC level.
> I didn't plan to implement anything like this, though.

I see little point in the fast sampling mode due to our register cache
implementation. Averaging in software is not buying you anything. In
continuous mode you don't even save power. In cycle mode, the averaging
won't work (sample frequency being too low.)

So I wouldn't provide the user with an option to change the averaging
mode.
Just keep the mode your found the chip in, so as to preserve possible
BIOS settings. The power-on default is averaging enabled, which is what
we want.

> > 2* Bit 4 of register 0x4F may be used to make the second offset
> > register (0x1F) apply to the internal temperature channel rather than
> > the first external channel. If an external source (e.g. the BIOS) did
> > this, then your driver will misbehave with regards to this offset
> > register. A simple fix would be to create either temp1_offset or
> > temp2_offset depending on the value of this bit.
>
> Yes, I was wondering how to handle this one. If the user chooses to change
> the configuration bit, would this make the file temp2_offset disappear and
> temp1_offset to appear instead?
> Of course an option is to simply not allow her to change that bit.
>
> After thinking about this question, a possibility could be to actually
> create all 3 tempN_offset files. After all, the chip has the capability
> to add offsets to any of the temperature readings, just not to all of them
> simultaneously. The currently inactive offset reads as zero, and writing
> it with a nonzero value flips the configuration bit.
> Thus writing a non-zero value to temp1_offset would reset temp2_offset
> to zero. Other than that, everything would work as expected, you can set
> an offset for any single temperature channel.
> The configuration bit would not directly be accessible by the user.

It might be a bit confusing to the user that setting a value arbitrarily
kills another value. Given the little interest of the feature in the
first place, I would go for the more simple approach of keeping the
default/BIOS setting, and only create either temp1_offset or
temp2_offset at driver load time, not allowing the user to change it
afterwards. But the decision is really up to you, I don't care that
much.

> Concerning the naming scheme of temperature fault files:
> (...)
> I like the idea of having separate files. A coherent and flexible
> convention would be to call the files tempN_input, tempN_max, tempN_min,
> tempN_offset, tempN_alarm, tempN_fault, tempN_ ...
> This makes a large number of files, but all features that involve the
> temp1 channel would start with temp1_*, so they would appear grouped in
> the directory listing. Without ever reading any documentation, just
> listing the directory contents you can probably guess what's in each of
> these files.
> A general userspace program can determine which files exist and thus which
> features this channel offers.

This was the whole point of the sysfs interface in the first place, but
we failed for some points, in particular the chip status
(alarm/fault/beep etc.) :( Good if we can get it right for the
smsc47m192 driver right away.

> The file content would not necessarily need to be limited to one bit, so
> more than one kind of alarm or fault condition could be coded.

True. This is how the _status files are working in pc87360 and fsc*,
except that the meaning of each bit should be standardized across all
driver. Also, a difference is that _status files were grouping alarms
and faults, while you propose separate files.

> Now it seems that the alarms_temp file with one bit per channel has
> already been agreed upon, so the logical extension of this would be
> another file with the same bit assignment, called faults_temp.
> I feel like faults and alarms are somehow similar concepts.
> The disadvantage is that the file content does not allow to distinguish
> between 'no fault' and 'no information', the userspace program would have
> to obtain such information from some other source (configuration file?).

The alarm_temp/_in/_fan files is something very recent and mostly mine -
not really something that was collectively agreed upon. It was just not
collectively disagreed upon ;) I introduced that as the most simple
change to convert arbitrarily ordered alarm files we had before, to a
chip-independant alarm representation. If we move to individual files,
fine with me, as the aim is the same (chip-independant interface). Note
that there is nothing preventing both representations to coexist for
some time so we can move from one to the other relatively smoothly.

> > From your original post I had understood that temp1 and temp3 had
> > offsets, rather than temp2 and temp3 as your code now has. Typo?
>
> No, I really changed the numbering deliberately. The reason is that I've
> read the sysfs-interface documentation between my two posts :)
> It says that temp1 is supposed to be the temperature on the sensor chip.
> In the first version I had just ordered the channels by register address,
> so temp1 was CPU temperature.

Ah, this comment is somewhat misleading. It is (or was) referring to the
most frequent natural order from a hardware point of view, and it
happens that the drivers usually follow the hardware order. This comment
was not meant as an invitation to reorder the temperature inputs at the
driver level. So this order is really up to you; whatever makes the
driver easier to write or makes more sense to you.

I'll go fix that comment, it's not even relevant with recent chips
design.

> > +static ssize_t show_raw_alarms(struct device *dev,
> > +                     struct device_attribute *attr, char *buf)
> > +{
> > +     struct smsc47m192_data *data = smsc47m192_update_device(dev);
> > +     return sprintf(buf, "%u\n", data->raw_alarms);
> > +}
> > +static DEVICE_ATTR(alarms, S_IRUGO, show_raw_alarms, NULL);
>
> You quoted this one but did not comment on it. I suppose you wanted to
> suggest to remove it?

Ah, yes, you're right, that's exactly what I wanted to suggest.

> I will implement all the other changes you suggested and send another
> patch, but I would prefer to do that after we agreed on the names and
> number of sysfs files.

Sure. It seems that we both agree on the superiority of the individual
files approach, so you can go with that and we'll see how the code
looks like. It should be quite elegant, and you may even be able to have
a single callback for all individual alarm and fault files. Just set the
integer value associated to each file to the bit position in the status
word, and that should do it. If it works well in your driver, it'll be
a clear indication that most other drivers can be converted in the same
way (even if we keep the old "alarms" file for compatibility reasons.)

If you have more questions, or if I have not been clear on some point,
just tell me.

Thanks,
--
Jean Delvare

