From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 23 Jan 2006 22:23:51 +0000
Subject: [lm-sensors] kacpid vs sensors and fan problem
Message-Id: <43D55777.8050506@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060123184912.GA25092@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20060123184912.GA25092@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi,

> 
> i have tried to run acpi and sensors on asus m6va notebook,
> but i have come accross problems im not able to solve.
> 
> sensors-detect found i2c-i801 bus and lm85 and eeprom chips.
> i can probe all kernel modules without difficulty, sensors
> seem to work as far as statistics concerned.
> 
> first problem starts, when boot initscript tries to intialize
> sensors - kacpid kernel module takes 99% CPU and stick to this
> usage. i found, this happens whenever "sensors -s" is executed.
> when i switched off initialization (INITSENSORS=no), notebook
> boots without difficulty.

Please send me in private output of cat /proc/acpi/dsdt > /tmp/dsdt.bin
It may be the reason that acpi is trying to access the chip too.


> second problem is, that i can't setup fans, although i can read
> their current state. when i run pwmconfig, there are errors such as: 
>    
>    0-002d/pwm1
>    /usr/sbin/pwmconfig: line 102: 0-002d/pwm1_enable: Permission denied
> 
> can be this problem caused by skipping sensors initialization ?

This is long term problem. The driver is too complex to fix it without having
this chip and nobody else (Khali and me) never show up with a patch fixing this.

(I recall someone already worked on this but never finished)

I hope this helps,

regards
Rudolf

