From: wixor <wixorpeek@gmail.com>
Date: Sun, 20 Sep 2009 12:46:37 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <c43b2e150909200546p764978ecnb0606533c7dea542@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com> 
	<68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
In-Reply-To: <68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Luca Tettamanti <kronos.it@gmail.com>
Cc: lm-sensors@lm-sensors.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sun, Sep 20, 2009 at 14:20, Luca Tettamanti <kronos.it@gmail.com> wrote:
> Try the asus_atk0110 driver, it handles the ACPI hwmon interface on
> Asus motherboards. If it does not work then please send a dump of your
> DSDT (/sys/firmware/acpi/tables/DSDT).

Works great, thank you very much.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
