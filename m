From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:55 +0000
Subject: linux 2.6 port of smsc47m1
Message-Id: <1083238050.4090e6a2d9da7@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040429023201.89488.qmail@web20802.mail.yahoo.com>
In-Reply-To: <20040429023201.89488.qmail@web20802.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me directly]

> I ported the smsc47m1 driver to kernel 2.6
> you can find the file at:
> http://penguintown.net/~gorlik/smsc47m1.c

Nice :)

> I don't know what is the procedure to get it into the
> lm_sensors and/or kernel distribution.

The file has to go into the main 2.6 kernel tree, after taking the
several steps:

1* Propose the patch on this mailing-list for reviewing and comments.
Do
the requested changes (or explain why you won't) until we agree that
the file is clean (code and style altogether).

2* Send a proper patch against the latest stable kernel or -mm kernel
(whichever has the more up-to-date i2c subsystem) to Greg KH (greg at
kroah dot com), CC the mailing list. The patch must include the new
driver (of course) as well as updates to the Makefile and Kconfig
files.

3* Greg applies the patch to his tree (and thanks you).

4* At some later time, Andrew Morton includes Greg's updates to the i2c
subsystem into his -mm series.

5* Once enough testing has been done, Greg send the patch to Linus for
inclusion into the main tree.

We're at step 1 at the moment ;)

Now, here are my comments about your code.

1* The memory allocation scheme changed recently in both the CVS chip
drivers and the Linux 2.6 kernel's ones. Your file still uses the old
one, this needs to be changed. An example of what you need to do is
here:
http://linux.bkbits.net:8080/linux-2.5/diffs/drivers/i2c/chips/w83627hf.c@1.6?nav=cset@1.1371.600.23

2* In smsc47m1_find(), you added a printk:
  printk("smsc47m1.o: found SMSC47M1xx with DevID=0x%02X\n",val);
I think it should be:
  printk(KERN_INFO "smsc47m1.o: found SMSC47M1xx with DevID=0x%02X\n",
val);
printks without KERN_* constants are not welcome if I remember
correctly.

3* Please respect the coding style. Your style is definitely better
than
most of what I usually have to review, but still... Please do not leave
white spaces before closing parenthesis. OTOH, please leave a white
space after comas.

4* There are a few lines you commented out (two of them if I counted
right). Just remove them. And don't use C++-style comments please.

5* You have an extra tabulation before "new_client->flags = 0;" in
smsc47m1_detect().

6* In smsc47m1_detect(), you use check_region(). This is deprecated. See
how things are fone in the w83627hf.c driver (basically you just try to
request the region, and bail out with an error if it fails).

That's about all for this first check. I have yet to take a look at the
sysfs callback functions. Please update your file and provide a full
patch against linux-2.6.6-rcX.

BTW, Have you been fixing things that you think should be backported to
the CVS (2.4) driver?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
