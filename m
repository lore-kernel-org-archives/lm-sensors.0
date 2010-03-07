From: Ken Milmore <ken@kenm.demon.co.uk>
Date: Sun, 07 Mar 2010 02:13:07 +0000
Subject: [lm-sensors] Andigilog asc7621 driver: Temperature scaling
Message-Id: <4B930BB3.6030201@kenm.demon.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi George et al,

Its great to see the aSC7621 driver being resurrected, but I notice in 
the patches flying about recently (see LKML 22 Feb 2010 in particular) 
that the voltage calculation is a bit off, as I already pointed out in a 
previous review.  To get the correct results, it is much easier to use 
the 3/4 scale values given in the data sheet, and also be careful to do 
the multiplication before the division to avoid loss of precision (Hint: 
The BSD version of the driver does it correctly!).

See below:


static int asc7621_in_scaling[] = {
     2500, 2250, 3300, 5000, 12000
};


For the 10-bit voltage registers, do something like this:

long regval      (data->reg[param->msb[0]] << 8) |
     (data->reg[param->lsb[0]]);
regval = (regval >> 6) * asc7621_in_scaling[index] / (192 << 2);


And for the 8-bit registers:

long regval = data->reg[param->msb[0]];
regval = regval * asc7621_in_scaling[index] / 192;


I've not yet checked the code thoroughly to look for any of the other 
fixes which were put in during our previous discussions, but I suspect 
that some of the other minor fixes which were discussed on the mailing 
list may have been left out.

This was a very ambitious driver in that it included all the fancy 
thermal management features of the aSC7621, and a complete review and 
testing of everything in the driver was a lot more than I had the 
stomach for.  I'm glad to see others have now picked it up though!

Best wishes,

Ken.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
