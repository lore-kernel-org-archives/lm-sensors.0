From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Ticket no. 1817
Message-Id: <HRlwov7W.1101372600.1343230.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <41A4C939.8050404@jonrkc.com>
In-Reply-To: <41A4C939.8050404@jonrkc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jon,

>I installed lm_sensors 2.8.8 following instructions below,
>ran sensors-detect
>and copied the lm_sensors.init file to
>/etc/rc.d/init.d/lm_sensors following that,
>and the result of sensors -s, sensors, (wait >5 sec.),
>sensors is still:
>
>[root@bodhisattva prog]# sensors
>via686a-isa-6000
>Adapter: ISA adapter
>CPU core:  +1.69 V  (min =  +2.00 V, max =  +2.50 V)   ALARM
>+2.5V:     +2.51 V  (min =  +3.10 V, max =  +3.00 V)   ALARM
>I/O:       +3.31 V  (min =  +4.13 V, max =  +4.13 V)   ALARM
>+5V:       +5.13 V  (min =  +6.44 V, max =  +6.02 V)   ALARM
>+12V:     +12.06 V  (min = +15.60 V, max = +15.60 V)   ALARM
>CPU Fan:  3000 RPM  (min =    0 RPM, div = 2)
>P/S Fan:     0 RPM  (min =    0 RPM, div = 2)
>SYS Temp:  +29.5?C  (high =   +45?C, hyst =   +40?C)
>CPU Temp:  +27.2?C  (high =   +60?C, hyst =   +55?C)
>SBr Temp:  +22.4?C  (high =   +65?C, hyst =   +60?C)

I.e. everything's perfect except for the voltage limits. Your
configuration file (well, our default configuration file) does only set
them for the CPU core, but with incorrect values (for you at least). I
agree we should add sensible defaults for this chip in the default
config file. Try this:

set in0_min  1.70 * 0.95
set in0_max  1.70 * 1.05
set in1_min  2.5  * 0.95
set in1_max  2.5  * 1.05
set in2_min  3.3  * 0.95
set in2_max  3.3  * 1.05
set in3_min  5    * 0.9
set in3_max  5    * 1.1
set in4_min 12    * 0.9
set in4_max 12    * 1.1

instead of the current "set in0_{min,max}" lines in the via686a section.

Then "sensors -s" should write the correct limits, and two subsequent
"sensors" should wipe the alarms out.

--
Jean Delvare
