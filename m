From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Sun, 04 Mar 2007 20:22:09 +0000
Subject: [lm-sensors] Call for 2.10.3
Message-Id: <45EB2A71.4070206@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070303171327.186cd0f4.khali@linux-fr.org>
In-Reply-To: <20070303171327.186cd0f4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark M. Hoffman wrote:
> Hi Hans, Jean:
> 
> * Hans de Goede <j.w.r.degoede at hhs.nl> [2007-03-04 12:15:51 +0100]:
>>>> What about the:
>>>> -dynamic sysfs chip support
>>>> -get_sensor_type addition
>>>> -generic print suppoty in sensors the program
>>>>
>>>> A previous group of my students has been worming on, any chance some of 
>>>> those could make it, or maybe that we can start looking at them after 
>>>> the 19th?
> 
>> Jean Delvare wrote:
>>> I discussed this with Mark M. Hoffman and we agreed that this was
>>> lm-sensors 3.0 material. Mark is more or less in charge of the
>>> lm-sensors 3.0 tree, while I'm taking care of the current "stable"
>>> branch (2.10.x)
> 
> That said, I don't "own" the 3.0 branch.  Jean and I have offered commit access
> to you and your students for exactly the reason that our time is limited.  I
> have Bob's patches queued up, it's just that I lack the time right now.
> 
>> Hmm, that doesn't make me happy, I told my students to not do any API 
>> changes, as the idea was to get this into 2.x somewhere, as I don't see 
>> 3.0 happening anytime soon. Note that the all the patches only come into 
> 
> 3.0 was meant to happen following 2.10.3, or .4 at the latest.  July 2007.  I
> have not had spare cycles to spend on it yet this whole year, but I expect the
> pressures of my job to ease up by the end of this month.  
> 
>> play when libsensors / sensors doesn't know howto handle a chip, so for 
>> existing cases nothing changes. (although I plan to remove abituguru 
>> support from 2.10 when my students code has proven to handle that well, 
>> and the same could be done for other 2.6 only chips).
>>
>> Any chance you and Mark could reconcider, and this time do the 
>> discussion on the list so I get a chance to influence it?
> 
> Yes, we should probably send summaries of our occasional IRC discussions to
> the list.  On the other hand, if you look at the trak site, you will see the
> 3.0 milestone and everything I would like to do for it.
> 
> Do you think that July is too long to wait?  If so, what do you propose?
> 

I didn't know 3.0 was that close I thought that 3.0 was eons away, in 
that case integrating them into 3.0 seems like an ok plan. Will the 3.0 
libsensors be ABI compatible with 2.x ?

Also some of the libsensors 3.0 plans seem a bit of a huge undertaking 
for such a short time frame, taking into account how understaffed the 
project is.

In my view it would be best to stay with 2.x releases, or atleast ABI 
compatible releases and add the following:
1) dynamicly support new chips who use the standardized 2.6 sysfs
    interface
2) add a get_feature_type function
3) add generic printing routine to sensors for use with chips supported
    only through 1)
4) add an include statement to sensors.conf (might be handy for 5)
5) use DMI for sensors autodetect and autoconfig



I want 1-3 because most distro's update kernels way more often then 
libsensors and this way we can get support for new chips out there soon, 
also this will allow us to focus on writing drivers for new hardware 
without the (boring, repetitive) work of updating libsensors and sensors 
for each new driver.

I want 5 to make lm-sensors plug and play/ autodetected without any user 
configuration.

About svn commit access, I don not know the code all that well, none the 
less if its easier for you to let me commit stuff I think is good and 
then review the commits instead of reviewing patches I send to the list 
and having to apply them manually, then I have no problem with commmit 
access.

Regards,

Hans


