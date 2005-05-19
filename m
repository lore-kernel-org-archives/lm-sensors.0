From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:28 +0000
Subject: Sensor results of P4P800
Message-Id: <20031207104231.394e9c03.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
In-Reply-To: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm using P4P800/ASUS mother board. Also I know that
> Winbond w83627thf is assembled on it.

True.

> Currently I downloaded i2c and lm_sensors source code from
> CVS dated on 12/6/'03 and installed them on
> TruboLinux(2.4.18). Then I can get following result.

I guess you have been defining a section in /etc/sensors.conf for
"w83627thf-*". Could you please send it to us? It'll help us understand
the sensors output below, and we also could add it to our default
configuration file for the benefit of other users.

> VCore 1:   +2.99 V  (min =  +0.00 V, max =  +0.00 V)      
> VCore 2:   +3.20 V  (min =  +4.08 V, max =  +4.08 V)      
> (...)
> in4:       +0.00 V  (min =  +0.30 V, max =  +5.55 V)      
> (...)
> vid:      +0.000 V
> (...)
> My question is the results of Vcore1, Vcore2, in4 and CPU
> Temp.
> Vcore1: BIOS shows 1.55V as Vcore voltage. Should I
> calculate to make correction with 'compute'? Is there any
> formula?

Usually, motherboard manufacturers provide the chip with VID input(s),
which the driver uses to automatically compute the VCore min and max
values. Since your vid reading is 0, min and max are naturally computed
to 0. You can try changing the vrm value through the configuration file,
it will change the way VID is read. But I doubt it'll lead you anywhere
considering you start from +0.0V.

As for the VCore 1 readings, you might need to divide the value by 2.
Never see that before though.

> Vcore2: Can I ignore?

If your CPU is a single power plane one, yes, this value probably
doesn't make much sense. Take a look at what your BIOS setup screen
displays. If it display a single reading for your CPU, I would assume
VCore 2 isn't used.

> in4: I believe in4 shows +12V. Is this a bug?

Strange indeed. Could you please provide the list and contents of all
files in /proc/sys/dev/sensors/w83627thf-isa-0290? This would help us
understand wether the problem comes from the driver or from the library
or sensors program.

> CPU Temp: I tried to set 1,2,3435 in /etc/sensors.conf.
> Result shows as below.
> 
> CPU Temp:  +29.0  (high =   +52, hyst =   +47)   sensor > PII/Celeron diode
> CPU Temp:  +30.0  (high =   +52, hyst =   +47)   sensor > 3904 transistor
> CPU Temp:  +86.0  (high =   +52, hyst =   +47)   sensor > thermistor   ALARM
> 
> BIOS shows 40'C(approx M/B+9'C) as CPU temp value. What
> should I do?

Asus are well known to use arbitrary computation formulae. You shouldn't
necessarily trust them, and you should not expect to come to the same
value as the one your BIOS setup screen displays. According to this
page:
  http://mbm.livewiredev.com/comp/asus.html
the correct sensor type for CPU is diode. If you really want to match
the BIOS' claimings, feel free to add a compute line for temp2.

> Also I report the status of temp3 with above condition for
> reference.
> temp3:    +127.5  (high =   +80, hyst =   +75)   sensor > PII/Celeron diode   ALARM
> temp3:    +127.5  (high =   +80, hyst =   +75)   sensor > 3904 transistor   ALARM
> temp3:    +208.0  (high =   +80, hyst =   +75)   sensor > thermistor

All these mean the temp3 sensor is not used. Add an ignore temp3 line.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
