From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: new stuff
Message-Id: <FJEPJHGHDGKMMPFFGCLOCEAJEMAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1073644715.3ffe84ab5d687@imp.gcu.info>
In-Reply-To: <1073644715.3ffe84ab5d687@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean

so far I have no real idea who/what/where of the Uguru, could be a new PCI
device for all I know, I do not think its smbus based as it would show up on
the scans.  They also keep mentioning things like h/w monitoring without
systemload (http://www.abit-usa.com/technology/uguru.php) which to me rules
out the smbus :)

so either PCI or ISA/superIO based I would think.

As for what I had in mind, no clue to be honest, I had a little hope you may
have a better contact at Abit then I have had.

--

correct it's a W83627THF-A on the Asus I encounted today, their bios shows:

M/B Temperature - 34    (offset 27)
CPU1 Temperature - 30   (offset 50 bank 1)
CPU2 Temperature - 30   (offset 50 bank 2)
M/B Temperature 2 - 28
M/B Temperature 3 - 22

as for what users want with it, nothing probably but if their bios has it
then why not mbm/lm_sensors ;)

I have mailed my contact as Winbond this morning after getting no reply from
my last Asus contact.  Maybe Winbond knows something.  There are no smbus
devices found by my smbus scanner, so below is the ISA scan

Setting Bank to Bank0

  $00: $01  $01: $FF  $02: $01  $03: $FF  $04: $00  $05: $00  $06: $00  $07:
$00
  $08: $01  $09: $01  $0A: $01  $0B: $01  $0C: $3C  $0D: $3C  $0E: $01  $0F:
$01
  $10: $01  $11: $FF  $12: $00  $13: $00  $14: $00  $15: $01  $16: $01  $17:
$3C
  $18: $43  $19: $00  $1A: $FF  $1B: $FF  $1C: $24  $1D: $32  $1E: $00  $1F:
$E3
  $20: $A3  $21: $C7  $22: $CF  $23: $BA  $24: $BF  $25: $40  $26: $00  $27:
$21
  $28: $FF  $29: $FF  $2A: $FF  $2B: $F0  $2C: $00  $2D: $04  $2E: $01  $2F:
$00
  $30: $60  $31: $20  $32: $00  $33: $00  $34: $02  $35: $00  $36: $00  $37:
$00
  $38: $14  $39: $20  $3A: $00  $3B: $04  $3C: $00  $3D: $00  $3E: $00  $3F:
$00
  $40: $01  $41: $00  $42: $00  $43: $FE  $44: $FF  $45: $00  $46: $00  $47:
$50
  $48: $2D  $49: $03  $4A: $01  $4B: $C4  $4C: $18  $4D: $15  $4E: $00  $4F:
$A3
  $50: $FF  $51: $FF  $52: $00  $53: $FF  $54: $FF  $55: $FF  $56: $00  $57:
$80
  $58: $90  $59: $70  $5A: $FF  $5B: $FF  $5C: $11  $5D: $01  $5E: $FF  $5F:
$05
  $60: $A1  $61: $C7  $62: $CD  $63: $BA  $64: $BF  $65: $40  $66: $00  $67:
$21
  $68: $FF  $69: $FF  $6A: $FF  $6B: $F0  $6C: $00  $6D: $04  $6E: $01  $6F:
$00
  $70: $60  $71: $20  $72: $00  $73: $00  $74: $02  $75: $00  $76: $00  $77:
$00
  $78: $14  $79: $20  $7A: $00  $7B: $04  $7C: $00  $7D: $00  $7E: $00  $7F:
$00
  $80: $01  $81: $FF  $82: $01  $83: $FF  $84: $00  $85: $00  $86: $00  $87:
$00
  $88: $01  $89: $01  $8A: $01  $8B: $01  $8C: $3C  $8D: $3C  $8E: $01  $8F:
$01
  $90: $01  $91: $FF  $92: $00  $93: $00  $94: $00  $95: $01  $96: $01  $97:
$3C
  $98: $43  $99: $00  $9A: $FF  $9B: $FF  $9C: $24  $9D: $32  $9E: $00  $9F:
$E3
  $A0: $A1  $A1: $C7  $A2: $CD  $A3: $BA  $A4: $BF  $A5: $40  $A6: $00  $A7:
$21
  $A8: $FF  $A9: $FF  $AA: $FF  $AB: $F0  $AC: $00  $AD: $04  $AE: $01  $AF:
$00
  $B0: $60  $B1: $20  $B2: $00  $B3: $00  $B4: $02  $B5: $00  $B6: $00  $B7:
$00
  $B8: $14  $B9: $20  $BA: $00  $BB: $04  $BC: $00  $BD: $00  $BE: $00  $BF:
$00
  $C0: $01  $C1: $00  $C2: $00  $C3: $FE  $C4: $FF  $C5: $00  $C6: $00  $C7:
