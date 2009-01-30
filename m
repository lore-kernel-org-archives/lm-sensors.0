From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 16:23:36 +0000
Subject: Re: [lm-sensors] Problem with order of module loading
Message-Id: <20090130172336.533d6698@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090125021151.GE16739@paradise.net.nz>
In-Reply-To: <20090125021151.GE16739@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 28 Jan 2009 09:06:28 +0100, Jean Delvare wrote:
> I have discussed this a bit with Kay Sievers yesterday. He suggested
> that we can use the modalias files in sysfs together with "modprobe -n"
> to find out whether a loaded hwmon driver has been auto-loaded or not.
> This would let us exclude kernel modules from /etc/sysconfig/lm_sensors
> based on whether they auto-load rather than based on whether they were
> loaded when sensors-detect was run. This should be way more robust than
> my initial proposal, to a point where I think it would make sense to
> give it a try.

Damn, it isn't as easy as I thought. Not all drivers follow the Linux
device driver model to the letter. Actually, most hwmon drivers do not,
because they create their own devices. Once such a driver is loaded, it
appears to be autoloading (its devices have modalias strings that point
to the driver) but in fact it is not. This fools my new code into
thinking that pretty much all loaded hwmon drivers were autoloaded.

Thus I fear I will have to limit the scope of my autoloading detection
code to PCI devices. At least this covers the k8temp driver, which is
probably the one that causes the more trouble in practice.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
