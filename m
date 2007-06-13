From: R Kimber <rkimber@ntlworld.com>
Date: Wed, 13 Jun 2007 21:36:45 +0000
Subject: [lm-sensors] Change in reported CPU temperatures
Message-Id: <20070613223645.40f82f42.rkimber@ntlworld.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have:-

Asus M2N-E with amd64x2
Ubuntu 7.04
lm-sensors 1:2.10.1-2ubuntu2

When I upgraded to Ubuntu 7.04 I got kernel 2.6.20-15.14
This allowed me to monitor CPU temperatures with k8temp.

When running Boinc (5.4.11-5) projects on both processors, CPU
temperatures were reported as being around 53C.  Idle temperature was
around 28C.

However, on 1 June the kernel was upgraded to 2.6.20-16.28 and the
reported temperatures immediately dropped to around 38C, without any
config changes on my part, or as far as I know a Boinc-manager/client
upgrade. Idle temperature remained the same.

On 9 June the kernel was upgraded again to 2.6.20-16.29 and the
reported temperatures remained around 38C.

Is k8temp reliable? Was there a significant change to it with the
recent kernels? Which set of temperatures should I trust? If the
higher, how should I go about getting the correct report?

I have seen newsgroup comments from two other people both reporting
different levels on similar machines !

The bios is set for optimal fan performance (varying with temp). The
reported fan revs are consistent with the temperatures (i.e. lower revs
with 38C) and the machine feels, subjectively, very cool (exhaust air
feels cool to the hand, unlike previous machines I have owned).

I should be grateful for any comments on this. I would not be overly
worried with 53C at current ambient temperatures, but when the
weather gets really hot I suspect it might rise quite a lot.

Naturally, I'd be very happy with 38C.

- Richard
-- 
Richard Kimber
http://www.psr.keele.ac.uk/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
