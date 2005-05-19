From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: who is this ?
Message-Id: <FJEPJHGHDGKMMPFFGCLOGEHAEIAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809094756.6f6f9756.khali@linux-fr.org>
In-Reply-To: <20030809094756.6f6f9756.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

thanks Jean

I also noticed that, but since the voltages are controlled via the INI file
I just go with the minumum voltage input and will add them if I ever
encouter a board that uses it (beside the combo MSI board)

Regards, Alex

- Please always attach all previous mails !
----------------------------------------------------------------------
The Motherboard Monitor:
http://mbm.livewiredev.com/
----------------------------------------------------------------------
For long you live and high you fly,
And smiles you'll give and tears you'll cry,
And all you touch and all you see,
Is all your life will ever be.
----------------------------------------------------------------------



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: zaterdag 9 augustus 2003 09:48
To: MBM Support
Cc: sensors@stimpy.netroedge.com
Subject: Re: who is this ?



> btw, if you update the detection to also check for 65 as version
> number you support the EMC6D102, I have not found any diffrences
> myself in the sheets.

Two things I found in our lm85 drivers:

1* It seems that the EMC6D10x has 3 more voltage inputs than the LM85.
We have the following specific defines for the EMC6D10x:
#define EMC6D100_REG_SFR  0x7c
#define EMC6D100_REG_ALARM3  0x7d
#define EMC6D100_REG_CONF  0x7f
#define EMC6D100_REG_INT_EN  0x80
/* IN5, IN6 and IN7 */
#define EMC6D100_REG_IN(nr)  (0x70 + ((nr)-5))
#define EMC6D100_REG_IN_MIN(nr) (0x73 + ((nr)-5) * 2)
#define EMC6D100_REG_IN_MAX(nr) (0x74 + ((nr)-5) * 2)

We don't use _SFR, _CONF nor _INT_EN in our code as far as I could see.

2* Interesting comment: "Unfortunately, we can't tell a '100 from a '101
from the registers. Since a '101 is a '100 in a package with fewer pins
and therefore no 3.3V, 1.5V or 1.8V inputs, perhaps if those inputs read
0, then it's a '101."

Well, I guess you'd have find all that in the datasheet anyway, but now
you know how we do handle these chips.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
