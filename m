From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 27 Feb 2014 19:55:47 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <20140227205547.2f867c54@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Thu, 27 Feb 2014 09:52:42 -0800, Guenter Roeck wrote:
> On Thu, Feb 27, 2014 at 06:20:54PM +0100, Jean Delvare wrote:
> > First time I see this. I don't know which driver does this but this
> > looks pretty wrong, "pkg" is way too generic as a device name. This
> > should be fixed quickly.
>
> Not sure, but it might come in through drivers/thermal/x86_pkg_temp_thermal.c.
> It registers thermal zones named pkg-temp-<processor id>.

A name with a dash, that's bad. What about catching (and rejecting)
these in hwmon_device_register_with_groups?

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
