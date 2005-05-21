From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 21 May 2005 09:50:14 +0000
Subject: [lm-sensors] No temperature/fan values with 83627THF chip
Message-Id: <428EE7F7.5000604@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
In-Reply-To: <Pine.LNX.4.56.0505201624000.1858@io.tertial.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again,

> 
> Sensors-detect output was attached to the original post, but here it is 
> again, just in case!

I asked because it was not there :)

> 
> Isadump output:
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Hmm that I strange. Please can you reboot without loading the module and
do: cat /proc/ioports Thanks.


> I'll also take a look at the various IPMI projects you mentioned.

> Client found at address 0x2f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83791D'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F (rev.1)'... Failed!
> Probing for `Asus AS99127F (rev.2)'... Failed!
> Probing for `Asus ASB100 Bach'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1029'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!

See? Nothing Is detected but this address often used for HW monitoring.

> Client found at address 0x4b

Typical subclient address  #1
> Client found at address 0x4f
Typical subclient address  #2

Please can you try sensors-detect from CVS or from 2.9.1 version? We are thinking you have Winbond W83792D that is used for HW monitoring.
You can find the driver in lm_sensors 2.9.1. The driver is currently ported to 2.6 so it is only avaiable for 2.4 kernels
now.

Regards

Rudolf


