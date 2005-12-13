From: fredantispam@free.fr (fred)
Date: Tue, 13 Dec 2005 22:31:58 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <439F4BDE.6020306@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fred a ?crit :
> Jean Delvare a ?crit :
> 
>>Hi Fred,
>>
>>
>>
>>>>But..., a stupid question : what can I do with this i2c busses ?
>>>
>>>Now, I can see eeprom with xsensors.
>>>I have 4 x 1 GB (DDR2) on my mobo.
>>>xsensors displays I have 4 modules, yes,
>>>but with memory type of 8 and memory size of 14 MB !
>>
>>
>>xsensors most probably doesn't know about DDR2 memory modules. You may
>>try the following patch. That's a quick hack and I have no way to test
>>it (no DDR2 SDRAM here). Please let me know if it works. If it does,
> 
> Ok, I'm going to try it.
That works much better !
I don't have 1024 MB but 1 24 MB : 0 does not appears.
I don't know why.

PS :  xsensors works fine, but sensord still complains :
Dec 13 23:25:01 marsu sensord: Adapter: SMBus nForce2 adapter at 5000
Dec 13 23:25:01 marsu sensord: Algorithm: Unavailable from sysfs
Dec 13 23:25:01 marsu sensord:   Memory type: Invalid
Dec 13 23:25:01 marsu sensord:   Memory size (MB): Invalid 14 10 97 4

PS2 : why it87 is not supported by xsensors ?

Thanks, Jean.

-- 
Fred.

