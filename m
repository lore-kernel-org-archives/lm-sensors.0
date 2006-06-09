From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 09 Jun 2006 21:28:38 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <4489E806.20707@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thomas Andrews wrote:
> Hi Jim,
>
> On Fri, May 05, 2006 at 10:39:50AM -0400, Jim Cromie wrote:
>
> [...]
>
>   
>> Im looking for the right way to coordinate use of Super-IO control
>> ports amongst the drivers that would use them.  While you and I dont
>> actually compete for the same port (mines at 2E,2F), you clearly have
>> a clue about these things, and could either; - provide me with one (if
>> you see that I need it ;-) - add it into your thinking on your driver
>> (so that its easy to fit in a port-lock-coordinator later) - tell me
>> that Ive more or less thought of everything that seems relevant.  - or
>> some combo of them..
>>     
>
> I've had a look at the links you gave, and it made a lot of sense to me
> because I've been worrying about collisions in usage of the SIO. I'm
> pretty sure I can make good use of your module.
>
>   
I should follow up:  Heres a newer-cleaner version of the locks coordinator,
plus a 2nd patch that uses it, during init.  I had it running against 
rc5-mm3,
quite unspectacular . ie good.  Comments welcome.


> One thing that I must mention though, is that in order to discover the
> actual SIO address, I have had to access other regions, and these are
> not always the same; the actual address depends on a) the bootloader,
> and b) how pins are strapped.
>   
Please look at find_superio() - its a more active wrapper on get_superio().
Here it is, as used in the 2nd patch:

+/* 0-terminated search vectors for find_superio() */
+static u8 cmd_addrs[] = { 0x2e, 0x4e, 0 };
+static u8 devids[] = { 0xE1, 0xE8, 0xE4, 0xE5, 0xE9, 0 };
+static struct superio* gate;
+

...

-	int i;
+	int i, status = -ENODEV;
+
+	gate = find_superio(cmd_addrs, DEVID, devids);
+	if (!gate) {
+		printk(KERN_WARNING "pc87360: superio port not detected, "
+		       "module not intalled.\n");
+		goto unlock;
+	}
+	/* this driver only uses superio port during init */
+	printk(KERN_WARNING "pc87360: locking superio \n");
+	mutex_lock(&gate->lock);


Code has had only cursory testing, but it feels tighter 
now with the 2nd version of the patch


> The long and short of this is that I will need to make use of your
> locking mechanism on all of the addresses, not just on the SIO address.
> Looking at your code, that doesn't seem to be a problem though. I only
> need to lock 3 or 4 addresses briefly.
>   
Id want to see the code to understand what youre talking about,
 *and* Im way far from a lock-meister, (as Ive probably just admitted in 
the patches ;)
but ..

- maybe I need a try-to-allocate-lock.
- im hoping your issue vanishes when you see find-superio
- whats protected by any lock is by agreement of users coordinating via it.
    disregarding agreements is B&E (breakin & entry)

Whats -all- the addresses ?  do you mean those in regular ISA space ?
Im not sure you need the 'shared' lock for that,  does  in*_p()  work 
correctly ?
( I fret from ignorance)

All that squawking aside, if you have agreement amongst the users of that
lock, there shouldnt be a problem.  This is independent of whether or not
the locks-coordinator ever knew about them -

You could share the lock addr amongst any group that you want,
and coordinate that way, the lockmanager has ;
-    forgotten you asked for a superio-port,
-   knows only that someone asked,
         it found one, and allocated a lock for future sharing

changing terms midstream:
    the locks-provider/vendor   sells the lock, and customer goes away...

      
it knows someone asked


> If my explanation is too vague, I'll send you my module, and you can
> have a look to see how I do it, but it's not very readable unless you
> have the sc1100 data-sheet close at hand. Just shout if you want to see
> it.
>  
>   
yes

> [...]
>
>   
>> Im still on the hook for giving your code a compile, load, try.  I
>> might need some guidance on the try part, I'll email on that if/when I
>> do.
>>     
>
>   
I have something to report :-(

soekris:~/pinlab# modprobe scx200_acb
[ 4455.721842] scx200_acb: probe failed
[ 4455.731069] scx200_acb: probe failed
FATAL: Error inserting scx200_acb 
(/lib/modules/2.6.17-rc6-gpio-sk/kernel/drivers/i2c/busses/scx200_acb.ko): 
No such device or address

This is a hacked kernel, in modules closely related to yours (sharing 
the chip),
so I could easily have trashed that symbol somehow.  This was several
days ago when I found this, so I figured I better hit send - in whatever 
form I could muster.

IIRC I also tried something recent of yours, against vanilla rc6, with 
rejects.
I'll repeat shortly so I can talk specifics, or I'll see a proto-patch 
from you ;-)

> Thanks. But you could also hang on until I submit a more final version,
> because I've drastically improved the discovery of the SIO address now,
> plus got interrupt-driven mode working nicely.
>
>   
That sounds cool - I very much want to take this chance to test for you,
and in so doing get the 'guided tour' :-)



So youre also on an SC-1100 ?   What board ? 
Im on a soekris net-4801

soekris:~/pinlab# cat /proc/cpuinfo
processor       : 0
vendor_id       : Geode by NSC
cpu family      : 5
model           : 9
model name      : Unknown
stepping        : 1
cpu MHz         : 266.694
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu tsc msr cx8 cmov mmx cxmmx up
bogomips        : 534.87

>> btw, wheres za ?
>>     
>
> South Africa - Down at the very bottom in a town called Cape Town
>
> Cheers,
> Thomas
>
>   
have a great day
-jimc
-------------- next part --------------
A non-text attachment was scrubbed...
Name: superio-locks-add-module.patch
Type: text/x-patch
Size: 6257 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060609/1d9e208f/attachment-0002.bin 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: superio-locks-usein-pc87360.patch
Type: text/x-patch
Size: 2038 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060609/1d9e208f/attachment-0003.bin 
