From: Jaswinder Singh Rajput <jaswinder@kernel.org>
Date: Mon, 22 Feb 2010 10:57:18 +0000
Subject: Re: [lm-sensors] reformat: [PATCH] hwmon: Driver for Andigilog
Message-Id: <1266835935.1948.19.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <000601caa1fd$c6dadb30$54909190$@joseph@fairview5.com>
In-Reply-To: <000601caa1fd$c6dadb30$54909190$@joseph@fairview5.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hello,

I am sorry. I was preparing the email and accidentally I send this
email. Please ignore it. I will send another email. Sorry for noise.

Thanks,
--
JSR
 
On Mon, 2010-02-22 at 16:15 +0530, Jaswinder Singh Rajput wrote:
> On Sun, 2010-02-21 at 23:29 -0700, George Joseph wrote:
> > Fixed word wrap this time (I hope)...
> 
> Yes, this applies cleanly thanks.
> 
> I have compared the sensors output of Intel WX58BP with its BIOS
> hardware monitoring.
> 
> http://userweb.kernel.org/~jaswinder/Corei7/sensors_Intel_WX58P.txt :
> 
> asc7621a-i2c-0-2e
> Adapter: SMBus I801 adapter at 2000
> in0:         +1.08 V  (min =  +0.00 V, max =  +3.31 V)
> in1:         +0.92 V  (min =  +0.00 V, max =  +2.99 V)  
> in2:         +3.19 V  (min =  +0.00 V, max =  +4.36 V)   
> in3:         +4.99 V  (min =  +0.00 V, max =  +6.61 V)   
> in4:        +12.00 V  (min =  +0.00 V, max = +15.94 V)   
> fan1:        949 RPM  (min =    0 RPM)
> fan2:       2437 RPM  (min =    0 RPM)
> fan3:          0 RPM  (min =    0 RPM)
> fan4:        623 RPM  (min =    0 RPM)
> temp1:       -57.5°C  (low  = -127.0°C, high =  +0.0°C)  
>                       (crit = -17.0°C)                  
> temp2:       +35.8°C  (low  = -127.0°C, high = +127.0°C)  
>                       (crit = +65.0°C)                  
> temp3:       +42.5°C  (low  = -127.0°C, high = +127.0°C)  
>                       (crit = +65.0°C)                  
> temp4:       +52.5°C  (low  = -127.0°C, high = +127.0°C)  
>                       (crit = +103.0°C)                  
> temp5:       -57.5°C                                    
> temp6:       -84.5°C                                    
> temp7:       +96.2°C                                    
> temp8:      +118.5°C      
> 
> 
> BIOS hardware monitoring :
> 
> Processor Fan speed: 949 RPM (which is same as fan1)
> Aux Fan speed: 2437 RPM (which is same as fan2)
> Front Fan speed: 0 (which is same as fan3)
> Rear Fan speed: 623 RPM (which is same as fan4)
> 
> Processor Thermal Margin: 57 C (which is same as temp1 but without -ve)
> IOH Temperature: 52 C (which is same as temp4)
> Motherboard Ambient Temperature: 35 C (which is same as temp2)
> Voltage Regulator Temperature: 42C (which is same as temp3)
> 
> V12.0 : 12.00 V (which is same as in4)
> V12.0 : 12.00 V (which is same as in4)
> V12.0 : 12.00 V (which is same as in4)
> V12.0 : 12.00 V (which is same as in4)
> 
> I am CC Andrew, Ingo, Stephen and LKML. I hope we can also get reviews
> and feedbacks from them.
> 
> Thanks,
> --
> Jaswinder Singh.
> 



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
