From: Alistair John Strachan <alistair@devzero.co.uk>
Date: Wed, 08 Oct 2008 17:05:58 +0000
Subject: [lm-sensors] [PATCH 0/2] abituguru3: Abit AT8 32X: one bugfix and
Message-Id: <1223485560-3806-1-git-send-email-alistair@devzero.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Some trivial one-liners. The first fixes a bug in conjunction with
the Abit AT8 32X that prevented the sixth fan from being exported
to userspace. The second patch skips a recently discredited manual
probe routine by using DMI, again on the Abit AT8 32X.

The patches are probably suitable for 2.6.27 (they're trivial and
have been tested by a user with the hardware); failing that, they
could also be -stable candidates, I'm not sure. Please advise.

For the moment they're certainly good for 2.6.28. Please apply.

--
Cheers,
Alistair.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
