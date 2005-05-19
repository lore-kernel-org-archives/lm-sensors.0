From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: #1385 (sensors segfault)
Message-Id: <20030830174931.19a8a884.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030824213041.GA6171@borneo.zolder.net>
In-Reply-To: <20030824213041.GA6171@borneo.zolder.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > As for the segmentation fault, I know we already encountered the
> > problem and that it was caused by the modules and the library to be
> > from different versions. You say it's not the case here. I'd like
> > you to double check. "sensors -v" will give you the sensors version.
> > "dmesg" right after loading the i2c modules will give you the
> > modules versions. If they don't match, you know why sensors-detect
> > crashes.
> 
> dmesg:
> 
> i2c-proc.o version 2.6.1 (20010825)
> (...)
> i2c-i801 version 2.8.0 (20030714)

Bingo! Two modules with different versions. The i2c-proc module
obviously comes from your kernel while i2c-i801 was installed from our
packages.

> Does version problems also include kernel / version mismatch ? I 
> use 2.4.21, but I recompiled it a few times after i installed
> lm_sensors.

That's the problem. Recompiling (and reinstalling) overwrote our modules
with the kernel ones. Reinstall our i2c package again and the trouble
should be gone.

> Offtopic: what new Intel P4 board does have good support
> for lm_sensors ? (For entry level server use)

That I can't say, sorry.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
