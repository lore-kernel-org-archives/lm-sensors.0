From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 14:26:42 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Remove many EXPERIMENTAL flags
Message-Id: <20101014162642.5b7018dd@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014103239.1096f962@endymion.delvare>
In-Reply-To: <20101014103239.1096f962@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 14 Oct 2010 18:04:01 +0400, Owl wrote:
> F71882FG still does not work properly.
> 
> f71882fg: Found f71862fg chip at 0x290, revision 18
> ACPI: resource f71882fg [io  0x0290-0x0297] conflicts with ACPI region 
> IP__ [??? 0x00000295-0x00000296 flags 0x5f]
> ACPI: If an ACPI driver is available for this device, you should use it 
> instead of the native driver

Please don't top-post.

The f71882fg driver works OK, it is simply not suitable for your system
where ACPI wants control over the device.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
