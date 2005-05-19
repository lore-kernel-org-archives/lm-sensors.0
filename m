From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: [PATCH] sensors-detect and udev
Message-Id: <20040811203651.1926bfa9.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040810225714.GA2700@pc.aurel32.lan>
In-Reply-To: <20040810225714.GA2700@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> sensors-detect currently checks at the beginning of its execution if
> the i2c device nodes exists. It can't work on a system using udev as
> the nodes are created when the i2c-dev module is inserted.
> 
> The attached patch fixes that.

I don't get this:

+  if (-d './dev') {

How does the existence of a directory named "dev" in the current
directory (which can be just anything) demonstrate the use of udev?

And could you please explain how udev is working? I don't know anything
about it.

Also,

+  if ((!$use_devfs) and (!$use_udev)) {

Please use "&&" instead of "and". Also notice that !(A && B) is more
efficient than (!A) && (!B), but I admit I am splitting hairs here ;)

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
