From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 16 Apr 2007 05:28:43 +0000
Subject: Re: [lm-sensors] kernel/hwmon todo
Message-Id: <4623098B.703@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070415161302.GB3158@jupiter.solarsys.private>
In-Reply-To: <20070415161302.GB3158@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Hans:
> 
> * Hans de Goede <j.w.r.degoede@hhs.nl> [2007-04-15 21:46:07 +0200]:
>> Hi Mark, All
>>
>> First of all, Mark great to hear you're stepping in to become the Maintainer 
>> and many thanks for this.
>>
>> Mark M. Hoffman wrote:
>>> Hi everyone:
>>>
>>> Here's a list of kernel patches which are not in Jean's queue[1] and which need
>>> review.  I've only searched the mailing list archives back through March.  I'm
>>> sure I've missed some, or if there are updated patches available for any of
>>> these, please let me know.
>>>
>> I think you've missed the admXXXX driver backported from 2.4 which was posted a
>> while ago.
> 
> Err, I still can't find it.  Can you post a link please?
> 

Its here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-March/019094.html

>>> PATCH: hwmon-abituguru3-new-driver.patch: Add support for newer uGuru's
>>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-April/019433.html
>>> primary reviewer: Juerg Haefliger
>>>
>> The biggest problem with this patch currently is the discussion about the 
>> included chip model/revision/stepping table, which is (somewhat) needed because 
>> with the uguru being a software solution every motherboard essentially has its 
>> own version of the chip.
>>
>> Jean didn't like this much because he believes this kinda info belongs in 
>> userspace. I've given a long reply to a mail of Jean where I explain why I 
>> decided to put the table in kernelspace and that I still believe this to be the 
>> right decision. Unfortunately that mail has gotten 0 replies.
> 
> Yes, I remember skimming those discussions.  I will reread that more closely
> and reply in the appropriate thread... soonish.  Please be patient.  I can tell
> you now that I am inclined to allow such a patch to spend some time in -mm to
> either 1) work out the kinks of that approach, or else 2) demonstrate that
> userspace would be better.
> 

Ok, notice though that there are no real kinks either way its just a design 
decision really. I'm pretty sure there are no kinks with the current table in 
driver variant, as it has been tested by several people on several different 
mobo's.

As far as I can currently oversee the userspace variant, that shouldn't have 
any issues either, but IMHO is ugly as it creates sysfs files which aren't 
there which then will get picked up by the dynfs support, only to finally get 
ignored by ignore statements in sensor.conf, why create them in the first place 
then?

Anyways this has already been said in the appropriate thread. SO I'm looking 
forward to your reply there. Notice that the thread is "hidden" under the 
subject of "xxx_label sysfs file proposal" or something like that.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
