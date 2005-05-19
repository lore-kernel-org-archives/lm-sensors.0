From: Frenchstylistics@gmx.li (Frenchstylistics@gmx.li)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: AW: ---=== Lm_sensors Support DB Entry Ticket # 1179 ===---
Message-Id: <000101c2f1e1$22fc9770$0201a8c0@franzose>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

>Ticket # 1179

>you need to answer YES to scan the PIIX4 bus.

I tried to do so but as mentioned in the ticket, the system hangs when
scanning the PIIX4 bus.

>So I can?t see where your 83781 is.
>If it is at 0x29 (the only address you aren?t ignoring),
>then it should be working.

This is the problem, but when I try to change the ignore range, the
system hangs too.

I did all modprobes as told in ticket #721.

>old libraryies may be the problem, make sure you don?t have
>old libsensor libraries in /usr/lib.

Improbable, because I installed it on a "virgin" SuSE system.

Regards....


