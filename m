From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Sep 2009 16:23:20 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (abituguru3) Support multiple DMI
Message-Id: <20090906182320.4d2e212b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
In-Reply-To: <1252170780-4141-1-git-send-email-alistair@devzero.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  6 Sep 2009 15:30:28 +0100, Alistair John Strachan wrote:
> Most known Abit motherboards have unique uguru chip IDs. However,
> some "refresh" boards keep the same chip ID but have a different
> DMI string. As our DMI board string matching is (necessarily)
> strict, some boards were failing DMI detection, and as the old
> probe method was also failing, the driver would not load.
> 
> The only known boards affected by this problem are the IP35 Pro XE
> (vs IP35 Pro) and the AB9 Pro (vs AB9). Is it not sufficient to
> relax the match criteria, as some boards (e.g. the AB9 Quad GT)
> have different uguru chip IDs.
> 
> This patch replaces the dmi_name string with a NULL terminated
> array of strings to be matched per uguru chip ID. It has been
> compile and runtime tested (thanks Rune).
> 
> References: https://bugs.launchpad.net/bugs/298798
> 
> Signed-off-by: Alistair John Strachan <alistair@devzero.co.uk>
> Tested-by: Rune Svendsen <runesvend@gmail.com>
> Cc: Rune Svendsen <runesvend@gmail.com>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: lm-sensors@lm-sensors.org
> 
> ---
>  drivers/hwmon/abituguru3.c |   77 +++++++++++++++++++++++---------------------
>  1 files changed, 40 insertions(+), 37 deletions(-)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
