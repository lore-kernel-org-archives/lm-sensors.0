From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: One-liner fix for i2c-velleman (and problems with i2c-tsunami)
Message-Id: <20030725105440.61630269.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307242129.59862.kelledin@users.sourceforge.net>
In-Reply-To: <200307242129.59862.kelledin@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Here's a snippet of my current patch to give you an idea:
> 
>  static struct i2c_algo_bit_data tsunami_i2c_bit_data = {
> -
> -       bit_tsunami_setsda,
> -       bit_tsunami_setscl,
> -       bit_tsunami_getsda,
> -       bit_tsunami_getscl,
> -       10, 10, HZ/2    /* delays/timeout */
> +       .setsda         = bit_tsunami_setsda,
> +       .setscl         = bit_tsunami_setscl,
> +       .getsda         = bit_tsunami_getsda,
> +       .getscl         = bit_tsunami_getscl,
> +       .udelay         = 10,
> +       .mdelay         = 10,
> +       .timeout        = HZ/2,
>  };
> 
> Apparently gcc-3.2.3/alpha doesn't grok the original method of 
> static initialization.  It choked on it badly until I switched 
> it.  gcc-2.95.3/x86 seems to like either way just fine.
> 
> Maybe the C standard has changed, or maybe gcc3 is just being a 
> fruitcake.  But as the other static structs use a different form 
> of initialization, I decided to accomodate gcc3 and introduce 
> proper consistency in one fell swoop.

The new way complies with C99 (yes, the standard has evolved, if not
changed) and we try to make all our drivers comply with that. This makes
struct changes less painful (although it's still tough). Everything in
i2c should be that way now, but we haven't finished cleaning lm_sensors
yet.


> Hmmm...well, part of the tsunami_driver struct requires a PCI ID 
> table (tsunami_ids).  I'm not sure what's supposed to go in that 
> table?
> 
> Could it be that someone tried to port the driver to the new API, 
> half-finished it, and left it for dead?  lm_sensors-2.7.0 makes 
> no mention of the tsunami_driver struct or the tsunami_ids 
> table.  Maybe that little struct arrangement isn't supposed to 
> be there?

This is really possible (not to say probable). As said in an earlier
e-mail, the last changes on this driver back in January 2003 were part
of a bulk change that affected almost all of our drivers. I remember
there were many thread on this list about PCI drivers needing updates. I
guess this one has been left over in an unstable state (again due to a
lack of hardware for testing).

You should go and read this one:
http://archives.andrew.net.au/lm-sensors/msg02718.html

I think this matches what you suspected pretty good. Maybe Mark will be
able to tell you what should be done (it's over my own knowledge).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
