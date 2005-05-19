From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: sysctl magnitude and sysfs ...
Message-Id: <20030401075730.GA13198@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E87E9DF.4020306@penguincomputing.com>
In-Reply-To: <3E87E9DF.4020306@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 30, 2003 at 11:10:23PM -0800, Philip Pokorny wrote:
> Hmmm...
> 
> I now see that I am hopelessly out of touch the current state of lm_sensors 
> development.
> 
> To fix that, please add me to the list.  Since I'm updating lm85 with the 
> SMSC chip and writing the adm1026, plus I want to have some input on the 
> adm1021 (for xeons...)
> 
> So I guess my magnitude suggestion is kinda silly given the long thread 
> about sysfs support...

Heh.

> My two cents on the sysfs proposal would be that it takes something that 
> was easy to understand (a list of structures defining "files") and a few 
> basic functions one for each type of sensor (generally) and replaces them 
> with a bizarre set of macros with concatenation operators creating a 
> blizzard of functions and entries in the chip directory.

If you like, you can write out the individual read and write file
operations.  I was just having fun with macros to keep the number of
lines of code in the driver to a minimum.

> For reference, both the lm85 and adm1026 will have about 100 or more 
> entries in the new sysfs scheme.

I bet.  There's nothing wrong with this, and if you can think of some
simple wrappers for these files, I would be very interested.  If you
look at my patch for the adm1021 driver, it's still a smaller driver
with the conversion to sysfs.

> Some temperature sensors have min/max limits.  Others have over/hyst limits.
> 
> One other comment that didn't seem to get acknowledged was that if you're 
> going to switch to fixed point and leave off the decimal, then it would be 
> helpful to make *everything* milli-volts and milli-degC.  That means * 1000 
> not *100.  Most devices have at least 8-bit A/D converters and using only 
> 1/100 volts will loose precision in some cases.  Some chips have 10-bit or 
> more A/D converters.  For more than 10-bits, even milli-volts may not be 
> accurate enough.

Ok, I'll work on cleaning up the document to reflect this, thanks.

> As for sensor numbering, that's what libsensors and sensors.conf is for.  
> To map the driver names (fan0, fan1, fan2) to the board labels (SYS_FAN1, 
> CPU0_FAN, CPU2_FAN, FAN3).  So if we want to change to base 0 for all the 
> inputs, that might make sense.

I don't care either way.  As was posted on this list, hardware is
traditionally enumerated starting at 1.

> I also notice that the new code being commited have lines more than 80 
> characters.  Is there no longer a kernel coding standard of 80 characters?  
> I agree that some of the line breaks in the exisitng code are strange...

They are more than strange, they are impossible to read.  It looks like
someone ran lindent on the code and didn't clean it up afterward.

Yes, there is still a coding standard of 80 characters.  But readable
code is more important at times than this standard.  That's why I
changed a few lines to reflect this.  Hopefully it is much more readable
now in those places.

thanks,

greg k-h
