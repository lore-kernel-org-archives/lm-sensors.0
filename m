From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 19 Oct 2009 07:14:08 +0000
Subject: Re: [lm-sensors] Sensors-dectect ,
Message-Id: <20091019091408.77040ccc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
In-Reply-To: <alpine.DEB.2.00.0910160554380.2841@p34.internal.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lars,

On Fri, 16 Oct 2009 20:35:07 +0200, Lars Lindquist wrote:
> output from sensors-detect
> # sensors-detect revision 5729 (2009-06-02 15:51:29 +0200)
> # System: System manufacturer System Product Name
> # Board: ASUSTeK Computer INC. P7P55D
> 
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
> (...)
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):  
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0xb353
>     (logical device B has address 0x290, could be sensors)

I've added detection of some new chips, please try the latest version
of sensors-detect:

http://dl.lm-sensors.org/lm-sensors/files/sensors-detect

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
