From: timm@fnal.gov (Steven Timm)
Date: Thu, 26 Oct 2006 01:13:38 +0000
Subject: [lm-sensors] grafting lm-sensors 2.10.1 onto red hat kernel
Message-Id: <Pine.LNX.4.64L.0610252009590.15996@flxi05.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
In-Reply-To: <Pine.LNX.4.64.0610251056560.7544@snowball.fnal.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>>
>> The kernel as distributed by Red Hat in RHEL4 update 4
>> (2.6.9-42.0.3) has got
>> an lm_sensors and i2c in there already but it is a very old version,
>> 2.8.7.  That is not new enough to support certain chips on new hardware,
>> particularly the w83792 sensor.  Has anyone successfully
>> been able to patch the latest 2.10.1 lm_sensors against that
>> old kernel, and if so, how?
>
> The lm-sensors project has two parts:
> 1) a userspace part, including the sensors(1) program and libsensors(3) library
> 2) the Linux kernel drivers for the i2c bus and sensor chips
>
> We maintain the kernel drivers for the 2.6 series directly in Linus' tree now.
> The trouble is, you're using 2.6.9-something which does not contain support
> for your device - not surprising since 2.6.9 is a few days over 2 years old
> by now.

What was 2.6.9 in Linus' tree and what Red HAt distributes are quite 
different.  They grab a lot of the newer patches from the newer kernels
but evidently not these ones.  I guess I am just going to have to
open a ticket with Red Hat and ask them to include these into
their next version.
>
> To support the w83792 sensor on that old kernel, someone will have to back-
> port the current driver so that it works with 2.6.9.  My guess is that you
> will not get any volunteers to do this (not particularly interesting) work.
> Although, it shouldn't be very hard for a decent C programmer to do it...
> maybe that is you or someone you work with.

IF we do this we have to get the latest i2c as well as the latest 
lm_sensors back-ported there, don't we?
>
> Another option could be to upgrade to a newer kernel that does support the
> device.
>
Not an option here because we are depending on Red Hat for security 
updates on this kernel and thus want to leave the underlying kernel
as untouched as possible.  This was possible in the 2.4 kernel series.
I can't believe we are the only site in this situation.  There are a lot
of others that try to run with the enterprise kernels and it would
seem there should be quite a bit of interest in this.

Steve


> In either case, you will need to upgrade from the 2.8.7 package of lm-sensors
> to something much newer, which should be no problem.
>
> Regards,
>
> -- 
> Mark M. Hoffman
> mhoffman at lightlink.com
>
>

