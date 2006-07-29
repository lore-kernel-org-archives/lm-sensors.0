From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 29 Jul 2006 15:26:16 +0000
Subject: [lm-sensors] 18-rc1-mm1  and unchecked return-codes
Message-Id: <20060729152616.GJ25291@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44B3EEFD.5050209@gmail.com>
In-Reply-To: <44B3EEFD.5050209@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim:

> Mark M. Hoffman wrote:
> >  But
> >you didn't actually send your patch to the list right (?)  At least I can't
> >find it now that I'm looking again.

* Jim Cromie <jim.cromie at gmail.com> [2006-07-29 09:09:30 -0600]:
> For the patch itself, I used a subject-line I thought more suitable for 
> submission.
> However, it lost connection to this subject - doh.
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-July/016909.html

OK thanks.

> >Anyway... I guess we should stuff all those attributes in a table and run
> >over them with a for loop.  Then if we catch an error, we can run back
> >through the table in reverse.  I mean, what else can we do right? 
> Im not sure what you mean -
> - we dont *need* device-remove-file, since they 'go away' by themselves 
> (at least for normal rmmods)
>    and work properly when re-modprobed

Sorry, I'll be more specific.  Right now, when you rmmod a hwmon driver, the
struct device to which it was bound gets destroyed.  When that happens, all
sysfs files created with device_create_file() will get auto-freed also.

But this is contrary to the way most subsystems work.  E.g. in PCI, the
struct device is created by the bus and is persistent (so long as it isn't
physically removed from the system).  In this scenario, when the driver
is rmmod'ed, it is merely unbound from the struct device... and those sysfs
files have to be removed manually.  I plan to move the I2C subsystem to
this model "sometime soon".

Ergo, while we're at it... we should add the device_remove_file() calls
now in order to save the time later.  We'll be touching all the same code
anyway.

> - changing strategy  from completely-unchecked to 
> undo-everything-and-bailout
>    is a rather long step, and makes driver possibly unusable in some 
> corner cases
>    (none of which we know and can repeat)

True enough, but I imagine that any other solution will be frowned upon
as "wallpapering over bugs".  Jean: any opinion on this?

> - my approach of just counting and warning is 'more legacy'
>    (but warnings may be ignored, whereas a 'broken-driver' will elicit 
> more feedback)
> 
> IOW - theres a balance to strike here, and Im not sure where (too-clever 
> see-saw analogy elided)
> Anyway, your forthcoming patches will clarify your sense of the right 
> balance..
> 
> > I'll
> >patch the following to start, all of which I can either test easily or
> >for which I'm responsible anyway...
> >
> >	asb100, lm75, lm78, smsc47b397, w83627hf
> >
> >Any volunteers for the other 38?
> >
> >Regards,
> >
> >  

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


