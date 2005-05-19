From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:57 +0000
Subject: CVS patch for lm85 fixes and EMC6D100 support
Message-Id: <20030530173734.GA19662@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3ED78579.9030203@penguincomputing.com>
In-Reply-To: <3ED78579.9030203@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 30, 2003 at 10:12:08AM -0700, Philip Pokorny wrote:
> I didn't think drivers you hadn't converted were in the 2.5 tree.
> 
> If you're asking for a sysfs converted version of the lm85 driver, I'd like 
> to, but I don't have the time right now.

Oops, sorry, I got that one mixed up with the it87 driver.  You are
correct, the lm85 driver isn't in 2.5 yet.

> I have been doing research into sysfs and sub-directories and alternate 
> implementations of sysfs support.
> 
> Some observations:
> 
> 1. The sysfs documentation implies that you *can* group multiple things 
> into a single sysfs attribute.  So we could create attributes like:
> 
>     temp
>     temp_min
>     temp_max
>     fan
>     fan_min
> 
> That would contain lists of the relavent values (temp1, temp2, temp3 or 
> temp1_min, temp2_min, temp3_min, etc...)  This would reduce the number of 
> attributes at the expense of a more complicated attribute function.

Yes, but doing a write would be difficult too.  I suggest just sticking
with the current one value per file.  It makes things a lot easier for
userspace that way.

> With regard to sub-directories, the sysfs implementation makes 
> sub-directories both easy and hard.

There is upcoming support for the driver model to make subdirectories
much easier to create and handle.  This has been a known problem for a
while.

> I'm worried about the libsensors implementation for 2.5/2.6.  The switch to 
> sysfs will mean a radical change to the libsensors implementation.  This 
> may be a good time to address a number of issues (duplicated code in 
> libsensors and prog/sensors, inflexible formating, integration of 
> sensord/rrdb, etc) if we have to do a major re-write of the libsensors and 
> sensors code.  Has anyone given any thought to this?

I've looked at this, and agree, a radical change to the libsensors
implementation seems to be in order.  I haven't spent any serious time
yet on this, but will have the time after 2.6.0 comes out.

> ******
> But if the lm85 code is already in the 2.5 tree and I need to do a seperate 
> diff against that code, I'd be happy to do that if I can do that diff 
> against the bitkeeper cvs copy...

Heh :)

thanks, and again, sorry for mixing up the driver names...

greg k-h
