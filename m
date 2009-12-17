From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 17 Dec 2009 17:42:50 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon(asus_atk0110): debugfs interface
Message-Id: <20091217184250.22f84ae9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20091217141220.GA8416@nb-core2.darkstar.lan>
In-Reply-To: <20091217141220.GA8416@nb-core2.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Luca,

On Thu, 17 Dec 2009 15:12:20 +0100, Luca Tettamanti wrote:
> Expose the raw GGRP/GITM interface via debugfs. The hwmon interface is
> reverse engineered and the driver tends to break on newer boards...
> Using this interface it's possible to poke directly at the ACPI methods without
> the need to recompile, reducing the guesswork and the round trips needed to
> support a new revisions of the interface.
> 
> Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
> ---
>  I should have addressed all you comments
> 
>  drivers/hwmon/asus_atk0110.c |  191 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 191 insertions(+)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
