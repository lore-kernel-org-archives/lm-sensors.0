From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 May 2011 12:03:24 +0000
Subject: Re: [lm-sensors] Adding 83627ehf input to sensors
Message-Id: <20110503140324.39502603@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DBEE857.3010709@ridgellc.com>
In-Reply-To: <4DBEE857.3010709@ridgellc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 02 May 2011 10:22:31 -0700, Mike Eneboe wrote:
> I have a Lanner 8875B and it implements power supply fault sensing on 2 
> GPIO bits (36 and 37) of 83627ehf chip.  I cannot figure out how to 
> integrate those 2 pins into the sensors functionality so that I can get 
> simpler enclosure monitoring for ALL aspects.
> 
> Can you give me a clue on how to do this?

lm-sensors currently doesn't have any support for this, even though it
could certainly be supported. It's not too different from the chassis
intrusion detection feature.

However, in practice it will be more difficult, because it is based on
GPIOs rather than dedicated pins, so we need board-specific information
to implement it. And we'd need a driver for the GPIO pins of the
W83627EHF and compatible devices, which doesn't exist currently. So
that's a long way to go.

> I'm using Ubuntu 10.04 LTS.
> 
> Regards,
> 
> Mike Eneboe
> Ridge Partners, LLC
> 
> P.S. Does anyone have a link to a comprehensive document for how all the 
> signals are brought into the OS and how to link them to ACPI?

"ACPI" and "comprehensive" can't match, I'm afraid.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
