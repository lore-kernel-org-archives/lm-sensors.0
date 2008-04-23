From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Apr 2008 21:21:10 +0000
Subject: Re: [lm-sensors] ASUS P5E-VM DO and unknown chip with ID 0x0b00
Message-Id: <20080423232110.3b68540c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <48077504.4000905@frugalware.org>
In-Reply-To: <48077504.4000905@frugalware.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 23 Apr 2008 22:50:27 +0200, Rudolf Marek wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi all,
> 
> I checked the DSDT as soon you would not use that driver you are safe to use the
>  driver you are using right now.
> 
>         OperationRegion (HWRE, SystemIO, IOHW, 0x0A)
> 
> The operation region is 0x290-0x29A dont know how the reported line got to 299

0xA is the size, 0x290 + 0xA - 1 = 0x299 is the last I/O port. Nothing
wrong here from a mathematical point of view (but this I/O range makes
no sense from a hardware point of view.

> [   19.961068] ACPI: I/O resource w83627ehf [0x295-0x296] conflicts with ACPI
> region HWRE [0x290-0x299]
> 
> The ATK driver has no extra funcs then the classic driver so I think you can use
>  what you have right now.

You mean that without the ATK0110 driver _nothing_ will access the I/O
range? How can you be so sure?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
