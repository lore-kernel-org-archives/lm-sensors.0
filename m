From: hanyongkui99@gmail.com (Yongkui Han)
Date: Sat, 21 Oct 2006 19:55:00 +0000
Subject: [lm-sensors] About the "CPU temp" output of ADM1025A chip
Message-Id: <2ca62ec0610211255g3a2f7866me6fb15f372246014@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi All,

I have an Intel D850MV motherboard. There is an ADM1025A sensor chip on the
motherboard. Also there is an LPC47M142 I/O chip on the motherboard. My CPU
is a Pentium 4 CPU, 1.7GHz.

The following is a sample output for my lm-sensors software.
---------------------------------
$ sensors
adm1025-i2c-0-2d
Adapter: SMBus I801 adapter at efa0

+2.5V:     +2.49 V  (min =  +2.25 V, max =  +2.75 V)
VCore:     +1.68 V  (min =  +1.66 V, max =  +1.84 V)
+3.3V:     +3.30 V  (min =  +2.97 V, max =  +3.63 V)
+5V:       +5.13 V  (min =  +4.50 V, max =  +5.50 V)
VCC:       +3.30 V  (min =  +2.97 V, max =  +3.63 V)
CPU Temp:  +35.0?C  (low  =   +10?C, high =   +60?C)
M/B Temp:  +34.0?C  (low  =   +10?C, high =   +45?C)
vid:      +1.750 V  (VRM Version 9.0)

smsc47m1-isa-0800
Adapter: ISA adapter
fan1:     3233 RPM  (min =  640 RPM, div = 8)
fan2:        0 RPM  (min =  640 RPM, div = 8)
--------------------------------------------------------------

I am interested in the temperature readings from the sensor chip. There are
two temperature readings: CPU temp and M/B temp. According the ADM1025A
datasheet, I think the M/B temp is the on-chip sensor in the ADM1025A chip,
and the CPU temp is the External Temperature Measurement with Remote Diode.

My question is: Where is this remote diode located? Is this remote diode the
internal thermal diode inside the Pentium 4 CPU chip, or a thermal sensor
provided by the motherboard which is attached to the CPU chip very closely?

I downloaded the manual of Intel D850MV motherboard from Intel's website,
but could not get the answer to my question.

I opened the computer case, removed the CPU fan, and saw the CPU and the
ADM1025A chip sit together on the motherboard, but I could not see from
the circuit board whether the PIN 9 and 10 (the two pins connected to
the remote diode) of ADM1025A chip are connected to the internal thermal
diode inside the Pentium 4 CPU chip.

Any suggestions are very welcome.

Thank you!

Regards,
Yongkui
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061021/ddfd7283/attachment.html 
