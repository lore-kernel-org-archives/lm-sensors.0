From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Feb 2008 12:27:36 +0000
Subject: Re: [lm-sensors] PATCH: make lm_sensors init script return values
Message-Id: <20080213132736.594d5a48@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47B039BA.8020707@hhs.nl>
In-Reply-To: <47B039BA.8020707@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 13 Feb 2008 13:07:33 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Mon, 11 Feb 2008 13:04:10 +0100, Hans de Goede wrote:
> >> I've received the attached patch through Fedora's bugzilla. It fixes the return 
> >> values of the various error exit cases to match the LSB spec:
> >> http://refspecs.linux-foundation.org/LSB_3.2.0/LSB-Core-generic/LSB-Core-generic/iniscrptact.html
> >>
> >> It looks sane to me, if there are no objections I'll commit it to svn.
> > 
> >> --- lm_sensors.orig	2008-02-07 11:37:22.000000000 -0500
> >> +++ lm_sensors	2008-02-07 11:41:04.000000000 -0500
> >> @@ -40,15 +40,15 @@
> >>  
> >>  	# Don't bother if /proc/sensors still doesn't exist, kernel doesn't have
> >>  	# support for sensors.
> >> -	[ -e /proc/sys/dev/sensors ] || exit 0
> >> +	[ -e /proc/sys/dev/sensors ] || exit 6
> > 
> > Note that this doesn't work with a 2.6 kernel anyway, which makes me
> > wonder whether it's worth keeping these init files in the lm-sensors
> > tree. Obviously no distribution uses them as-is.
> > 
> 
> It helps to read the whole script before jumping to conclusions like this, 
> above this is:
> if grep -q sysfs /proc/mounts; then
>          WITHSYS=1
> else
>          WITHSYS=0
> fi
> 
> if [ $WITHSYS = "0" ]; then
> 
> So this piece of code doesn't get executed on 2.6 kernels with sysfs enabled. 

Oops, you're right, I totally missed that, probably because
lm_sensors.init.suse doesn't have this conditional.

> And actually atleast one distro (Fedora) is using the scrip as is.

The script we ship in openSuse is based on lm_sensors.init.suse, but
it's heavily patched. In fact the patch is bigger than the script
itself. My impression is that lm_sensors.init.suse has not been updated
in parallel with lm_sensors.init and is totally lagging behind by now.
So I'd rather delete it, and let openSuse base their patch on
lm_sensors.init (which is certainly a saner base) or even just maintain
their own init script.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
