From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: lm75 compute
Message-Id: <3F9C884D.93E32BDA@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

who made the default compute for lm75 temperature be divide by 2
(attributed to the Asus TX97-E)?!?!
Ticket 1423 complains.
I can't tell from the CVS log for sensors.conf.eg how it happened.
Or did this get in by mistake?
Let's not change a years-old default for the sake of one motherboard!!!
