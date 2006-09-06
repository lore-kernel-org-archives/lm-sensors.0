From: bchang@atipa.com (Brady Chang)
Date: Wed, 06 Sep 2006 19:17:49 +0000
Subject: [lm-sensors] i2c_nforce2 on ASUS K8N-DRE
Message-Id: <E7EB4A8D5B2C8F498A269F0963C8BB8E038329@mail.atipa.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
In-Reply-To: <E7EB4A8D5B2C8F498A269F0963C8BB8E038328@mail.atipa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,
I forgot to mention that the PCI ID  worked on Tyan 2891 did not work for the ASUS k8n-dre.
 
thanks
-Brady
 
 

________________________________

From: Jean Delvare [mailto:khali at linux-fr.org]
Sent: Wed 9/6/2006 2:14 PM
To: Brady Chang
Cc: lm-sensors at lm-sensors.org
Subject: Re: [lm-sensors] i2c_nforce2 on ASUS K8N-DRE



Hi Brady,

> I have the K8N-DRE running redhat 4 update 3
> Kernel 2.6.9-34.0.2ELsmp , sensors version 2.8.7
> 
> 00:01.1 SMBus: nVidia Corporation CK804 SMBus (rev a2)
>         Subsystem: ASUSTeK Computer Inc.: Unknown device 8162
>         Flags: 66Mhz, fast devsel, IRQ 177
>         I/O ports at fc00 [size2]
>         I/O ports at 4c00 [sized]
>         I/O ports at 4c40 [sized]
>         Capabilities: [44] Power Management version 2
>
> 
> Appreciated if anyone knows what  PCI ID's I should add to the nForce2_smbus
> 
> In the past,  I used
> echo "10de 0052" > /sys/bus/pci/drivers/nForce2_smbus/new_id on the Tyans, and it seems to work.

I don't understand what you want. The PCI ID is 10de 0052, you wrote it
yourself above. What's your problem exactly?

--
Jean Delvare


-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060906/85fd3d4a/attachment.html 
