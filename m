From: =?UTF-8?B?TWFydGluIE1PS1JFSsWg?= <mmokrejs@ribosome.natur.cuni.cz>
Date: Wed, 16 Sep 2009 16:56:33 +0000
Subject: Re: [lm-sensors] unhide_ICH_SMBus: line 33:
Message-Id: <4AB118C1.8030701@ribosome.natur.cuni.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9122E1.7010006@ribosome.natur.cuni.cz>
In-Reply-To: <4A9122E1.7010006@ribosome.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

>>>>> These I have already in the kernel, so I can drop the whole SMbus thing?
>>>> Yes.
>>> Ooops, are we talking about I2C_I801=N, I2C=N or SENSORS_DS1621=N? ;-)
>> ENSORS_DS1621=N and I2C_I801=N, yes. I2C=N, bad idea, you might need
>> I2C support for something else.
> 
> $ sensors 
> max6657-i2c-4-4c
> Adapter: SMBus I801 adapter at e800
> M/B Temp:  +39.1°C  (low  =   -55°C, high =  +127°C)   
> CPU Temp:  +49.2°C  (low  = +48.0°C, high = +62.0°C)   
> M/B Crit:    +85°C  (hyst =   +75°C)                  
> CPU Crit:    +75°C  (hyst =   +65°C)                  

I forgot that once I opened the laptop and put on the web its contents.
See http://ribosome.natur.cuni.cz/~mmokrejs/ASUS_L3800/p1010020-1-0.html
I see MAX1715 (or 1745?) chip.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
