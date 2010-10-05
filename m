From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 05 Oct 2010 10:16:30 +0000
Subject: Re: [lm-sensors] Accelerometer drivers in drivers/hwmon
Message-Id: <4CAAFAFE.7000002@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100925132330.4ee5e6a7@endymion.delvare> <20101004180333.GD8321@core.coreip.homeip.net>
In-Reply-To: <20101004180333.GD8321@core.coreip.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-input@vger.kernel.org, LM Sensors <lm-sensors@lm-sensors.org>, Takashi Iwai <tiwai@suse.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, Eric Piel <eric.piel@tremplin-utc.net>, Frank Seidel <frank@f-seidel.de>

Hi all,

I've cc'd a few more relevant people and linux-iio as the below
attribute discussion may result in minor changes there.
> Hi Jean,
> 
> On Sat, Sep 25, 2010 at 01:23:30PM +0200, Jean Delvare wrote:
>> Hi Dmitry,
>>
>> I would like to kick the following 5 drivers out of drivers/hwmon: ams,
>> hdaps, hp_accel, lis3lv02d and applesmc. These are primarily
>> accelerometer devices, so the drivers do not belong to hwmon.
>>
>> ams, hdaps, hp_accel and lis3lv02d don't even register a hwmon device.
>> They are pure accelerometer drivers as far as I can see. Would you take
>> them in drivers/input/misc?
>>
>> applesmc is more complex, it's a multifunction device. Maybe it would
>> better go to drivers/macintosh, where the other thermal management
>> drivers for mac machines live.
>>
>> If you don't want hdaps and hp_accel, they might also fit under
>> drivers/platform/x86. There are quite a few laptop-specific drivers
>> living there already.
>>
>> If nobody wants these drivers, drivers/misc is yet another option. I'm
>> open to suggestions. Virtually anything which moves these drivers
>> outside of drivers/hwmon will make me happy.
>>
> 
> I looked over the drivers and none of them (with possible exception of
> lis3lv02d) are pure input devices either. I think the best course of
> action would be to move ams, applesmc, hdaps and hp_accel into
> drivers/*/platform (I'd say drivers/x86/platform except that I think
> apple one might not be x86 only).
> 
> lis3lv02d could ether go into drivers/misc or stay where it is for the
> time being, pending resolution on overall IIO/Input/accelerometers
> decision. I'd take it in input/misc but accelerometer guys need to
> decide on common sysfs layout for such devices.
Actually not so much a problem for that driver seeing as it provides very
few sysfs interfaces...   Lets take a quick look at what is there and see
if we can resolve this question nice and quickly.

selftest - device specific so consistency doesn't matter - and it's a perfectly
	   good name anyway!

position  - (I suspect this is a somewhat misleading name)
	  I could be wrong but I doubt anyone is using this interface for
	  cases where they care if they get a consistent set of readings,
	  I'd advocate splitting that one up into three separate attributes.
	  Whilst a single attribute is just fine if you know exactly what the
	  device you are using is, it really doesn't generalize well to devices
	  that aren't 3d accelerometers or have addition sensor types.
	  We can quite happily maintain the 'position' interface as well though
	  for compatibility reasons.  I'd just add, accel_x_input, accel_y_input
	  and accel_z_input.

rate -  here we have a subtle and largerly irrelevant difference.
	IIO uses sampling_frequency but rate is just as valid.  We just came
	from a more data capture terminology whereas I guess rate is more common
	when considering data streams?  If I'm playing devil's advocate I guess
	rate might imply a data rate and hence people might interpret it as being
	in bytes per second.  Then again I'm sure sampling_frequency can also be
	misinterpreted!

This is a large complex driver which is definitely in input in a sense (even if
it is located elsewhere in the tree). Until someone is using one of these parts
in a circumstance where they need the other bits of IIO it doesn't to my mind
make sense to do a complete rewrite.  There are a lot of bells and whistles in
here that we would need to support that aren't even vaguely of interest for
things other than input usage.  These are very much input oriented devices
(supporting things like 'click' detection. Hence I'd encourage you to pick
this one up for input. The misc option is fine with me as well.

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
