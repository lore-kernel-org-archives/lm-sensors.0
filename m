From: "Luca Tettamanti" <kronos.it@gmail.com>
Date: Mon, 05 Jan 2009 20:46:05 +0000
Subject: Re: [lm-sensors] Asus KFN4-DRE board
Message-Id: <68676e00901051246x6781dc05sf58dc162cfb6909c@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <gjtlg7$htb$1@ger.gmane.org>
In-Reply-To: <gjtlg7$htb$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Jan 5, 2009 at 8:02 PM, Mark Nienberg <gmane@tippingmar.com> wrote:
> Forgive me if this is double posted.  I'm using gmane and I forgot to enable the
> address the first time.
>
> CentOS 5.2 x86_64
> lm_sensors 2.10.6 installed from atrpms
> ASUS KFN4-DRE server motherboard
>
> sensors-detect suggested the w83627hf module, but that gave nonsense results.  The
> w83792d module is the correct one for this board, as documented in the motherboard
> user guide.  I switched to that one and it mostly works.

I'm curious... can you send me a copy of your DSDT:
cat /sys/firmware/acpi/tables/DSDT | bzip2 > /tmp/dsdt.bz2

or - for older kernels:
cat /proc/acpi/dsdt | bzip2 > /tmp/dsdt.bz2

I'd like to see whether the board supports the ATK ACPI interface or not.

thanks,
Luca

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
