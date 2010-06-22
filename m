From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 Jun 2010 20:10:38 +0000
Subject: Re: [lm-sensors] sensors.conf for DFI LP MI P55-T36 (it8720-*)
Message-Id: <20100622221038.52877466@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
In-Reply-To: <20100606154919.4066.qmail@mailserver01.ottosenfx.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lars,

On 6 Jun 2010 15:49:19 -0000, Lars Kr.Lundin wrote:
> I have created a sensors.conf for my
> DFI LP MI P55-T36 board at
> http://www.eso.org/~llundin/sff/sensors.conf
> 
>  - please feel free to
> 
> 1) include into the lm-sensors project anything
>    from this file that is deemed useful.
> 
> 2) post corrections and improvements to the configuration.

Could you please provide a dump of the configuration register space of
your chip? I'd like to check something:

# isaset -y -k 0x87,0x01,0x55,0x55 0x2e 0x2f 7

(If it doesn't work, try with 0x4e 0x4f instead of 0x2e 0x2f.)

Together with the output of "sensors", and the revision of your chip
(printed in the kernel logs when you load the it87 driver).

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
