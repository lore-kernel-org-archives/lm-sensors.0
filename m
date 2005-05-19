From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: General questions
Message-Id: <20040118214002.68ebd352.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040118125025.3102d486.khali@linux-fr.org>
In-Reply-To: <20040118125025.3102d486.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Oops, I moved my bk trees, and didn't tell anyone :(
> 
> The tree previously at bk://linuxusb.bkbits.net/usb-2.5 is now at:
> 	bk://kernel.bkbits.net/home/gregkh/linux/gregkh-2.6
> I don't know if there is web access to that tree or not, sorry.

Don't think there is. I think this leaves me no other choice than to
give a try to bitkeeper. I guess it can't hurt, anyway.

> I'm also staging the i2c patches to send off to Linus at:
> 	bk://kernel.bkbits.net/home/gregkh/linux/i2c-2.6

This is what I would be primarily interested in.

> > 3* Is there a chance that the i2c subsystem could be moved one level
> > down in the configure tree? I wonder why we live in "Character
> > Devices". The i2c subsystem is big enough to have its own
> > subdirectory, so I would expect it to appear in "Device Drivers"
> > directly.
> 
> Heh, I had that same idea a few days ago, and already did it in my
> trees with the following patch.

Perfect :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
