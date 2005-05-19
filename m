From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: Fix for kernel 2.4.21 patch
Message-Id: <20030730111431.17cc682a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4ABDB84E30B89F4E9C942C186F0B9EF605BAF8@4rf-nz-mail.local.4rf.com>
In-Reply-To: <4ABDB84E30B89F4E9C942C186F0B9EF605BAF8@4rf-nz-mail.local.4rf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I downloaded the Linux 2.4.21 kernel patch for the I2C 2.8.0 release
> and tried to patch my kernel for an RPXLite target board. There are a
> couple of bugs in the patch for this target which prevent it from
> compiling. I have fixed these and would like to know where to send the
> updated patch file.

You hit the right address, we are interested in your patch. Please send
it to us. Comments about what it does and why it is necessary would be
very welcome too.

However, please dont send us a modified patch. This patch is soooo big
and I guess you just fixed some lines. What we would need is a patch
against our original I2C source code. Please download i2c-2.8.0.tar.gz
(or checkout from CVS, at your option) and generate a patch from this.

(If you don't want to/don't know how to do that, send your large file to
me only and I'll try to handle it.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
