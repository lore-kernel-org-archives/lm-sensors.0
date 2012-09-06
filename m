From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 06 Sep 2012 19:34:24 +0000
Subject: Re: [lm-sensors] Patching help
Message-Id: <20120906213424.4132e99a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
In-Reply-To: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 6 Sep 2012 20:23:51 +0100, Simon Tims wrote:
> zgrep I2C_PIIX4 /proc/config.gz
> 
> reports no such file or directory; on my server, /proc exists but
> /config.gz isn't within it.

It is only there if a specific kernel configuration option is enabled,
which is apparently not the case on your kernel.

Distributions often place a copy of the kernel configuration file
under /boot. If you can find a kernel configuration file there, search
for I2C_PIIX4 in it. Something like:

# grep I2C_PIIX4 /boot/*config*

should do.

> I think it looks like the combination of the HP N40L with Ubuntu isn't
> presently supported by LM Sensors yet, due to Debian not being
> supported by the SMBus multiplexing driver.

Correct.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
