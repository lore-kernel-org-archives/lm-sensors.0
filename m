From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 01 Feb 2010 13:52:10 +0000
Subject: Re: [lm-sensors] API extensions (for IIO,
Message-Id: <20100201145210.5edea063@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B65CC6C.7070605@cam.ac.uk>
In-Reply-To: <4B65CC6C.7070605@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jonathan,

On Sun, 31 Jan 2010 18:31:08 +0000, Jonathan Cameron wrote:
> We recently proposed an API specification for parts of the Industrial I/O
> subsystem in a thread on LKML.  Greg KH pointed out that a we ought to, where
> sensible keep as close as possible to API's of existing subsystems.  To that
> end we are working on an updated version of the original document.
> (original at http://lkml.org/lkml/2010/1/20/195, please note it has changed
> a lot in response to comments made in that thread!)

I've read Greg's comment. I'm not quite sure I agree... IIO serves a
purpose which is clearly different from hwmon. The use cases are
different. Otherwise everyone would use hwmon and IIO wouldn't have to
support voltage and temperature inputs at all. So I don't think it
makes too much sense to make the new IIO API look like the hwmon one.
Learning from our mistakes, yes, certainly. But let's not get too far
into copying, otherwise we might lose the focus on the specific IIO
needs.

> The big difference from hwmon is that we very rarely export processed values
> to user space.  The fundamental reason for this is that our primary access to
> data is via ring buffer interfaces accessed through related character devices
> rather than direct access through sysfs.  Speed is of the essence and often
> processed values are not actually what is required in any case.  However,
> we do wish to provide sufficient information for a user space library to perform
> these calculations in the common case of a linear transform.
> 
> Anyhow, taking just voltage channels (ADC's) as a starting point we are looking
> at the following and would appreciate comments / suggestions from the hwmon
> community.
> 
> in0_raw     //raw access
> in0_offset  
> in0_gain    
> 
> (in0_value equivalent would be obtained from (in0_raw + in0_offset)*in0_gain)
> 
> In cases where all channels of type in share offset and gain we also allow (to
> reduce the large number identical sysfs entries):
> 
> in_offset
> in_gain

FWIW, we considered this for hwmon too, and finally decided to not
support this shortcut. The reasoning was that some chips have common
parameters for _some_ channels, but not all. Finding good sysfs file
names for such cases was challenging. To handle these cases, we decided
it was better to expose one separate file for each channel, and to make
all but first of each seat read-only. As this also covered the more
general case where all channels share a given parameter, we did not want
to create a special case for it, to make things more consistent and the
user-space library more simple.

Now I am not claiming that your case is similar. In particular, if you
intend to put the ADC's resolution in in_gain, then having a single
file for all inputs makes a lot of sense. But it should be possible to
override the general setting with a channel-specific one if needed
(e.g. for power sources which are internally scaled). Whether the final
gain in that case should be in_gain * inX_gain or just inX_gain, I
don't know.

> There are a couple of cases that I'm not sure how to sensibly handle, particularly
> differential pairs.  Here we want to indicate which input lines they refer to within
> the name and that we are dealing with a differential situation.
> 
> Ideas that come to mind for a case which is corresponds to (in0_raw - in1_raw) are
> 
> in0:1_raw
> diff0:1_raw
> in0-1_raw
> 
> What do people think is clearest?  Obvious, as per hwmon the vast majority of users
> are going to access this through a user space library, but it would still be nice
> to get a sensible human readable layout in sysfs.  Also note that there are a number
> of other elements associated with each channel, but I have left them out of this
> discussion to keep things simple (for now!) They are primarily to do with the ring
> buffer access and so do not overlap so much with hwmon other than in base naming of
> channels.

For hwmon, we have hidden the fact that a voltage could be the result
of a differential pair, so we did not have to come up with separate
names. This may not be suitable for IIO though, I'll let you decide.

I think I like the use of "-", as it makes it very clear which pin is
considered the negative one and which pin is considered the positive
one. Maybe in0-in1_raw would be even clearer? I can't find any fatal
flaw in the other proposals though. 

> Note that there is no intention of adding the option to use these new interfaces to
> hwmon, merely an intent to avoid introducing incompatible interfaces should this
> functionality become of interest in the future and to take advantage of the experience
> of the developers on this list.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
