From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <25381867050504121679a9feba@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I've included a modified version of the previous dynamic callback
> > patch where I defined a DEVICE_ATTR_DATA macro which becomes useful in
> > these cases, likely in any real patch this would be rolled into the
> > DEVICE_ATTR macro but for simplicity (i.e. not breaking everything
> > else that uses DEVICE_ATTR out there) I'm using a separate one for
> > now.
> 
> Try modifying __ATTR() to have the data pointer and then make
> DEVICE_ATTR pass a NULL for the data field.
> 

This would work except __ATTR is used by all the attribute macros not
just DEVICE_ATTRIBUTE. Would a void * field in those attributes be
useful too?

> Just use the void * as an int.  No need to point it to an integer
> variable, right?  Would that make this code a bit more readable (it's
> pretty messy as is.)
Jean:
On 5/4/05, Jean Delvare <khali@linux-fr.org> wrote:
>Irk. What about the kittens? :(

I was tempted to do this but it set off alarms in my better coding
judgement (abusing a pointer to store an int). It is certainly
'cleaner' than defining the awkward static ints, but aside from the
language abuse would doing something like this cause any portability
issues? And yes, what about those poor kittens? ;-)

> Hm, as we want to move toward dynamic attributes, would a helper
> function to create one be a good idea to have?
> 
It would be useful for most of the cases (like moving to dynamic
attributes in adm1026), but when creating completely dynamic
attributes (as in you don't know what you will be creating at compile
time) you have to create and allocate the sysfs name strings too (see
bmcsensors).

> And thanks for doing this, it makes a bit more sense now, and seems
> almost reasonable.  I'd like a few more cleanups before adding it to my
> trees :)
>

Well I'm an almost reasonable person ;-). Yes this code was mainly for
comment so it definitely needs cleaning up, although any pointers on
how/where are welcome.

Thanks,
Yani
