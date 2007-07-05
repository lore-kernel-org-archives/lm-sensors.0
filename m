From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jul 2007 12:56:28 +0000
Subject: Re: [lm-sensors] Appropriate KM's loaded, still no love..
Message-Id: <20070705145628.20df4d30@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 Jun 2007 11:28:24 -0600, sun@ranger.scare.org wrote:
> I'm having a time getting lm_sensors configured. I've run
> sensors-detect and confirmed that the appropriate KM's are loaded.
> I've followed the helpful output and added config snippits to
> /etc/modules.conf, and /etc/rc.local as well as allowed
> sensors-detect to write out my /etc/sysconfig/lm_sensors config
> file. Even after this, and a reboot, I'm still getting this:
> 
> [root@00-1a-4d-20-32-ac ~]# sensors -s
> No sensors found!
> 
> So, I'm stuck and need some assistance. Hopefully someone will
> see something that I'm missing, thanks! The following is the output
> of sensors-detect as well as the info from the config files mentioned
> above.

> # sensors-detect revision 1.393 (2005/08/30 18:51:18)

This is old!

> Do you want to scan the ISA bus? (YES/no): 
> (...)
> Probing for `ITE IT8712F'
>   Trying address 0x0290... Success!
>     (confidence 8, driver `it87')

This is a misdetection. You don't have an IT8712F...

> Do you want to scan for Super I/O sensors? (YES/no): 
> (...)
> Probing for `ITE 8712F Super IO Sensors'
>   Failed! (0x8718)

... but an IT8718F.  A newer version of sensors-detect would have told
you. It is only supported since kernel 2.6.19. You didn't tell us which
kernel you were using, but I guess it is older, and this explains why
the it87 driver doesn't work for you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
