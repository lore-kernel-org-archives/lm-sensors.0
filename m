From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 20 Dec 2005 22:08:46 +0000
Subject: [lm-sensors] [it8712] +5 V/+12 V are ok, but not -5 V/-12 V....
Message-Id: <20051220230846.5dcbd2f0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43A6FE61.1030104@free.fr>
In-Reply-To: <43A6FE61.1030104@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Fred,

> Yes I read that negative voltage can be not displayed.
> 
> Ok, formulas must be used for -5 V & -12 V.
> 
> But /etc/sensors.conf orig mentions that it8712 chip _has_ negative
> voltages :
> 
> # The next two are negative voltages (-12 and -5).
> # The following formulas must be used. Unfortunately the datasheet
> # does not give recommendations for Rin, Rf, but we can back into
> # them based on a nominal +2V input to the chip, together with a 4.096V
> Vref.
> .../...

This is the default configuration for this chip, yes (as suggested by
ITE). But every motherboard manufacturer is free to use these inputs
for any voltage, negative or positive. You then have to edit the
configuration file for the labels and formulas to match your hardware.

> But both display 0 V for my Asus P5ND2-Sli Deluxe.
> 
> So what ? -5 V & -12 V work or don't work for it8712 chip ?

It's a matter of board, not chip. And 0 is a pretty good indication
that these inputs are not used (wired to the ground) in your case. You
can compare with what your BIOS shows if it has hardware monitoring
information.

-- 
Jean Delvare

