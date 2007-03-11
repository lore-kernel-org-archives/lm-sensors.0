From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 11 Mar 2007 19:53:43 +0000
Subject: [lm-sensors] libsensors patches
Message-Id: <45F45E47.6000703@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070311152104.bd092ff9.khali@linux-fr.org>
In-Reply-To: <20070311152104.bd092ff9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Axel Thimm wrote:
> On Sun, Mar 11, 2007 at 08:23:25PM +0100, Hans de Goede wrote:
>> Mark M. Hoffman wrote:
>>> Hi Hans:
>>>
>> <discussion about 3.0 versus increments snipped>
>>
>>> I don't agree.  I think the sum of changes we are planning does warrant the
>>> move to 3.0.  It will be easier than the alternative, e.g.:
>>>
>>> 	2.10.4 - drop support for 2.4.x proc file access
>>> 	2.10.5 - new API function
>>> 	2.10.6 - include command in config file
>>>
>> Okay, first of all this is me with my lmsensors-contributers hat firmly 
>> off and my packager maintaining over a 100 packages in Fedora hat firmly on:
>>
>> Lets try to split 2 things here, doing a 3.0 release to indicate some 
>> kinda milestone and breaking the ABI.
> 
> If /proc support gets dropped then it already breaks the ABI, since
> the ABI is not only about talking to the shared lib, but also to other
> interfaces as well.
> 
> If you still keep half the ABI in place by not touching API and soname
> of the lib, dependent projects will not notice the loss of /proc
> support until runtime.
> 

Agreed, thinking about this some more I'm not so sure that dropping 2.4 
support is a good idea as there is still plenty of 2.4 usage out there. 
An alternative would be to maintain both a 2.10 branch for 2.4 + 2.6 
users and a 3.0 branch for those who only use 2.6, but is the gain of a 
somewhat smaller, cleaner 3.0 branch worth the pain of maintaining 2 
branches. Also in this scenario I think we should keep them atleast API 
compatible from the application pov, as some distros may want to ship 
2.10 then while others ship 3.0. This is exactly why I've suggested to 
turn 2.4 support into an ifdef instead of ripping it out.

> So it looks like breaking the ABI "on purpose" might be just OK. The
> question is whether libsensors.so.3 and libsensors.so.4 would
> peacefully coexist on a non-packaging level to allow for a smooth
> transition.
> 

IOW, no sensors.conf format changes for example?

Regards,

Hans

