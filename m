From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 14 Feb 2011 21:29:21 +0000
Subject: Re: [lm-sensors] hwmon API update
Message-Id: <20110214212921.GA18964@srcf.ucam.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D57CC24.1040306@free.fr>
In-Reply-To: <4D57CC24.1040306@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Feb 14, 2011 at 01:25:15PM -0800, Guenter Roeck wrote:
> On Mon, Feb 14, 2011 at 02:40:14PM -0500, Matthew Garrett wrote:
> > As I said, we could rework the hwmon drivers into thermal devices
> > instead, but we'd still need a mechanism for providing the thermal 
> > device back to the registering device.
> > 
> Not sure I understand the second part. How do you do that today for ACPI 
> thermal devices ?

In the ACPI case it's the same code registering the thermal zone and 
creating the thermal devices, whereas in this case there's two separate 
drivers involved. You need some way to get from an i2c device to a 
thermal device.

> > > > Because hardware control is the kernel's job, not userspace's. Having 
> > > > hardware melt just because userspace fell off a cliff isn't acceptable.
> > > > 
> > > The same argument would apply to system fan control, doesn't it ?
> > 
> > Yes, which is why it belongs in the kernel.
> > 
> Accepted, but that implies a generic solution, not one restricted/limited to GPUs.

There's nothing in this solution that's limited to GPUs. The generic 
thermal code is already used by ACPI.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
