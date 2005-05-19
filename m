From: jkl@sarvega.com (John Lash)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: re ticket 721
Message-Id: <20020410065900.67939350.jkl@sarvega.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3BEBE198.3050607@sarvega.com>
In-Reply-To: <3BEBE198.3050607@sarvega.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I should have sent this a while back but forgot.

Our vendor had a fellow spend a couple of days looking at the problem. Here's what we are using.

        modprobe w83781d init=0 ignore_range=0,0x00,0x28,0,0x2a,0x7f
        modprobe i2c-piix4

he gave a pretty good walk thru of how he debugged it. It's in my mailbox at home and I'm having some network problems at the momemt. If you are interested I'll send it along later to add to this ticket.

--john


-- 
John Lash	jkl@sarvega.com	630-734-5925

Sarvega Inc.
745 McClintock, Suite 230
Burr Ridge, IL 60527
