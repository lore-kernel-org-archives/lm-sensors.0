From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: PWM on a W83697HF
Message-Id: <1080218350.4062d2eebbe15@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079973316.405f15c4abd09@imp.gcu.info>
In-Reply-To: <1079973316.405f15c4abd09@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Uwe Andersen <uandersen@MAYAH.com>:

> More or less historical reasons.
> I started five years ago with a W83781D and just integrated it with
> no probs.
> As a Delphi unit. On a OS that's mor or less WinAPI compatible.
> So it made sense to integrate the following chip in the same manner.
> And so on.
> Now I have a collection of chipset drivers that are all based on
> Pascal code.
> When I want to integrate lm_sensors I have to solve some problems:
> a) Throw away running code  ..*sigh*..
> b) Make lm_sensors compatible (e.g. the "out" command has its
> parameters "address" and "value" just the other way round.)
> c) I have to make all the linux header files included compatible

Mhmmm, for which project is this?

IANAL, but if you use our code as a base, and even if in the end the
code differs because it's not the same language, I think you must
release your project as GPL, or you are infringing the GPL.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
