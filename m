From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <200308021617.35225.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 02 August 2003 13:59, Jean Delvare wrote:
>> So where do users go to post problem reports?  I seem to have
>> gotten lost in a quagmire of updates between its (sensors) all
>> working in kernel-2.4.22-pre8 and the 2.7.0 family of
>> i2c/lm_sensors, and 2.4.22-pre10 and either 2.7.0 or 2.8.0 of
>> i2c/lm_sensors.
>
>The list is OK for reporting problems, you just don't have to
> register to do so. Alternatively, you can use our ticket-based
> support: http://www2.lm-sensors.nu/~lm78/support.html
>
>> I just saw a bitkeeper pull go by on the usb list from greg-kh,
>> but I don't have bitkeeper.  From the list of fixes, it would fix
>> my problems.  i2c-nforce is one that I need but which won't build
>> here, and somehow, i2c-viapro seems to have disappeared from the
>> kernel stuffs, if it was ever in there.
>
>I think you're messing up between what Greg KH does and what we do.
> We develop i2c and lm_sensors as add-ons to the Linux 2.4 kernel.
> Grek KH works on integrating our drivers into Linux 2.6. So unless
> you are using Linux 2.6, you just don't need anything Greg can
> offer.
>
>Now that this is clear, could you start again explaining to us which
>kernel you are using, which version of i2c and lm_sensors you are
> using, and what the problem is?

Humm, I've been building both 2.4.22-pre's and 2.6.0-test2 here and it 
gets confusing at times.  But basicly, in the 2.4.22-pre10 tree, 
i2c-viapro seems to have disappeared.  If I build in the i2c-2.7.0 
tree (and in the lm_sensors-2.7.0 tree, both externally but in my 
compiler driver script as a ps to making the targeted kernel, it all 
works with some of the i2c stuff in the kernel turned on, this for 
kernel 2.4.22-pre8.  Skip to pre10, and the viapro module is gone for 
both 2.7.0 and 2.8.0 builds of both, and 2.8.0 gives me lots of 
depmod errors, so I've reverted to the 2.7.0 family when trying the 
last couple of 2.4.22-pre10 builds.

Q's: In the i2c dir tree there is a mkpatch, but unless I'm getting 
blind in my old age, I cannot find any howto instructs to use just in 
case the 2.7.0 (or the 2.8.0) versions are newer than whats in the 
2.4.22-pre10 tree.  Since 2.7.0 is getting a bit long in the tooth 
now, I need my perception of whats what sorted out, so be my guest 
and sort me out if you have the time.

In the meantime, I'll ignore Gregs stuff in terms of the 2.4 kernel, 
and use it as its added to the 2.6 tree, which I cannot use just yet, 
something has broken my scsi cards driver, advansys.c, by deprecating 
the check_region() call.  This IIRC is the same function that causes 
the build of lm_sensors-2.8.0 to fail at the nforce.c build.

Like I said, its a bit hard to keep them straight in my 68 year old 
head.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
