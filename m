From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 15 Mar 2012 14:18:00 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] watchdog_dev: Add support for having more then 1 watchdog
Message-Id: <4F61FA18.70104@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1331812757-3491-1-git-send-email-hdegoede@redhat.com> <1331812757-3491-2-git-send-email-hdegoede@redhat.com> <20120315131131.1096f8c8@pyramind.ukuu.org.uk>
In-Reply-To: <20120315131131.1096f8c8@pyramind.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-watchdog@vger.kernel.org, Wim Van Sebroeck <wim@iguana.be>, LM Sensors <lm-sensors@lm-sensors.org>, Thilo Cestonaro <thilo.cestonaro@ts.fujitsu.com>, =?ISO-8859-1?Q?P=E1dra?= =?ISO-8859-1?Q?ig_Brady?= <P@draigBrady.com>

Hi,

On 03/15/2012 02:11 PM, Alan Cox wrote:
>> Also having this support in watchdog_dev makes developing watchdog drive=
rs
>> for watchdog hardware which happens to often be found on systems with
>> multiple watchdogs a lot easier.
>
 > For x86 we need them as some systems can have both a TCO timer and a
 > management engine timer.

He he, iTCO + another watchdog exactly the same reason I need support
for this :)

> See the patches I posted. I (biased as ever ;)) think they way I've done
> it is better

I agree it is better, but I never saw the patch as I'm not subscribed
to either one of linux-watchdog or linux-kernel. I've subscribed
myself to linux-watchdog now.

> but its also produced no feedback so I'll resend them again
> shortly if others also need them.

Thanks to P=E1draig Brady finding an archived version of your patch
was really easy. I've done a quick review and here are some remarks:

+static unsigned long dog_mask; /* Watcodgs that are in use */

Please fix (spelling) the comment after dog_mask.

+ *     watchdog_open: open the /dev/watchdog device.
+ *     @inode: inode of device
+ *     @file: file handle to device
+ *
+ *     When the /dev/watchdog device gets opened, we start the watchdog.
+ *     Watch out: the /dev/watchdog device is single open, so we make sure
+ *     it can only be opened once.
+ *
+ *     FIXME: review locking on old_wdd v unregister
+ */
+
+static int watchdog_open(struct inode *inode, struct file *file)
+{
+       if (old_wdd !=3D NULL)
+               return watchdog_do_open(old_wdd, inode, file);
+       return -ENXIO;
+}

You set old_wdd to NULL after misc_deregister, and after misc_deregister
has completed watchdog_open can no longer run (watchdog_open runs
with the misc_mtx hold). So you can remove the FIXME as well as the check
for old_wdd being NULL.

+       err =3D watchdog_assign_id(watchdog, 0);
+       if (err < 0)
+               return err;
+       if (err =3D=3D 0) {
+               err =3D misc_register(&watchdog_miscdev);
+               if (err =3D=3D 0)
+                       old_wdd =3D watchdog;
+               else {
+                       pr_err("%s: cannot register miscdev on minor=3D%d (=
err=3D%d
+                               watchdog->info->identity, WATCHDOG_MINOR, e=
rr);
+                       pr_err("%s: probably a legacy watchdog module is pr=
esen
+                               watchdog->info->identity);
+                       watchdog_release_id(watchdog);
+                       err =3D watchdog_assign_id(watchdog, 1);
+                       if (err < 0)
+                               return err;
+               }
+       }

You may want to check for err =3D=3D -EBUSY in the fallback instead of assu=
ming
the problem is a legacy watchdog driver

+       err =3D watchdog_add_device(watchdog);
+       }

You do this even for watchdog0 / for the watchdog we've also registered as
misc_dev. I guess this is intentional and you want the watchdog to be
available as both misc,130 as well as as MAJOR(dog_devt),0 ?

+       if (err < 0) {
+               if (watchdog->id =3D=3D 0)
+                       old_wdd =3D NULL;
+               watchdog_release_id(watchdog);

That is missing a misc_deregister(&watchdog_miscdev); under the
if (watchdog->id =3D=3D 0). IOW this should be:

+       if (err < 0) {
+               if (watchdog->id =3D=3D 0) {
+                       misc_deregister(&watchdog_miscdev);
+                       old_wdd =3D NULL;
+               }
+               watchdog_release_id(watchdog);

  int watchdog_dev_unregister(struct watchdog_device *watchdog)
  {
<snip>
+       watchdog_del_device(watchdog);
+       if (watchdog->id =3D=3D 0) {
+               misc_deregister(&watchdog_miscdev);
+               old_wdd =3D NULL;
         }

You're calling watchdog_del_device here even for watchdog0, assuming
that the add_device for watchdog0 above is intended that is fine, but
if that was unintended this needs a check too.

Other then these few remarks it looks fine. If you can resend it
with my remarks addressed I'll add a Reviewed-By.

###

To be able to convert my drivers to watchdog_dev too, I really need this
one also:
[PATCH 2/4] watchdog_dev: Add support for dynamically allocated watchdog_de=
vice structs

Any chance you could review that? Also if Wim is too busy to take
your multiple device support patch and my dyn alloc watchdog_device
patch, could you then send these to Linus for 3.4?

The reason I'm asking is because I'm about to send patches for adding
watchdog support for the smc sch5627 and smc sch5636 superio hwmon parts,
and my plan was to just use a DIY approach to the watchdog interface given
my watchdog_dev patches seemed to not be getting anywhere. But if these
can go upstream for 3.4 then I would prefer to directly submit a version
using watchdog_dev, rather then converting it later.

###

And here is me response to your review of my multiple devices
support patch, not that it matters much if we decide to go with
yours:

>> +	.minor		=3D 212,
>> +	.name		=3D "watchdog1",
>
> Also for submitted patches please don't go taking minor numbers from
> miscdev which are statically allocating them without properly registering
> them first...

These are already used in other drivers, and claimed in
Documentation/devices.txt, they just lack defines which is why
I hardcoded them. The fact that they are already claimed and in
use is why I opted for this approach. But I agree your approach is
better.

>
>
>> +	/* Find our watchdog_device */
>> +	for (idx =3D 0; idx<  MAX_WATCHDOGS; idx++)
>> +		if (watchdog_miscdev[idx].minor =3D=3D iminor(inode)) {
>> +			wdd =3D wdd_list[idx];
>> +			break;
>> +		}
>
> Locking model ?
>
>
>> +	/* No need to lock */
>> +	for (idx =3D 0; idx<  MAX_WATCHDOGS; idx++)
>> +		if (wdd_list[idx] =3D=3D watchdog)
>> +			break;
>
> What about a parallel open ?

1) open can not run after misc_deregister completing
2) wdd_list[idx] gets set to NULL after misc_deregister

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
