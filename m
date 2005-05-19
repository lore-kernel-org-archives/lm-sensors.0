From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: PWM on a W83697HF
Message-Id: <1080222282.4062e24ad7cd2@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079973316.405f15c4abd09@imp.gcu.info>
In-Reply-To: <1079973316.405f15c4abd09@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Uwe Andersen <uandersen@MAYAH.com>:

> I didn't use your code as a base. 
> (...)
> If you like I can send you my source so that you can convince
> yourself that I don't sponge on your code.

This won't be necessary. I just misread your previous mail, sorry for
the trouble:

> When I want to integrate lm_sensors I have to solve some problems:
> a) Throw away running code  ..*sigh*..
> b) Make lm_sensors compatible (e.g. the "out" command has its
>    parameters "address" and "value" just the other way round.)
> c) I have to make all the linux header files included compatible

I guess this should have read "IF I WOULD want to", not "When I want". I
thought you described what you did, while you were explaining why you
precisely don't want to... Whatever, I read it wrong. Sorry again.

> BTW, what means "IANAL"?

"I'm not a lawyer"
http://www.catb.org/~esr/jargon/html/I/IANAL.html

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
