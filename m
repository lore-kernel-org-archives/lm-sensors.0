From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Feb 2013 12:31:49 +0000
Subject: Re: [lm-sensors] Device 8086:27a3 (Performance counters)
Message-Id: <20130211133149.74eae913@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.LRH.2.02.1302111244410.2736@pikachu.3ti.be>
In-Reply-To: <alpine.LRH.2.02.1302111244410.2736@pikachu.3ti.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 11 Feb 2013 12:51:59 +0100 (CET), Dag Wieers wrote:
> Hi,
> 
> Another question regarding a device found in AppleTV of which I cannot 
> find a lot of information on the net. This PCI device reports itself as:
> 
> ----
> 00:07.0 Performance counters: Intel Corporation Device 27a3 (rev 03)
>          Flags: 66MHz, fast devsel
>          Memory at 22a04000 (32-bit, non-prefetchable) [size=4K]
>          Capabilities: [dc] Power Management version 2
> ----
> 
> Looking for this device on Google, it seems most (if not all) references 
> relate to Apple hardware (mac mini, appletv, macbook). Do we know what 
> it is ? Is there a driver for this device ? Does it have useful system 
> sensors ?

I don't know anything about this, sorry. But "performance counters"
sounds more like a hardware profiling helper device.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
