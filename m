From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 07 Oct 2007 15:04:53 +0000
Subject: Re: [lm-sensors] Call for 2.10.5
Message-Id: <4708F595.6080602@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007114017.27909e43@hyperion.delvare>
In-Reply-To: <20071007114017.27909e43@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Sun, 07 Oct 2007 14:08:46 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Hi all,
>>>
>>> lm-sensors 2.10.4 is 3 months old now, so we should think about
>>> releasing 2.10.5. There are no big changes, as expected in a stable
>>> branch, but a good load of bugfixes. Proposed schedule:
>>>
>>> * October 10th: SVN freeze
>>> * October 11th-14th: testing
>>> * October 15th: release
>> <ugh> thats awefully short notice.
> 
> The release date of 2.10.5 has been set to October 16th long ago:
> http://www.lm-sensors.org/milestone/2.10.5
> 

Ah, I never look there, I'll try to take a peek there now and then from now on.

>> Alternatively I could test for the readability of SENSORS_FSC***_TEMP1_STATE 
>> and switch between the code for the old driver and new to be written code for 
>> the new driver, that might be better as it will also reduce the chance of 
>> regressions.
> 
> My point exactly :)
> 

Yes,

After writing all the stuff snipped above, pressing enter and giving it a 
second thought, I've come to the conclusion that this way is both the easiest 
and the best.

I'm working on integrating your driver review changes now (so that I can test 
tomorrow when I have access to the actual hardware) and then I'll start working 
on a userspace patch.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
