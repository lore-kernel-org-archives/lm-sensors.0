From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 Nov 2007 14:37:46 +0000
Subject: Re: [lm-sensors] IT8702F request
Message-Id: <20071103153746.4cee67da@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <472486C0.2080907@edv2g.de>
In-Reply-To: <472486C0.2080907@edv2g.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Gerold,

On Sun, 28 Oct 2007 13:55:28 +0100, Gerold Gruber wrote:
> the list http://www.lm-sensors.org/wiki/Devices says,
> there is a data sheet for the IT8702F sensor, and three requests.
> 
> Well, you can add me to the list of requesters ;-)

Done.

> I could take part in testing.

Note that I wouldn't be surprised if most IT8702F chips were not wired
for monitoring. These chips are rare and only include fan speed
sensors, no voltage sensors nor thermal sensors as other ITE Super-I/O
chips do. Does the BIOS report any fan speed?

You may provide a dump of the hardware monitoring I/O area of your chip
and I'll tell you whether it appears to be actually monitoring fans.
This will prevent you from waiting for a driver that you don't actually
need. It's relatively easy. Take the address sensors-detect reported
the chip was at. Typically it's 0x290. Then call isadump on this
address with offsets 5 and 6, typically:

isadump 0x295 0x296

From the output I can tell you whether fans are monitored or not.

BTW, if someone wants to write this missing driver, that should be an
easy one. I would do it myself if I had the time (or if someone pays me
to do the work.)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
