From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 28 May 2007 06:33:51 +0000
Subject: Re: [lm-sensors] [PATCH] Add IT8726F
Message-Id: <20070528083351.71db06a8@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <465207E5.3010500@assembler.cz>
In-Reply-To: <465207E5.3010500@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

On Mon, 21 May 2007 22:58:13 +0200, Rudolf Marek wrote:
> Following patch adds support for IT8726F chip driver, which is just same as 
> IT8716F with additional glue logic for AMD power sequencing.
> 
> Signed-off-by: Rudolf Marek <r.marek@assembler.cz>
> 
> Please apply. Compile tested.

Patch applied, thanks. I added a minor change to drivers/hwmon/Kconfig
to list the IT8726F there.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
