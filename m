From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: LM-sensors Q
Message-Id: <20020924141329.A17577@mercury.solarsys.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020924115615.A15392@mercury.solarsys.net>
In-Reply-To: <20020924115615.A15392@mercury.solarsys.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello again:

* harry <harry@dr-data.net> [2002-09-24 12:59:38 -0700]:
<snip>
> I did not find any info on building the AS991275 as a module. The only 
> reference I found was in the latest drivers section where there was a 
> mkpatch link that I pulled the info listed below from. I would much perfer 
> to build a standalone module against my current kernel as opposed to 
> rebuilding the kernel. I assumed that as a result of the patches I would 
> be able to configure the kernel to build the AS199127F module, which I 
> assume is not an option w/o the patches.
> 
> Please advise as to how I might build the AS99127F module.
<snip>

On second thought, probably you didn't build correctly.  And btw, there
is no as99127f module... that is supported by w83781d.

1. Get a clean/fresh kernel source tree.
2. Get the latest sensors and i2c (2.6.5) packages.
3. Read the file "INSTALL" in each of those packages *very carefully*.

If you use a 2.4 series kernel, then you probably want build option 1.
Make sure you configure the I2C parts of the (clean) kernel according to
the instructions in INSTALL.  You need to do this *before* you build
the I2C and sensors packages.

Only if you use a 2.5 series kernel, will you have to use the kernel
patches.  If that is the case, someone else will have to help you as
that is completely out of my experience.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com
