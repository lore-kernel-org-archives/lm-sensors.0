From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 23 Jun 2010 20:31:39 +0000
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100623223139.397454d7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
In-Reply-To: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 23 Jun 2010 19:37:59 -0000, Lars Kr.Lundin wrote:
> On Tue, Jun 22, 2010 at 10:10:38PM +0200, Jean Delvare wrote:
> > Hi Lars,
> >
> >
> > Could you please provide a dump of the configuration register space of
> > your chip? I'd like to check something:
> 
> Hi Jean,
> 
> Thanks for your interest in this board.
> 
> >
> > # isaset -y -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7
> >
> 
> The -k option is not supported by /usr/sbin/isaset under Ubuntu 10.04:
> 
> $ sudo isaset
> Syntax for I2C-like access:
>   isaset [-y] ADDRREG DATAREG ADDRESS VALUE [MASK]
> Syntax for flat address space:
>   isaset [-y] -f ADDRESS VALUE [MASK]

My mistake, the -k is correct, what's not is the command name. Please
try instead:

# isadump -y -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
