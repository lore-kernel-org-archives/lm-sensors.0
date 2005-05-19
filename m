From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <20040126193724.209a3916.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Reinhard,

> Attached you'll find the 2.6.x module and configuration.

Great :)

> Is there a guide for writing chip documentation, as I don't know what
> to do with "Chip Features" in doc/chips/fscher?

No chip-specific documentation has been commited to Linux so far,
although I planned to do so too. Basically I think that "Chip Features"
should become "Sysfs Interface" and be a simple list of all files with
permissions (R-, -W or RW) and comments if they are needed.

> Is there a guide, how to port the sensors program?
> 
> Without changes, sensors just gives me the following:
> 
> fscher-i2c-0-73
> Adapter: SMBus I801 adapter at 2000
> +12V:           +11.86 V
> +5V:             +5.05 V
> Battery:         +3.05 V

This is libsensors that needs to be ported, not sensors. I was a bit
surprised that sensors doesn't seem to complain about missing values,
but contrary to most other chips, FSC chips support in sensors silently
ignores errors. Maybe this should be fixed for the sake of consistency.

Here are the steps that need to be taken now:
1* Fix libsensors so that it handles fscher correctly.
2* Update the 2.4 version of the driver so that it handles voltages the
   same way the 2.6 driver does.
3* Apply your patch to sensors.conf.eg.
4* Review your 2.6 driver and send it to Greg KH for inclusion into
   Linux 2.6.3.
5* Fix sensors so that it shows errors for FSC chips.

You must understand that step 3 doesn't make sense unless step 2 is also
achieved. The 2.4 and 2.6 drivers have to be as compatible as possible
so that users can switch from one to the other and back.

I will work on 1* (and possibly 5*) right now. Please work on 2*
meanwhile. Once done I'll do 3*, and you'll test that both the old and
the new driver work OK.

Then, and only then, I'll review your 2.6 driver (with changes if you
have done any) and submit it to Greg.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
