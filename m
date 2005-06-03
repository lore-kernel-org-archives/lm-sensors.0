From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Fri, 03 Jun 2005 21:00:06 +0000
Subject: [lm-sensors] Re: [PATCH 2.6.12-rc5-mm1 3/3] i2c: modify sensors
Message-Id: <253818670506031159466bf3b8@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050602033727.GD4906@jupiter.solarsys.private>
In-Reply-To: <20050602033727.GD4906@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

> > The problem essentially is, unlike the i2c/isa sensor chip drivers,
> > ipmi_sensors isn't a device driver as such, it is an lm-sensors
> > interface to the sensors available to an IPMI BMC.
> 
> Which is a platform device.  Or if not, it should be.  There is your
> struct device.

Yes, I agree, I'm going to have to see if I can find away to make the
low level device (assuming that exists..) for each IPMI interface type
available at a higher level, without annoying Corey too much :-).
 
> > I just come back to my previous line of thought that we really should
> > be using class_device_attributes for hwmon class sensor attributes
> > rather than assuming that every hwmon class_device has an associated
> > device...
> 
> No, every hwmon class_device should have a struct device associated with
> it.  If not, it needs to be fixed :)

Well even assuming that every hwmon class_device does have a device
associated with it, it still makes sense to me to be using
class_device_attributes.

First of all they are attributes of the hwmon class, not that
neccessarily that device, for example assuming I add the sensor
device_attributes to the ipmi low level interface device, now I have a
device entry with a whole load of sensor attributes when that low
level interface hasn't actually got sensors hanging off it, it is just
a way of accessing the IPMI BMC (which by the way can be accessed
through more than one interface). It simply doesn't make sense in the
way that the sysfs tree should IMHO.

Furthermore I've added attributes for the device from a hwmon class,
shouldn't the device be responsible for device_attributes?

Thanks,
Yani
