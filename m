From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: [RFC] I2C: Remove the i2c_client id field
Message-Id: <20041227230402.272fafd0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>
Cc: LM Sensors <sensors@stimpy.netroedge.com>

Hi Greg, hi all,

While porting various hardware monitoring drivers to Linux 2.6 and
otherwise working on i2c drivers in 2.6, I found that the i2c_client
structure has an "id" field (of type int) which is mostly unused. I am
not exactly sure why it was introduced in the first place, and since the
i2c subsystem code was significantly reworked since, it might not
actually matter.

Most hardware monitoring drivers allocate a unique (per driver) id
through an incremented static global variable, and never use it. Some
(lm85 and most notably adm1026) use the value in debug messages. I saw
various video drivers appending the id value to the client name between
square brackets, while others would set the id field to -1 and then
leave it alone. The i2c core itself doesn't use this field.

Using this field to identify a client doesn't make much sense to me, for
the following reasons:

1* A client is already uniquely identified by the combination of the
number of the bus it sits on and the address it is located at on this
bus.

2* With the implementation described above, the id will possibly change
depending on which i2c bus drivers are loaded and the order they were
loaded in. As a consequence, you can't rely on its value from
user-space, and its usability in kernel-space isn't obvious either.

3* As a matter of fact, no driver in the kernel tree uses this field
except for debugging (and even then with no obvious benefit), with only
a few exceptions where I could easily change the code so it wouldn't
need this field anymore.

Thus, I propose that we simply get rid of this field, so as to save some
memory space and kill some useless code. If anyone really ever needs to
carry some sort of id attached to an i2c_client structure, this is
private data and can be added to whatever structure the data field is
pointing to for this particular driver.

Unless someone objects with valid reasons, I am going to send patches to
kill the i2c_client id field. I have everything ready, but don't know
exactly how I should send them. The difficulty comes from the relatively
large number of affected drivers (50) and the fact that they spread over
very different subsystems (the big ones are i2c and media/video, plus
half a dozen drivers in acorn/char, macintoch and sound).

Greg, can you tell me if you would take such a patch, and how I would
have to split it for you to accept it?

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
