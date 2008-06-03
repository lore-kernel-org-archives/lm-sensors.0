From: Sergio Bruder <sergio@bruder.com.br>
Date: Tue, 03 Jun 2008 05:31:07 +0000
Subject: [lm-sensors] v1211 fan control
Message-Id: <3DB98ECB-DD2B-4F05-93AA-0F3A8BC94665@bruder.com.br>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ive recently builded a (almost) fanless little server around a EPIA  
LN10000EG with a VIA C7 1GHZ fanless, a little case with a 60W PSU and  
a desktop (3.5") HD. The case has a small and loud fan, that I plugged  
in as cpu fan.

Im using a C7-compiled-for version of Ubuntu 8.04 server kernel  
(2.6.24-17-server).

Ive compiled the kernel for C7, using e_powersaver, acpi=force,  
hpet=force (powertop is showing 2-3 wakeups per second, cool, but my  
cpu isnt entering C3, only C2. but that is another problem).

  VT1211 has pwm fan control, but I dont know what temperature is  
driving the "auto control", and the unique variation that I can get is  
fully on with auto control turned off and completely turned off with  
auto control turned on (echo 2). So I hacked a little cronjob that  
turns auto control on and off to indirectly turn fan off and on using  
the temp2 result of sensors (the unique temperature that appears sane)  
until a better solution is found.

My goal is to configure the fan control map to never trigger "full  
trottle" of the fan.

What is the temperature that are controlling the fan auto control?

Sergio Bruder

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
