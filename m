From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 05 Sep 2006 12:17:09 +0000
Subject: [lm-sensors] [RFC] Generic device detection in sensors-detect
Message-Id: <20060905141709.b9de8979.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060902172512.960d5eca.khali@linux-fr.org>
In-Reply-To: <20060902172512.960d5eca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:
> Now that I'm done with all the cleanups in sensors-detect, I thought it
> would be refreshing to go for some inovation. Two ideas came to my
> mind, both related to generic device detection. So far, sensors-detect
> is essentially a long list of known devices to look for on the target
> system. I think we could go one step further, and try to detect chips
> we don't know about yet.
> 
> 1* PCI devices have a class field, which describes the main
> functionality of the device. SMBus is one of the possible classes since
> PCI 2.2. Most recent SMBus adapters have their class properly set to
> 0x0c05 (SMBus), with the notable exception of the VIA ones.
> 
> Thus my first idea is to look for such devices even if we don't know
> about the exact model yet. Patch attached
> (sensors-detect-generic-pci.patch), sample output follows:
> 
>   We can start with probing for (PCI) I2C or SMBus adapters.
>   Do you want to probe now? (YES/no): 
>   Probing for PCI bus adapters...
>   Found unknown SMBus adapter 8086:2483 at 00:1f:3.
> 
> I'm not exactly satisfied with the implementation, but feel tree to
> comment on the idea nevertheless. To try it out, apply the patch, then
> in @pci_adapters, comment out the entry for your own SMBus adapter.

I committed a cleaned-up version. We now use sysfs to enumerate the PCI
devices on Linux 2.6. It also searches for unknown SMBus adapters even
if one was found, in case some systems have more than one adapter.

> 2* The interface to Super-I/O chips is mostly standard, so we should be
> able to talk even to Super-I/O chips we don't specifically know about.
> The logical device used for hardware monitoring differs from one chip
> to the next, but a good half of the chips (Winbond, ITE and Fintek
> ones) still use the legacy I/O address 0x290 for hardware monitoring.
> 
> Thus my second idea is to scan all the logical devices when we find an
> unknown Super-I/O chip, and see if one is set to I/O address 0x290 or
> nearby. If we find one, this means that this unknown Super-I/O chip
> most certainly embeds hardware monitoring features, and we can tell
> that the user. Patch attached (sensors-detect-generic-superio.patch),
> sample output follows:
> 
>   Some Super I/O chips may also contain sensors. We have to write to
>   standard I/O ports to probe them. This is usually safe.
>   Do you want to scan for Super I/O sensors? (YES/no): 
>   Probing for Super-I/O at 0x2e/0x2f
>   Trying family `ITE'...                                      No
>   Trying family `National Semiconductor'...                   No
>   Trying family `SMSC'...                                     No
>   Trying family `VIA/Winbond/Fintek'...                       No
>   Probing for Super-I/O at 0x4e/0x4f
>   Trying family `ITE'...                                      No
>   Trying family `National Semiconductor'...                   No
>   Trying family `SMSC'...                                     No
>   Trying family `VIA/Winbond/Fintek'...                       Yes
>   Found unknown chip with ID 0x0406
>       (logical device 4 has address 0x295, could be sensors)
> 
> This patch is simple and clean, and I think could be applied as is. The
> only change I might do is to only attempt a guess for the "ITE" and
> "VIA/Winbond/Fintek" families, as we've never seen an SMSC or National
> Semiconductor Super-I/O chip with hardware monitoring device at 0x290
> anyway.
> 
> To try it out, apply the patch, then in @superio_ids, comment out the
> entry for your own Super-I/O chip.

I committed an updated version implementing the above improvement.

Thanks to all who helped me with testing!

-- 
Jean Delvare

