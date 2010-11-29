From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 29 Nov 2010 19:11:34 +0000
Subject: Re: [lm-sensors] [RFC] Medfield_Current_Monitoring_Driver
Message-Id: <1291057894.20815.150.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101129172516.5185.77145.stgit@bob.linux.org.uk>
In-Reply-To: <20101129172516.5185.77145.stgit@bob.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2010-11-29 at 12:27 -0500, Alan Cox wrote:
> Any views on the best way to approach this. It manages current overflow and
> draw - ie its not a power meter. One possibility is to put it in hwmon with
> some API tweaks as needed, but are there any analogous drivers or likely to
> be ? The other is to move it out of hwmon and into the x86 platform code and
> decide it's not an API/interface that can be usefully genericised.
> 
> My own preference is to make it a platform specific interface and leave it
> that way but I wanted to run it past the hwmon folk first.
> 
> Alan
> 
Seems to be a lot of chip specific stuff. Actually, you don't define a
single hwmon ABI attribute right now. So moving it to the x86 platform
code might be a better option.

One possibility might be to move the driver to the x86 platform code,
but add/use hwmon ABI attributes as much as possible, and register those
attributes as hwmon device if CONFIG_HWMON is defined. Several other
platform specific drivers already do the same.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
