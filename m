From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:47 +0000
Subject: [Patch 2.6] it87 part3(pwm)
Message-Id: <20040314113823.3755a718.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040313143512.571098a9.komoriya@paken.org>
In-Reply-To: <20040313143512.571098a9.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting myself:

> I invite you to use 2.6.4-mm1 as the base for your patch. It aleady
> has your two previous patches.

Just realized I'm wrong here. MMH's refactoring patch is *not* in
2.6.4-mm1, so I invite you to base your patch on 2.6.4-mm1 + this patch:
http://delvare.nerim.net/i2c/linux-2.6/linux-2.6.4-i2c-chips-refactoring.diff

Just take a look at it87.c after patching and you should understand
easily how to adapt your own work. BTW, sorry that our recent changes
will require a bit more work from you, but we believe that these changes
were the right thing to do, so the sooner, the better.

Sorry for the wrong information too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
