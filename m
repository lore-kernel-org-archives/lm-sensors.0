From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 02 Sep 2009 12:51:36 +0000
Subject: Re: [lm-sensors] Ambient Light sensor for Intersil-ISL29020 device
Message-Id: <20090902145136.2d822a57@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090811185416.GB32002@intel.com>
In-Reply-To: <20090811185416.GB32002@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 13 Aug 2009 16:22:29 +0530, Trisal, Kalhan wrote:
> This driver used Hwmon interface ,

No, it doesn't. It registers as a hwmon device but it doesn't implement
_any_ feature listed in Documentation/hwmon/sysfs-interface. Which can
be easily explained: your device is not a hardware monitoring device.

> I don't find the ils29003 registering with hwmon. I still believe
> this should be part of hwmon group.

No, it shouldn't. hwmon is for hardware monitoring. Other sensor types
must find a different home.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
