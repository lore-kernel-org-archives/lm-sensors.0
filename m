From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 28 Sep 2005 09:29:52 +0000
Subject: [lm-sensors] [PATCH] ICH6 ACPI and GPIO quirk
Message-Id: <433A464E.9030908@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050927215451.19403.qmail@desitka.sh.cvut.cz>
In-Reply-To: <20050927215451.19403.qmail@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Craig Sylla wrote:

> Pardon me - would it be advisable to apply this patch to a 2.6.5 kernel
> running on an ICH6-equipped mainboard?  I have already tweaked the i801
> driver to support the ICH6 (added PCI ID's).

Hello,

This patch is not changing any stuff. It just registers with /proc/ioports the ACPI and GPIO regions
provided by LPC bridge, so no other devices will think this IO addresses are free.
It does not tweak any HW.

To answer your question: it wont hurt if you port it to your kernel.

Regards
Rudolf
