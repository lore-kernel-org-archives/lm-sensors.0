From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 26 Oct 2006 00:33:40 +0000
Subject: [lm-sensors] grafting lm-sensors 2.10.1 onto red hat kernel
Message-Id: <20061026003340.GA3012@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve:

* Steven Timm <timm at fnal.gov> [2006-10-25 12:36:24 -0500]:
> On Wed, 25 Oct 2006, Jean Delvare wrote:
> 
> > Hi Steven,
> >
> > On Wed, 25 Oct 2006 10:59:20 -0500 (CDT), Steven Timm wrote:
> >>
> >> Has anyone successfully managed to compile i2c 2.10.1 and lm_sensors
> >> 2.10.1 so that they work with kernels such as "2.6.9-42.0.2.ELsmp" as
> >> distributed with Red Hat Enterprise Linux 4?
> >>
> >> For some of the 2.9 version of lm_sensors there used to be
> >> lm_sensors-kmdl and i2c-kmdl rpms available in the ATRPMS repository
> >> but now I do not see those anymore.  any hints are welcome.
> >
> > For 2.6 kernels, you don't need the separate module packages,
> > everything's already in the kernel tree. All you need is the user-space
> > part of lm_sensors, which is available from ATrpms:
> > http://atrpms.net/dist/el4/lm_sensors/
> >
> 
> The kernel as distributed by Red Hat in RHEL4 update 4
> (2.6.9-42.0.3) has got
> an lm_sensors and i2c in there already but it is a very old version, 
> 2.8.7.  That is not new enough to support certain chips on new hardware,
> particularly the w83792 sensor.  Has anyone successfully
> been able to patch the latest 2.10.1 lm_sensors against that
> old kernel, and if so, how?

The lm-sensors project has two parts: 
1) a userspace part, including the sensors(1) program and libsensors(3) library
2) the Linux kernel drivers for the i2c bus and sensor chips

We maintain the kernel drivers for the 2.6 series directly in Linus' tree now.
The trouble is, you're using 2.6.9-something which does not contain support
for your device - not surprising since 2.6.9 is a few days over 2 years old
by now.

To support the w83792 sensor on that old kernel, someone will have to back-
port the current driver so that it works with 2.6.9.  My guess is that you
will not get any volunteers to do this (not particularly interesting) work.
Although, it shouldn't be very hard for a decent C programmer to do it...
maybe that is you or someone you work with.

Another option could be to upgrade to a newer kernel that does support the
device.

In either case, you will need to upgrade from the 2.8.7 package of lm-sensors
to something much newer, which should be no problem.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


