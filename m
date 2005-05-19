From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: eeprom driver
Message-Id: <3C6E8C94.163D84E7@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I made the naming change you suggested in eeprom.c
and fixed decode-dimms and decode-xeon,
unfortunately I don't have a Perl book at home
so I need your help to fix decode-vaio, if you
would please send me a patch that would be great.
thanks
mds

Jean Delvare wrote:
> 
> > I think all three we could use if you would like to submit patches.
> I will.
> 
> > On 1), what I kept meaning to do but never did, can you rename the
> > /proc names from "0-15", for example, to "00" or "00-0F" or "0x00-0x0F"
> > or something similar, so that when you "cat *" at least the results
> > come out in the right alphabetical order?
> > That's bitten me more than once...
> I agree.  It makes things much more complicated for everyone, even if
> "ls -v" can help for this particular point.
> 
> Anyway, I won't modify that unless anyone agrees.  I'm rather new to this
> project and this ain't a decision I can make alone.  If I am the one who
> decides, I would even remove the heading "data" and remove the end
> address, since it can be deduced from the start address.  I would have
> something like that :
> 
> eeprom-i2c-0-50/00
> eeprom-i2c-0-50/10
> eeprom-i2c-0-50/20
> eeprom-i2c-0-50/30
> eeprom-i2c-0-50/40
> eeprom-i2c-0-50/50
> eeprom-i2c-0-50/60
> eeprom-i2c-0-50/70
> 
> Now, I don't know everything about the needs of everyone, so I'd like to
> know what people think about it.  What's sure is that it would require to
> rewite some utils, such as the dimms decoder.
> 
> So, please, everyone let me know if it is a good idea or not.
> 
> (Anyway, it does *note* need to be changed right now.  I can submit my
> patches and wait some time that we all agree if a change in the file names
> is a good thing or not.)
> 
> --
>        /~~       Jean "Khali" Delvare
>   -----\_                        mail: delvare@ensicaen.ismra.fr
>  --------\                http://www.ensicaen.ismra.fr/~delvare/
> ---=ISMRA/- ____________________________________________________
