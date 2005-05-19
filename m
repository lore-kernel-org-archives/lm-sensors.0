From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:25:54 +0000
Subject: [RFC/PATCH 0/22] W1: sysfs, lifetime and other fixes
Message-Id: <1114499202.8527.85.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <200504210207.02421.dtor_core@ameritech.net>
	 <d120d500050425132250916bcb@mail.gmail.com>
	 <1114497816.8527.66.camel@uganda>
	 <200504260150.00948.dtor_core@ameritech.net>
In-Reply-To: <200504260150.00948.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: sensors@stimpy.netroedge.com, LKML <linux-kernel@vger.kernel.org>, Greg KH <gregkh@suse.de>

On Tue, 2005-04-26 at 01:50 -0500, Dmitry Torokhov wrote:
> On Tuesday 26 April 2005 01:43, Evgeniy Polyakov wrote:
> > On Mon, 2005-04-25 at 15:22 -0500, Dmitry Torokhov wrote:
> > > On 4/25/05, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> > > > While thinking about locking schema
>  > > with respect to sysfs files I recalled,
> > > > why I implemented such a logic -
> > > > now one can _always_ remove _any_ module
> > > > [corresponding object is removed from accessible
> > > > pathes and waits untill all exsting users are gone],
> > > > which is very good - I really like it in networking model,
> > > > while with whole device driver model
> > > > if we will read device's file very quickly
> > > > in several threads we may end up not unloading it at all.
> > > 
> > > I am sorrry, that is complete bull*. sysfs also allows removing
> > > modules at an arbitrary time (and usually without annoying "waiting
> > > for refcount" at that)... You just seem to not understand how driver
> > > code works, thus the need of inventing your own schema.
> > 
> > Ok, let's try again - now with explanation, 
> > since it looks like you did not even try to understand what I said.
> > If you will remove objects from ->remove() callback
> > you may end up with rmmod being stuck.
> > Explanation: each read still gets reference counter, 
> > while in rmmod path there is a wait until it is zero.
> > If there are too many simultaneous reads - even
> > if each will put reference counter at the end, we still can have
> > non zero refcnt each time we check it in rmmod path.
> > That is why object must be removed from accessible pathes
> > first, and only freed in ->remove() callback.
> 
> Please try to read the code. device_unregister and kobject_unregister
> do not require caller to wait for the last reference to drop, they rely
> on availability of release method to clean up the object when last user
> is gone. driver_unregister is blocking (like your family code) but
> teardown takes no time. If driver is in use (attributes are open) then
> module refcount is non-zero and instead of (possibly endless) "waiting for
> refcount to drop" message you will get nice -EBUSY.
> 
> If you program so that you wait in module_exit for object release - you
> get what you deserve. 

But we can remove objects not from rmmod path.
You pointed right example in one previous e-mail.

Using above "waiting for device..." message is for debug only.

> > > BTW, I am looking at the connector code ATM and I am just amazed at
> > > all wied refounting stuff that is going on there. what a single
> > > actomic_dec_and_test() call without checkng reurn vaue is supposed to
> > > do again?
> > 
> > It has explicit barrieres, which guarantees that
> > there will not be atomic operation vs. non atomic
> > reordering. 
> 
> And you can't use explicit barriers - why exactly?

I used them - code was following:
smp_mb__before_atomic_dec();
atomic_dec();
smp_mb__after_atomic_dec();

I think simple atomic_dec_and_test() or even atomic_dec_and_lock()
is better.

-- 
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050426/b256574e/attachment.bin
