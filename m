From: Len Brown <lenb@kernel.org>
Date: Thu, 07 Feb 2008 06:41:33 +0000
Subject: Re: [lm-sensors] The new thermal management sysfs class, and hwmon
Message-Id: <200802070141.33362.lenb@kernel.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080203022622.GA995@khazad-dum.debian.net> <20080203164410.GL20687@jupiter.solarsys.private> <20080203175006.GB9159@khazad-dum.debian.net>
In-Reply-To: <20080203175006.GB9159@khazad-dum.debian.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, Zhang Rui <rui.zhang@intel.com>, linux-acpi@vger.kernel.org, lm-sensors@lm-sensors.org, Jean Delvare <khali@linux-fr.org>, "Thomas, Sujith" <sujith.thomas@intel.com>


> Agreed.  However, *duplicating* what is already in hwmon elsewhere is not
> fun.  Please reconsider.

I started off with the same position as you, Henrique,
but Rui and Sujith don't see it that way.
Of course this is software, we can always change it --
particularly since there will be a very small list
of users for the new I/F, and we happen to know them:-)

> I'd like to see passive cooling (heck, the entire 
> ACPI v3.0 thermal model, if needed) added to hwmon, that will enhance hwmon
> to be even more generic, and we all benefit from that.

The ACPI 3.0 thermal model requires quite a bit of sophistication from
the system designer and BIOS writer.
Based on the quality of system designs and BIOS code we see
in the industry, I think it is way over the head of 99% of the industry.

That said, if a system does come out that supports the ACPI 3.0 Thermal Model
and they want to ship Linux on it, we can look into it then.

cheers,
-Len

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
