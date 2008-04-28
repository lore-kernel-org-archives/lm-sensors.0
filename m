From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 Apr 2008 14:09:05 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <20080428160905.218fe905@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Wed, 23 Apr 2008 23:27:52 +0200, Rudolf Marek wrote:
> >> [   19.961068] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI
> >> region HWRE [0x290-0x299]
> >>
> >> The ATK driver has no extra funcs then the classic driver so I think you can use
> >>  what you have right now.
> > 
> > You mean that without the ATK0110 driver _nothing_ will access the I/O
> > range? How can you be so sure?
> 
> Yes I can be sure beacuse I checked the DSDT. There is no thermal zone, only the
> proprietary ATK methods to read the chip. Nothing calls them. Gabriel could do
> modprobe thermal ; acpi -V and it should not print any temperature info.

Can you explain to me how you reached this conclusion? When I look at a
DSDT I can usually recognize if it deals with temperatures and fans,
but how do I know if there's a thermal zone or not?

Also, does the absence of thermal zone imply that ACPI isn't running
the methods in question on its own?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
