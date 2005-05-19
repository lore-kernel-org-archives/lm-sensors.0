From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <1075727574.401e4cd6d9515@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting "J. Bolt" <james@evilpenguin.com>:

> I applied the patch to 2.6.2-rc3 and wrote a simple perl script to
> test the  output of sensors:
> 
> Executing 50 tests of diode output
>  (Checking every 3 seconds)
> [50] +48?C
> [49] +51?C
> [48] +54?C
> [47] +50?C
> [46] +51?C
> [45] +51?C
> [44] +52?C
> [43] +49?C
> [42] +51?C
> [41] +52?C
> (...)

Looks good. The rather fast variations are expected since the thermal
diode is inside the CPU itself.

> Executing 20 tests of diode output
>  (Checking every 1 seconds)

Note that the driver caches the data for 2 seconds anyway, so you can't
see changes faster than that. This explains why you see pairs of
identical values in the following list:

> [20] +49?C
> [19] +49?C
> [18] +48?C
> [17] +48?C
> [16] +51?C
> [15] +51?C
> [14] +52?C
> [13] +52?C
> [12] +51?C
> [11] +51?C
> (...)

> Hope that's off some use, haven't had any "-1" values,

Thanks for testing. Since the new driver hides the errors as it
"corrects" them, there's no easy way to know how useful the improved
(or should I call it insisting) read method is. I really think we
should make it more verbose.

Could you please apply the attached patch (on top of the previous one)
and recompile the w83l785ts driver with DEBUG enabled? No need to
recompile the whole kernel, just updating the w83l785ts module should
do it. Running your test script should then trigger the debug log (and
possibly the error log but I doubt it). I wonder how frequently the
retry will be necessary, and wether you'll sometimes need more than one
retry.

I would appreciate it much if you could let your script run long enough
to have some solid statistics about the phenomenon.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.2-rc3-i2c-w83l785ts-debug.diff
Type: application/octet-stream
Size: 480 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040202/9e0f5550/linux-2.6.2-rc3-i2c-w83l785ts-debug.obj
