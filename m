From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: gl518sm chip driver for 2.6 kernel
Message-Id: <1075456058.401a283ab7fbf@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1075295349.4017b475e9031@imp.gcu.info>
In-Reply-To: <1075295349.4017b475e9031@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting Chew Hong Gunn <hgchew@gunnet.org>:

> > * Your new driver defines two different names for the two
> > different releases of the chip. This breaks compatibility with
> > libsensors, and would better be fixed (I will do too).
>
> Ok.  It was there to differentiate the two revisions.

The intention was good, but libsensors won't like it, sorry.

> I have tested rc2 and there are no problems with it.  I did however
> make two minor changes to it:
> * added swap_bytes function declaration (unless you deleted it
> intentionally)

Yes, deletion was intentional. This is a utility function and doesn't
belong to the interface, so to say.

> * removed voltage_in[0-2] = 0 for rev00 chips
>   these are initialised to 0 on init, so there should be no need
>   to set them at each update.

I couldn't find where it had been initialized so decided to play it
safe, but you're right, there's a memset at the very beginning, so this
part can get away.

Looks like we are not that far from a "final" version? Maybe some
changes to bring comments, authorship and copyrights in line with the
other drivers, and we should have something good for inclusion.

Greg, we're listening to your comments if you have any. And thanks a lot
for your initial review which was obviously needed ;)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
