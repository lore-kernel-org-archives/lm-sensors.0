From: s.cramatte@wanadoo.fr (=?ISO-8859-1?Q?S=E9bastien_CRAMATTE?=)
Date: Wed, 14 Mar 2007 09:36:02 +0000
Subject: [lm-sensors] lm-sensors and 2.6.18 kernel under debian
Message-Id: <45F7C202.3080302@wanadoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F6AAC5.5050307@wanadoo.fr>
In-Reply-To: <45F6AAC5.5050307@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

#----cut here----
# I2C adapter drivers
i2c-i801
i2c-isa
# I2C chip drivers
# no driver for Winbond W83792D yet
# Warning: the required module smbus-arp is not currently installed on
your system.
# For status of 2.6 kernel ports see
http://secure.netroedge.com/~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
smbus-arp
w83627hf
#----cut here----

It's very strange because I've compiled W83792D kernel module but
doesn't load it ...

#ls /lib/modules/2.6.18.3-router.5/kernel/drivers/hwmon
hwmon-vid.ko  hwmon.ko  ipmisensors.ko  w83627hf.ko  w83792d.ko

#ls /lib/modules/2.6.18.3-router.5/kernel/drivers/hwmon
hwmon-vid.ko  hwmon.ko  ipmisensors.ko  w83627hf.ko  w83792d.ko

Moreover where can I get correct values sensords.conf  for fan and voltage ?


JGong at winbond.com a ?crit :
> Hi, S?bastien,
>
>   
>> I've got a p8sci supermicro motherboard.
>> I've compiled and loaded successfully i2c and hardware monitoring modules.
>> I've tried to disable beep and alarm but unfortunately doesn't work
>> Moreover values are very strange ... and for example   "set beep_enable
>> 0" is ignored...
>> w83627thf-isa-0290
>> Adapter: ISA adapter
>> in0:       +1.94 V  (min =  +1.94 V, max =  +1.94 V)       ALARM  (beep)
>> in1:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
>> in2:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
>> in3:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
>> in4:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
>> in7:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
>> in8:       +4.08 V  (min =  +4.08 V, max =  +4.08 V)       ALARM  (beep)
>> fan1:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
>> fan2:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
>> fan3:        0 RPM  (min =    0 RPM, div = 128)              ALARM  (beep)
>> temp1:        -1 C  (high =    -1 C, hyst =    -1 C)   sensor = diode
>> ALARM   (beep)
>> temp2:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode
>> ALARM   (beep)
>> temp3:      +0.0 C  (high =    +0 C, hyst =    +0 C)   sensor = diode
>> ALARM   (beep)
>> vid:      +0.000 V  (VRM Version 10.0)
>> alarms:   Chassis intrusion detection                      ALARM
>> beep_enable:
>>          Sound alarm enabled
>>     
>
> The sensors output of w83627thf makes no sense here. It was used for Super I/O usage. So we need to find the real sensor chip on your motherboard.
>
> Could you please run "sensors-detect", and send the results back to us?
>
> If you have any questions, feel free to contact us.
>
> Best regards,
> Gong Jun
>
>
> =============================================> The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such  a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Winbond is strictly prohibited; and any information in this email irrelevant to the official business of Winbond shall be deemed as neither given nor endorsed by Winbond.
>
>
>   


