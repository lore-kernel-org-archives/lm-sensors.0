From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Fix in eeprom.c
Message-Id: <20040403102243.27c4deba.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329193435.7d9a587d.khali@linux-fr.org>
In-Reply-To: <20040329193435.7d9a587d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > OK... Here we go. I've converted all drivers in our CVS repository
> > to a new model where we do the two kmallocs separately. I didn't
> > commit it yet because it's a very important change (47 chip drivers
> > affected). So I'd appreciate code reviews and tests before I apply
> > it.
> > 
> > The patch is here:
> > http://jdelvare.net1.nerim.net/sensors/lm_sensors-CVS-separate-mallocs.diff
> > It applies on latest CVS.
> > 
> > I tested only the eeprom and lm90 drivers so far. Seems to work, but
> > the changes are error-prone so what it "seems" is hardly enough to
> > be sure it's correct.
> 
> At a quick glance it looks sane.

Well, I doubt that a quick glance is enough to ensure that the patch
didn't break anything. I'm confident that the memory allocation and
"normal" freeing are correct. What I consider error-prone is the error
handling in detect functions. In several cases I had to rename labels.
It's hard to be sure that all error paths are absolutely correct,
although I did my best not to screw anything up.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
