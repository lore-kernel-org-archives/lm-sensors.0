From: fredantispam@free.fr (fred)
Date: Wed, 14 Dec 2005 20:04:00 +0000
Subject: [lm-sensors] i2cdetect fails on a Asus P5ND2-Sli Deluxe
Message-Id: <43A07AB0.40305@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <4399D312.1010109@free.fr>
In-Reply-To: <4399D312.1010109@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare a ?crit :
> Please give a try to the following patch, which I expect to fix it:
Yes, it does !
Great. :-)

>>PS :  xsensors works fine, but sensord still complains :
>>Dec 13 23:25:01 marsu sensord: Adapter: SMBus nForce2 adapter at 5000
>>Dec 13 23:25:01 marsu sensord: Algorithm: Unavailable from sysfs
> 
> 
> Note that it isn't an error. You may ignore any message related to
> algorithms safely, see my other post. We'll drop them soon (I hope).
Ok.
> 
>>Dec 13 23:25:01 marsu sensord:   Memory type: Invalid
>>Dec 13 23:25:01 marsu sensord:   Memory size (MB): Invalid 14 10 97 4
> 
> 
> Lack of support for DDR2 SDRAM. We have dropped eeprom support entirely
> from sensord in the next release anyway. There's little interest in
> continuously polling read-only data, isn't it?
No, it's nice to see 1024 MB on xsensors :-)))
> 
>>PS2 : why it87 is not supported by xsensors ?
> 
> 
> it87 is. You have (I guess) it8712, which is only supported in xsensors
> 0.47, while Sarge ships 0.46. Try 0.47 with my two patches and it
> should work fine.
Yes. It works fine.
My Asus mobo is very happy.

Thanks a lot for your job, Jean.

-- 
Fred.

