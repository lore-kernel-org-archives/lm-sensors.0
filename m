From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Tue, 07 Mar 2006 20:02:17 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <440DE6C9.90404@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

> Can I have a -p1 patch please?

Yep ;)

All fixed, here we go...

This patch adds the voltage measuring support to W83627EHF. The code is based
on the patch provided by Yuan Mu from Winbond.

Signed-off-by: Yuan Mu <Ymu at Winbond.com.tw>
Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

Regards
Rudolf
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: 01-w83627ehf-add_volt.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060307/7689c642/01-w83627ehf-add_volt.pl
