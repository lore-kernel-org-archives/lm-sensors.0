From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: Fw: Re: OMKE and temperature
Message-Id: <20030210102554.11d6802c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030210095456.458d0d87.khali@linux-fr.org>
In-Reply-To: <20030210095456.458d0d87.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Begin forwarded message:

Date: Mon, 10 Feb 2003 10:02:33 +0100 (CET)
From: Soos Peter <sp@osb.hu>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: OMKE and temperature


On Mon, 10 Feb 2003, Jean Delvare wrote:

> I am working with the LM Sensors group (http://www.lm-sensors.nu/) on
> I2C/SMBus busses and devices for hardware health monitoring. We have
> been informed by Virgil that OMKE was able to report temperature for
> his HP Pavilion ze4145, while our own driver doesn't work (if I
> understood correctly). My first guess is that you don't use anything
> I2C/SMBus related, but some HP-specific interface. Am I right?

Yes you hit it ;). I'm read directly from the ACPI Embedded Controller. 
If available I use ACPI ec_read function if not I use my own one. See
the 
http://sf.net/projects/omke for details.

> If this is the case, well, there isn't anything we can do (since I
> don't think we want to support very specific methods, nor any
> non-I2C/SMBus one).

It'd be good to create hooks in the kernel for getting infos about 
hardware, and every module can use them if wants. See
console_blank_hook() 
in console and apm/omnibook code for examlpe.

Regards,
-- 
So?s P?ter		Pannonhalmi F?ap?ts?g / Archabbey of Pannonhalma
			H-9090 Pannonhalma, V?r 1.
			Tel: +3696570189, Fax: +3696470011



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
