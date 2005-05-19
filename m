From: sjhill@realitydiluted.com (Steven J. Hill)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: i2c/sensors patch for 2.4.21 uploaded to my server....
Message-Id: <3F136E12.8040509@realitydiluted.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFCF67D.9040503@realitydiluted.com>
In-Reply-To: <3EFCF67D.9040503@realitydiluted.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
> We will generate new patches in a few weeks based on i2c and lm_sensors
> 2.8.0, actually right after 2.8.0 is released. There has been so much
> change commited to CVS since 2.7.0 that this will be a hard work.
> 
> What would be of interest for us is to know if you encountered
> difficulties while doing your patch. If yes, we are likely to encounter
> the same difficulties too.
>
Yes, the following patches failed with the specific files:

     2.4.20-i2c-1-patch
       * drivers/i2c/Config.in
     2.4.20-i2c-2-patch
       * include/linux/i2c-id.h
       * include/linux/i2c.h

> In the meantime, we could consider putting a link on our news page,
> pointing to your patch, for interested users, unless someone has an
> objection against this. My only objection would be on the patch name.
> I'd better name it "sensors" than "i2c".
> 
I changed the name, but I also uploaded the corrected patches with the
2.4.21 prefix. All of the other 2.4.20 patches could be renamed with
the 2.4.21 prefix and new regeneration of the patches are unnecessary.

I also downloaded the 2.8.0 stuff and tested it out on my dual Athlon
machine. I have uploaded the 2.8.0 patches for 2.4.21 to my ftp site
as well. There were two modules, scx200_acb.c and scx200_i2c.c that did
not compile. These patches have also been uploaded. The link again is:

     ftp://ftp.realitydiluted.com/linux/i2c

-Steve
