From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Sep 2012 14:19:33 +0000
Subject: Re: [lm-sensors] Patching help
Message-Id: <20120911161933.08125501@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
In-Reply-To: <CAPevXitqR63A+B0KH3ZfRfC-E=dHQVF7ak7MupQf-WUzcDnhbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Simon,

Please don't top-post.

On Sun, 9 Sep 2012 20:11:41 +0100, Simon Tims wrote:
> Yes, that does give more detail:
> 
> /boot/config-3.0.0-12-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.0.0-16-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.0.0-17-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.0.0-19-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.0.0-20-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.0.0-21-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.0.0-22-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.0.0-24-generic-pae:CONFIG_I2C_PIIX4=m
> /boot/config-3.2.0-29-generic-pae:CONFIG_I2C_PIIX4=m

So your kernel has the i2c-piix4 driver compiled as a module. You
should see it as file:

/lib/modules/3.2.0-29-generic-pae/kernel/drivers/i2c/busses/i2c-piix4.ko

Please confirm you have this file.

Next step is to have a standalone replacement of that driver with
support for the additional SMBus channels. Thomas (Cc'd) is supposedly
working on this, once the code goes upstream, I will make a standalone
i2c-piix4 driver available for download.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
