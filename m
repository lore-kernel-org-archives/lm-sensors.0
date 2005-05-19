From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: linux-2.6.1, ECS K7S5A / SiS735
Message-Id: <20040122014900.GM10681@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
In-Reply-To: <20040113004723.5892cfb2.Dexter.Filmore@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Dexter Filmore <Dexter.Filmore@gmx.de> [2004-01-21 19:40:36 +0100]:

> I suspected that, but then again how can I get the complete list instead of
> replies only to my threads?

The mailing list is maintained manually.  If you want to subscribe, send
a message to Phil Edelbrock <phil@netroedge.com>.  If you just want to
read the list, look here: http://archives.andrew.net.au/lm-sensors/

> > Could you send the results of 'lspci -v' and 'lspci -n' on your system
> > while running 2.6.x?  Does the i2c-sis645 driver work for you with
> > kernel 2.4.x?  If so, please send both 'lspci' results while running
> > that also.
> 
> I've got it working now with 2.4.24 (to which I reverted anyway since there's
> some framebuffer woes with 2.6) and got it working fine.
> Here is lsmod and lspci -v-/n from 2.4.24:
> 
> ******** 2.4.24 *********
> root@xerxes:~# lsmod
> Module                  Size  Used by    Not tainted        //strange no
> module is listed as "used" by any other, is'nt it
> it87                   11852   0  (unused)
> smbus-arp               4820   0  (unused)    //this one is not displayed in
> 2.6
> eeprom                  3824   0  (unused)     
> i2c-isa                  716   0  (unused)
> agpgart                14224   0  (unused)

No, the above shows that you don't have i2c-sis645 loaded.  The sensors
program may work without it though (it87 via ISA access).

> root@xerxes:~# lspci -n
> 00:00.0 Class 0600: 1039:0735 (rev 01)
> 00:01.0 Class 0604: 1039:0001
> 00:02.0 Class 0601: 1039:0008
> 00:02.5 Class 0101: 1039:5513 (rev d0)
> 00:0b.0 Class 0401: 1274:1371 (rev 02)
> 00:0d.0 Class 0200: 10ec:8139 (rev 10)
> 01:00.0 Class 0300: 102b:1001 (rev 02)

After you load i2c-sis645, you should see a new entry in 'lspci -n',
like this:

00:02.1 Class 0c05 1039:0016

This is the SMBus PCI device that i2c-sis645 un-hides.  Let's first
confirm that much works for you in kernel 2.4.

> that's it about 2.4. right now I can't boot 2.6 since this is a server
> machine, I guess I'll have the opportunity tomorrow, I'll send you the other
> data then.

With kernel 2.6, the driver (which is renamed to the more correct i2c-sis96x)
does not unhide the SMBus device.  The kernel itself does that right after it
boots.  This is the part that I suspect is going bad for you; here's what I'd
like you to do (beware this could crash your machine, especially if you or I
mistype something)...

As root, do this (# is the prompt):

# setpci -s 00:02.0 0x40

This will report a single number in hex; for me, it gives "98".  Add hex 40
to it; for me that's "98 + 40 = d8".  Substitute yours in place of NN below...

# setpci -s 00:02.0 0x40=0xNN

OK, now the true identity of that PCI device is revealed:

# lspci -H1 -n | grep "00:02.0"

Send me the results of that command.  Here's what I expect you'll see:

00:02.0 Class 0601: 1039:0018

Now one more command, to put things back.  Substitute the hex number that
you read in the first command for MM below...

# setpci -s 00:02.0 0x40=0xMM

I don't expect that the above commands will make much sense to you, but
at least you need to understand addition in hex to do this - if not then
let me know and I'll try to arrange a meeting by IRC to walk you through
it.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
