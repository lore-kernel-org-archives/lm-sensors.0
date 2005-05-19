From: joker_pl@2com.pl (=?windows-1250?Q?Micha=B3_Laskowski?=)
Date: Thu, 19 May 2005 06:23:47 +0000
Subject: SMBus on WinNT READING problem. Can u help me?
Message-Id: <14965115330.20030203174701@2com.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <57041875.20030203013908@wszib.edu.pl>
In-Reply-To: <57041875.20030203013908@wszib.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi !

  My name is Michal Laskowski and im from poland. Firs i want to say
  sorry for my english, and for that email if u will get angry :).
  I just want to ask u for a little bit help.
  I use Win XP and DriverLinx Kernel Driver for Port I/O operations.
  And i want to make some soft but i have a problem with getting a
  information from SMBus. So  :
  I Have ABit ST6, with Intel 815EP (ICH2) 82801BA, and a WinBond
  W83627HF. I did a function for scaning a pci and my SMB adress is
  0x5000 (Dev 0x1f, Fun 0x03) and here i have a problem for getting
  any information from SMB.
  I know that if SMB is bussy in his Base address (port) 1st bit will
  be set for 1. so i can wait for the moment when smb will be free

  After i wait i write to base_address +5 and to base_address +6 (this
  will be my Index and Data registers) a "paramets" for function what
  i want to call. for eg. i write 80h.
  
  Now to base_address +3 i write a command (for eg. 4Eh - Bank Select Register)

  to base_address + 2 (Host Control Register) i write 48h for Byte
  Data protocol and for generaiting an interaption afte completion of
  the command.

  im waiting for SMB

  now i read a data from base_address +6 and base_address +5

  now i can read a vendor id high byte

  so i do that
  base_address + 5 = 0
  base_address + 6 = 0
  base_address + 3 = 4Fh
  base_address + 2 = 48h
  wait for SMB
  and read base_address + 6 and base_address + 5

  and that ports are empty no data are there
  what i am making wrong maby i did something wrong but i dont know
  what.

  If u can help me it would be very nice.
  Thanks a LOT

  PLEASE SEND REPLY
-- 
Michal Laskowski
                         mailto:joker_pl@2com.pl


Serwis www.logo.hoga.pl - sci?gaj bajery na telefony
Nokia, Siemens, Alcatel, Ericsson, Motorola,Samsung
------------------------------------------------------------
mks_vir 2002 zosta? nominowany do plebiscytu magazynu CHIP PRODUKT
ROKU 2002. Kupon do g?osowania znajduje si? w magazynie CHIP 12/2002.
