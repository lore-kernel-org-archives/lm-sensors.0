From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: adding support for new 2.6 chips in (lib)sensors
Message-Id: <20031231190049.0c2a741f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031230214411.6eb029e7.khali@linux-fr.org>
In-Reply-To: <20031230214411.6eb029e7.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> strace?
> 
> temp_critx is NOT standard, or at least not converted by getsysname();
> so if 'sensors' is looking for it as tempx_crit it won't find it.

I figured it out. The 2.4 driver uses tempX_high and tempX_low instead
of _max and _min, respectively. I added the conversion rules for those
in lib/proc.c, and for tcritX -> temp_critX as well.

Now I need to work the hysteresis problem out. This is a single,
relative value in 2.4, and has to be two absolute values in 2.6. This
cannot possibly be done in libsensors as far as I can see, so I think
I'll have to tweak sensors itself. Is there a way sensors could know
wether we are running under 2.4 or 2.6? Or would I simply try the
alternate method if and only if the first one failed?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
