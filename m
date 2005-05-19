From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: 1250
Message-Id: <3EF61518.6060703@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks!

See comments below...

David wrote:

> Philip,
> 
> 	Got the trace done for you. It isn't that big so will just paste the results here.
> Results:
> *******************************************************************************************

> _sysctl({{CTL_DEV, 2, 100, 3e8}, 4, 0x4003b300, 12, (nil), 0}) = 0
> _sysctl({{CTL_DEV, 2, 100, 3e8}, 4, (nil), 1074751684, 0x4003b300, 4}) = -1 EACCES (Permission denied)
> _sysctl({{CTL_DEV, 2, 100, 3e8}, 4, 0x4003b300, 12, (nil), 0}) = 0
> _sysctl({{CTL_DEV, 2, 100, 3e8}, 4, (nil), 1074751684, 0x4003b300, 8}) = -1 EACCES (Permission denied)


Well, the patch is either doing it's job or you didn't have the problem the 
patch was designed to fix.  However, in either case, your problem lies 
someplace else.

The second _sysctl() call above would not have said "CTL_DEV" if you had the 
problem the patch was designed to solve.

However, we *do* see that the kernel is denying write access to the files. 
(-1 EACCESS (Permission denied)) when attempting to set the limits.

> write(2, "via686a-isa-6000: Can\'t access /"..., 55) = 55
> write(2, "Run as root?\n", 13)          = 13


Are you running "sensors -s" as root?  While you can read sensors as any user, 
only root can write the limits.

The output from 'ls -l /proc/sys/dev/sensors/via686a-isa-6000' might also be 
interesting to see.

:v)

> *********************************************************************************************************************
> 
> Need anything else, just give me a holler.
> 
> David
> 
> 
> On Friday 20 June 2003 07:20 pm, you wrote:
> 
>>I'm glad you were able to apply the patch.
>>
>>The via686a is on the ISA bus.  That may be changing the "corruption"
>>that happens when we attempt to read from /proc.
>>
>>David, can you please run:
>>
>>    strace -o /tmp/sensors.strace sensors -s
>>
>>And then send me (or the list) the file /tmp/sensors.strace that will be
>>created.  I'd like to see the system calls and more detail about the
>>error before we decide to back out the patch.  It definitely does solve
>>a problem for some people...
>>
>>Thanks,
>>
>>:v)
>>
>>DAVID wrote:
>>
>>>>Do you by any chance have any additional patch to your kernel, such as
>>>>GRSEC or ACL?
>>>>
>>>If your asking me I don't believe so. Even if I do I don't have GRSEC
>>>set in the kernel.
>>>
>>>
>>>On Fri, 20 Jun 2003 08:35:43 +0200
>>>
>>> Jean Delvare <khali@linux-fr.org> wrote:
>>>
>>>>>2)  Installed fine. Tried several things. Still get same error. I
>>>>>restarted lm_sensors and rebooted. Still:
>>>>>#sensors -s
>>>>>via686a-isa-6000: Can't access /proc file for writing;
>>>>>Run as root?
>>>>>
>>>>OK, so the patch doesn't work. Or, at least, it doesn't fix *that*
>>>>problem. Philip, should we remove the fix from CVS?
>>>>
>>>>Do you by any chance have any additional patch to your kernel, such as
>>>>GRSEC or ACL?
>>>>
>>>>--
>>>>Jean Delvare
>>>>http://www.ensicaen.ismra.fr/~delvare/
>>>>
>>><TEXTAREA NAME="Signature" ROWS="4" COLS="60">
>>>
> 

