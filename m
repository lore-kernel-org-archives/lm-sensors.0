From: r.marek@assembler.cz (Rudolf Marek)
Date: Tue, 17 Oct 2006 21:39:17 +0000
Subject: [lm-sensors] lm_sensors trigger pc buzzer beeping continuously
Message-Id: <45354D85.70808@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
In-Reply-To: <5251aaf50609051620r683eb75fm95d738c444ff86da@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Prakash J K wrote:
> Hi,
> thanks for ur interest.i tried unloading it87 module and again it beeps 
> for the current session.BIOS is up2date.
>                                 regards,

Ok and now please try following:

1) remove/delete/move the it87.ko
2) powerdown the system, unplug from power
3) boot linux

Does it make the beeps too? Or only when you load or later unload the driver?

Thanks,
Rudolf

