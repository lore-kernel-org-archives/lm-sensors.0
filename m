From: tuharsky@misbb.sk (Mgr. Peter Tuharsky)
Date: Mon, 16 Oct 2006 11:01:49 +0000
Subject: [lm-sensors] Wrong values for MB QDI Kinetiz7E, VIA686 chipset
Message-Id: <4533669D.7000709@misbb.sk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo,


here is my experience with using sensors on QDI Kinetiz7E MB (VIA686 
chipset).

1, +2,5V seems need 10x multiplication, or is invalid completely?
2, SYS Temp should be probably CPU in real
3, CPU Temp should be SBr temp probably
4, SBr Temp should be SYS Temp.

Can the sensors or whatever be adjusted so that it detects the MB 
correctly and set the variables accordingly? I see there in conf, that 
VIA686 chipset is used in many motherboards and the behaviour is not 
consistent. Is it possible to automate things so that user is not 
demanded to play with sensor.conf?

I am new to this conference and I'm just askin'. I want to help at least 
with my data that I have access to, to make sensors more useful for 
users, and to "just work" without the need of config file editing.


Here is the output:

via686a-isa-6000
Adapter: ISA adapter
CPU core:  +1.78 V  (min =  +0.06 V, max =  +3.10 V)
+2.5V:     +0.29 V  (min =  +2.37 V, max =  +2.62 V)   ALARM
I/O:       +3.34 V  (min =  +3.13 V, max =  +3.47 V)
+5V:       +4.93 V  (min =  +4.51 V, max =  +5.50 V)
+12V:     +12.37 V  (min = +10.81 V, max = +13.20 V)
CPU Fan:  2376 RPM  (min =    0 RPM, div = 8)
P/S Fan:     0 RPM  (min =    0 RPM, div = 8)
SYS Temp:  +51.2 C  (high =   +45 C, hyst =   +40 C)   ALARM
CPU Temp:  +36.7 C  (high =   +60 C, hyst =   +55 C)
SBr Temp:  +27.4 C  (high =   +65 C, hyst =   +60 C)



Sincerely, Peter

