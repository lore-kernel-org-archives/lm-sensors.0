From: linux@rick.claranet.de (Hartmut Rick)
Date: Tue, 28 Feb 2006 21:56:13 +0000
Subject: [lm-sensors] 2.6.15.1 Kernel patch for hardware monitoring
Message-Id: <Pine.LNX.4.63.0602282055090.3115@Laila>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0602272321260.3095@Laila>
In-Reply-To: <Pine.LNX.4.63.0602272321260.3095@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Hi Jean,

Thanks a lot for your detailed comments and advice.

On Tue, 28 Feb 2006, Jean Delvare wrote:
>
> I've just read the datasheet and noticed a few things which your driver
> may not always be handling properly. Please comment on the following
> points, and update your driver code where needs be.
> 
> 1* The LPC47M192 chip has two sampling modes, which can be selected using
> the bit 1 of register 0x4F. Currently your driver leaves the chip in the
> mode in which it was found. However, given that we do not allow the user
> to refresh the data more often than every 1.5 second, wouldn't it make
> sense to switch the device to "cycle mode" so as to save some power?
>

I have to admit that I've been a bit sloppy at my first attempt at the 
chip driver. I didn't bother to worry about power consumption, since
the hardware monitoring block needs typically 1.2mA at a voltage of 3.3V,
which makes a total of about 4mW. And it needs about half a second in 
order to complete all the conversions, so there is not much time during 
which it would not be active anyway.

But of course you're right, as long as we don't read it more often 
anyway we don't need it to sample more frequently.
I will change that.

There are more options, the sampling can be completed 8 times faster, with 
fewer conversions averaged. One could imagine to give the user access to 
configuration registers in order to choose these things. You could read 
the faster and (probably) noisier value and average in software in order 
to increase the resolution beyond the 1 degC level. I didn't plan to 
implement anything like this, though.


> 2* Bit 4 of register 0x4F may be used to make the second offset register
> (0x1F) apply to the internal temperature channel rather than the first
> external channel. If an external source (e.g. the BIOS) did this, then
> your driver will misbehave with regards to this offset register. A
> simple fix would be to create either temp1_offset or temp2_offset
> depending on the value of this bit.
>

Yes, I was wondering how to handle this one. If the user chooses to change 
the configuration bit, would this make the file temp2_offset disappear and
temp1_offset to appear instead?
Of course an option is to simply not allow her to change that bit.

After thinking about this question, a possibility could be to actually
create all 3 tempN_offset files. After all, the chip has the capability 
to add offsets to any of the temperature readings, just not to all of them 
simultaneously. The currently inactive offset reads as zero, and writing 
it with a nonzero value flips the configuration bit.
Thus writing a non-zero value to temp1_offset would reset temp2_offset 
to zero. Other than that, everything would work as expected, you can set 
an offset for any single temperature channel.
The configuration bit would not directly be accessible by the user.


> 3* The datasheet suggests that limits are left uninitialized at power-up.

You're right, I will add the initialization you're suggesting.


Concerning the naming scheme of temperature fault files:

>
> So at this point we have several possibilities:
> * Go with an alarms-like file, grouping by event and sensor type. If we
> follow the naming scheme, it would be named fault_temp.
> * Go with a status file, grouping by channel; it would be named
> tempN_status. We'd need to standardize the meaning of each bit, and
> update the pc87360 and fsc* drivers accordingly where needed.
> * Go with individual files: tempN_status_fault. These would hold boolean
> values (or almost-boolean if there are several possible fault cases).
>
> Each of these possibilities has advantages and drawbacks in terms of
> driver size, speed, and interface compatibility.
>
> My personal preference goes to the choice #3 (individual files)
> especially now that we have the dynamic sysfs callbacks in place. It's
> also convenient in the temperature sensor case as usually only some
> sensors will have a fault bit (external diodes). That being said, my
> previous attempt to define a standard sysfs interface wasn't exactly a
> success so I probably shouldn't be the one deciding.
> Comments/suggestions anyone?
>

I like the idea of having separate files. A coherent and flexible 
convention would be to call the files tempN_input, tempN_max, tempN_min, 
tempN_offset, tempN_alarm, tempN_fault, tempN_ ...
This makes a large number of files, but all features that involve the 
temp1 channel would start with temp1_*, so they would appear grouped in 
the directory listing. Without ever reading any documentation, just 
listing the directory contents you can probably guess what's in each of 
these files. 
A general userspace program can determine which files exist and thus which 
features this channel offers.
The file content would not necessarily need to be limited to one bit, so 
more than one kind of alarm or fault condition could be coded.

Now it seems that the alarms_temp file with one bit per channel has 
already been agreed upon, so the logical extension of this would be 
another file with the same bit assignment, called faults_temp.
I feel like faults and alarms are somehow similar concepts.
The disadvantage is that the file content does not allow to distinguish 
between 'no fault' and 'no information', the userspace program would have 
to obtain such information from some other source (configuration file?).


> >From your original post I had understood that temp1 and temp3 had
> offsets, rather than temp2 and temp3 as your code now has. Typo?

No, I really changed the numbering deliberately. The reason is that I've 
read the sysfs-interface documentation between my two posts :)
It says that temp1 is supposed to be the temperature on the sensor chip.
In the first version I had just ordered the channels by register address, 
so temp1 was CPU temperature.


> > +static ssize_t show_raw_alarms(struct device *dev,
> > +                     struct device_attribute *attr, char *buf)
> > +{
> > +     struct smsc47m192_data *data = smsc47m192_update_device(dev);
> > +     return sprintf(buf, "%u\n", data->raw_alarms);
> > +}
> > +static DEVICE_ATTR(alarms, S_IRUGO, show_raw_alarms, NULL);


You quoted this one but did not comment on it. I suppose you wanted to 
suggest to remove it?


I will implement all the other changes you suggested and send another 
patch, but I would prefer to do that after we agreed on the names and 
number of sysfs files.


Best wishes,
  Hartmut



