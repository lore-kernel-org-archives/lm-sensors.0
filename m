From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Keywest detection
Message-Id: <20030807125655.2fe446de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806190950.6326aa8f.khali@linux-fr.org>
In-Reply-To: <20030806190950.6326aa8f.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The driver does it's internal device detection using Open Firmware.  
> Take a look at this in the kernel source:
> 
> arch/ppc/kernel/prom.c
> 
> It's sort of like a PCI device table, except it includes all sorts of 
> hardware interfaces besides just PCI devices.

I'm not used to PCI device tables either, so I'm rather confused.

> If you have a newer Mac around (made within the last few years), you
> can hold down option-o-f while booting to get into the Open Firmware
> 'shell'.  It's a Forth type interpreter which lets you do various
> things like browse the hardware of the computer or change some boot
> params.

Well, I don't have any Mac.

The real question was if there was a way to add Keywest detection to our
sensors-detect script. As it turns out, I think there must be one, but
it will be too complex for inclusion into sensors-detect (and for me
too). That's why I plan to add it to our undetectable adapters list
instead.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
