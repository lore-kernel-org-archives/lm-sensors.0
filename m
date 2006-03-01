From: devik@cdi.cz (Martin Devera)
Date: Wed, 01 Mar 2006 20:23:54 +0000
Subject: [lm-sensors] HT1000 support (see lm_sensors ticket 2031,
Message-Id: <440602DA.40409@cdi.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
In-Reply-To: <Pine.LNX.4.62.0603010955280.24174@trinity.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> One other possibility is that because I have a BMC card plugged in to 
> the motherboard (SuperMicro H8SSL-i) the BMC card is not allowing access 
> to the devices from lm_sensors.

it works well for me for the same MB, only loaded patched piix4 and then
adm1026 module. Then even supermicro's superodoctor started to work on 
the bow :) But I can imagine that it may become unavailable after BMC is 
plugged in. I havn't bought BMC yet but I want to.

By the way, Jean, is it possible to have two masters on one i2c bus ? 
How are priorities handled then ?

devik

