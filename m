From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 03 Jul 2013 14:48:45 +0000
Subject: Re: [lm-sensors] 3.10: Intel HWMON/NIC temperature sensor question
Message-Id: <20130703144845.GB10323@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <002401ce77e9$da6524b0$8f2f6e10$@lucidpixels.com>
In-Reply-To: <002401ce77e9$da6524b0$8f2f6e10$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Justin Piszcz <jpiszcz@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Wed, Jul 03, 2013 at 08:35:50AM -0400, Justin Piszcz wrote:
> Hi,
> 
>  
> 
> I saw this in the device drive section and was curious which Intel-based
> NICs contain temperature sensors?
> 
>  
> 
> Intel(R) 10GbE PCI Express adapters HWMON support
> 
> Intel(R) PCI-Express Gigabit adapters HWMON support
> 
>  
> 
> I checked the boards below and none appear to expose a hwmon interface:
> 
> 08:00.0 Ethernet controller: Intel Corporation 82580 Gigabit Network
> Connection (rev 01)
> 
> 08:00.1 Ethernet controller: Intel Corporation 82580 Gigabit Network
> Connection (rev 01)
> 
> 08:00.2 Ethernet controller: Intel Corporation 82580 Gigabit Network
> Connection (rev 01)
> 
> 08:00.3 Ethernet controller: Intel Corporation 82580 Gigabit Network
> Connection (rev 01)
> 
> 09:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
> Connection
> 
> 0a:00.0 Ethernet controller: Intel Corporation 82574L Gigabit Network
> Connection
> 
> 01:00.0 Ethernet controller: Intel Corporation 82598EB 10-Gigabit AT2 Server
> Adapter (rev 01)
> 
82575 and 82599. Doesn't matter much, though, since they don't export the "name"
attribute from their driver, meaning the sensors command won't find the sensors.
Also, they enerate the hwmon device first and then create the attributes, which
is the wrong order and creates a potential race condition with demons.

Someone who has a board will have to fix that at some point.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
