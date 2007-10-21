From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 21 Oct 2007 18:16:34 +0000
Subject: Re: [lm-sensors] sensors3 and pwm properties
Message-Id: <20071021201634.673f90f1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071020213509.cc414874.krzysztof.h1@wp.pl>
In-Reply-To: <20071020213509.cc414874.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Krzysztof,

On Sat, 20 Oct 2007 21:35:09 +0200, Krzysztof Helt wrote:
> I ask here because I was asked few times.
> 
> The sensors3 command does not display pwmX values. It is confusing
> for drivers which have pwmX properties for controlling fans but
> have not fanX properties (no fan feedback). The thmc50 driver is one example.
> 
> The output from sensor3 command looks like there is no fan attached.

Actually, the output of the sensors3 command looks like there is no
fan speed tachometer on the system, which is correct.

> Is it design decision, omission or feature not implemented yet?

Design decision. PWM (or DC) outputs are not sensors.

Giving users the impression that the value of the PWM output is
necessarily related to the speed of their fans would be dangerous. PWM
outputs may or may not be wired to fans, and when they are, the mapping
may not be obvious. On top of that, fan speed is generally not linear
to the PWM value, and also changes depending on the fan model. And,
more importantly, the PWM output doesn't tell you when your fan has
died and is no longer spinning - which is what sensors is all about.

Fortunately, the thmc50/adm1022 is an exception, all other chips that
control fans have also tachometers to monitor them, as far as I
remember.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
