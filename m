From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4016D90C.5050507@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>Well, looking at the conversion formula again, this idea is not 100 %
>>perfect, because it doesn't care to scale the offset value. Currently,
>>the offset is 0 but there is no guarantee, that it will always be 0.
> 
> This isn't a problem. The formulae are applied *after* libsensors (or
> any other program such as gkrellm) reads the value from sysfs or procfs.
> For example, if you have a raw reading of 1.8V, in 2.4 it'll be stored
> internally as 180, and read through procfs as 1.80. In 2.6 it'll be
> stored internally as 1800 and exported through sysfs as 1800 too. But
> libsensors knows about magnitudes in both cases and will read the value
> as 1.80. And any formula in sensors.conf will be applied to *this*
> value.

This is the kind of information that I was missing, when I wrote the last email.

> So, as you can see, it is safe to have a single formula for both
> versions.

You are right. I've attached the fixed drivers and adjusted sample 
configuration. Documentation will follow later and explains, how to get the 
necessary (M)ultiplier, (R)efVoltage and (O)ffset values from dmidecode.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fscher.c-2.4.22.gz
Type: application/x-gzip
Size: 5767 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040127/28ff505d/fscher.c-2.4.22.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fscher.c-2.6.1.gz
Type: application/x-gzip
Size: 4994 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040127/28ff505d/fscher.c-2.6.1.gz
-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors.conf.eg.diff.gz
Type: application/x-gzip
Size: 517 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040127/28ff505d/sensors.conf.eg.diff.gz
