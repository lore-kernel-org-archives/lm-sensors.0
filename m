From: dmitry.torokhov@gmail.com (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [03/07] I2C: Fix incorrect sysfs file permissions in it87 and
Message-Id: <d120d50005042712417656ba3a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050427171446.GA3195@kroah.com> <20050427171617.GD3195@kroah.com>
In-Reply-To: <20050427171617.GD3195@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg KH <gregkh@suse.de>
Cc: khali@linux-fr.org, sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org, stable@kernel.org, Justin Forbes <jmforbes@linuxtx.org>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, Cliff White <cliffw@osdl.org>, Theodore Ts'o <tytso@mit.edu>, "Randy.Dunlap" <rddunlap@osdl.org>, Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk

On 4/27/05, Greg KH <gregkh@suse.de> wrote:
> 
> -stable review patch.  If anyone has any objections, please let us know.
> 

While the patch is correct I'd have something like this as well:

--- linux-2.6.11.orig/fs/sysfs/file.c
+++ linux-2.6.11/fs/sysfs/file.c
@@ -36,7 +36,7 @@ subsys_attr_store(struct kobject * kobj,
 {
        struct subsystem * s = to_subsys(kobj);
        struct subsys_attribute * sattr = to_sattr(attr);
-       ssize_t ret = 0;
+       ssize_t ret = -ENOSYS;
 
        if (sattr->store)
                ret = sattr->store(s,page,count);

So writes without store handler would return "not implemented".

(It is whitespace-mangled and therefore not a real patch - so no
signed-off-by...)

-- 
Dmitry
