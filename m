From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 Oct 2009 16:40:18 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <20091005184018.5655090e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
	<68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
	<4AC939BB.8090600@wasp.net.au>
	<68676e00910050837g2006bfb8j349891504e474a95@mail.gmail.com>
In-Reply-To: <68676e00910050837g2006bfb8j349891504e474a95@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: Brad Campbell <brad@wasp.net.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Mon, 5 Oct 2009 17:37:29 +0200, Luca Tettamanti wrote:
> That's good ;-) The driver is quiet when everything is ok. You should
> see the corresponding entries under /sys/class/hwmon/hwmonN; upgrade
> lm-sensor package to version 3.1.1, older versions do not support ACPI
> devices.

Actually lm-sensors version 3.1.0 did already support ACPI devices. But
there's no reason to not upgrade to 3.1.1.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
