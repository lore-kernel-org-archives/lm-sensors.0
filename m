From: Ramesh Agarwal <notagarwal@gmail.com>
Date: Thu, 06 Aug 2009 08:36:17 +0000
Subject: [lm-sensors] Looking for reviewers
Message-Id: <c632a690908060124q355f086erfc71c689d49d819e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have written the driver for an analog accelerometer device on
Intel's upcoming Moorestown platform. It is a platform specific driver
and has a dependency on another driver for Langwell which though
submitted to kernel is not part of the distribution yet. I am new to
this list but from what I understand of the process, I have to wait
for the Langwell driver to get merged before I can submit a patch with
my driver.

However what I wanted to do was to see if I could get any early review
comments so that I don't have to make any drastic changes finally when
I submit for inclusion. The driver is fairly simple and small (about
300 lines), so was wondering if someone on this list could review the
code for me. I have done all the basic sanity checks like
functionality, no warning, coding style check and the like.

Would really appreciate help on this.

Ramesh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
