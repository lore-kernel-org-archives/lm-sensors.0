From: dynmail1@gassner-waagen.at (Michael Burian)
Date: Thu, 23 Feb 2006 11:05:52 +0000
Subject: [lm-sensors] Relax probing for ds1337.c
Message-Id: <43FD9710.5070406@gassner-waagen.at>
List-Id: <lm-sensors.vger.kernel.org>
References: <43FD7385.8020304@gassner-waagen.at>
In-Reply-To: <43FD7385.8020304@gassner-waagen.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Not acceptable as is due to the risk that the ds1337 driver will
> accidentally attach to non-DS1337 devices. 
OK

> Better ways are:
> * Use the force module parameter to force detection of the chip even when
> in invalid state. This is no different from what your patch does, but at
> least this is an optional module parameter rather than the default.
>

This would fix the problem in a clean way - but I'd prefer not having to
use modules.

> * If the "invalid state" of the DS1337 is something that can be
> identified, we can add code to the driver to specifically identify this
> state and accept it.
>

Well it's rather difficult for ds1337.c to decide if it sees a
corrupted ds1337 or some completely different chip. Platform dependent
code could solve this, but this would be even worse.

> * I have some work in progress with Nathan Lutchansky and Alessandro
> Zummo to make it possible to explicitely attach i2c drivers to chips
> 

I'm looking forward to this, seems like it could fix this problem.

Thanks!

