From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 08 Sep 2013 19:09:53 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <20130908210953.0a4b5ca1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 08 Sep 2013 11:58:39 -0700, Guenter Roeck wrote:
> Different driver. Centos 6.4 uses the coretemp driver which gets the temperature
> from the CPU directly. Unfortunately, Centos 6.4 is quite old when it comes to
> kernel version, and so is its coretemp driver. The displayed temperatures in your version
> are all wrong; the maximum temperature for Atom 330 is 125 degrees C, not 90 degrees C.
> You'll have to add 35 degrees C to the displayed temperature.
> 
> You could either update the coretemp driver to a later version to fix this,
> or add the offset to /etc/sensors3.conf.
> 
> Note that CPU temperatures are notoriously unreliable.

"Inaccurate in the low temperature range" is a better way to describe
the situation IMHO. The coretemp values are reliably telling the user
when the temperature gets too close to the high limit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
