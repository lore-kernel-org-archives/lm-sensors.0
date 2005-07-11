From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 11 Jul 2005 16:09:20 +0000
Subject: [lm-sensors] sensors-detect bug in generating
Message-Id: <OpiMTXXE.1121090660.2393100.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <FB3C0705909A7E4A9D832D5CD5A4289206D0CF97@ge1884exch001u.de.lucent.com>
In-Reply-To: <FB3C0705909A7E4A9D832D5CD5A4289206D0CF97@ge1884exch001u.de.lucent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Peter,

On 2005-07-11, Peter Gunreben wrote:
> I had problems to configure lm_sensors 2.9.0-3 (SuSE 9.3)
> on my Asus A7M266-D (Dual Athlon MP 1900+) board.
> Sensors-detect showed the correct chip (AS99127F (rev.2)),
> but the driver was missing in the generated file:
> /etc/sysconfig/lm_sensors. It seems there's a bug in
> sensors-detect.
> (...)
> Driver `to-be-written' (should be inserted):
>  Detects correctly:
>  * Bus `SMBus AMD768 adapter at e4e0' (Algorithm unavailable)
>    Busdriver `i2c-amd756', I2C address 0x2d (and 0x48 0x49)
>    Chip `Winbond W83792D' (confidence: 8)
>
> Driver `w83781d' (may not be inserted):
>  Misdetects:
>  * Bus `SMBus AMD768 adapter at e4e0' (Algorithm unavailable)
>    Busdriver `i2c-amd756', I2C address 0x2d (and 0x48 0x49)
>    Chip `Asus AS99127F (rev.2)' (confidence: 8)
>...

What happened here is that the script thought you had a different chip
(W83792D), and since this chip had no driver back then, it did not add
it to the list at all. So the real bug here is a chip misdetection. If
we can fix that, then the correct driver will be listed in
/etc/sysconfig/lm_sensors as expected.

I would like to know whether the current version of the script still has
the problem, or not. Could you please download the latest version here:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/detect/sensors-detect

And report whether this is any better or not?

Thanks,
--
Jean Delvare
