From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: 1250
Message-Id: <3EF7A5DE.7040004@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200306021011.37032.decibel8@charter.net>
In-Reply-To: <200306021011.37032.decibel8@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't have my lm_sensors source handy right now, but I wanted to reply 
so perhaps you or someone else could look into this...

I notice that the adapter is registered at address 6000.  That's a bit 
of a strange isa address.  I believe that the original ISA bus only has 
I/O addresses up to 3fff.  Anything above that is either an alias or a 
PCI bus address.

Perhaps there is a test in the ISA write function that makes sure the 
address you're attempting to write is in the range: 0-3fff or less and 
if not, returns an error.

If 6000 is an alias, then the "ISA" address would have been 2000...  I 
wonder why the VIA686A driver is looking for address 6000.  Perhaps that 
came from a PCI register programmed by the BIOS?  If so, then the 
VIA686A is really a PCI device and we need to generalize the isa 
driver's notion of I/O address space for PCI devices...

:v)

David wrote:
> On Sunday 22 June 2003 03:44 pm, you wrote:
> 
>>Well, the patch is either doing it's job or you didn't have the problem the
>>patch was designed to fix.  However, in either case, your problem lies
>>someplace else.
>>
>>The second _sysctl() call above would not have said "CTL_DEV" if you had
>>the problem the patch was designed to solve.
>>
>>However, we *do* see that the kernel is denying write access to the files.
>>(-1 EACCESS (Permission denied)) when attempting to set the limits.
>>
>>
>>>write(2, "via686a-isa-6000: Can\'t access /"..., 55) = 55
>>>write(2, "Run as root?\n", 13)          = 13
>>
>>Are you running "sensors -s" as root?  While you can read sensors as any
>>user, only root can write the limits.
>>
>>The output from 'ls -l /proc/sys/dev/sensors/via686a-isa-6000' might also
>>be interesting to see.
> 
> 
> 
> 
> root # ls -l /proc/sys/dev/sensors/via686a-isa-6000
> total 0
> -r--r--r--    1 root     root            0 Jun 22 20:50 alarms
> -rw-r--r--    1 root     root            0 Jun 22 20:50 fan1
> -rw-r--r--    1 root     root            0 Jun 22 20:50 fan2
> -rw-r--r--    1 root     root            0 Jun 22 20:50 fan_div
> -rw-r--r--    1 root     root            0 Jun 22 20:50 in0
> -rw-r--r--    1 root     root            0 Jun 22 20:50 in1
> -rw-r--r--    1 root     root            0 Jun 22 20:50 in2
> -rw-r--r--    1 root     root            0 Jun 22 20:50 in3
> -rw-r--r--    1 root     root            0 Jun 22 20:50 in4
> -rw-r--r--    1 root     root            0 Jun 22 20:50 temp1
> -rw-r--r--    1 root     root            0 Jun 22 20:50 temp2
> -rw-r--r--    1 root     root            0 Jun 22 20:50 temp3
> 
> 
> 
>>Are you running "sensors -s" as root?  While you can read sensors as any
>>user, only root can write the limits.
> 
> 
> Hmmm, hope your joking here. But I guess sometimes you do have to ask.
> 
> Dave
> 
> 



-- 
Philip Pokorny, Director of Engineering
Tel: 415-358-2635   Fax: 415-358-2646   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
