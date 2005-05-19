From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: PWM on a W83697HF
Message-Id: <1080052293.40604a45852f3@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1079973316.405f15c4abd09@imp.gcu.info>
In-Reply-To: <1079973316.405f15c4abd09@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Uwe Andersen <uandersen@MAYAH.com>:

> I should have be more concrete:
> 
> I'm not using lm_sensors...
> I'm working on a real time OS called RTOS-32 and doing the hardware
> monitoring software on my own.
> The last thing missing was PWM and I read that lm_sensors is using
> that feature on the W83697HF.
> So I thought of an answer like "Did you enabled PWM in register xy
> with bit n?"
> I have written several values into register 0x01 and register 0x03
> but the fan speed didn't change.
> If there is nothing else to do it looks like that my motherboard
> (Epox 8KMM3I) is the problem.
> 
> Sorry for being so unprecise.

No problem. We don't do anything but read/write registers 0x01 and 0x03
in our drivers, and this is supposed to work, so there's nothing more I
can tell you, sorry. There is no bit that is supposed to be set to
enable it AFAIK.

Maybe you could contact Epox and ask them if PWM is supposed to be
supported on this motherboard?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
