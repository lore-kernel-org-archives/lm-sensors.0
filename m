From: beejay@gentoo.org (Benjamin Judas)
Date: Thu, 19 May 2005 06:25:21 +0000
Subject: Bug #1807: sensors with kernel 2.4, but not with kernel 2.6
Message-Id: <1099501427.11618.18.camel@antares.hausnetz>
List-Id: <lm-sensors.vger.kernel.org>
References: <1099499003.11618.13.camel@antares.hausnetz>
In-Reply-To: <1099499003.11618.13.camel@antares.hausnetz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Bonsoir Jean,

> What I am mostly interested is the devices directory, not the drivers
> directory. Do you see any subdirectory named *-002d there, those
> "name" file reads asb100? What else do you see in this subdirectory?
> There should be a whole bunch of in*, temp* and fan* files.

I don't have that directory in /sys/bus/i2c/devices. What I have is:

antares /sys/bus/i2c/devices # ls -al
insgesamt 0
drwxr-xr-x  2 root root 0  3. Nov 17:31 .
drwxr-xr-x  4 root root 0  3. Nov 17:31 ..
lrwxrwxrwx  1 root root 0  3. Nov 17:31 0-0018
-> ../../../devices/pci0000:00/0000:00:0b.0/i2c-0/0-0018
lrwxrwxrwx  1 root root 0  3. Nov 17:31 0-0040
-> ../../../devices/pci0000:00/0000:00:0b.0/i2c-0/0-0040
lrwxrwxrwx  1 root root 0  3. Nov 17:31 0-0042
-> ../../../devices/pci0000:00/0000:00:0b.0/i2c-0/0-0042
lrwxrwxrwx  1 root root 0  3. Nov 17:31 0-0061
-> ../../../devices/pci0000:00/0000:00:0b.0/i2c-0/0-0061

Regards,
  Benjamin

-- 

Benjamin Judas

---------------------------------------------------------------------                                  
Gentoo-developer                        http://dev.gentoo.org/~beejay
Giessen, Germany                                http://www.gentoo.org

GPG-Key         : 0xC31DEDD8
Key-Fingerprint : 4E65 AAFE 785B 61D8 E4D9  1671 E017 87B7 C31D EDD8
Jabber          : beejay@im.gentoo.org


-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Dies ist ein digital signierter Nachrichtenteil
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20041103/d44738d1/attachment.bin
