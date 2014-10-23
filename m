From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Thu, 23 Oct 2014 23:28:48 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (i5500_temp) Don't bind to disabled sensors
Message-Id: <20141023232848.GA23126@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20141023114047.3be4ca6b@endymion.delvare>
In-Reply-To: <20141023114047.3be4ca6b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 23 Oct 2014, Jean Delvare wrote:
> On many motherboards, for an unknown reason, the thermal sensor seems
> to be disabled and will return a constant temperature value of 36.5
> degrees Celsius. Don't bind to the device in that case, so that we
> don't report this bogus value to userspace.

...

> +	if (tsfsc = 0x7F && tstimer = 0x07D30D40) {
> +		dev_warn(&pdev->dev, "Sensor seems to be disabled\n");
> +		return -ENODEV;

If this is an autoloadable module, and this sensor is very often disabled,
shouldn't this be dev_info() or dev_notice()?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
