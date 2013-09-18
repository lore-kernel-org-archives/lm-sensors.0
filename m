From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Sep 2013 11:31:53 +0000
Subject: Re: [lm-sensors] +12 Voltage Constantly at +10.48 V on ASUS M5A78LE
Message-Id: <20130918113153.GB9447@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130918110156.Horde.yeEgEajJkz1f9borvfxiyA4@webmail.df.eu>
In-Reply-To: <20130918110156.Horde.yeEgEajJkz1f9borvfxiyA4@webmail.df.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 18, 2013 at 11:01:56AM +0200, Sascha Haupt wrote:
> 
> Dear @ll,
> 
> I am monitoring multiple systems (with Asus M5A78LE mainboards)
> using sensors and Munin.
> 
> On one of the nodes, the +12 V value is constantly reported to be
> +10.48 Volt which
> causes Munin to report a warning (value outside 10.92 to 13.08 Volt range).
> The value seems to be close to +12 V on all other nodes.
> 
> One idea was that the system reduces voltage to save power.
> Therefore I caused some load on the node:
> 
> root:/home/root # md5sum /dev/urandom &
> root:/home/root # md5sum /dev/urandom &
> root:/home/root # md5sum /dev/urandom &
> root:/home/root # md5sum /dev/urandom &
> 
> What I can see is that the 1.4 V value is now constanly at 1.38 V.
> Previously, it jumped between 1.01 V and 1.38 V.

Makes sense, as the CPU voltage changes with load.

> However, there is no difference in the +12 V value.
> 
12V voltage does not usually change baed on power states.

> I do not understand why the 12 V value stays at such an low voltage.
> 
> May any power saving options cause that behaviour (when yes, which
> settings can cause that)?
> Do you have any ideas how I can localise the cause of the +10.48 Volt value?
> 
Maybe there is a problem with that system ? Can you measure the voltage at the
power supply ? That may even be related to the fan problem you reported earlier
if that is on the same system, as the fans operate on 12V.

Guenter

> Thanks for your help.
> 
> Best regards
> Sascha Haupt
> 
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
