From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 03 Nov 2009 20:01:44 +0000
Subject: [lm-sensors] [PATCH v3 0/8] sensord: Cleanup of the sensors deamon
Message-Id: <20091103200144.GB4724@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Jean,

Another week another patch series :)

There are two new patches. To make you happy I split up the change of
the function pointer signature into a separate patch (5/8). Patch 7/8
fixes the unhandled return value of idChip (see your comment in Patch
v2 5/8). I've ignored the strcat() issue for now (also from v2 5/8). I
hope I don't have missed one of the minor issues. The changes are
explained in the patches too.

BTW thanks for your effort to review my patches.

Regards,
Andre

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
