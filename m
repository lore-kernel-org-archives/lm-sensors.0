From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <20030731164232.16a36ffa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> So I done: 
> Grep sensors -ir * /etc/rc2.d/

Bad command. You want to do:

grep sensors -ir /etc/rc2.d/*

(BTW I'm surprised you are in runlevel 2, it's unusual.)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
