From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 27 Feb 2007 08:45:39 +0000
Subject: [lm-sensors] Could the k8temp driver be interfering with ACPI?
Message-Id: <20070227094539.7d57b8dc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D5EA88.7090300@redhat.com>
In-Reply-To: <45D5EA88.7090300@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 26 Feb 2007 20:03:59 +0100, Hans de Goede wrote:
> Ok, notice though that although the detection of the abituguru is indeed
> very weak, it will probably cause tons of false positives, that the
> driver will not actually load as the driver probe function will do a
> full test-read, which will fail on anything but an uguru (1 in a million
> chance this doesn't happen). The problems here are:
> 1) the read cycle does isa outb's which could upset non uguru hardware

outb is, by definition, a write, which is why we should prevent it from
happening on systems without the relevant hardware.

> 2) at this point in the mod-loading stage, the insmod has succeeded
>    confusing users, as the see the module but get no sysfs hwmon entries
>    (the driver didn't load but the platform device was created)
> 
> Now 2 can be fixed by doing the test-read before creating the platform
> device, but I don't know if thats worth it.

Well there are two approaches:
1* Keep the platform driver approach, and have the platform device
created outside the abituguru driver. In this case it is OK to let the
abituguru driver load when no device is found, same as PCI drivers do.
* Think of the uGuru as a legacy ISA device. In that case the driver
should fail if the uGuru isn't found. Maybe you can look into the new
isa driver type (drivers/base/isa.c). I must look into it myself, it
might be the right solution to move the lm78 and w83781d drivers out of
using i2c-isa.

> Agreed 100% this is _exactly_ the asignment I have given my students,
> I've even told them to create a web interface to allow people to upload
> correct sensors.conf settings for a certain motherboatd together with
> the DMI data. Please read the document they have posted, it is in
> English and it should contain a product description exactly matching
> what you describe / want. If you want to fix the requirements I laid
> down for this now would be THE time.

I've read the "Background Information" and "Objectives" parts, overall
it looks good, except that a proofread of the document would be very
welcome. I'll comment in the adequate thread.

-- 
Jean Delvare

