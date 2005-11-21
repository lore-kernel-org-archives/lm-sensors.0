From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 21 Nov 2005 19:49:45 +0000
Subject: [lm-sensors] Re: [PATCH] VRM table update
Message-Id: <20051121195027.58f5f8c9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051108220930.10413.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20051108220930.10413.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Rudolf,

> > This patch adds the VIA CENTAUR CPUs to detection table.
> > Table was updated to treat future Intel x86 CPUs as VRD10.
> > Stepping field was added, because some VIA CPUs have
> > different VRM specs across stepping.
> > 
> > Please apply.
> 
> Applied, thanks.

On second thought, there's a problem with that patch. The new VRM value
you introduce, 1718, doesn't fit in a u8, while all hwmon driver (but
it87) use a u8 to store the value.

We could change all hardware monitoring drivers to use an int instead
of a u8 for vrm, but as the VRM values are totally arbitrary, I think we
should rather simply use values which fit in 8-bit, have find_vrm and
vid_which_vrm return a u8, and have vid_from_reg take a u8 as its
second parameter. In other words, make it clear that vrm values are u8.

Care to respin a patch?

Thanks,
-- 
Jean Delvare
