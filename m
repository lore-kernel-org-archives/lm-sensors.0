From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 11 Sep 2012 16:35:17 +0000
Subject: Re: [lm-sensors] CONFIG_THERMAL_HWMON in thermal_sys.c
Message-Id: <20120911163517.GA14630@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D68720C2E767A4AA6A8796D42C8EB591B6F8F@BGSMSX101.gar.corp.intel.com>
 <20120911091204.24fd1510@endymion.delvare>
 <4D68720C2E767A4AA6A8796D42C8EB591B7261@BGSMSX101.gar.corp.intel.com>
 <20120911110335.68009452@endymion.delvare>
 <4D68720C2E767A4AA6A8796D42C8EB591B72C6@BGSMSX101.gar.corp.intel.com>
 <20120911114921.2e39e28c@endymion.delvare>
 <20120911134505.GA4123@roeck-us.net>
 <20120911160538.1fc4d23e@endymion.delvare>
In-Reply-To: <20120911160538.1fc4d23e@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: "R, Durgadoss" <durgadoss.r@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>, Len Brown <lenb@kernel.org>, lm-sensors@lm-sensors.org, linux-acpi@vger.kernel.org

On Tue, Sep 11, 2012 at 04:05:38PM +0200, Jean Delvare wrote:
> On Tue, 11 Sep 2012 06:45:05 -0700, Guenter Roeck wrote:
> > I do wonder what is going to happen with existing hwmon temperature sensor
> > drivers which are needed as thermal drivers. Re-write/copy ?
> 
> Have them register as thermal devices and leave their hwmon interface
> unchanged?
> 
> For simple temperature sensor devices, the current situation (expose
> thermal devices as hwmon devices automatically) works well, but if a
> more complex devices (with, say, voltage sensors) needs to be exposed
> as a thermal device then it doesn't work. If we want to handle this
> case, then I see no alternative to having each driver implement both
> interfaces.
> 
Ok, makes sense.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
