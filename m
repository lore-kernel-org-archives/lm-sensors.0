From: Sean Fidler <fidlersean@gmail.com>
Date: Wed, 10 Mar 2010 16:19:44 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <alpine.OSX.2.00.1003101117130.310@blackbird.local>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="140733193388032-1335266783-1268237991=:310"
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--140733193388032-1335266783-1268237991=:310
Content-Type: TEXT/PLAIN; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit

Hi, Jean,

Thanks for the updated driver.

I've run into a second issue: I have to manually insmod the smsc47m1.ko 
file before I'm able to modprobe smsc47m1.

Previously, I used insmod once and the smsc47m1 module loaded properly 
at boot.

Thanks,
Sean

On Mon, 8 Mar 2010, Jean Delvare wrote:

> Hi Sean,
>
> On Mon, 8 Mar 2010 02:26:26 -0500, Sean Fidler wrote:
>> I've run into a problem with the driver you wrote, smsc47m1.c
>> (http://khali.linux-fr.org/devel/misc/smsc47m1/). The server has been
>> moved from Ubuntu 9.10 to 8.04 (same hardware, Compaq Presario
>> S4000NX). When running "make" the following errors occur:
>>
>> CC [M]  /home/sean/smsc47m1.o
>> /home/sean/smsc47m1.c: In function ‚Äòsmsc47m1_handle_resources‚Äô:
>> /home/sean/smsc47m1.c:558: error: implicit declaration of function
>> ‚Äòacpi_check_region‚Äô
>> make[2]: *** [/home/sean/smsc47m1.o] Error 1
>> make[1]: *** [_module_/home/sean] Error 2
>> make: *** [modules] Error 2
>>
>> The steps (i.e. isaset…) that were indicated in this thread work
>> correctly, as before.
>
> I have put an updated driver at:
> http://khali.linux-fr.org/devel/misc/smsc47m1/
>
> The new version should work with both recent and older kernels, at
> least down to kernel version 2.6.24, maybe even older.
>
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
>

--
Twitter: endersyrinx
GTalk: fidlersean
--140733193388032-1335266783-1268237991=:310
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--140733193388032-1335266783-1268237991=:310--
