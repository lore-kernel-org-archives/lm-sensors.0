From: "Mini Stac" <mmstac@gmail.com>
Date: Mon, 07 Apr 2008 00:37:44 +0000
Subject: [lm-sensors] D201GLY2 Ubuntu 7.10 fan control
Message-Id: <f7fb2140804061737l73447d24n50b5ef11b2179557@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============2624030114968649141=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============2624030114968649141==
Content-Type: multipart/alternative; 
	boundary="----=_Part_5472_30220535.1207528664951"

------=_Part_5472_30220535.1207528664951
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I would like to get fan control working, but when running pwmconfig, I get
the following message:

Found the following devices:
   hwmon0/device is w83627dhg

Found the following PWM controls:
   hwmon0/device/pwm1
hwmon0/device/pwm1_enable stuck to 2
Failed to set pwmhwmon0/device/pwm1 to full speed
Something's wrong, check your fans!


There is no fan control options that can be set in BIOS, however using
Speefan under Windows I was able to control the Case fan speed although CPU
fan speed is fixed.
I installed lm-sensors v2.10.4 using Synaptic. Sensors shows fan speeds for
both case and cpu. I tried reloading the driver with modprobe using
reset/init but seems these parameters are not supported for this driver.

------=_Part_5472_30220535.1207528664951
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I would like to get fan control working, but when running pwmconfig, I get the following message:<br><br>Found the following devices:<br>&nbsp;&nbsp; hwmon0/device is w83627dhg<br><br>Found the following PWM controls:<br>&nbsp;&nbsp; hwmon0/device/pwm1<br>
hwmon0/device/pwm1_enable stuck to 2<br>Failed to set pwmhwmon0/device/pwm1 to full speed<br>Something&#39;s wrong, check your fans!<br><br><br>There is no fan control options that can be set in BIOS, however using Speefan under Windows I was able to control the Case fan speed although CPU fan speed is fixed.<br>
I installed lm-sensors v2.10.4 using Synaptic. Sensors shows fan speeds for both case and cpu. I tried reloading the driver with modprobe using reset/init but seems these parameters are not supported for this driver.<br><br>

------=_Part_5472_30220535.1207528664951--


--===============2624030114968649141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============2624030114968649141==--
