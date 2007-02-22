From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 22 Feb 2007 20:21:07 +0000
Subject: [lm-sensors] [PATCH] hwmon: Request the I/O regions in platform
Message-Id: <20070222212107.4050b6dc.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070221201208.0420dc7d.khali@linux-fr.org>
In-Reply-To: <20070221201208.0420dc7d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 22 Feb 2007 12:06:18 -0800, Juerg Haefliger wrote:
> OK, with your patch (http://lkml.org/lkml/diff/2007/2/20/310/1)
> applied, it works as advertised :-)

Great, thanks for testing and reporting.

> However, your platform-io-region patch doesn't apply cleanly:
> 
> juno:/usr/src/linux-2.6.21-rc1# patch -p1 < ../jean.patch
> patching file drivers/hwmon/f71805f.c
> Hunk #1 succeeded at 35 with fuzz 2.
> missing header for unified diff at line 11 of patch
> can't find file to patch at input line 11
> Perhaps you used the wrong -p or --strip option?
> The text leading up to this was:
> --------------------------
> |
> | static struct platform_device *pdev;
> --------------------------
> File to patch:

I don't understand, I thought you had already applied that one? Either
way, it smells like a corrupted patch file. It's probably visible if
you open the patch file with a text editor. I guess your mailer saved
it with some encoding and you'd need to fix it before you can apply it
(e.g. using metamail.)

-- 
Jean Delvare

