From: "Tomas Larsson" <tomas@tlec.se>
Date: Sun, 08 Sep 2013 20:01:24 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAIy6UfOI9ilKgAiL00FYIuABAAAAAA==@tlec.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Sunday, September 08, 2013 9:10 PM
> To: Guenter Roeck
> Cc: Tomas Larsson; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
> 
> On Sun, 08 Sep 2013 11:58:39 -0700, Guenter Roeck wrote:
> > Different driver. Centos 6.4 uses the coretemp driver which gets the
> > temperature from the CPU directly. Unfortunately, Centos 6.4 is quite
> > old when it comes to kernel version, and so is its coretemp driver.
> > The displayed temperatures in your version are all wrong; the maximum
> temperature for Atom 330 is 125 degrees C, not 90 degrees C.
> > You'll have to add 35 degrees C to the displayed temperature.
> >
> > You could either update the coretemp driver to a later version to fix
> > this, or add the offset to /etc/sensors3.conf.
> >
> > Note that CPU temperatures are notoriously unreliable.
> 
> "Inaccurate in the low temperature range" is a better way to describe the
> situation IMHO. The coretemp values are reliably telling the user when the
> temperature gets too close to the high limit.
> 
> --
> Jean Delvare

Well, I'm aware of that, what I want to know is when the fan fails, these
40mm fans are not that reliable, unfortunately.
However, regarding adding 35 degC offset, I can't find any entries in the
/etc/sensors3.conf. file, that is uilized by the coretemp driver.
Obviously using CENTOS I am stuck with the drivers in hand, doubt that they
will make updates available, unfortunately.


Tomas Larsson


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
