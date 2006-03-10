From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 10 Mar 2006 14:09:24 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <20060310150924.cdd78efd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> I've given this some more thought and I've decided against implementing 
> my way for a couple of other drivers to be able to really measure the 
> difference. I believe we agree my way is somewhat more efficient, but 
> that the differences aren't big enough to swing the scales to my way 
> only on the efficiency reasons.
> 
> Instead of spending more time coding test-cases I'd rather just see a 
> decision soon and (if nescessarry) I'll update the uguru driver to match .
> 
> There are 2 arguments I would still like to make in favor of my way though:
> 
> 1) you initially did it this way too for atleast one driver. Remember, 
> usually your first hunch is a good one.

Doesn't work for me, it seems. See my automatic fan speed control
interface :(

If I did it that way for the f71805f, this was mostly suggested by the
design of the chip itself. If you look at the code you'll see that it's
really simple. This one chip was almost meant for your proposal. But
for many other chips it wouldn't be that nice at all.

Also, I did this without really thinking of all the other features
(separate high/low alarms, input faults, beeps, etc...) that other
drivers would need, and ideas cannot always be generalized.

> 2) I've also written support for libsensors and the sensors application 
> when doing things my way and that fits nicely. I'm afraid that the many 
> files way will be a problem with the current libsensors. I don't want to 
> now wath the lib and the progs chips.* will look like. 100+ additional 
> entries for the uguru alone! And I don't think the chip specific reading 
> and report code in the sensors application will get any pretter too.

This will look fat and ugly, no matter which alarms interface we go
with. This is due to the broken design of libsensors, there's not much
we can do until then. And this isn't specific to the uguru either.

Having seperate alarm files would simply cause you to pass feature IDs
for alarms instead of pre-computed booleans to print_abituguru_in and
friends. It really doesn't change much in terms of number of lines of
code, just try it.

> Now I know that libsensors is destined to be replaced, but it will be 
> around for a while I think.

True, but the new interface is clearly meant for the future library, so
I really don't care if it looks less than optimal for the old library.

> I've attached a patch adding support for the uguru to both lib and prog 
> with alarm reporting to give you an idea how this will look like when 
> doing things my way. Please note that this patch needs updating for
> 2.10 / cvs and thus won't apply.

You may spare some lines in lib/chips.h by defining feature IDs as
parametrized macros rather than constants. Given that this is how you
end up using these values, this would be cleaner too. That's what I
did for the f71805f, if you want to take a look.

Also, I invite you to leave some room after each set of values. Having
SENSORS_ABITUGURU_IN10 = 11 and SENSORS_ABITUGURU_IN0_MIN = 12 doesn't
look good at all - what will you do if the next version of the uguru
has a 12th voltage input?

Thanks,
-- 
Jean Delvare

