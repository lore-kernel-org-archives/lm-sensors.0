From: JGong@winbond.com (JGong at winbond.com)
Date: Tue, 13 Mar 2007 02:18:14 +0000
Subject: [lm-sensors] Sensors reports out of range values
Message-Id: <FF9D611BFCDB1E42B37FAA148096BECE01A3162D@weshml03.winbond.com.tw>
List-Id: <lm-sensors.vger.kernel.org>
References: <B75E0279E6507E44A9C27B96D66D68A202B8F4F0@cossmgmbx06.EMAIL.CORP.TLD>
In-Reply-To: <B75E0279E6507E44A9C27B96D66D68A202B8F4F0@cossmgmbx06.EMAIL.CORP.TLD>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, Venkataram

>MODULE_0=i2c-i801 
>MODULE_1=w83781d 
>MODULE_2=w83793 
>MODULE_3=w83627hf 

>w83627hf-i2c-0-2d 
>Adapter: SMBus I801 adapter at 1100 
>VCore 1:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
>VCore 2:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
>+3.3V:     +4.08 V  (min =  +2.82 V, max =  +3.79 V)       ALARM  
>+5V:       +5.03 V  (min =  +5.78 V, max =  +0.24 V)       ALARM  
>+12V:     +11.61 V  (min =  +8.03 V, max =  +6.63 V)       ALARM  
>-12V:      +1.04 V  (min = -12.85 V, max = -11.37 V)       ALARM  
>-5V:       +1.84 V  (min =  +0.08 V, max =  -0.17 V)       ALARM  
>V5SB:      +5.62 V  (min =  +3.04 V, max =  +1.77 V)       ALARM  
>VBat:      +3.17 V  (min =  +3.20 V, max =  +2.88 V)       ALARM  
>fan1:        0 RPM  (min = 48214 RPM, div = 2)             ALARM  
>fan2:        0 RPM  (min = 2812 RPM, div = 2)              ALARM  
>fan3:        0 RPM  (min = 56250 RPM, div = 2)             ALARM  
>temp1:       -48?C  (high =   +88?C, hyst =  -116?C)   sensor = >thermistor           
>temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = >thermistor           
>temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = >thermistor           
>vid:      +1.419 V  (VRM Version 11.0) 
>alarms:   beep_enable: 
>          Sound alarm enabled 
>w83627hf-isa-0290 
>Adapter: ISA adapter 
>VCore 1:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
>VCore 2:   +4.08 V  (min =  +0.00 V, max =  +4.08 V)              
>+3.3V:     +4.08 V  (min =  +2.82 V, max =  +3.79 V)       ALARM  
>+5V:       +5.08 V  (min =  +5.78 V, max =  +0.24 V)       ALARM  
>+12V:     +11.86 V  (min =  +8.03 V, max =  +6.63 V)       ALARM  
>-12V:      +1.04 V  (min = -12.85 V, max = -11.37 V)       ALARM  
>-5V:       +1.89 V  (min =  +0.08 V, max =  -0.17 V)       ALARM  
>V5SB:      +5.62 V  (min =  +3.04 V, max =  +1.77 V)       ALARM  
>VBat:      +3.17 V  (min =  +3.20 V, max =  +2.88 V)       ALARM  
>fan1:        0 RPM  (min = 48214 RPM, div = 2)             ALARM  
>fan2:        0 RPM  (min = 2812 RPM, div = 2)              ALARM  
>fan3:        0 RPM  (min = 56250 RPM, div = 2)             ALARM  
>temp1:       -48?C  (high =   +88?C, hyst =  -116?C)   sensor = >thermistor           
>temp2:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = >thermistor           
>temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = >thermistor           
>vid:      +1.419 V  (VRM Version 11.0) 
>alarms:   beep_enable: 
>          Sound alarm enabled 

According to the /etc/sysconfig/lm_sensors file, I guess the "real" sensor chip may be the w83793 on your motherboard, so could you please tell me what your motherboard is?

As your kernel version is 2.6.19, you may need to update your kernel to get the w83793 driver (We have pushed the w83793 driver into kernel tree since 2.6.20).

If you have got any questions, feel free to contact us.

Best regards,
Gong Jun


=============================================The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.

