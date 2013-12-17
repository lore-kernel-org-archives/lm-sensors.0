From: Christian Herzog <herzog@phys.ethz.ch>
Date: Tue, 17 Dec 2013 06:32:26 +0000
Subject: [lm-sensors] I2C support for AMD Hudson-1
Message-Id: <20131217063226.GD25105@phys.ethz.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear list,

I'm currently beta testing a pretty cool embedded board for router
applications etc. (http://www.pcengines.ch/apu.htm) that sports a Hudson-1 FCH
which is pretty similar to the Hudson-2 your module supports but sufficiently
different so that i2c-piix4 doesn't work.
I found a patched i2c-piix4 source that adds support for the Hudson-1 and it
works beautifully: http://www.men.de/products/13SC24-90.html#t=overview
Now I'm wondering if you would be willing to get this patch into lm-sensors
and also the kernel.
If there's anything I can do to help, please let me know.
I expect those boards to become at least as popular as their alix predecessors
were, so out-of-the-box kernel support would be nice.

thanks and kind regards,
-Christian


-- 
Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
IT Services Group, HPT H 8                    voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://nic.phys.ethz.ch/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
