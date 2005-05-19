From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: eeprom driver
Message-Id: <3C605888.17FB3A1C@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020201105452.C1871@Stimpy.netroedge.com>
In-Reply-To: <20020201105452.C1871@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think all three we could use if you would like to submit patches.

On 1), what I kept meaning to do but never did, can you rename the
/proc names from "0-15", for example, to "00" or "00-0F" or "0x00-0x0F"
or something similar, so that when you "cat *" at least the results
come out in the right alphabetical order?
That's bitten me more than once...

Jean Delvare wrote:
> 
> > The 0x57 eeprom is clearly set up for some non-volatile storage on the
> > motherboard. I see a lot of ASCII numbers and letters; At row E0, for
> > example, is "11/15/01 13:26:37"
> > This answers your second question.
> 
> Well done :)
> 
> You're perfectly right.
> 
> I modified i2cdump so that is shows a "string" version of the data, and it
> is now clear to me that 0x57 is used to "identify" the laptop.  I could
> find the model name and serial number, among other things.
> 
> I am writing a perl script right now, to show what I understood from this
> eeprom.  It's called decode-vaio.pl and could take place with phil's
> decode-dimms.pl in eeprom/, I guess.  I would like to get in touch with
> other Vaio users, to have more than just my eeprom to do the job.
> 
> So, three things I could actually add to the project :
> 
> 1* The modifications I made to the eeprom driver, so that it shows 256
> bytes instead of 128.  It is required for the Vaio eeprom.  Maybe we could
> move to a device-specific length (for exemple, still limit to 128 if we
> recognise a DIMM module.)  I don't know how accurate it can be, so we may
> need to discuss this a bit.
> 
> 2* The enhancement I made to i2cdump.
> 
> 3* The script itself.
> 
> If the script gives good results on more than just my machine, maybe we
> could consider adding the vaio eeprom decoding to sensors itself.
> 
> Work is still in progress anyway, any comments welcome.
> 
> --
>        /~~       Jean "Khali" Delvare
>   -----\_                        mail: delvare@ensicaen.ismra.fr
>  --------\                http://www.ensicaen.ismra.fr/~delvare/
> ---=ISMRA/- ____________________________________________________
