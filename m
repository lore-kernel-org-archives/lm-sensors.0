From: "KEITH ROMBERG" <k_romberg@msn.com>
Date: Mon, 04 Jun 2007 02:26:51 +0000
Subject: Re: [lm-sensors] Intel SRSH4 Motherboard Sensors
Message-Id: <BAY117-F32BA1E7E72A852B6A5281893210@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <465336B0.2030304@ucar.edu>
In-Reply-To: <465336B0.2030304@ucar.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Another problem I think is that the i2c-ipmi module is not getting loaded.  
The module is not in the /lib/modules directory and I can not find any trace 
and/or reference to it in the kernel source.  Is this one need?  It says it 
should be loaded by sensors-detech which is version 2.10.1


>>
>>OK, I also loaded ipmi_msghandler as I was not loading it before.  I am 
>>not
>>loading these modules in my rc.local file:
>>
>>i2c-piix4
>>i2c-ipmi
>>eeprom
>>ipmisensors
>>ipmi_msghandler
>>hwmon
>
>You should load ipmi_msghandler and hwmon first, ipmisensors depends on 
>them.
>
>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
