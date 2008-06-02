From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 02 Jun 2008 19:02:29 +0000
Subject: Re: [lm-sensors] adm1021 in 2.6.9 question..
Message-Id: <20080602210229.5789dc82@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <484441F5.6000203@salientsystems.com>
In-Reply-To: <484441F5.6000203@salientsystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Warrick,

On Mon, 02 Jun 2008 14:54:45 -0400, Warrick Lacey wrote:
> We have recently transitioned for a 2.4.x based kernel to the 2.6.9 
> kernel and I'm trying to get the onboard temperature sensor working 
> under the 2.6.9 kernel. Under the 2.4.x kernel, we needed i2c-core, 
> i2c-dev, i2c-proc, dmi-scan, i2c-piix4 and adm1021.
> 
> We have not changed hardware (basically a 6U VR7 board), will/should the 
> adm1021 device be an ISA device or an I2C device?.

I2C.

> I see that the adm1021 driver is now part of the kernel in 2.6.x but 
> what steps to I have to take to get the kernel to recognize and access 
> this device under 2.6.9.

Exactly the same as you were doing before:

$ modprobe i2c-piix4
$ modprobe adm1021
$ sensors

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
