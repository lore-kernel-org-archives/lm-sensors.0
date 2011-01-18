From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Jan 2011 08:46:09 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <20110118094609.0b9b2171@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 17 Jan 2011 13:54:30 -0800, Guenter Roeck wrote:
> On Mon, 2011-01-17 at 15:26 -0500, DarkNovaNick@gmail.com wrote:
> > # sensors-detect revision 5901 (2011-01-14 17:11:54 +0100)
> > # System: Gigabyte Technology Co., Ltd. H67A-UD3H
> > (...)
> > Some Super I/O chips contain embedded sensors. We have to write to
> > standard I/O ports to probe them. This is usually safe.
> > Do you want to scan for Super I/O sensors? (YES/no): 
> > Probing for Super-I/O at 0x2e/0x2f
> > Trying family `National Semiconductor'... No
> > Trying family `SMSC'... No
> > Trying family `VIA/Winbond/Nuvoton/Fintek'... No
> > Trying family `ITE'... Yes
> > Found unknown chip with ID 0x8728
> > (logical device 4 has address 0x290, could be sensors)
> 
> The problem is more likely that the SuperIO chip used in your system is
> not supported. If so, your problem doesn't have anything to do with
> SandyBridge.

This would be an ITE8728F, ITE's latest Super-I/O chip. Nick, can you
confirm this by visual inspection? The chip should look like this:
http://img713.imageshack.us/img713/3831/it8728fsmall.jpg

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
