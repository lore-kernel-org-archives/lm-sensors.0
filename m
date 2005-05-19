From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:24 +0000
Subject: ASB100 PWM
Message-Id: <FJEPJHGHDGKMMPFFGCLOCEMCEKAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031111062929.GA30118@earth.solarsys.private>
In-Reply-To: <20031111062929.GA30118@earth.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

this is my detection routine for it:

for Z:=$29 to $2F do
begin
  SMBChipAddress:=Z;
  UsedBus:=btSMBus;
  IOByte($4E,$00,IOWrite);
  X:=IOByte($58,$0,IORead);

  if X=$31 then
  begin
    if (IOByte($4F,$0,IORead)=$94) or (IOByte($4F,$0,IORead)=$06) then
    begin
      ChipType:=ASB100;
      // etc etc
    end
    else
    begin
      ChipType:=AS99127F;
      // etc etc
    end;
  end;
  if (X=$56) or (X=$10) then
  begin
    if ((IOByte($4E,$0,IORead)=$94) and (IOByte($4F,$0,IORead)=$06))
    or ((IOByte($4E,$0,IORead)=$94) and (IOByte($4F,$0,IORead)=$36))
    or ((IOByte($4E,$0,IORead)=$5C) and (IOByte($4F,$0,IORead)=$A3))then

    //Asus ASM58 Mozart-2            $58=$56 $4E=$94 $4F=$36
    //Asus AS2K129R Mozart-2         $58=$56 $4E=$94 $4F=$06
    //Asus XXXXXXXX Mozart-2         $58=$10 $4E=$5C $4F=$A3
    begin
      ChipType:=MOZART2;
      // etc etc
    end;
  end;

question for you, heard/know of the VIA VT6307 ?

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
Sent: woensdag 12 november 2003 22:58
To: MBM Support
Cc: sensors@Stimpy.netroedge.com; vitalyb@mail333.com
Subject: Re: ASB100 PWM




> as far as I know there are 2 bach's but I have never worked much with
> the fans, only how to read them, so not only late answer but also a
> crappy one... sorry

Maybe you can at least tell us how one can tell the difference between
the two revisions? Some register we can read the information in?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
