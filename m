From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 22 Jul 2005 11:46:05 +0000
Subject: [lm-sensors] [patch]  KERNELVERSION=2.6.12-something make
Message-Id: <Ip6FeyJQ.1122025197.4927440.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <42E04664.3020001@divsol.com>
In-Reply-To: <42E04664.3020001@divsol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Jim,

On 2005-07-22, Jim Cromie wrote:

> Separately, Ive been trying to hack around my lack of
> include/linux/modversions.h,  which is not present in the 2.6.12, 13-rc
> trees that Ive built
>
> Ive tried turning off CONFIG_MODVERSIONS,
> despite some ifdefs in some of the code that suggest it shoul help,
> I get almost nowhere doing so.
>
> is modversions.h a synthesized file (written based upon config) ?
> is it a holdover from earlier kernel releases ?

I suspect that you are trying to build the kernel modules of lm_sensors
with a 2.6 kernel. No surprise it doesn't work, it is not supposed to.
With a 2.6 kernel, the only part of lm_sensors you are interested in is
the user-space tools, which are built with "make user" and installed
with "make user_install". Don't use "make" nor "make install".

--
Jean Delvare
