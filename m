From: jharvell@dogpad.net (Joe Harvell)
Date: Fri, 02 Mar 2007 15:12:18 +0000
Subject: [lm-sensors] fan control for CPU fan on Asus P5B-Deluxe
Message-Id: <45E83ED2.3090105@dogpad.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an Asus P5B-Deluxe (not the WiFi), and I have been able to get 
the 80mm fans connected to FAN1 and FAN2 working under fancontrol using 
pwm in the winbond 83627dhg.  Both fans are controlled by pwm4.

But the really loud fan in the box is the Zalman CNPS 9500 LED CPU fan.  
pwmconfig didn't find any sensors correlated to that fan.  But the MB 
comes with software (QFan) that supposedly  independently controls the 
fan speeds of FAN1, FAN2, and CPU_FAN.  For each of the three fans 
mentioned, the BIOS has settings to enable/disable fan control, and to 
set a fan control profile (silent,optimal,performance).  However, none 
of the settings seems to have any effect on any of the fans.

The fan comes with an adapter for the fan connection with a knob so you 
can turn it down.  But I want to be able to control it programmatically.

