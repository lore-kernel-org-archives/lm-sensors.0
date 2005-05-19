From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: no FAN3 available
Message-Id: <20030915194830.28be6876.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200309011224.08300.martin@martin-fernau.de>
In-Reply-To: <200309011224.08300.martin@martin-fernau.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > There is something there. Something we don't know yet, but it's
> > there. Please provide the output of "i2cdump 0 0x18" (make sure
> > i2c-viapro is loaded). (I got the strange feeling that I *already*
> > asked you for that output... Please forgive me if this is the case).
> 
> no problem. In your last mail you don't talk about this, but it's ok.
> I append the output to this mail.

Hm. Reading my own words now, I'm not sure that what I really meant was
obvious. I never meant "hey, I already asked you, what the hell are you
waiting for." I instead meant "I'm going slightly mad, please forgive me
if I'm telling the same thing many times as old people tend to do." Hope
it is clear now.

As far as the dump is concerned, I don't know which chip it is. It looks
like a chip, for sure, but not necessarily a hardware monitoring one. I
don't recognize any known company ID.

I'd like you to run the i2cdump command again. I'm looking for values
that change between dumps. Monitoring chips should have some. Repeat the
process enough times to know for sure:
1* Which values change, which don't.
2* The "range" for changing values (more likely a set of discrete
values).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
