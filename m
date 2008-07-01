From: Justin Piszcz <jpiszcz@lucidpixels.com>
Date: Tue, 01 Jul 2008 19:08:24 +0000
Subject: Re: [lm-sensors] Intel DG965WH / Case 745-44-22 (slow bios/upgrade)
Message-Id: <alpine.DEB.1.10.0807011506450.18141@p34.internal.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.1.10.0806300958070.13171@p34.internal.lan> <alpine.DEB.1.10.0807011442500.18141@p34.internal.lan> <200807011158.46258.jesse.barnes@intel.com>
In-Reply-To: <200807011158.46258.jesse.barnes@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jesse.barnes@intel.com>
Cc: "crmotherboard@mailbox.intel.com" <crmotherboard@mailbox.cps.intel.com>, "Williams, Dan J" <dan.j.williams@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Anas Nashif <anas.nashif@intel.com>



On Tue, 1 Jul 2008, Jesse Barnes wrote:

> On Tuesday, July 01, 2008 11:43 am Justin Piszcz wrote:
>>> This is from 2007:
>>> http://softwareblogs.intel.com/2007/04/13/intel-me-interface-heci-now-ava
>>> ilable/
>>>
>>> Their updated project page:
>>> http://www.openamt.org/
>>>
>>> Justin.
>>
>> The issue regarding accessing the hard drive menu was fixed by simpling
>> power cycling/rebooting the host.
>
> And the problem hasn't come back?
Correct, after several reboots, the problem has not come back, I can 
access the HDD part of the BIOS w/out any issues.

>
>> All issues are now resolved (regarding the slow speed/memory/etc)..
>
> Hopefully there's a more recent BIOS available that doesn't need to trim the
> memory for you?
Erm, that is what I am trying to get across, version 1738 of the BIOS has 
successfully solved the memory mapping/non-cachable memory issue.

>
>> Only other question left is the HECI support in the kernel.
>
> I'll defer that question to Anas, he's been handling the HECI stuff.
Thanks, a lot of people are probably curious where this is heading as 
well, as it impacts purchasing decisions of people and whether one should 
buy an Intel board if one cannot monitor the sensors on it (voltages/fan 
speeds, etc)..

>
> Jesse
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
