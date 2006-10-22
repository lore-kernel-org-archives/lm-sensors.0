From: r.marek@assembler.cz (Rudolf Marek)
Date: Sun, 22 Oct 2006 11:06:12 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <453B50A4.7000501@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
In-Reply-To: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> I have an Intel D850MV motherboard. There is an ADM1025A sensor chip on
> the motherboard. Also there is an LPC47M142 I/O chip on the motherboard.
> My CPU is a Pentium 4 CPU, 1.7GHz.

And here is your motherboard
ftp://download.intel.com/design/motherbd/mv/A6514501.pdf

technical guide ;)


> The following is a sample output for my lm-sensors software.
> ---------------------------------
> $ sensors
> adm1025-i2c-0-2d
> Adapter: SMBus I801 adapter at efa0
>  
> +2.5V:     +2.49 V  (min =  +2.25 V, max =  +2.75 V)
> VCore:     +1.68 V  (min =  +1.66 V, max =  +1.84 V)
> +3.3V:     +3.30 V  (min =  +2.97 V, max =  +3.63 V)
> +5V:       +5.13 V  (min =  +4.50 V, max =  +5.50 V)
> VCC:       +3.30 V  (min =  +2.97 V, max =  +3.63 V)
> CPU Temp:  +35.0?C  (low  =   +10?C, high =   +60?C)
> M/B Temp:  +34.0?C  (low  =   +10?C, high =   +45?C)
> vid:      +1.750 V  (VRM Version 9.0)
>  
> smsc47m1-isa-0800
> Adapter: ISA adapter
> fan1:     3233 RPM  (min =  640 RPM, div = 8)
> fan2:        0 RPM  (min =  640 RPM, div = 8)
> --------------------------------------------------------------
>  
> I am interested in the temperature readings from the sensor chip. There
> are two temperature readings: CPU temp and M/B temp. According the
> ADM1025A datasheet, I think the M/B temp is the on-chip sensor in the
> ADM1025A chip, and the CPU temp is the External Temperature Measurement
> with Remote Diode.
>  
> My question is: Where is this remote diode located? Is this remote diode
> the internal thermal diode inside the Pentium 4 CPU chip, or a
> thermal sensor provided by the motherboard which is attached to the CPU
> chip very closely?

According to technical docs from intel, it is Remote thermal diode sensing for
direct monitoring of processor temperature

inside the CPU.

> I downloaded the manual of Intel D850MV motherboard from Intel's
> website, but could not get the answer to my question.

I did ;)

> I opened the computer case, removed the CPU fan, and saw the CPU and the
> ADM1025A chip sit together on the motherboard, but I could not see from
> the circuit board whether the PIN 9 and 10 (the two pins connected to
> the remote diode) of ADM1025A chip are connected to the internal thermal
> diode inside the Pentium 4 CPU chip.

Well there is a lot of layers PCB so it is impossible to track it down.

The manual also suggest that the fan speeds are somehow controlled. This is
quite interesting. Page 43 Quote:

The temperature sensors that control the fans are initialized by the BIOS at
power-up to turn on only when the sensor reaches 36 C (96.8 F). The fans switch
off when their respective sensors
cool down to 31 C (87.8 F). This prevents the fans from turning off and on when
the ambient air around the sensor fluctuates around 35?36 C. When the fans
switch on, they may appear to rotate
slowly because the fan's duty cycle starts at 70 percent and rises to 100
percent when the sensor reaches 46 C (114.8 F).

Datasheet is here http://www.datasheets.org.uk/datasheet.php?article 40255

It seems it somehow changes the PWM via software (system management interrupt)

I hope it helps,

Regards
Rudolf

