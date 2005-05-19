From: mr-smoke@spinning-plates.eu.org (Romain Riviere)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: ---=== Lm_sensors Support DB Entry ===--- 1382
Message-Id: <1061440403.7881.8.camel@marla.spinning-plates.eu.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020324193410.GA7656@chrysler.kbs.twi.tudelft.nl>
In-Reply-To: <20020324193410.GA7656@chrysler.kbs.twi.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I'm not doing anything differently at all :(
However, I have sensors_init_all defined in drivers/sensors/sensors.c
It makes me wonder whether the patching was OK or not.
By the way, I checked drivers/sensors/sensors.o, and it was 8 bytes
long: it just had something like !<arch> in it and that's all.

I'll try patching again and will keep you informed.

thanks,
Romain

On Thu, 2003-08-21 at 05:28, Nobody wrote:
> Your Lm_sensors support entry has been updated.
> 
> Please go to http://secure.netroedge.com/~lm78/support.html to check
> the status of your entry.  
> 
> Ticket # 1382
> 
