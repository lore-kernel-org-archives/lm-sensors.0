From: Niels <n.wassenberg@chello.nl>
Date: Wed, 01 Jul 2009 17:22:04 +0000
Subject: [lm-sensors] no PWM output with pwmconfig
Message-Id: <4A4B9B3C.1040104@chello.nl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============8535914601723550098=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============8535914601723550098==
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
</head>
<body bgcolor="#ffffff" text="#000000">
I'm having trouble with my pwmconfig.<br>
<br>
<div style="margin: 5px 20px 20px;">
<div class="smallfont" style="margin-bottom: 2px;">Code:</div>
<pre class="alt2" dir="ltr"
 style="border: 1px inset ; margin: 0px; padding: 6px; overflow: auto; width: 640px; height: 98px; text-align: left;">Found the following PWM controls:
   hwmon2/device/pwm1
   hwmon2/device/pwm2
   hwmon2/device/pwm3
There are no usable PWM outputs.</pre>
</div>
Though my sensors cleary reads out the fans<br>
<br>
<div style="margin: 5px 20px 20px;">
<div class="smallfont" style="margin-bottom: 2px;">Code:</div>
<pre class="alt2" dir="ltr"
 style="border: 1px inset ; margin: 0px; padding: 6px; overflow: auto; width: 640px; height: 466px; text-align: left;">nelis@nelis-desktop:~$ sensors
acpitz-virtual-0
Adapter: Virtual device
temp1:       +41.0&Acirc;&deg;C  (crit = +70.0&Acirc;&deg;C)
k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +36.0&Acirc;&deg;C
Core1 Temp:  -49.0&Acirc;&deg;C
f71862fg-isa-0220
Adapter: ISA adapter
in0:         +1.70 V
in1:         +2.04 V
in2:         +1.20 V
in3:         +2.04 V
in4:         +1.34 V
in5:         +1.18 V
in6:         +1.18 V
in7:         +1.68 V
in8:         +1.66 V
fan1:       2538 RPM
fan2:       2222 RPM
fan3:          0 RPM  ALARM
temp1:       +41.0&Acirc;&deg;C  (high = +85.0&Acirc;&deg;C, hyst = +81.0&Acirc;&deg;C)
                      (crit = +70.0&Acirc;&deg;C, hyst = +66.0&Acirc;&deg;C)  sensor = transistor
temp2:       +89.0&Acirc;&deg;C  (high = +85.0&Acirc;&deg;C, hyst = +81.0&Acirc;&deg;C)  ALARM
                      (crit = +100.0&Acirc;&deg;C, hyst = +96.0&Acirc;&deg;C)  sensor = transistor
temp3:       +44.0&Acirc;&deg;C  (high = +254.0&Acirc;&deg;C, hyst = +252.0&Acirc;&deg;C)
                      (crit = +254.0&Acirc;&deg;C, hyst = +252.0&Acirc;&deg;C)  sensor = transistor</pre>
</div>
<br>
Anyone got an idea on how to deal with this ?<br>
</body>
</html>


--===============8535914601723550098==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============8535914601723550098==--
