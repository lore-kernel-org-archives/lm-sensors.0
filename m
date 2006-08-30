From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 30 Aug 2006 13:03:17 +0000
Subject: [lm-sensors] request ITE IT8282M
Message-Id: <20060830150317.1408bee7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608301222.39414.A.Huisman@inter.nl.net>
In-Reply-To: <200608301222.39414.A.Huisman@inter.nl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Age,

> > Better try sensors-detect to find out what chip you have.
> 
>  The problem is, it is still in the box, i just got it and i don`t have
>  a PCI(e) video-card to test it out.
> 
>  Waiting for the Open Graphics Card  :-)
>  
>  I searched the web for information and found this link :
>  
>  http://www.overclockersonline.com/index.php?page=articles&num92&pnum=4
>  
>  "This area is home to the IT8282M chip that provides voltage and temperature monitoring"

You shouldn't trust random websites. The guy obviously has no clue what
he is talking about. The IT8282M appears to be some voltage regulation
chip, not monitoring. And it definitely doesn't have anything to do with
temperature.

>  Ok, i will mail Epox for the wright information.

If you download the PDF manual for this motherboard (or open the box
and pick the paper copy, I guess) you'll find a system block diagram.
On this diagram it appears that the chip responsible for the hardware
monitoring on this board is the Super-I/O chip. This seems to be a
custom chip made by Epox themselves: "EPoX EP1308".

We don't have a driver for this chip yet (I didn't even know EPoX was
doing Super-I/O chips 10 minutes ago), so unless it happens to be
compatible with another Super-I/O chip for the hardware monitoring
part, it isn't supported.

-- 
Jean Delvare

