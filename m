From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: Question about chip driver policy
Message-Id: <20030829192353.335dfad6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
In-Reply-To: <629E717C12A8694A88FAA6BEF9FFCD440224B3AB@brigadoon.spirentcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In the new-drivers document, under the heading "Write the new driver",
> it says:
> 
>   "Remember that you want to output the direct measurements done by
>   the chip. If these sensor values need scaling, this should be done
>   through the configuration file."
> 
> However, many of the existing drivers don't do this. For example,
> lm85.c has this macro:
> 
> #define FAN_FROM_REG(val) ((val)=0?-1:(val)=0xffff?0:5400000/(val))
> 
> which the driver uses to convert from register values to rps. There
> are lots of similar constructs in other drivers.
> 
> Which is the right way for new drivers - the code or the
> documentation?

The documentation sure would need some clarifications. Yes, most drivers
convert values to output useful information. Chips behave too
differently and it would be a complete mess if we were really outputing
raw values (what would the drivers be worth to then?). I think that what
the documentation tries to prevent there is hardcoding resistor values
for +5V, +12V, -12V and -5V. These values are likely to change from
motherboard to motherboard, and that's why they are set in
/etc/sensors.conf. For the rest, drivers tend to convert from registers
to "real" values (that is, values that make direct sense for a human
being).

Most of the time you will want to believe the driver code :) However,
the best thing to do would be to fix the documentation to match what we
actually do. I have made some modifications to the documentation at the
time I wrote a chip driver myself, feel free to do the same.

And don't hesitate to ask other questions that may come to your mind :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
