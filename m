From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 02 Mar 2014 13:54:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Do not accept name attributes which include '-'
Message-Id: <20140302145420.662e0bf1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393612837-20042-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 2 Mar 2014 14:17:43 +0100, Jean Delvare wrote:
> Also I think we want to discuss the x86_pkg_temp_thermal driver case
> with the guys responsible for it. The driver creates a thermal zone
> with type "pkg-temp-0" (and "pkg-temp-1" etc. if you have more than one
> CPU.) The thermal-to-hwmon bridge puts "pkg-temp-0" in the name
> attribute, which causes libsensors to have to deal with a device named
> "pkg-temp-0-virtual-0". Horrible.
> 
> Changing "pkg-temp" to "pkg_temp" isn't enough. We also need to teach
> the thermal-to-hwmon bridge how to deal with multiple instances of the
> same thermal device. And we need to find a way to transmit the
> information to libsensors (presumably trough a new sysfs attribute?),
> and then implement the support in libsensors.

Correction: the thermal-to-hwmon bridge consolidates the thermal zones
of the same type into a single hwmon device. So there will never be
multiple instances of the same type, and libsensors is fine as it is.

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
