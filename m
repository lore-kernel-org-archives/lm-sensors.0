From: Jesse Barnes <jbarnes@virtuousgeek.org>
Date: Tue, 10 Jun 2008 19:02:19 +0000
Subject: Re: [lm-sensors] [PATCH] Unhide the SMBus on the Compaq Deskpro EN
Message-Id: <200806101202.20257.jbarnes@virtuousgeek.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080608134702.401b9fb5.krzysztof.h1@wp.pl>
In-Reply-To: <20080608134702.401b9fb5.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, lm-sensors@lm-sensors.org, khali@linux-fr.org, rh1985@wp.pl

On Sunday, June 08, 2008 4:47 am Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
>
> This patch unhides the SMBus on Compaq Deskpro EN
> SFF P667 with the Intel 815E chipset. Unhiding it reveals
> a THMC51 hardware monitoring chip.
>
> Jean Delvare has checked that this machine has no ACPI
> magic touching the SMBus nor the hardware monitoring chip,
> so this should be safe.
>
> The patch was tested on Fedora Core 9 with 2.6.25.4 kernel.
>
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> Tested-by: Rafa=B3 Ha=B3aduda <rh1985@wp.pl>
> CC: Jean Delvare <khali@linux-fr.org>

Thanks Krzysztof; applied to linux-next.  I had to fix up a conflict by han=
d=20
though, would be good if you could double check it.

Thanks,
Jesse

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
