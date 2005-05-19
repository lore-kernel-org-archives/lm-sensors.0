From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: [PATCH 2.6] it87 Part2(reset option)
Message-Id: <20040228085449.06a402ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040225111219.1c117787.komoriya@paken.org>
In-Reply-To: <20040225111219.1c117787.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here's new version.

Great :) It's OK for me.

Now I could send it to Greg, but you could also to it yourself, so as to
get the credit you deserve for your work. It's easy. Send your patch
again, to Greg KH, CC the lm_sensors mailing list. The patch must be
inline (as you always do) and work when one uses "patch -p1" from the
first level of the Linux kernel tree. This means that you have to
generate it using
"diff -u linux-2.6.3/drivers/i2c/chips/it87.c.sensor_type linux-2.6.3/drivers/i2c/chips/it87.c"
or similar. Your email should explain what the patch does and why it is
good. You are also invited to mention the fact that I already reviewed
your work and liked it (so as to ease Greg's decision).

In the meantime, I'll be backporting your code to our 2.4 driver.

Thanks a lot for your good work so far :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
