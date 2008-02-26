From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 26 Feb 2008 13:11:50 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (w83793) VID and VRM
Message-Id: <20080226131150.GB2947@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-02-12 11:25:07 +0100]:
> * Rework the device initialization function so as to read the
> "Multi-Function Pin Control" register (0x58) once instead of twice.
> I2C transactions aren't cheap so this speeds up the driver loading.
> 
> * Only create the "vrm" attribute if at least one VID value is
> available.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Gong Jun <jgong@winbond.com>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> ---
> Gong Jun and/or Rudolf, can you please review and/or test this patch?
> 
>  drivers/hwmon/w83793.c |   26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
