From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <20020204101241.L1871@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think all the related eeprom decode stuff (SPD, Xeon, etc.) was from
Intel's web site.  Thankfully, Intel does a reasonable job documenting
things and providing them to the development community.


Phil

On Mon, Feb 04, 2002 at 07:00:57PM +0100, Jean Delvare wrote:
> 
> > BTW- Have you tried running eeprom-decode.pl?  It's in
> > lm-sensors/prog/eeprom, I think.  It can help decode the values of
> > your valid SPD DIMM (timing and such).  There is also a checksum value
> > which it computes and compared with what is stored on the chip.  If
> > the checksum isn't valid, then it is almost certainly evidence that
> > the chip isn't on a DIMM (or is corrupted).
> 
> I guess you refer to decode-dimms.pl.  Yes, I tried it.  It gives correct
> results for 0x50 and awful garbage for 0x57.
> 
> I also just tried xeon/decode-xeon.pl.  No resulult either.
> 
> If byte at 0x02 has a class meaning (0x04 for DIMMs, you said), is there a
> reference about this? It would help to know what kind of item 0x00 is
> supposed to be.
> 
> 
> -- 
>        /~~       Jean "Khali" Delvare
>   -----\_                        mail: delvare@ensicaen.ismra.fr
>  --------\                http://www.ensicaen.ismra.fr/~delvare/
> ---=ISMRA/- ____________________________________________________

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
