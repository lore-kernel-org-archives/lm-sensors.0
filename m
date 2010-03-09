From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Mar 2010 08:48:47 +0000
Subject: Re: [lm-sensors] Upgraded my old Debian box's Kernel from 2.6.30 to
Message-Id: <20100309094847.2ae9bdb8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100305222015.GR11436@alpha.zimage.com>
In-Reply-To: <20100305222015.GR11436@alpha.zimage.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phillip,

On Mon, 8 Mar 2010 13:43:14 -0800, Phillip Pi wrote:
> In older Kernels like v2.6.30, did this conflict happen too? I only 
> remember seeing inaccurate values like for voltages. Speaking of 
> voltages, which part is responsibile for voltages showing that I don't 
> have in 2.6.32, but did in 2.6.30?

Please be specific. What chip is it, which voltages are missing?

Remember that the output of sensors is influenced by the contents of
libsensors configuration files (/etc/sensors.conf, /etc/sensors3.conf
and/or /etc/sensors.d/* depending on your libsensors version and
distribution choices.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
