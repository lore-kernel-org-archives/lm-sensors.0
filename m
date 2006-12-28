From: JGong@winbond.com (JGong at winbond.com)
Date: Thu, 28 Dec 2006 09:08:48 +0000
Subject: [lm-sensors] w83793 driver ready
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE010BA7B0@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <20061208153817.de1c2b4c.khali@linux-fr.org>
In-Reply-To: <20061208153817.de1c2b4c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Jean:

I have accomplished the tests with your advice. I write the values to
them within the range of themselves, and here is the all the items
passed the test:
1)	Temperature: ($i= 1->6)
temp$i_max 
temp$i_max_hyst
temp$i_warn 
temp$i_warn_hyst 
temp$i_beep 

2)	Voltage: ($i=0->9)
in$i_min
in$i_max
in$i_beep

3)	Smartfan2: ( $i=1->6 $j=1->7)
temp_critical 
pwm_downtime 
pwm_uptime
pwm$i_stop_time
pwm$i_start_time
pwm$i_nonstop
tolerance$i
temp$i_auto_point$j_pwm
temp$i_pwm_enable
temp$i_auto_channels_pwm
temp$i_auto_points$j_temp

4)	Thermal cruise:($i=1->6)
thermal cruise$i


Alarm test:
I just modify the value above or below the critical value of
temperature, voltage, and fans to see whether there will be an alarm
signal, also works well.

Best regards
PI14
GongJun




=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

