From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Sep 2005 13:22:20 +0000
Subject: [lm-sensors] 2006b3 ksensors cpu temp pb
Message-Id: <20050911132217.0a32b3d9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509091803.30808.philippe.roubach@free.fr>
In-Reply-To: <200509091803.30808.philippe.roubach@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut Philippe,

Merci de r?pondre ? la liste plut?t qu'? moi, d'autres personnes auront
peut etre d'autres id?es.

> The thermal sensors is good because the CPU fan is well regulate by
> the CPU temperature.

If you mean that you have a self-regulating CPU fan, then your analysis
is not correct, because such fans regulate themselves using an internal
thermal sensor. This is not the same sensor as the ones lm_sensors is
reporting values for.

> w83l785ts-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 5500
> temp:        +61?C  (high =  +110?C)

*This* is the CPU temperature, as obtained from a thermal diode built
inside the CPU. 61 degrees C is a quite reasonable value, so I'd expect
it to be correct.

> M/B Temp:    +48?C  (high =   +45?C, hyst =   +40?C)

And this should be the temperature in the CPU socket, most likely from a
thermistor. The value is expected to be lower, and to change much
slower, that those returned by the built-in thermal diode. This seems to
be your case so there's nothing to worry about.

Now, if the value really *never* changes, there might be a problem. You
might try increasing the high and hyst limits for this input (to, say,
55 and 50 degrees C, respectively). I know that some sensor chips stop
monitoring channels in alarm conditions until the alarm is read. I also
have to admit that 48 degrees C is a bit high for a socket temperature.

Remember that the asb100 driver was written without the benefit of a
datasheet. Blame Asus for that. As a result, we did our best but when
things don't seem to work properly, there's almost nothing we can do.

Maybe Mark Hoffman will have more ideas, as he wrote the driver.

> Power Temp:
>               -0?C  (high =   +45?C, hyst =   +40?C)
> CPU Temp (AMD):
>              +25?C  (high =   +60?C, hyst =   +50?C)

These two are obviously not wired so you can add "ignore" statements
for them in your sensors.conf file.

-- 
Jean Delvare
