From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 13 Oct 2009 14:18:30 +0000
Subject: Re: [lm-sensors] it87 / acpi / DSDT-dump (ASUS P5V2D-MX)
Message-Id: <20091013161830.05e78d75@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
In-Reply-To: <68676e00910130600u39fff342mf5db22c962f895de@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Oct 2009 15:37:34 +0200, Luca Tettamanti wrote:
> So my advise to you is to use asus_atk0110; if you need to directly
> control the fans (not possible with the ACPI driver) then use
> "acpi_enforce_resources=lax" and load it87 (and do *not* load
> asus_atk0110).

I thought the asus_atk0110 driver was being automatically? If I'm
correct then one needs to _blacklist_ the asus_atk0110 driver for it to
not load.

-- 
Jean Delvare



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
