From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Jun 2005 20:04:13 +0000
Subject: [lm-sensors] EPIA sensors (vt1211)
Message-Id: <20050628200325.40d2b474.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050628033338.90656.qmail@web31206.mail.mud.yahoo.com>
In-Reply-To: <20050628033338.90656.qmail@web31206.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

> see http://www2.lm-sensors.nu/~lm78/supported.html

3 months ago or so, I asked you if you could take a look at Lars Erkan's
port of the vt1211 driver to Linux 2.6. I think I remember that you do
own such a chip yourself, and are somewhat familiar with it, while I
neither have a chip nor have knowledge about it. You did a first review
of the driver, Lars provided a revised version of the driver, and since
then nothing happened.

So, instead of redirecting Kino to a page he most certainly already
read, I'd appreciate if you could review Lars' revised driver [1], give
it a test, and if everything's alright, give your approval for inclusion
into the 2.6 kernel tree. The vt1211 port has been around for over a
year now, it's about time it gets into the officiel 2.6 tree.

Note that, due to the current changes in the 2.6 kernel tree, the driver
will need some changes (sysfs callback functions, and location in the
tree and hwmon class, at least).

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2005-March/011136.html

Thanks,
-- 
Jean Delvare
