From: David Anderson <davea42@gmail.com>
Date: Mon, 31 Jan 2011 18:22:45 +0000
Subject: Re: [lm-sensors] W83795AG on SuperMicro 7046T-NTR+ board
Message-Id: <4D46FDF5.6020008@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4D44621B.40506@earthlink.net>
In-Reply-To: <4D44621B.40506@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/31/2011 12:07 AM, Jean Delvare wrote:
> On Sun, 30 Jan 2011 13:13:24 -0800, David Anderson wrote:
>> Here is a configure file that worked (to go with the new
>> kernel module).  It may not be perfect.  inserted it as
>> /etc/sensors.d/w83795ag.conf
>>
>> chip "w83795-*"
> This can't work, as the chip will be named w83795adg-* or w83795g-* by
> libsensors.

It is in fact a     w83795adg    as reported by dmesg.
The supermicro folks had a typo in what they sent me, as you suggested 
earlier.

  They also sent
+12V Voltage, Offset 0x14        Voltage = Data* 0.008/ (10./66.2)
which I had as
    compute in4 @*(10.0/66.2), @/(10.0/66.2)
Aha. Notice I misread what they sent me.     They used  '/   /' and I 
used '*  /'.
My reading of the algebra was careless.

So I switched to Henrique's equation which is an accurate representation:

    compute in4 @*6.62, @/6.62

which gives a more sensible output (11.94 volts).


Thanks again for all the help.
David Anderson


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
