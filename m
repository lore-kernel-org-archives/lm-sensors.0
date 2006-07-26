From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 26 Jul 2006 15:11:30 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <44C78622.8060808@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Rudolf Marek wrote:
> 
> Hi Hans,
> 
> 
>> I was thinking about doing things differently with regards to userspace.
>> As I already posted to the list I'm working on a driver for the uGuru2.
>> The driver is done (waiting for feedback from testers) but I still need
>> todo userspace. Since the uGuru2 driver is going to be 2.6 only and
>> since 2.6 has a clear API/ABI between userspace and the kernel for hwmon
>> chips I was thinking about adding code to libsensors for generic 2.6
>> support. The idea is to write a piece of code which will come into
>> action only if libsensors doesn't have a chip definition for a found
>> chip and libsensors is running on a  2.6 kernel. This piece of code
>> would then fill a dynamicly allocated structure describing the unknown
>> chip, using the same structure as for known chips.
> 
> Yes this is in long term plan.
> 

I know it has been the long term plan for a while, my suggestion is to
write an intermediate solution for the short term (say within a couple
of weeks) this short term solution would only kick into action for new
chip drivers (like your k8 temp driver) leaving the behaviour unchanged
for chips currently already supported by libsensors (although the 2.6
only ones may be removed after thorough testing making libsensors smaller).

>> Does this sound like a plan With this in place we no longer need to
>> write support for every new 2.6 hwmon driver, actually if this goes in I
>> would like to see explicit support for the uGuru (1) be removed, since
>> this generic code should do just as good of a job.
> 
> Yes.
> 
> There are still questions if to rewrite the libsensors and allow LGPL or
> change libsensors to what you propose.
> 

I know, what I propose is not to wait for a decission but instead add
support for unknown 2.6 driven chips to libsensors, leaving things as is
for already supported chips. This way we no longer need to update
libsensors each time a new 2.6 driver is added. I've been planning to
write a patch for this evolutionary change for a while now. But first I
would like to see some people backing the concept, I don't like writing
code with 0%chance of getting it integrated upstream.

> I'm  leaving now for two weeks so please be patient with further answers
> from me.
> 

I know, this mail is meant for the whole list, not just for you. Have a
good vacation!

Regards,

Hans

