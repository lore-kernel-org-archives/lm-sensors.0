From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 22 Jun 2008 14:29:50 +0000
Subject: Re: [lm-sensors] [REGRESSION, ABI] Re:  LMSENSORS: 2.6.26-rc,
Message-Id: <485E61DE.6020202@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <485DA11C.7050906@keyaccess.nl> <485DFF35.6080008@hhs.nl> <485E505F.8010306@keyaccess.nl>
In-Reply-To: <485E505F.8010306@keyaccess.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: linux-acpi@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>

Rene Herman wrote:
> This is an ABI breakage issue and an unfortunate one at that:
> 

No it is not, in 2.6.26rcX, the acpi thermalzones have grown a hwmon interface, 
that is they register a hwmon device so that "sensors" and other lm_sensors ABI 
compliant using applications can read the zone temperatures using an existing 
ABI instead of adding yet another ABI.

The problem is that the hwmon entries for the thermalzone device lack a 
"device" symlink under /sys/class/hwmon/hwmonX, as they are not tied to a 
specific device. lm_sensors-2.10.x barfs on this, which would not be a problem 
if it would simply skip with the new hwmon which it does not understand 
(because of the missing device link, which is not a part of the documented 
ABI), but instead of skipping it, if I understand you correctly it aborts and 
never gets to hwmon1 (which is 100% unchanged and should still work fine).

I wonder what just plain "sensors" (without the -s) does.

Still this is an issue that needs fixing, but not on the kernel side, but 
rather on the lm_sensors-2.10.x side, I guess its time for a new 2.10.x release.

>> I'm pretty sure this caused by your lm_sensors using space being to old 
>> to support the new thermalzone stuff. You need atleast 3.0.2 to support 
>> the thermalzone driver.
> 
> I see. I was about to mark this up as Volkerding doing his usual "if it 
> has a lower version number it must be better" thing but in this case it 
> seems it's hwmon or ACPI which is to blame.
> 

Actually its lm_sensors userspace which is to blame, as instead of skipping the 
new hwmon device which it doesn't understand it aborts (atleast that is what I 
understand from what you're telling us).

> This is ABI breakage. I wouldn't care if my older lm_sensors userspace 
> couldn't handle the ACPI Thermal Zone, but I do care that even having it 
> breaks my other sensors;

Yes, and that is exactly the part which is an lm_sensors userspace bug.

> Now, I'm actually usally a big fan of not dragging around old gunk 
> forever, ABI be damned, but in this case this really won't do. 2.6.10 is 
> a recent maintenance release and I see for the new 3.0 branch:
> 
> http://www.lm-sensors.org/wiki/Download
> 
> => Most third party monitoring applications do not yet work with the 
> library in this package. We are encouraging authors to port their 
> applications to the new library. We already have patches for xsensors 
> 0.60, gkrellm-2.3.0, net-snmp-5.4.1 (configure with 
> --with-mib-modules="ucd-snmp/lmsensorsMib" --with-ldflags="-lsensors"), 
> xfce4-sensors-plugin-0.10.99.2, kdebase-3.5.8(ksysguard), 
> sensors-applet-1.8.1 and ksensors-0.7.3-fedora-14.tar.gz (upstream is 
> dead this tarbal contains a version with all Debian's changes + 2 
> patches from Fedora, including lm_sensors-3.x support).
> => 
> So it seems we have here a change to the kernel requiring a userspace 
> basically noone is ready for

Erm if you look at that same page you will notice there are links to patches 
for almost every userspace package which uses lm_sensors, I know as I wrote 
most of them, quite a few of them have been integrated by their resp. upstreams.

Also "noone is ready for"? lm_sensors-3.0.x is the default in both Fedora 9 and 
OpenSuse 11.

> But if not, .26 is around the corner and requiring libsensors-3.0 must 
> really not be.
> 

I agree that requiring libsensors-3.0.2 for this is not a good solution, but I 
don't want to be crippling the kernel for what I believe is a bug in 2.10.x either.

So we need todo 2 or 3 things:
1) Find out if this really is as big an issue as you make it, maybe
    "sensors -s" is rightfully complaining about hwmon0 and then still happily
    doing its job for hwmon1?

    Again, what does plain "sensors" say? Does it still show the hwmon1
    readings, and are the limits what they should be after sensors -s?

2) Fix this in the 2.10.x series (which are still supported) and do a new
    2.10.x release.

3) If this really completely messes 2.10.x and in that case I'm afraid we will
    have to make kernel side changes.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
