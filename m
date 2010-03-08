From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Mar 2010 17:39:03 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20100308183903.5fb2e657@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Mon, 8 Mar 2010 02:26:26 -0500, Sean Fidler wrote:
> I've run into a problem with the driver you wrote, smsc47m1.c
> (http://khali.linux-fr.org/devel/misc/smsc47m1/). The server has been
> moved from Ubuntu 9.10 to 8.04 (same hardware, Compaq Presario
> S4000NX). When running "make" the following errors occur:
> 
> CC [M]  /home/sean/smsc47m1.o
> /home/sean/smsc47m1.c: In function ‚Äòsmsc47m1_handle_resources‚Äô:
> /home/sean/smsc47m1.c:558: error: implicit declaration of function
> ‚Äòacpi_check_region‚Äô
> make[2]: *** [/home/sean/smsc47m1.o] Error 1
> make[1]: *** [_module_/home/sean] Error 2
> make: *** [modules] Error 2
> 
> The steps (i.e. isaset…) that were indicated in this thread work
> correctly, as before.

I have put an updated driver at:
http://khali.linux-fr.org/devel/misc/smsc47m1/

The new version should work with both recent and older kernels, at
least down to kernel version 2.6.24, maybe even older.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
