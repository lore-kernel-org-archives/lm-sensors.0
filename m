From: aurelien@aurel32.net (=?iso-8859-15?Q?Aur=E9lien?= Jarno)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: [PATCH]: pwmconfig and fancontrol manpages
Message-Id: <20050127004833.GA21732@bode.aurel32.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Please find attached a patch to add pwmconfig(8) and fancontrol(8)
manpages. They are based on the doc/fancontrol.txt documentation.

Cheers,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net

-------------- next part --------------
diff -urN lm_sensors2.orig/prog/pwm/fancontrol.8 lm_sensors2/prog/pwm/fancontrol.8
--- lm_sensors2.orig/prog/pwm/fancontrol.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/pwm/fancontrol.8	2005-01-27 01:25:03.000000000 +0100
@@ -0,0 +1,103 @@
+.TH FANCONTROL 8 "January 27, 2005"
+.SH NAME
+fancontrol \- automated software based fan speed regulation
+
+.SH SYNOPSIS
+.B fancontrol
+.I [configfile]
+
+.SH DESCRIPTION
+\fBfancontrol\fP is a shellscript for use with lm_sensors. It reads its
+configuration from a file, then calculates fan speeds from temperatures and
+sets the corresponding PWM outputs to the computed values.
+
+.SH WARNING
+Please be careful when using the fan control features of your mainboard, in
+addition to the risk of burning your CPU, at higher temperatures there will be
+a higher wearout of your other hardware components, too. So if you plan to use
+these components in 50 years, \fBmaybe\fP you shouldn't use fancontrol/your
+hardware at all.  Also please keep in mind most fans aren't designed to be
+powered by a PWMed voltage.
+
+In practice it doesn't seem to be a major issue, the fans will get slightly
+warmer, just be sure to have a temperature alarm and/or shutdown call, in case
+some fan fails, because you probably won't hear it anymore ;)
+
+.SH CONFIGURATION
+For easy configuration, there's a script
+named \fBpwmconfig\fP(8) which lets you interactively write your 
+configuration file for \fBfancontrol\fP. Alternatively you can write this 
+file yourself using the information from this manpage.
+
+Since most of you are going to use \fBpwmconfig\fP(8) script, the config
+file syntax will be discussed last. First I'm going to describe the various
+variables available for changing \fBfancontrol\fP's behaviour:
+
+.TP
+.B INTERVAL
+This variable defines at which interval in seconds the main loop of
+\fBfancontrol\fP will be executed
+.TP
+.B FCTEMPS
+Maps PWM outputs to temperature sensors so \fBfancontrol\fP know which
+temperature sensors should be used for calculation of new values for
+the corresponding PWM outputs.
+.TP
+.B FCFANS
+FCFANS records the association between a PWM and a fan.
+Then \fBfancontrol\fP can check the fan speed and restart it if it
+stops unexpectedly.
+.TP
+.B MINTEMP
+The temperature at which the fan gets switched off completely.
+.TP
+.B MAXTEMP
+The temperature at which the fan gets switched to full speed.
+.TP
+.B MINSTART
+Sets the minimum speed at which the fan begins spinning. You should
+use a safe value to be sure it works, even when the fan gets old.
+.TP
+.B MINSTOP
+The minimum speed at which the fan still spins. Use a save value here,
+too.
+.PP
+If you set up your configuration by hand, be sure to include ALL variables and
+use valid values, there's no error handling yet! The file format is a bit
+strange:
+.IP
+.nf
+VARIABLE=chip/pwmdev=value chip/pwmdev2=value2
+VARIABLE2=...
+.fi
+.PP
+Each variable has its own line. The variable name is followed by an equal sign
+and the device=value pairs. These consist of the relative path to the pwm
+output (from /proc/sys/dev/sensors/) for which the value is valid, equal sign
+followed by the value and are seperated by a blank. Example:
+.IP
+MINTEMP=w83627hf-isa-0290/pwm2@ w83627hf-isa-0290/pwm1T
+.PP
+You have to play with the temperature values a bit to get happy. For initial
+setup I recommend using the \fBpwmconfig\fP script. Small changes can be made by
+editing the config file directly following the rules above.
+
+.SH THE ALGORITHM
+
+\fBfancontrol\fP first reads its configuration, writes it to arrays and loops its
+main function.  This function gets the temperatures and fanspeeds from
+lm_sensors proc files and calculates new speeds depending on temperature
+changes, but only if the temp is between MINTEMP and MAXTEMP. After that, the
+new values are written to the PWM outputs. Currently the speed increases
+quadratically with rising temperature. This way you won't hear your fans most
+of the time at best.
+
+.SH CONFORMING TO
+lm_sensors?2.x
+       
+.SH SEE ALSO
+pwmconfig(8), sensors(1).
+
+.SH AUTHOR
+.PP
+Marius Reiner <marius.reiner@hdev.de>
diff -urN lm_sensors2.orig/prog/pwm/Module.mk lm_sensors2/prog/pwm/Module.mk
--- lm_sensors2.orig/prog/pwm/Module.mk	2005-01-27 01:32:11.000000000 +0100
+++ lm_sensors2/prog/pwm/Module.mk	2005-01-27 01:40:52.000000000 +0100
@@ -18,6 +18,9 @@
 MODULE_DIR := prog/pwm
 PROGPWMDIR := $(MODULE_DIR)
 
+PROGPWMMAN8DIR := $(MANDIR)/man8
+PROGPWMMAN8FILES := $(MODULE_DIR)/fancontrol.8 $(MODULE_DIR)/pwmconfig.8
+
 PROGPWMTARGETS := $(MODULE_DIR)/fancontrol \
                   $(MODULE_DIR)/fancontrol.pl \
                   $(MODULE_DIR)/pwmconfig
diff -urN lm_sensors2.orig/prog/pwm/pwmconfig.8 lm_sensors2/prog/pwm/pwmconfig.8
--- lm_sensors2.orig/prog/pwm/pwmconfig.8	1970-01-01 01:00:00.000000000 +0100
+++ lm_sensors2/prog/pwm/pwmconfig.8	2005-01-27 01:25:03.000000000 +0100
@@ -0,0 +1,33 @@
+.TH PWMCONFIG 8 "January 27, 2005"
+.SH NAME
+pwmconfig \- tests the PWM outputs of sensors and configures fancontrol
+
+.SH SYNOPSIS
+.B pwmconfig
+
+.SH DESCRIPTION
+.B pwmconfig
+searches your sensors for pulse width modulation (PWM)
+controls, and test each one to see if it controls a fan on
+your motherboard. Note that many motherboards do not have PWM
+circuitry installed, even if your sensor chip supports PWM.
+
+It attempts to briefly stop each fan using the PWM controls. It then
+attempts to restore each fan to full speed after testing. However, it
+is \fBvery important\fP that you physically verify that the fans have 
+been to full speed after the program has completed.
+
+.SH WARNING
+This program will stop your fans, one at a time, for approximately 5 seconds each.
+This may cause your processor temperature to rise. Verify that all fans are running 
+at normal speed after this program has exited.
+
+.SH CONFORMING TO
+lm_sensors-2.x
+
+.SH SEE ALSO
+fancontrol(8), sensors(1).
+
+.SH AUTHOR
+.PP
+Marius Reiner <marius.reiner@hdev.de>
