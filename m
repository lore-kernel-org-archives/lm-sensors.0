From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: W83L785TS-S
Message-Id: <FJEPJHGHDGKMMPFFGCLOAEHEEIAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030809120646.541e35a3.khali@linux-fr.org>
In-Reply-To: <20030809120646.541e35a3.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jean

I rechecked my code cos you got my confused :)

4C:A3, 4D:5C, 4E:50 or 4E:51 = W83L784R
4C:A3, 4D:5C, 4E:60 = W83L785R
4C:A3, 4D:5C, 4E:70 = W83L785TR
4C:A3, 4D:5C, 4E:70 = W83L785TS

the TR and the TS have the same ID's, same goes for the W83791D & W83791SD,
same ID's


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
Sent: zaterdag 9 augustus 2003 14:32
To: mbm@livewiredev.com
Cc: sensors@Stimpy.netroedge.com
Subject: Re: W83L785TS-S



> I don't have a datasheet for the W83L785TR. I could find one for the
> W83L785R, and fortunately it has a different ID (50h instead of 70h).

I correct that, there's an error in the datasheet: the ID id 60h (50h is
for the W83L784R).

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83l784r.pdf
Type: application/pdf
Size: 1530242 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030809/1a6edeb6/w83l784r.pdf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: W83L785R.PDF
Type: application/pdf
Size: 321733 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030809/1a6edeb6/W83L785R.pdf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: W83L785TR datasheet 0.5.pdf
Type: application/pdf
Size: 1124099 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030809/1a6edeb6/W83L785TRdatasheet0.5.pdf
-------------- next part --------------
A non-text attachment was scrubbed...
Name: W83L785TS-S_datasheet 0.5.pdf
Type: application/pdf
Size: 340923 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030809/1a6edeb6/W83L785TS-S_datasheet0.5.pdf
