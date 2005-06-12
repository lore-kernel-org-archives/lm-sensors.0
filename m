From: atomic.devterium@gmail.com (devterium)
Date: Sun, 12 Jun 2005 11:53:38 +0000
Subject: [lm-sensors] Sensor readings
Message-Id: <op.sr84fcepcb5z0o@linux.site>
List-Id: <lm-sensors.vger.kernel.org>
References: <op.sr7hnt2fcb5z0o@linux.site>
In-Reply-To: <op.sr7hnt2fcb5z0o@linux.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

My motherboard: Gigabyte k8nsPro (nforce3)
uname -a says: Linux linux 2.6.11.4-20a-default #1 Wed Mar 23 21:52:37 UTC  
2005 i686 athlon i386 GNU/Linux
lm_sensors verison: cvs 6/10/2005

...mmm, I think it works now. I don't know what was wrong. Well, move on:
My next question:
Is there a way the sensors(prog) would write the reading into a file e.g.
/proc/acpi/thermal_zone/info
every x seconds, so I would be able to read the temperature via  
Ktemperature program?

On Sat, 11 Jun 2005 16:34:21 +0200, Rudolf Marek <r.marek@sh.cvut.cz>  
wrote:

> Hi please tell us:
>
> Motherboard type/manufacturer
> kernel version uname -a
> lm_sensors version
>
> Output of sensors-detect script.
>
> If any trouble obtaining the data, I will help.
>
> Regards
> Rudolf



-- 
Using Opera's revolutionary e-mail client: http://www.opera.com/mail/
