From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 24 Mar 2011 17:07:33 +0000
Subject: Re: [lm-sensors] Supermicro H8QM3-2 Sensors
Message-Id: <20110324180733.4cfdeb83@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU162-w49C9794A5AF1DB1F22A98A93B60@phx.gbl>
In-Reply-To: <BLU162-w49C9794A5AF1DB1F22A98A93B60@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Keith,

On Thu, 24 Mar 2011 16:54:56 +0000, KEITH ROMBERG wrote:
> I have a Supermicro H8QM3-2 motherboard running Opteron 8356 CPUs.   It is running Fedora 14 x86_64 using lm_sensors 3.2.0.  For thermal CPU monitoring the board uses Winbond 83627HG thermal diodes.  When I run sensor-detect they are picked up and put into the config.  When I run sensors, the values for them are way low.  They report 8C, 3C, 5C, and 9C when all four CPUs are under full load.  I know that can not be accurate or even in the ballpark.  Are these sensors fully support?  If so, what information would you need to help figure out why they are reporting so low.

Please provide the full output of sensors-detect. Supermicro engineers
often add dedicated hardware monitoring devices on their boards instead
of using the sensors integrated in the Super-I/O. The original H8QM3
had a Winbond W83793G used for that purpose, maybe the revision 2 has
this chip too, or its successor (Nuvoton W83795G/ADG). These would be
respectively supported by the w83793 and w83795 drivers.

HTH,
-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
