From: Greg KH <greg@kroah.com>
Date: Fri, 02 Oct 2009 14:19:14 +0000
Subject: Re: [lm-sensors] Error message when ACPI causes a device probe to
Message-Id: <20091002141914.GA20816@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091002154332.076fede2@hyperion.delvare>
In-Reply-To: <20091002154332.076fede2@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Oct 02, 2009 at 03:43:32PM +0200, Jean Delvare wrote:
> Hi all,
> 
> We have recently added a mechanism to check for ACPI vs. native driver
> resource conflicts. When such a conflict happens, we get an error
> message of the following form in the logs:
> 
> ACPI: I/O resource 0000:00:1f.3 [0x18a0-0x18bf] conflicts with ACPI region SMBI [0x18a0-0x18af]
> ACPI: Device needs an ACPI driver
> 
> But when the conflict is found in probe(), we also get the following
> error message:
> 
> i801_smbus: probe of 0000:00:1f.3 failed with error -16
> 
> This is because the probe() method returns -EBUSY. The driver core
> currently silents some error codes (ENODEV and ENXIO) but not EBUSY.
> This error message is redundant with the ones printed by ACPI, and
> somewhat more frightening, so users may report it to us, as was the
> case here:
> http://bugzilla.kernel.org/show_bug.cgi?id293
> 
> So I would like to get rid of this message. I can think of two ways:
> 
> * Change the driver core to silent EBUSY as it does for ENODEV and
>   ENXIO. Greg, I guess you wouldn't like that?

Nah, I don't, drivers should return -ENODEV if they can't bind to the
device.  The -ENXIO was for some odd driver that I can't remember, we
should remove that and change the source of it as well.

> * Change all drivers to return either -ENODEV or -ENXIO when an ACPI
>   resource conflict is found inside a probe function. After all, nobody
>   will ever see the error code in question so maybe it's acceptable
>   even though these error codes don't really match the reality?

They should be changed to -ENODEV, as that means the driver can not
handle the device for a valid reason.  And resource conflicts are valid
reasons.

thanks,

greg k-h

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
