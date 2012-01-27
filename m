From: Florian Fainelli <ffainelli@freebox.fr>
Date: Fri, 27 Jan 2012 12:51:29 +0000
Subject: [lm-sensors] coretemp ABI breakage during pkgtemp/coretemp merger
Message-Id: <4F229DD1.9040103@freebox.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Commit 199e0de7f5df31a4fc485d4aaaf8a07718252ace: hwmon: (coretemp) Merge 
pkgtemp with coretemp introduced a breakage on our system (Intel CE4100 
Atom core HT).

pkg_flag = 0 for our particular system, because we don't have 
X86_FEATURE_PTS set (I have no idea why hardware does not report it, 
whether this is genuine or not).

This is not a big deal, but since this is a sysfs attribute, it is 
kernel ABI and therefore should not break.
--
Florian

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
