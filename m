From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: i2c-amd756 and dual opteron sensors not foun
Message-Id: <1078156381.40435c5de45dd@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
In-Reply-To: <E039AC86-6597-11D8-8D31-000A958E5EF8@defenderhosting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Philip Pokorny <ppokorny@penguincomputing.com>:

> The ADM1027 is a monitoring chip.  There is a driver written for it.
> "adm1027"
> (...)

Aha :) Philip, now I'm sure you have a filter on "lm85" ;)

FYI, the problem is not with the ADM1027 itself (if that's what it is)
but with activating the AMD-8111 bus it is supposed to be connected
to.

This much ressembles the hidden SMBus problem seen on ICH2 and ICH4
chips, as well as some ALi chips if I remember correctly. But we've
never seen it on AMD's so far, and I don't know how we can get
information about it.

If you know anything about how we could activate that hidden 8111 bus,
please let us know!

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
