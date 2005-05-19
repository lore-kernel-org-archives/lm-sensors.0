From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Issues with lm_sensors on Intel SE7501cw2
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E23BC@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
In-Reply-To: <9D8C1A43309BAD4A9B46071DAF911D9E3E237D@exch01.paracel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

How do I do a dump of the chip?

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: Thursday, October 23, 2003 11:44 AM
To: sensors@Stimpy.netroedge.com; Marc Rieffel
Subject: Re: Issues with lm_sensors on Intel SE7501cw2



> agreed. if sensors-detect finds it at 0x290,
> then w83781d should find it at 0x290. Don't know what's wrong here.
> 
> As I said earlier, if it isn't at 0x290, w83781d won't find it.

The chip is at 0x290 (or wouldn't have detected by sensors-detect
anyway).

I suspect that the chip ID is 0x21. Sensors-detect is still tolerant on
the low bit (for ISA only), the driver isn't. As it was admitted that
only the original W83781D had two possible IDs (0x10 and 0x11), I had
been removing the general low bit tolerance in both the driver and
sensors-detect (I2C), but then forgot to do the same for ISA detection.

Well, I'm just guessing. Maybe it's completely different. Marc, could
you please provide a dump of your w83627hf chip? That way I could
understand why the w83781d driver doesn't want to handle it while it is
supposed to.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
