From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030811234629.2262d1c0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806233617.5a83d0b6.khali@linux-fr.org>
In-Reply-To: <20030806233617.5a83d0b6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > Not really. Looks complicated ;) and it seems these are capabilities
> > you give to a user/process, not to a file. I just don't want to dive
> > into this for something that "simple".
> 
> Why?  Just check for CAP_SYS_ADMIN if the Vaio is detected.  If that
> succeeds, then give access, otherwise deny it.

I'm not sure I understand how it works. Whose capabilities are checked?
The person accessing the proc file? In this case, yes, it would make
sense. I would then have something like:

if (!capable(CAP_SYS_ADMIN)) {
	/* show the real data */
} else {
	/* show zeroes only */
}

Is that it? I don't know actually what I should display for non-root
users (btw, CAP_SYS_ADMIN = root, or is it more complex?). Maybe an
empty file, or maybe zero values instead of the password.

> > Remember, the eeprom module, although widely used, is one of our
> > least interesting drivers.
> 
> But it's fun to play with :)

Sure it is, that's the one I started with (due to that Vaio EEPROM
already). But it's also one of the slowest drivers, and I believe we'll
get rid of it someday (I really plan not to load it by default at some
time).

> > And LM Sensors is useless on Sony Vaio's anyway (no sensor chips).
> 
> Looks like the eeprom driver works :)

Yes it does, but do users install lm_sensors to read how many memory
they do have in their laptop? I doubt it.

> > So let's play it safe, but without extra technologies involved. Do
> > not export the eeproms detected as Vaio's ones unless forced too.
> 
> What does "forced too" mean here?

Force like in "modprobe eeprom force=0,0x57".

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
