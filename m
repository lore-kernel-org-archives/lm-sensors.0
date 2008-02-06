From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 06 Feb 2008 18:26:02 +0000
Subject: Re: [lm-sensors] failed to load it87 module on IT8712F
Message-Id: <20080206192602.72adaf64@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <002001c8641e$71d8f6e0$180411ac@EDVW14>
In-Reply-To: <002001c8641e$71d8f6e0$180411ac@EDVW14>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 6 Feb 2008 09:42:44 +0100, Peter Eser wrote:
> Hi Jean,
> 
> yes the values of the it8712 make sense.
> Most likely its a BIOS issue, I try now to connect Aaeon (They celebrate new
> year at the moment...).
> The VT1211: I have a VIA CX700M on board and on
> http://www.via.com.tw/en/products/chipsets/c-series/cx700m/
> it looks like it's included.

If you refer to the block diagram on that page, then I think you're
wrong: the VT1211 is there only as an illustration of how the various
chips fit in the big picture. It's a separate chip, it's not included
in the CX700M at all. VIA puts a VT1211 as an example but motherboard
manufacturers are free to use functionally equivalent parts... such as
the IT8712F.

> Many Thanks, I let you know how the story moves on...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
