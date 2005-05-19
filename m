From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: lm-sensors-2.70 and chip W83977EF
Message-Id: <20030404100934.639e240f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200304040904.02936.jean.ribiere@wanadoo.fr>
In-Reply-To: <200304040904.02936.jean.ribiere@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> The driver loaded is w83781d but with the command sensors
> the result is not correct :
> - the value pour -5V is out of limits
> - the fan speeds are 0

Not necessarily a problem or error. -5V and -12V are almost never used
nowadays as far as I know. What's more, the fan in your system may not
report their speed at all.

If you have the possibility to reboot your system, please do so and try
and see "in the BIOS" wether you can get sensors information from there.
If they don't show -5V at all, then it means you don't have to worry
about it and should just have to ignore it (add an ignore statement in
the config file). Also check wether fans speed is reported there. Fan
can report their speed if and only if they are three-wired (usually
black/red/yellow) and plugged onto the motherboard (as opposed to
powered from the alimentation wires). If you don't have any three-wired
fan, they don't expect any speed feedback, and add some ignore
statements in your config file.

If there's nothing to be seen "in the BIOS" and you have another OS
(say, Windows) on the system, you can also try some sensors software
there (see for example http://mbm.livewiredev.com/) and see wether they
report things we don't. Unless this happens, the ignore trick is the
thing to do.

And the same applies to temp1, as far as I can see.

One good trick to know if a sensor is connected is to watch for changes
(even if the values are utterly wrong). If the value never changes, or
if it changes in a very erratic way, then you can assume it isn't
connected to anything. If it seems to match the system activity, then it
may actually be a scalling issue or a bug in our code.

Please let us know how it goes.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