$50
  $C8: $2D  $C9: $03  $CA: $01  $CB: $C4  $CC: $18  $CD: $15  $CE: $00  $CF:
$A3
  $D0: $FF  $D1: $FF  $D2: $00  $D3: $FF  $D4: $FF  $D5: $FF  $D6: $00  $D7:
$80
  $D8: $90  $D9: $70  $DA: $FF  $DB: $FF  $DC: $11  $DD: $01  $DE: $FF  $DF:
$05
  $E0: $A1  $E1: $C7  $E2: $CD  $E3: $BA  $E4: $BF  $E5: $40  $E6: $00  $E7:
$21
  $E8: $FF  $E9: $FF  $EA: $FF  $EB: $F0  $EC: $00  $ED: $04  $EE: $01  $EF:
$00
  $F0: $60  $F1: $20  $F2: $00  $F3: $00  $F4: $02  $F5: $00  $F6: $00  $F7:
$00
  $F8: $14  $F9: $20  $FA: $00  $FB: $04  $FC: $00  $FD: $00  $FE: $00  $FF:
$00

Setting Bank to Bank1

  $50: $1D  $51: $80  $52: $00  $53: $4B  $54: $00  $55: $50  $56: $00  $57:
$FF
  $58: $FF  $59: $FF  $5A: $FF  $5B: $FF  $5C: $FF  $5D: $FF  $5E: $FF  $5F:
$FF

Setting Bank to Bank2

  $50: $1E  $51: $00  $52: $00  $53: $4B  $54: $00  $55: $50  $56: $00  $57:
$FF
  $58: $FF  $59: $FF  $5A: $FF  $5B: $FF  $5C: $FF  $5D: $FF  $5E: $FF  $5F:
$FF

Setting Bank to Bank3

  $50: $FF  $51: $FF  $52: $FF  $53: $FF  $54: $FF  $55: $FF  $56: $FF  $57:
$FF
  $58: $FF  $59: $FF  $5A: $FF  $5B: $FF  $5C: $FF  $5D: $FF  $5E: $FF  $5F:
$FF

Setting Bank to Bank4

  $50: $03  $51: $13  $52: $00  $53: $00  $54: $00  $55: $00  $56: $00  $57:
$00
  $58: $1A  $59: $DE  $5A: $09  $5B: $03  $5C: $11  $5D: $00  $5E: $FF  $5F:
$FF

Setting Bank to Bank5

  $50: $BD  $51: $C3  $52: $00  $53: $00  $54: $40  $55: $00  $56: $00  $57:
$00
  $58: $00  $59: $00  $5A: $00  $5B: $00  $5C: $00  $5D: $00  $5E: $00  $5F:
$00


Regards, Alex

- Please always attach all previous mails !
----------------------------------------------------------------------
The Motherboard Monitor:
http://mbm.livewiredev.com/
----------------------------------------------------------------------
For long you live and high you fly,
And smiles you'll give and tears you'll cry,
And all you touch and all you see,
Is all your life will ever be.
----------------------------------------------------------------------



-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org]
Sent: vrijdag 9 januari 2004 11:39
To: MBM Support
Cc: Sensors ML
Subject: Re: new stuff



Hi Alex,

> 1) you need any info on the ALi M1563 southbridge ?

We had no request so far, but we'll keep your implicit proposal in mind
as the time comes :)

> 2) have you heard about the Uguru on the new Abit boards, they are
> replacing the normal senor chip with this, I have run into a brick
> wall at Abit
> though, forum posting is here:
> http://www.livewiredev.com/bbs/showthread.php?s=&threadidT53
>
> maybe we can combine forces on this one ? as I think will become a
> problem :)

I read the thread. Sure we can combine our forces. What do you propose?

Is it an SMBus-compatible chipset without specs (ala AS199127F) or
something completely different from other known chips. If it's too
different, it's unlikely that the LM Sensors project will support it,
but having a data sheet to write an "external" driver would be
appreciated though.

> 3) Asus is releasing boards like the ASUS PC-DL which show 5 temp
> sensors in the bios, however all my scans only show a normal winbond
> with the 3 sensors, you ran into this yet ?

We have had one report:
http://archives.andrew.net.au/lm-sensors/msg05327.html

From that post, looks like the monitoring chipset was detected as one
supported by our w83627hf driver, i.e. W83627HF, W83627THF or W83697HF.
W83697HF is unlikely since it would show 2 temperatures and you say
you see 3. So it must be a W83627HF or W83627THF.

That said, we know that ASUS are good at stealing chip designs from
Winbond and including modified versions on their boards. For example,
the ASB100 had a fourth temperature channel. Maybe that's something
similar here.

Or maybe the other temperature measurements come from somewhere else,
maybe ACPI? Or another I2C bus on the Video board for example (I wonder
how the BIOS could grab information from it, but who knows... if the
mobo has an integrated video chip, that would make sense)

BTW I wonder what the user will do with 5 temperatures... What are the
extra readings for?

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

