From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: CVS patch for lm85 fixes and EMC6D100 support
Message-Id: <3ED790E8.9090807@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED78579.9030203@penguincomputing.com>
In-Reply-To: <3ED78579.9030203@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I didn't think drivers you hadn't converted were in the 2.5 tree.

If you're asking for a sysfs converted version of the lm85 driver, I'd like 
to, but I don't have the time right now.

I have been doing research into sysfs and sub-directories and alternate 
implementations of sysfs support.

Some observations:

1. The sysfs documentation implies that you *can* group multiple things into a 
single sysfs attribute.  So we could create attributes like:

     temp
     temp_min
     temp_max
     fan
     fan_min

That would contain lists of the relavent values (temp1, temp2, temp3 or 
temp1_min, temp2_min, temp3_min, etc...)  This would reduce the number of 
attributes at the expense of a more complicated attribute function.

With regard to sub-directories, the sysfs implementation makes sub-directories 
both easy and hard.  If a driver were to use the kobject and klist 
infrastructure, then sysfs will map those to sub-directories "automatically" 
But the overhead for a kobject or klist seems significant compared to the 
actual data being managed (generaly only a single byte per attribute). 
Subdirectories that are not associated with a kobject should be possible, but 
the sysfs assumed mapping of kobjects to directories makes it somewhat 
complicated to implement.  (I suppose if it was simple, it would have already 
been done...)

I'm worried about the libsensors implementation for 2.5/2.6.  The switch to 
sysfs will mean a radical change to the libsensors implementation.  This may 
be a good time to address a number of issues (duplicated code in libsensors 
and prog/sensors, inflexible formating, integration of sensord/rrdb, etc) if 
we have to do a major re-write of the libsensors and sensors code.  Has anyone 
given any thought to this?

******
But if the lm85 code is already in the 2.5 tree and I need to do a seperate 
diff against that code, I'd be happy to do that if I can do that diff against 
the bitkeeper cvs copy...

:v)

Greg KH wrote:

> On Fri, May 30, 2003 at 09:23:21AM -0700, Philip Pokorny wrote:
> 
>>This patch fixes a race condition in the lm85 driver and adds support for 
>>the SMC EMC6D100 and EMC6D101.  The EMC6D100 and 101 chips have some 
>>additional features that *are not* currently implemented in the driver, but 
>>the chip is detected (by sensors-detect and the lm85 driver).
>>
> 
> Nice, care to make a 2.5 patch too?
> 
> thanks,
> 
> greg k-h
> 

