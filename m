From: fredantispam@free.fr (fred)
Date: Mon, 19 Dec 2005 18:39:29 +0000
Subject: [lm-sensors] [it8712] +5 V/+12 V are ok, but not -5 V/-12 V....
Message-Id: <43A6FE61.1030104@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Yes I read the FAQ.

Yes I read that negative voltage can be not displayed.

Ok, formulas must be used for -5 V & -12 V.

But /etc/sensors.conf orig mentions that it8712 chip _has_ negative
voltages :

# The next two are negative voltages (-12 and -5).
# The following formulas must be used. Unfortunately the datasheet
# does not give recommendations for Rin, Rf, but we can back into
# them based on a nominal +2V input to the chip, together with a 4.096V
Vref.
.../...

But both display 0 V for my Asus P5ND2-Sli Deluxe.

So what ? -5 V & -12 V work or don't work for it8712 chip ?

Thanks.

-- 
Fred.

