From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Mon, 26 Feb 2007 19:03:59 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <45E32F1F.1070207@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
In-Reply-To: <45D5EA88.7090300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 23 Feb 2007 09:08:30 +0100, Hans de Goede wrote:
>> I'm glad you like it, but how does this relate to using dmi info in 
>> sensors-detect, if we add that capability to sensors-detect and add a database 
>> with known motherboards and there configs, then that would be a doublure with 
>> having the info in the drivers, this is the main reason why I hesitate.
> 
> Very good point.
> 
> I believe that the abituguru case is a bit special. The DMI data is not
> only useful to find out which boards need the driver. It is also useful
> to prevent the driver from being loaded on random hardware. Given that
> the chip is impossible to detect, it would sound sensible to at least
> prevent the abituguru driver from being loaded on non-Abit systems. If
> the list of supported boards is short and well known, including it too
> can't hurt.
> 

Ok, notice though that although the detection of the abituguru is indeed
very weak, it will probably cause tons of false positives, that the
driver will not actually load as the driver probe function will do a
full test-read, which will fail on anything but an uguru (1 in a million
chance this doesn't happen). The problems here are:
1) the read cycle does isa outb's which could upset non uguru hardware
2) at this point in the mod-loading stage, the insmod has succeeded
   confusing users, as the see the module but get no sysfs hwmon entries
   (the driver didn't load but the platform device was created)

Now 2 can be fixed by doing the test-read before creating the platform
device, but I don't know if thats worth it.

> As for sensors-detect itself, there's much more to do with the DMI data
> than just finding which drivers need to be loaded. I don't think we
> would bother adding DMI support to sensors-detect just for that, except
> for the few boards with undetectable chips (uGuru) or which are
> otherwise known to cause trouble when probed. The true value of using
> DMI data in sensors-detect is to have a repository of configuration
> files identified by DMI data, so that sensors-detect can fetch and
> install a custom configuration file for your system. Being able to find
> out the right drivers without probing is more or less a side effect.
> 

Agreed 100% this is _exactly_ the asignment I have given my students,
I've even told them to create a web interface to allow people to upload
correct sensors.conf settings for a certain motherboatd together with
the DMI data. Please read the document they have posted, it is in
English and it should contain a product description exactly matching
what you describe / want. If you want to fix the requirements I laid
down for this now would be THE time.

Regards,

Hans



