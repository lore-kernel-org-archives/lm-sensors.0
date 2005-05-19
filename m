From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: lm_sensors 2.8.3
Message-Id: <20040131225017.69c2512f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401291139.58838.jumpyboy@infinito.it>
In-Reply-To: <200401291139.58838.jumpyboy@infinito.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> VCore 1:   +1.76 V  (min =  +1.56 V, max =  +1.72 V)   ALARM <<-- is
> it dangerous? It is stable to this value and for XP is 1.65 Volt.

I'm really astonished that you have different values under Linux and
Windows. Doesn't make much sense to me, so I just don't know what to
tell you.

> fan1:     3668 RPM  (min =    0 RPM, div = 2)

You should considering setting a min value for this one, 3000 RPM for
example.

> CPU Temp:    +58?C  (low  =   +43?C, high =   +43?C)   sensor > thermistor <-- this is right but I think in winter is too much.

There are a two formulas you can try in sensors.conf, depending on your
motherboard. That said, they all tend to increase, not decrease the
reported values. It's also possible that your motherboard needs a
formula we don't know yet. Or this is the real temperature, that's not
impossible.

> Temp3:      +127?C  (low  =   +15?C, high =   +45?C)   sensor
> = thermistor <-- What does it need?

+127 means error, most likely this temperature channel isn't used on
your motherboard and you can ignore it. Or try diode instead of
thermistor.

> M/B Temp:    -39?C  (low  =   +15?C, high =   +45?C)   sensor > invalid
>
> Why M/B temp is negative? A lm_sensors2 bug or a bad settings into 
> sensors.conf? From BIOS I get that temperature, maybe we need to know
> the formula tu calculare M/B temperature of Asus A7V600?

Obviously a bad setting in sensors.conf. You need to set the sensor
value to either 2 or 3. Here it says "invalid" so I guess you have set
it to another value. Correct, run "sensors -s" and it should be fine.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
