From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: Query on apparently 'disconnected' sysfs interfaces
Message-Id: <7k6n31lmkvc46g70299f82mic0n3qro55a@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
In-Reply-To: <pa6k311f7c2hhul35cifmso9g54ovrnu8c@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 18 Mar 2005 22:33:48 +0100, Jean Delvare <khali@linux-fr.org> wrote:

>> alarm_mask	< beep_mask?  I'd like to have alarm_mask
>
>Beep mask and alarm mask are different things. Alarm mask lets you
>ignore an alarm completely. Beep mask preserves the alarm but masks the
>associated beeping.
>
>If alarm_mask isn't documented, it should - except that it should be
>alarms_mask.
Okay, group with alarms_in and alarms_temp
>
>> analog_out
>> aout_output	< analog_out ?
>> out0_output
>
>This is the same thing. If we follow the naming convention for the other
>channels, the correct one would be out0_output. Should be documented,
>and drivers using analog_out and aout_output should be fixed.
okay, but I prefer analog in name because some drivers have digital 
out -- GPIO pins. analog0_out?  Any chips out there with multi-channel 
DAC's?  Currently we have three chips with a single analog_out:
lm87, adm1026 and adm9240 (so far).

>> die_code
Some drivers need it internally, previously Khali suggested 
printing chip revision value on detection for user.  
>
>Should probably be dropped (useless), but see below.
>
>> in1_ref
>> vid		< cpu0_vid?
>
>Both should cpu0_vid, drivers need to be fixed.
>
>> fan1_auto
>> gpio
>> gpio_mask
>> out0_enable
>> temp1_crit_enable
>> temp1_hyst
>> temp1_min_hyst
>
>I see nothing wrong with these. Remember that sysfs-interface documents
>the names for standard interface files. When a drivers has additional
>needs, it is free to use additional names. These might be standardized
>and documented later if other drivers also need the same.
They are 'odd ones out', and yes for complicated chips.

>The rule is that undocumented file names can be arbitrarily changed
>afterwards when a standard is established and documented. Documented
>file names should not change.
Okay
>
>> At this point in time I'm quite happy to document and cross-reference 
>> current practice, but I don't want to duplicate a work-in-progress.
>
>Nobody is working on this at the moment. We'd welcome patches fixing
>drivers that use incorrect file names, and documentation updates.

And append following to Documentation/i2c/sysfs-interface?

See Also:
Documentation/filesystems/sysfs.txt
Documentation/driver-model/device.txt

 - - - 
Making more sense the more I read, the first file above explains 
DEVICE_ATTR() thus creating the missing link to dev_attr...  I 
was looking for.  Doh!

The gobbledygook in the middle of the driver I was working on 
makes a lot more sense now, plus other reply this thread (Mark). 

Thanks all for help, I hope you've enjoyed this newbie's bafflement 
at going beyond applying patches to, and compiling, the kernel  :o)

Philip wrote:
>I suppose that's why you're adding cpu0_ to the name, but the existing 
>practice is clear that the vast majority of monitoring chips use the 
>name 'vid'.  (Which driver uses in1_ref?)  Changing to cpu0_vid or 

adm1025.c
static ssize_t show_vid(struct device *dev, char *buf)
{
        struct adm1025_data *data = adm1025_update_device(dev);
        return sprintf(buf, "%u\n", vid_from_reg(data->vid, data->vrm));
}
static DEVICE_ATTR(in1_ref, S_IRUGO, show_vid, NULL);

thus not meet maintainer's guideline for vid public reporting.

>cpu1_vid would seem to be a major change which should not be undertaken 
>lightly since this is likely to be one of the values *most* referenced 
>by user scripts and applications.

Driver's private data uses vid, I've yet to cross-reference drivers 
to public sysfs interface, which seems a useful learning exercise in 
itself for me, as well as producing a list of current usage.

Special exceptions and the misfit fixup list is a judgement call 
I'll not be making.  Got to leave a little work for the maintainer? :)

Cheers,
Grant.
