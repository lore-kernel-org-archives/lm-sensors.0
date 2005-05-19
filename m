From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:48 +0000
Subject: i2c bit bashing adapter number allocation (fwd)
Message-Id: <3E519FE8.1070101@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301291323.h0TDNbZ16513@morannon.frodo.local>
In-Reply-To: <200301291323.h0TDNbZ16513@morannon.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

done. We didn't have OMAHA in CVS so now we have both.
mds


Cam Mayor wrote:
> Thank you, Mark!  I'm not sure if you got the number I want to add - the 
> OMAHA listing was an example i took from the linux-arm code.  The number i 
> wanted to add is given below (and is also included in a patch against 
> linux-2.4.19-rmk5 (and 6) on the arm-linux maintenance site).  Please add it 
> in if this isn't the number you added.  (the omaha one is also valid, but i 
> don't maintain it)
> 
> #define I2C_HW_B_GUIDE  0x15    /* Guide bit-basher                     */
> 
> thanks,
> cam
> 
> ps.  Do you know where Simon Vogel went?  Has he disappeared?  
> 
> On Sunday 16 February 2003 18:36, Mark D. Studebaker  wrote:
> 
>>I checked your ID into i2c CVS.
>>It will eventually get submitted to the kernel or feel free to include it
>>in one of your patches. mds
>>
>>Frodo Looijaard wrote:
>>
>>>Cam Mayor wrote:
>>>>From cmayor@iders.ca Wed Jan 29 01:25:05 2003
> 
> [headers snip]
> 
>>>After lots of digging, I found a lead to the answer to where to find an
>>>answer in the place i should have looked but didn't remember - the
>>>MAINTAINERS file.
>>>
>>>Simon, Frodo, do you have an opinion on where i should submit the
>>>following:
>>>
>>>On Tuesday 28 January 2003 17:34, Russell King - ARM Linux wrote:
>>>
>>>>On Tue, Jan 28, 2003 at 05:22:17PM -0600, Cam Mayor wrote:
>>>>
>>>>>In the file ./include/linux/i2c-id.h
>>>>>there is a list of bit-algorithm adapters and their associated
>>>>>sequential numbers.
>>>>>eg.
>>>>>	#define I2C_HW_B_OMAHA  0x14    /* Omaha I2C interface
>>>>>*/
>>>>>
>>>>>Are the numbers allocated in a first-come-first-serve (or
>>>>>first-to-propagate-patch-gets-it), or are they allocated in a more
>>>>>bureaucratic way?  I see nothing listed in ./Documentation/i2c about
>>>>>this, and i wish to add our hardware to the list.
>>>>
>>>>I have no idea; there appears to be no documented method for these IDs.
>>>
>>>I suspect this device will only be used for ARM linux, as it is
>>>bit-bashed from an ARM processor.  However, i don't want to have to
>>>continually be patching the device number.
>>>
>>>Russell, it looks like at least two of these allocations are present in
>>>the 2.4.19-rmk5 patch, so perhaps i should just submit this patch to you.
>>>
>>>I've added the two I2C maintainers to the mail to see if they have an
>>>opinion on whether i should submit the one-line patch to them or to
>>>submit it with the rest of the i2c code that i'm going to submit to the
>>>-rmk tree.
>>>
>>>cheers,
>>>cam
> 
> 
