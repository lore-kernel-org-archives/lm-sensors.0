From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: IBM hardware
Message-Id: <1079701837.405af14d1faa4@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200403161623.00418.rafael.espindola@ic.unicamp.br>
In-Reply-To: <200403161623.00418.rafael.espindola@ic.unicamp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Rafael ?vila de Esp?ndola <rafael.espindola@ic.unicamp.br>:

> Some additional info.
> The computer is a "IBM ThinkCentre M50 8188-LPF".
> The output from the command 
> dd if=/dev/mem of=/tmp/mem-rafael bsdk skip count=1
> is attached.

Thanks :) I've already added this information to vpddecode, and added
your BIOS image to the collection I use for regression tests.

If I can find some time for this, I'll go on improving sensors-detect so
that it recognizes your machine as safe. The needed mechanisms are not
set up yet.

> I will try to discover if there is any other sensor in the
> motherboard.

OK, let us know if you find something interesting.

> Ps.: Sorry for the previous (incomplete) email

Oh well, nothing to be sorry about. How could you have guessed what I
wanted? ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
