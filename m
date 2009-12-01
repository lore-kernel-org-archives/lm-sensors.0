From: Sean Fidler <fidlersean@gmail.com>
Date: Tue, 01 Dec 2009 17:49:59 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <alpine.OSX.2.00.0912011230370.431@blackbird.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

That's the mystery, the BIOS does show the temperature and the fan 
speed.

Here's the information you requested (isadump -k 0x55 0x2e 0x2f 0x0a):


      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
00: 00 00 00 00 00 00 00 0a 00 00 00 00 00 00 00 00 
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
20: 60 01 19 00 44 00 2e 00 00 00 00 00 00 00 00 00 
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
60: 06 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
a0: 00 00 00 00 00 00 00 00 00 00 ff ff ff ff ff ff 
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
f0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Thanks!

On Tue, 1 Dec 2009, Jean Delvare wrote:

> Hi Sean,
>
> On Mon, 30 Nov 2009 18:08:46 -0500 (EST), Sean Fidler wrote:
>> Thanks for your assistance.
>>
>> Please find the requested information below: output of sensors-detect,
>> /proc/ioports and the kernel log entry after attempting to load smsc47m1
>>
>> ##############################
>> #sensors-detect revision 5249#
>> ##############################
>> (...)
>> Some Super I/O chips may also contain sensors. We have to write to
>> standard I/O ports to probe them. This is usually safe.
>> Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O at 0x2e/0x2f
>> Trying family `National Semiconductor'...                   No
>> Trying family `SMSC'...                                     Yes
>> Found `SMSC LPC47M15x/192/997 Super IO Fan Sensors'
>>      (but not activated)
>
> I see. The fan sensors block is disabled, which is why sensors-detect
> doesn't pick it up...
>
>> (...)
>> Nov 30 17:44:21 ubuntu kernel: [  728.046978] smsc47m1: Found SMSC LPC47M15x/LPC47M192/LPC47M997
>> Nov 30 17:44:21 ubuntu kernel: [  728.046997] smsc47m1: Device is disabled, will not use
>
> ... and neither does the smsc47m1 driver.
>
> Please look in your BIOS if there is any option to enable fan speed
> monitoring and/or control. BTW, does the BIOS display any voltage,
> temperature or fan speed data?
>
> If you can't find a suitable option in your BIOS, we can try to
> manually enable the fan sensors block. However, in most cases disabled
> sensors block are disabled because they are effectively unused
> (physically not wired on the board.) So there are good chances that
> this will not lead us anywhere. Do you have any reason to believe that
> fan speed can be monitored and/or controlled on this system in the
> first place?
>
> If you want to continue, I will need the output of the following
> command:
>
> isadump -k 0x55 0x2e 0x2f 0x0a
>
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

--
Twitter: endersyrinx
GTalk: fidlersean

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
