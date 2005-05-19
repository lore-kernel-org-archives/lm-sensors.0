From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: PWM on a W83697HF
Message-Id: <1080211915.4062b9cb54b2a@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079973316.405f15c4abd09@imp.gcu.info>
In-Reply-To: <1079973316.405f15c4abd09@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Uwe Andersen <uandersen@MAYAH.com>:

> In the meantime I have an answer from Epox: "We didn't know if the
> mainboard has a fan control or not."

What I would have expected.

> Seems to be that I contacted a person who might be better for
> answering questions like "My battery is low. What should I do?"

Unfortunately, experience shows that you hardly get any valuable
information from hardware (or software) manufacturer's support service.
I sometimes wonder why they pretend having such a service at all.

> Thank you for the time you spent with my problem!
> It was nice to have somebody to talk with who is (or has been)
> working on the same stuff!

No problem, and sorry for the number of broken info again.

BTW, why is it that you cannot use lm_sensors? It doesn't seem to be
that big. The whole i2c stack shouldn't exceed 64k. Or maybe 64k *is*
big for your embedded system?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
