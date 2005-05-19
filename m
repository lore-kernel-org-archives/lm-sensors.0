From: gene.heskett@verizon.net (Gene Heskett)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: subscribe gene.heskett@verizon.net
Message-Id: <200308022042.50092.gene.heskett@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308012231.07647.gene.heskett@verizon.net>
In-Reply-To: <200308012231.07647.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Saturday 02 August 2003 17:17, Jean Delvare wrote:
>> >Now that this is clear, could you start again explaining to us
>> > which kernel you are using, which version of i2c and lm_sensors
>> > you are using, and what the problem is?
>>
>> Humm, I've been building both 2.4.22-pre's and 2.6.0-test2 here
>> and it gets confusing at times.  But basicly, in the 2.4.22-pre10
>> tree, i2c-viapro seems to have disappeared.  If I build in the
>> i2c-2.7.0 tree (and in the lm_sensors-2.7.0 tree, both externally
>> but in my compiler driver script as a ps to making the targeted
>> kernel, it all works with some of the i2c stuff in the kernel
>> turned on, this for kernel 2.4.22-pre8.  Skip to pre10, and the
>> viapro module is gone for both 2.7.0 and 2.8.0 builds of both, and
>> 2.8.0 gives me lots of depmod errors, so I've reverted to the
>> 2.7.0 family when trying the last couple of 2.4.22-pre10 builds.
>
>I admit I'm not sure to understand everything you are trying to do.
>
>> Q's: In the i2c dir tree there is a mkpatch, but unless I'm
>> getting blind in my old age, I cannot find any howto instructs to
>> use just in case the 2.7.0 (or the 2.8.0) versions are newer than
>> whats in the 2.4.22-pre10 tree.  Since 2.7.0 is getting a bit long
>> in the tooth now, I need my perception of whats what sorted out,
>> so be my guest and sort me out if you have the time.
>
>I suggest you start from the very beginning with the separate
>compilation option. This is the way I personnally use, and the one I
>recommend too.
>
>You need to have a kernel tree matching your running kernel.

This has been one of the sore spots with me, this requirement that I 
make a new kernel, and sensors doesn't work because its referenceing 
the one that running, not the one thats building courtesy of the use 
of the uname facility to discover the version numbers.  I'd much 
rather it reached back into /usr/src/linux to discover this since 
that link *will* be valid for the kernel under construction.

> This
> kernel must not have any I2C element hard-compiled. If it has some
> as modules, it's OK, they'll be overriden.
>
>Then, install i2c-2.8.0. Don't patch your kernel, just compile
>separately. It's as easy as: make, make install.
>
>Then, install lm_sensors-2.8.0. Same as for i2c, don't patch your
>kernel, compile separately. It's as easy as: make, make install,
>ldconfig.

ldconfig?  Something tells me I really do need to rtfm better than I 
have recently...

>There will be depmod errors, we know about them, but unless you
> can't live with a module they appear on (i2c-matroxfb and such),
> just don't care. These errors won't be fixed before Linux 2.4.23 is
> released. If this is a real problem to you, then stick to i2c and
> lm_sensors-2.7.0.

Which, up to and includeing 2.4.22-pre8, worked just fine.

>This method is far easier than using mkpatch, and I expect it to
> work even with preX kernels.
>
>Hope this helps.

I'll give it a shot, Jean, thanks.

-- 
Cheers, Gene
AMD K6-III@500mhz 320M
Athlon1600XP@1400mhz  512M
99.27% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2003 by Maurice Eugene Heskett, all rights reserved.
