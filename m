From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 11 Aug 2006 16:21:23 +0000
Subject: [lm-sensors] Thinkpads still not supported?
Message-Id: <20060811182123.3fc558c4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20060811T155741-190@post.gmane.org>
In-Reply-To: <loom.20060811T155741-190@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> I see my model (T60p) in
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-April/015983.html
> Does that mean anything, or is
> http://www.lm-sensors.org/browser/lm-sensors/trunk/README.thinkpad still the
> latest news?

It's completely unrelated. The hdaps driver reports the acceleration of
the laptop. It's meant to park the hard disk driver heads if the laptop
falls, for example. It will work on your laptop. But it's not a
hardware monitoring chip in the common sense of the term.

The SMBus is still blacklisted on IBM systems based on a PIIX4 chip.
Your laptop probably has a more recent chip (Intel 82801), but anyway
we've never seen a Thinkpad with a useable hardware monitoring chip as
far as I remember, so it's probably not worth investigating. If you
want to know the temperature laptop, try the "thermal" acpi driver
instead.

-- 
Jean Delvare

