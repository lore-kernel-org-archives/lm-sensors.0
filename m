From: dgersic@myrealbox.com (David Gersic)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Feedback: lm_sensors 2.8.8, SuSE Linux 9.1, and SuperMicro P4SPA+
Message-Id: <200411240110.06905.dgersic@myrealbox.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Just wanted to send in some feedback on this combination and a thank you for 
lm_sensors.

SuSE 9.1 "Personal" edition (kernel 2.6.5-7.104-smp) distribution included 
lm_sensors 2.8.3-99. This, of course, didn't work. Some searching of your FAQ 
turned up the recommendation that lm_sensors needed to be 2.8.6 or newer with 
this kernel version. So, a download, make user, and make user_install later, 
I have the correct version installed, and it works fine. Thanks to the FAQ 
editor(s) for this.

I'm using a SuperMicro P4SPA+ motherboard, which is detected as having the 
Winbond w83627hf chip on it. sensors-detect worked fine picking that up. I 
have a slower than stock CPU fan (a Zalman 7000A kit) installed. There is a 
case fan, and an "overheat fan" as well, and case and CPU temperature 
sensors. These values in /etc/sensors.conf seem to be correct for this 
combination:

# Inserted - 23 November 2004 - dgersic
# Configuration for Fans
    label fan1 "CPU Fan"
    set fan1_div 4
    set fan1_min 1000

    label fan2 "Case Fan"
    set fan2_div 2
    set fan2_min 2000

    label fan3 "Overheat Fan"
    set fan3_div 2
    set fan3_min 0
# Configuration for Temp sensors
    label temp1 "System Temp"
    ignore temp2
    label temp3 "CPU Temp"
    compute temp3 @+6,(@-6)
# end - dgersic

and the outputs of lm_sensors status now match the values shown by the BIOS 
for the FAN speeds and the system and CPU temps. I have not yet verified the 
voltage monitors, but they look like they are probably correct.
