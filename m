From: greg@kroah.com (Greg KH)
Date: Fri, 03 Jun 2005 08:53:10 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <20050603070305.GA30292@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jun 03, 2005 at 02:25:43AM -0400, Yani Ioannou wrote:
> Hi Mark,
> 
> I'm trying to implement the hwmon interface in ipmi_sensors (the
> re-written driver based on bmcsensors w/o i2c-ipmi), but I can't find
> any device struct that I could pass when registering the hwmon class,
> the ipmi system simply doesn't seem to define any, I thought that
> perhaps the bmc interfaces would have an associated one at least.
> 
> The problem essentially is, unlike the i2c/isa sensor chip drivers,
> ipmi_sensors isn't a device driver as such, it is an lm-sensors
> interface to the sensors available to an IPMI BMC.

Which is a platform device.  Or if not, it should be.  There is your
struct device.

> I just come back to my previous line of thought that we really should
> be using class_device_attributes for hwmon class sensor attributes
> rather than assuming that every hwmon class_device has an associated
> device...

No, every hwmon class_device should have a struct device associated with
it.  If not, it needs to be fixed :)

thanks,

greg k-h
