From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 15 Nov 2005 13:15:24 +0000
Subject: [lm-sensors] RE: vt8231.c
Message-Id: <P5kp9Axl.1132056103.6789130.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051102092453.47B1712E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Roger,

On 2005-11-15, Roger Lucas wrote:
> We have another sample of the board here now, so we will be repeating the
> measurements to ensure that the VIA results are predictable from board to
> board.

OK, great. I've tried some mathematics on the formulae to find out if
anything obvious with regards to the physical meaning of the constants
would spring out, but did not find anything.

> I agree that whatever we do, the VIA users must apply some kind of
> equation to get their correct temperature, but I feel that the safest
> approach is "first do no wrong".

Fair enough.

> I am extremely uncomfortable with the situation where we release a
> driver that we know will give incorrect information under some
> conditions.  I feel that it is much better to return the result from
> the driver as a register value and put the text below:

The problem is that the standard sysfs interface sets some contraints on
what we can or cannot do. In particular, it dictates that the magnitude
for temperature values is 3. This suggests that the value we would be
returning would be REG * 1000. As it seems that there are an additional
2 bits of resolution, that would be (REG << 2 + ADDREG) * 250.

> # If you have an Intel CPU, then uncomment the line below
> # temp0_input = (@-65)/0.9686, (@*0.9686)+65
>
> # If you have an VIA EPIA CPU, then uncomment the line below
> # temp0_input = (@-45)/0.7809, (@*0.7809)+45

s/temp0_input =/compute temp1/, but yes.

BTW, does this suggest that you decided that the diode temperature would
be temp1, and thermistor-based ones are temp2+? I have no objection a
priori, just curious.

> This way, an incorrect value is never returned and the user must
> correctly set the board configuration before a temperature is
> returned.

By commenting out both compute lines, I'd rather say that an incorrect
value will *always* be returned. I'd prefer to keep the Intel line by
default so as to preserve backward compatibility as much as we can.

I think you will end up with a dedicated configuration file for your
board anyway. The best we can do to help out VIA EPIA users is to make
this file publicly available.

Thanks,
--
Jean Delvare
