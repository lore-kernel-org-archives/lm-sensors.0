From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 Nov 2012 17:34:09 +0000
Subject: Re: [lm-sensors] Fancontrol for intel HM77
Message-Id: <20121128183409.6bf90e86@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121128120329.GA3502@pegasus.localdomain>
In-Reply-To: <20121128120329.GA3502@pegasus.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 28 Nov 2012 13:03:29 +0100, Fred Grosskopf wrote:
> Hi folks,
> 
> i'm desperatly trying to get some fancontrol working for my laptop
> which has an Intel HM77 chipset.
> 
> I followed the http://en.gentoo-wiki.com/wiki/Lm_sensors guide.
> 
> Everything "looks good" except after starting lm-sensors, pwmconfig
> says:
> 
> /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
> 
> What is the problem, is my hardware to new? How to fix?
> 
> Attached you can find my "sensors-detect" log as well all IC2 related
> kernel settings.

Fan speed control on laptops is almost always achieved by either ACPI
or a vendor-specific kernel driver, not regular hwmon drivers. That
seems to be exactly your case.

For Compal laptops, there's a kernel module named - surprise surprise -
compal-laptop which you should try. I don't know what features it
offers exactly but that should be a good starting point. If it doesn't
work for your model then maybe you need a more recent version of the
driver, or support for your model needs to be added to the driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
