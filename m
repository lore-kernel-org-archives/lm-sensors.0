From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 12 May 2008 12:37:54 +0000
Subject: Re: [lm-sensors] Backporting coretemp and w83793 to 2.6.18
Message-Id: <20080512143754.6386a98a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46CB9161.5090408@curl.com>
In-Reply-To: <46CB9161.5090408@curl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 5 May 2008 19:05:27 +0200, Darth Tumi wrote:
> I have the same problema as you reported (the only difference is that my
> system is a x64 Cent OS 5.1, board Supermicro X7DBR-3 (Winbond W83793G),
> kernel 2.6.18-53.1.14.el5.
> 
> We need that kernel version and I'm blocked because I have absolutly no
> experience in compiling and installing drivers so can you send me those
> compiled by you or detailed instructions or references for compiling and
> installing them?

I happen to have backported the w83793 driver to kernel 2.6.18 for a
friend of mine already. You can pick it from:
http://jdelvare.pck.nerim.net/sensors/w83793/

In order to build it, you'll need the usual tools (gcc, make) and the
kernel sources matching your running kernel. Just running "make" should
build the w83793 driver, and "make modules_install" as root should
install it. Then all you have to do is "modprobe w83793".

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
