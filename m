From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: [PATCH] i2c-prosavage.c section usage
Message-Id: <1078758148.404c8b040939f@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040307194701.0cf1ec47.rddunlap@osdl.org>
In-Reply-To: <20040307194701.0cf1ec47.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Quoting "Randy.Dunlap" <rddunlap@osdl.org>:

> prosavage_remove() is called during init, so it shouldn't be
> marked as exit code.  (It matters when CONFIG_HOTPLUG=n.)
> (...)
> // Linux 2.6.4-rc2
> // prosavage_remove() shouldn't be marked as __devexit;

Wouldn't a more correct fix be that prosavage_remove would not be called
during init? Looks to me like this function will do almost nothing when
called at this point (because the driver hasn't fully intialized yet).

I took a look at the other drivers and no other one does handle this
particular point the way i2c-prosavage does. This makes me think that
it isn't the prefered way to do it. For example, i2c-savage4 could be
used as a template to modify i2c-prosavage.

On the opposite side, i2c-ixp42x and i2c-keywest do not use __devexit_p
for their .remove callback functions, while I would tend to think that
they should do so, since their aren't called explicitely like it is
done in i2c-prosavage.

(BTW, I don't much see how this is related to CONFIG_HOTPLUG, if you
could explain this to me...)

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
