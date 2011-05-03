From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 May 2011 11:42:58 +0000
Subject: Re: [lm-sensors] Using lm-sensors with TWL4030
Message-Id: <20110503134258.047c75a8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DBFE717.1060000@je-suunnittelu.fi>
In-Reply-To: <4DBFE717.1060000@je-suunnittelu.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 03 May 2011 14:29:27 +0300, Niclas Knuts wrote:
> I am trying to setup lm-sensors for use with the Texas Instruments 
> TWL4030 Chip (the main processor is  a OMAP3503). But I cannot seem to 
> get it to detect the chip. I have added the hwmon drivers and I am using 
> up to date MADC drivers that I have backported to kernel 2.6.32 (I am 
> running Angstrom).

Disclaimer: I don't know a thing about this chip nor its drivers.

There is no detection support for this device in sensors-detect, if
this was your question. I don't think this device can be detected from
user-space.

My understanding is that the drivers for the TWL4030 should all get
loaded automatically thanks to module aliases, as long as the TWL4030
itself is properly registered during platform setup. Check in lsmod
whether twl4030-madc and twl4030-madc-hwmon are actually loaded. If
not, try loading them manually.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
