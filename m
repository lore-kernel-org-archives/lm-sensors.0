From: Pavel Machek <pavel@ucw.cz>
Date: Wed, 09 Sep 2009 21:29:28 +0000
Subject: Re: [lm-sensors] [PATCH v4] hwmon driver for ACPI 4.0 power meters
Message-Id: <20090909212928.GB7248@elf.ucw.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200908202049.n7KKnKO7015060@imap1.linux-foundation.org> <20090820211557.GA8431@elf.ucw.cz> <20090820213755.GB10521@tux1.beaverton.ibm.com> <20090821091939.GC21167@elf.ucw.cz> <20090821184718.GD23397@tux1.beaverton.ibm.com> <20090821221705.GA2108@elf.ucw.cz> <20090822011744.GH10521@tux1.beaverton.ibm.com> <20090821140159.GB1328@ucw.cz> <20090908202410.GS10521@tux1.beaverton.ibm.com> <20090909182347.GB26158@tux1.beaverton.ibm.com>
In-Reply-To: <20090909182347.GB26158@tux1.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: akpm@linux-foundation.org, mm-commits@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>, rui.zhang@intel.com, lenb@kernel.org

> +config ACPI_POWER_METER
> +	tristate "ACPI 4.0 power meter"
> +	depends on HWMON
> +	default y

Should not really be default y, see the other mail.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
