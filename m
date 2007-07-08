From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Jul 2007 19:18:08 +0000
Subject: Re: [lm-sensors] PATCH: hwmon-fscher-individual-alarm-files-v3.patch
Message-Id: <46913870.2000103@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468A3045.1010307@hhs.nl>
In-Reply-To: <468A3045.1010307@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 06 Jul 2007 17:17:41 +0200, Hans de Goede wrote:
>> This is version 3 (non incremental) of the patch adding individual alarm and
>> fault files to the fscher driver. This version automatically clears alarms
>> when the condition for them is gone, and adds tempX_max sysfs atrributes.
> 
> Hmm, your patch actually does 4 different things:
> * Add the individual alarm files.
> * Add the tempX_max sysfs atrributes.
> * Add (disabled) auto fan speed control trip points.
> * Use arrays to reference register addresses.
> 
> That's a bit too much for a single patch. For easier review and faster
> acceptance, you should split it into logical steps, each doing only one
> thing. See what I did recently for the w83627ehf and lm85 drivers. 
> 

Oh,

Come on, thats a bit over the top isn't it?

[hans@shalem ~]$ diffstat hwmon-fscher-individual-alarm-files-v3.patch
  fscher.c |  209 ++++++++++++++++++++++++++++++++++++++++++++-------------------
  1 file changed, 148 insertions(+), 61 deletions(-)

Thats hardly a big / complex patch. Besides that they are all intertwined:

 > * Add the individual alarm files.
As requested

 > * Add the tempX_max sysfs atrributes.
Reading tempX_max from the chip is needed to reset the alarms, as the chip 
doesn't do this itself. Exporting the userspace once read is only logical.

This is the result of you arguing (and me agreeing) that leaving resetting the 
alarms to userspace is very bad.

 > * Add (disabled) auto fan speed control trip points.
Thats just to document my findings while searching for the undocumented 
tempX_max registers, this is 6 lines in total, thats not worth a separate patch 
at all.

 > * Use arrays to reference register addresses.
Which is needed to implement the resetting of the fan and temp alarms sanely 
and thus is an integral part of the individual alarm files patch.

In the Netherlands we have a word for exercises like this its called 
"werkverschaffing" translated "work-providing". Please review the patch as is, 
I've got much better things todo then splitting up this absolutely reasonable 
sized patch (or arguing about splitting it up).

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
