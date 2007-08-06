From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 06 Aug 2007 09:15:36 +0000
Subject: Re: [lm-sensors] modprobe f71882fg trouble
Message-Id: <46B6E6B8.2000905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46B6E1BB.5090609@akontech.ru>
In-Reply-To: <46B6E1BB.5090609@akontech.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Boris Losev wrote:
> Hello!
> 
> I've tried to install lm-sensors for fan monitoring. sensor-detect from 
> 2.10.4 detected me `Fintek F71882FG/F71883FG Super IO Sensors' and 
> writed "modprobe f71882fg". I've tried to modprobe f71882fg, but it was 
> unsuccessuful:
> 
> root@luck:~/soft/lm_sensors-2.10.4# modprobe f71882fg
> FATAL: Module f71882fg not found.
> 
> Where should I get module for f71882fg ?
> 

It hasn't made it into the kernel yet, a patch for it is here:
http://lists.lm-sensors.org/pipermail/lm-sensors/2007-July/020441.html

Talking about this Mark, any chance this could get merged anytime soon? It was 
reviewed by Darrick J. Wong.

Darrick can you verify that this second version fixes the things you spotted 
during review, and then ack it please?

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
