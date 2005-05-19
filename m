From: ed.tman@verizon.net (Ed Harrison)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: Info on ASB100(Bach) as as99127f on ASUS A7V333
Message-Id: <20030227132823.BJBR4892.out006.verizon.net@[67.243.22.126]>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Below is an answer query to Alex at "MBM Support" <mbm@livewiredev.com> about the ASB100 (Bach) chip on my A7V333.

Mine fell into the category under ASB100 at $4F : $06.  I hope you guys get this working as I have too little coding expertise to do it myself.


Subject: RE: ASUS asb100(bach) as as99127f

hope this is what you need.... Asus now also has the Mozart2 out :)

hi Ed

AS99127F
location: SMBUS only, $2C or $2D
ID: $58 : $31
Sub ID:  $4F : $12 or $4F : $C3 = type 1  [negative voltages like winbond
1D]
Sub ID:  $4F : $5C or $4F : $A3 = type 2  [negative voltages like winbond
2D]

Temp sensor 1: $27 on AS99127F
Temp sensor 2: $00 on LM75-2 clone
Temp sensor 3: $00 on LM75-1 clone

Voltage: like winbond 1D
Fans: like winbond 1D


ASB100
location: SMBUS only, $2C or $2D
ID: $58 : $31
Sub ID:  $4F : $94 or $4F : $06

Temp sensor 1: $27 on ASB100
Temp sensor 2: $00 on LM75-2 clone
Temp sensor 3: $00 on LM75-1 clone
Temp sensor 4: $17 on ASB100 [AMD diode only it seems]

Voltage: like winbond 1D [-5 and -12 probably not supported]
Fans: like winbond 1D


Ed Harrison, broadcasting on:
        L I N U X
by SuSE (8.1), Kernel 2.4.20,
X-server 4.2, PolarBarMailer 1.25rc8
