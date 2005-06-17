From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 17 Jun 2005 14:27:34 +0000
Subject: [lm-sensors] i2c-patch for toshiba a40
Message-Id: <xBepWjQw.1119010612.8739290.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1DjFVT-000HtE-GT@daiquiri.visp.de>
In-Reply-To: <E1DjFVT-000HtE-GT@daiquiri.visp.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Eggert,

On 2005-06-17, Eggert Ehmke wrote:
> some time ago a patch was posted that added smbus support for the
> toshiba a40 notebook to the linux kernel:
> http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040921/44447a38/quirks.c.bin
> The patch did not work on the actual kernel 2.6.11, but I managed to
> adapt it. Is there any activity to get those patches inserted in the
> official kernel tree?

The patch was needlessly duplicating code, so it wasn't accepted in its
original form, but one with a similar effect was applied. It's in the
official kernel tree since 2.6.12-rc1.

--
Jean Delvare
