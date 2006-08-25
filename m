From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 25 Aug 2006 06:42:57 +0000
Subject: [lm-sensors] it8716 under 2.6
Message-Id: <20060825084257.556030b7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi J?rgen,

> i am using a backported version of your patch with kernel 2.6.16.21 Suse 10.1 
> on an ASUS M2N-SLI Deluxe.
> 
> It seem's to work... in some way ;-)

Great :)

> Inside the BIOS...
> 
> VCORE		=>	1,31V
> 3,3V		=>	3,41V
> 5V		=>	5,13V
> 12V		=>	12,3V
> CPU Temp		26?C
> MB			28?C
> CPU_FAN		2096 => seems to be fan1
> CHA_FAN1		1256 => seems to be fan2
> CHA_FAN2		1427
> CHA_FAN3		1908
> CHA_FAN4		1978
> PWR_FAN		903=> seems to be fan3
> 
> Output from "sensors -c /dev/null" is
> ======> it8716-isa-0290
> Adapter: ISA adapter
> in0:       +1.01 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in1:       +3.22 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in2:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in3:       +2.85 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in4:       +2.86 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in5:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in6:       +0.00 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in7:       +2.85 V  (min =  +4.08 V, max =  +4.08 V)   ALARM
> in8:       +2.93 V
> fan1:     4166 RPM  (min =    0 RPM)
> fan2:     2481 RPM  (min =    0 RPM)
> fan3:     1844 RPM  (min =    0 RPM)
> temp1:       +22?C  (low  =    -1?C, high =    -1?C)   sensor = diode
> temp2:       +30?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor
> temp3:        -5?C  (low  =    -1?C, high =    -1?C)   sensor = thermistor   
> ALARM
> vid:       +0.30 V
> =======

You have the same problem as was reported to me by someone else, i.e.
fan speed readings are twice as much as what the BIOS says. Now, the
values reported by the BIOS are quite low... Do you know what is the
expected speed for these three fans? If you have the opportunity to
test one of them in another machine and compare what the two BIOSes
say, I'd appreciate.

Do the voltages match what the BIOS says if you use the default
configuration file?

> Output of /var/log/messages:
> =======
> Aug 24 22:27:19 deepthought2 kernel: it87: Found IT8716F chip at 0x290, 
> revision 0

So this is an IT7616F and not IT8718F contrary to what your original
subject line said... Fixed.

> Aug 24 22:27:19 deepthought2 kernel: it87: in3 is VCC (+5V)
> Aug 24 22:27:19 deepthought2 kernel: it87: in7 is VCCH (+5V)
> Aug 24 22:27:19 deepthought2 kernel: it87: fan4 is enabled
> Aug 24 22:27:19 deepthought2 kernel: it87: fan5 is enabled
> ======> 
> What do you think ? How can the BIOS tell me soemthing about 6 FANS..
> I thought the ITE8716 has only 5 tachometer inputs....

Very good question, I don't really know. I even had a report of a board
with 7 fans using this chip (Asus M2N32-SLI). Could either be a second
chip on the board, or multiplexed fan lines (would be bad.) Can you
please provide the complete output of sensors-detect for this system?

Thanks,
-- 
Jean Delvare

