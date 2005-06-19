From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 19 Jun 2005 17:56:35 +0000
Subject: [lm-sensors] Req for sensors help w/ Asus PC-DL
Message-Id: <42B595A1.20101@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42B4EC0B.1020603@ripptech.com>
In-Reply-To: <42B4EC0B.1020603@ripptech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

We are suspecting that you have enabled in kernel ACPI PNP stuff. Please disable it pernamently or try
pnpacpi=off

as kernel parameter. (the parameter will work for 2.6.11 or 2.6.12)
If it works and you can read sensors I will advise more how to get CPU temps directly from CPU...

Regards
Rudolf
