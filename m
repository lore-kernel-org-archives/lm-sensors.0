From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4016EC10.4070107@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:
> [Don't forget to CC: the mailing list on replies please]

Well, all mails so far, have had a reply-to address. Just the last one had 
not. I'll have to be more careful then ;-)

>>>>Basically this means the following conversion table, if I'm not
>>>>mistaking:
>>>>0..2 -> 1 (div=2)
>>>>3..4 -> 2 (div=4)
>>>>5+   -> 3 (div=8)
>>
>>I don't think, that this a good idea. If you recall an email from me
>>about VERAX fans, which supply 9 times as many pulses per rotation as
>>normal fans do, those fans would require a div of 18. This value would
>>then silently be converted to div = 8 and results in less then one
>>halve of the actual fan rpm.
>>
>>In my opinion, the driver should complain about any div values it
>>doesn't support, and simply do nothing as it wouldn't be what the user
>>expected, anyway. Therefore, once again the question: How should the
>>driver inform about/react on unsupported div values?
> 
> Well, this makes sense, you're right. You get the point.
> 
> In my mind, there was no possibility to return an error code, so you had
> to accomodate the best you could with the input, and keep quiet. By the
> way, what does conretely happen if you try to write a wrong value to the
> sysfs file?

video:/soft/src/lm_sensors2/kernel/chips # cat \
	/sys/bus/i2c/devices/0-0073/fan_div1
2
video:/soft/src/lm_sensors2/kernel/chips # echo 1 > \
	/sys/bus/i2c/devices/0-0073/fan_div1
video:/soft/src/lm_sensors2/kernel/chips # cat \
	/sys/bus/i2c/devices/0-0073/fan_div1
2
video:/soft/src/lm_sensors2/kernel/chips #

Nothing special. The invalid value is simply ignored. Although set_fan_div() 
returns -1 in that case, echo doesn't show any error.

How about adding a printk() for that case?

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
