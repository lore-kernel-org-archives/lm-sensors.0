From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 May 2009 07:23:12 +0000
Subject: Re: [lm-sensors] Support for  nuvoton(Winbond) W83627DHG-P ?
Message-Id: <20090518092312.369c1dff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1242369988.21111.53.camel@localhost.localdomain>
In-Reply-To: <1242369988.21111.53.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Madhu,

On Fri, 15 May 2009 12:51:56 +0530, Madhu wrote:
>    I have nuvoton(Winbond) W83627DHG-P Super I/O controller chip on the
> Intel DG41TY motherboard. 
> 
>    I see the kernel supports W83627DHG but not the W83627DHG-P and
> sensor-detect fails. I am using the latest 2.6.30-rc2 on F11.
> 
>    Is there any plans to support this chip? 

I am not aware of a significantly different "P" variant of the
W83627DHG. Please try the latest version of the sensors-detect script:

http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

and report the full output.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
