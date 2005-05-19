From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: bus collition
Message-Id: <FJEPJHGHDGKMMPFFGCLOEEAPEMAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Jean

no MBM does not ignore it,

1- I check if host is busy, if it is then reset it, if still then exit
2- I place the start bit
3- I wait for the transaction to start (check for bit changes), it takes to
long then exit
4- I wait for the transcation to complete, if takes to long then exit
5- I then check for transaction errors, if there are then exit

any exit is a fail.

if you can tell me which smbus mbm detect I can rip out the code I use for
that one, from the post I asume Via, I use the intel code for that one



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
Sent: zaterdag 10 januari 2004 11:27
To: MBM Support
Subject: bus collition



Hi Alex,

Could you please take a look at this thread (3 posts):
http://archives.andrew.net.au/lm-sensors/msg05852.html

The guy has bus collisions under Linux, but says MBM works fine on the
same system. Am I right assuming that you silently ignore bus collisions
and return the last known value if a collision happens?

Is there a way to know if MBM detected bus collisions? I'd like to know
if the user also has collisions with MBM, this would somewhat innocent
our Linux bus driver ;)

Thanks.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
