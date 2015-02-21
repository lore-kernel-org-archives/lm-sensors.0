From: Phil Pokorny <ppokorny@penguincomputing.com>
Date: Sat, 21 Feb 2015 18:37:05 +0000
Subject: Re: [lm-sensors] Address Port chip IT8620E
Message-Id: <CAAek22E+Rc=JQDoXTM7fTGqK9n7WqafG41yBRdXoWfjR9ENSyg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU436-SMTP13606C23E77219C144F9B1A902B0@phx.gbl>
In-Reply-To: <BLU436-SMTP13606C23E77219C144F9B1A902B0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday, February 21, 2015, cedric <cedric321@hotmail.fr> wrote:

> Hello,
>
> I see that lm-sensors.org have no datasheetfor chip IT8620E.
>
> Because in0 and in4, i think, is badly displayed with modeprobe it87
> option force_id=0x8728
> I contacted gigabyte-support and they gived me a little table.
>

This is helpful.

Can you ask them for the resistor voltage dividers on each input for your
board?  That way we can help you write the formulas for the sensors.conf
file.

Phil P.


-- 
Philip Pokorny, RHCE
Chief Technology Officer
PENGUIN COMPUTING, Inc
www.penguincomputing.com

Changing the world through technical innovation
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
