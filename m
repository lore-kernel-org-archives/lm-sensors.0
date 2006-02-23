From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Feb 2006 12:38:03 +0000
Subject: [lm-sensors] Relax probing for ds1337.c
Message-Id: <YAWYXUWv.1140698283.4048850.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <43FD7385.8020304@gassner-waagen.at>
In-Reply-To: <43FD7385.8020304@gassner-waagen.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

On 2006-02-23 Michael Burian wrote:
> > * Use the force module parameter to force detection of the chip even when
> > in invalid state. This is no different from what your patch does, but at
> > least this is an optional module parameter rather than the default.
>
> This would fix the problem in a clean way - but I'd prefer not having to
> use modules.

You don't have to compile the driver as a module in order to pass
parameters to it. With the ds1337 driver built-in, use
ds1337.force=0,0x68 on the boot command line and it should work just as
well. (Replace 0 with the correct i2c bus number if needed.)

--
Jean Delvare

