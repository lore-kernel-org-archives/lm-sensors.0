From: cminyard@mvista.com (Corey Minyard)
Date: Thu, 19 May 2005 06:25:35 +0000
Subject: PC87431 is not - need full datasheet.
Message-Id: <42024381.4000301@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D5D72B.2040706@ocesb.com.my>
In-Reply-To: <41D5D72B.2040706@ocesb.com.my>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

ipmi_smb doesn't exist in the mainstream kernel yet.  I'm working on 
getting it in; the driver and some rather large related changes to the 
I2C layer were posted on lkml (and the sensors list, too) a few days 
ago.  Those were against linux-2.6.11-rc2, not against 2.6.7, and those 
patches will almost certainly not apply against 2.6.7.

If you want to use the older smb driver, it does work, but certain 
functionality won't work, primarily things that occur at panic time like 
storing panic information in the SEL and extending the watchdog.  It's 
available at http://openipmi.sf.net.  There is a 2.6.7 version that will 
probably work, though it doesn't do automatic DMI detection so you will 
have to hand-specify the parameters.

-Corey

Chan Min Wai wrote:

>Corey Minyard wrote:
>  
>
>>Mark Studebaker wrote:
>>
>>    
>>
>>>so the ipmi_smb driver Corey just posted to LKML, together with his
>>>previous i2c patches,
>>>together with http://bmcsensors-26.sourceforge.net ,
>>>and you should be able to get sensor data from the 87431!
>>>let us know how it works!
>>>      
>>>
>>Note that this was against 2.6.11-rc2 and you need the completion patch
>>posted by Mike Waychison  at
>>http://marc.theaimsgroup.com/?l=linux-kernel&m0669761400454&w=2 or
>>the completion_timeout routine is broken.
>>    
>>
>
>I'm losing here,
>
>I've try to compile 2.6.7
>
>however I can't load the IPMI_SI module.
>Error is as below.
>
>
>IPMI System Interface driver version v31, KCS version v31, SMIC version
>v31, BT version v31
>ipmi_si: Unknown SMBIOS SI type.
>ipmi_si: Trying "kcs" at I/O port 0xca2
>ipmi_si: Trying "smic" at I/O port 0xca9
>ipmi_si: Trying "bt" at I/O port 0xe4
>ipmi_si: Unknown SMBIOS SI type.
>ipmi_si: Unknown SMBIOS SI type.
>ipmi_si: Unknown SMBIOS SI type.
>ipmi_si: Unable to find any System Interface(s)
>
>with the patch + lm_sensors 2.8.7 & also 2.9.0
>I've try to do a sensor-detect only the old config is being detected.
>(the one that giving 127 C)... WOO (Which is the wrong value)
>
>this is the lsmod that I'm loading
>Module                  Size  Used by
>w83627hf               29956  0
>eeprom                 12168  0
>i2c_sensor              7296  2 w83627hf,eeprom
>i2c_isa                 6400  0
>i2c_dev                14720  0
>i2c_i801               12304  0
>ipmi_devintf           12036  0
>i2c_ipmi                8972  0
>ipmi_msghandler        59876  2 ipmi_devintf,i2c_ipmi
>bmcsensors             40324  0
>i2c_core               28032  8
>w83627hf,eeprom,i2c_sensor,i2c_isa,i2c_dev,i2c_i801,i2c_ipmi,bmcsensors
>
>So I dont know where I'm now...
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m0669761400454&w=2
>I'm not too sure where it fit.
>
>I'm on an SE7210TP1-E Mobo where the sensor chip is
>AD1207 & PC87431, if you need more information.
>
>Please help
>
>Regards,
>Chan Min Wai
>
>P.s is ipmi_smb really exists?
>  
>
