From: Rudolf Marek <r.marek@assembler.cz>
Date: Tue, 16 Sep 2008 21:36:47 +0000
Subject: Re: [lm-sensors] New Asus board and multiple sensors
Message-Id: <48D026EF.1030608@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <48CCB294.907@hhs.nl>
In-Reply-To: <48CCB294.907@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Here is mine research:

DHG chip is wired as follows:

in0 is Vcore
in1 is 12V
in2 not used
in3 is 3.3V
in4 is 5V

temp1 is MB temp
fans are
fan2 is cpu,
fan5 is not, fan4 is not

There is some unknown i2c chip at 0x38 which measures voltages, and fans

It measures:
Cpu voltage, DDR voltage, SB 1.1V voltage SB 1.5V, CPU PLL voltage, NB 1.1V Dram 
VTT volrage, VTT CPU voltage,

And also fans:
Chasis fan1
Chasis fan2
Power Fan
And some Opt fans, I know what registers are there (mostly up 0xa0 for fans)

So we need to find out what chip it is, because it measures a lot too.

The NB temperature etc etc is measured by some chip at 0x40 it seems it also 
controls some fan temperature???

Definitely what is the output of

i2cdetect 0
i2cdump 0 0x40
i2cdump 0 0x38

Thanks,
Rudolf


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
