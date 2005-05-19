From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <1075195443.40162e337c724@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I think I would handle it that way:
> 1* v = (v >> 1) & 0x07.
> 2* v & 0x04 ? -> 3
>    v & 0x02 ? -> 2
>    else -> 1
> 
> Basically this means the following conversion table, if I'm not
> mistaking:
> 0..2 -> 1 (div=2)
> 3..4 -> 2 (div=4)
> 5+   -> 3 (div=8)
> 
> Should be fast and efficient enough, and keeps the code clear (IMHO
> at least).

In fact it isn't, since large values (>8) will lead to random divs.
Maybe the following is better:

if (v >= 8) v = 3;
else if (v >= 4) v = 2;
else v = 1;

Fast enough and much more readable IMHO. Sorry for my initial bogus
idea.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
