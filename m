From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 25 Mar 2006 18:04:36 +0000
Subject: [lm-sensors] [PATCH 02/10] w83627ehf: Add voltage inputs support
Message-Id: <20060325180436.GA5712@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060323162522.f46f7072.khali@linux-fr.org>
In-Reply-To: <20060323162522.f46f7072.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all:

* Jean Delvare <khali at linux-fr.org> [2006-03-23 16:25:22 +0100]:
> From: Rudolf Marek <r.marek at sh.cvut.cz>
> Content-Disposition: inline; filename=hwmon-w83627ehf-add-voltages.patch
> 
> Add the voltage measuring support to W83627EHF. The code is based
> on the patch provided by Yuan Mu from Winbond.
> 

[snip]

> +static inline u8 in_to_reg(u32 val, u8 nr)
> +{
> +	return SENSORS_LIMIT(((val + (scale_in[nr] / 2)) / scale_in[nr]), 0, 255);
> +}

This reminds me... it seems that static inlines (outside of header files)
are discouraged now - see chapter 14 of CodingStyle.  It would be pointless
to take them all out of drivers/hwmon/*.c now, but we probably shouldn't
add any more of them.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


