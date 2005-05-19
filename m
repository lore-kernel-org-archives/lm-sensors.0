From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: ADM1031 Driver (was long time ago <driver for mic184 chip>)
Message-Id: <421F3D7E.6010105@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20172.192.88.166.35.1109235034.squirrel@avrel.homeip.net>
In-Reply-To: <20172.192.88.166.35.1109235034.squirrel@avrel.homeip.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Hi Frank,
>
>  
>
>>I was able to sneak some time in today between builds and look at this
>>driver some more. I was able to get your driver to work with a simple
>>modification. Let me describe my setup first. Kernel is 2.6.9 except
>>when I started having problems with this driver I brought adm1031.c from
>>2.6.10 and put the normal_i2c stuff back in. It appears that in
>>adm1031_attach_adapter() adapter->class is zero and HWMON is 1 so I get
>>the return 0 instead of calling i2c_detect. I am using an adm1030 part.
>>When I remove the adapter->class test then the driver is up and running
>>fine.
>>    
>>
>
>adapter->class is provided by the driver of the bus your ADM1030 chip
>sits on. If it is zero this means that the driver did not properly
>declare its class. This is a problem with the bus driver, not the
>adm1031 driver. So both your claim that the adm1031 driver was broken
>and your fix are incorrect.
>
>  
>
>>I see some other drivers have removed this sort of test but I have
>>not looked into the consequences of doing this.
>>    
>>
>
>Which drivers please? We are rather currently *adding* the checks, not
>removing them.
>
>  
>
>>Any ideas or clues on what I might need to fix to get the class set
>>properly?
>>    
>>
>
>Which bus driver are you using? It obviously lacks class declaration, so
>the correct fix is to add the class there.
>
>Thanks,
>--
>Jean Delvare
>  
>
The modules that are loading are (in reverse order):
     adm1031
     ad5321
     mic184
     pca9540
     i2c_sensor
     i2c_elektor
     i2c_algo_pcf
     i2c_core

So I believe what you are asking for is the i2c_elektor driver for the 
PCF8584 ISA to I2C chip. Note again that this is 2.6.9 and I have not 
looked to see if there are any changes to the 2.6.10 or 2.6.11 drivers 
other than adm1031 as stated earlier.

Thanks
Frank
