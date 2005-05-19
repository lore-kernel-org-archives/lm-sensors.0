From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: as99127f pwm register
Message-Id: <FJEPJHGHDGKMMPFFGCLOCEAEEIAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030724225359.2546fa71.khali@linux-fr.org>
In-Reply-To: <20030724225359.2546fa71.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean

correct on the winbond 1D, 10 and 11, but that is the only one, anyways your
detection could be simpler I guess

check the 2 ID's that make the AS99127 the same as the winbond and then
simply do a check on $58, if it's 31 then it's AS99127 else it's not.

The mozart should be easy to add :)

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
Sent: vrijdag 25 juli 2003 12:06
To: sensors@Stimpy.netroedge.com
Cc: mbm@livewiredev.com
Subject: Re: as99127f pwm register



> Oh sorry, I forgot to mention one thing. In our detection script, we
> ignore the LSB of register $58. Thus the AS99127F rev2 ID ($31) and
> the W83782D ($30) look the same, that's why I got confused. I don't
> know why we ignore this bit, I couldn't read anything about that in
> the datasheets. I will take a look at our CVS logs tommorow and see
> what made us add this in the past.

I finally found it (after almost one hour of searching through the CVS).
We once saw W83781D's with ID $11 while the datasheet says ID is $10.
This is the reason why we decided to ignore the LSB for all chips.
Actually, for most chips it can't hurt, but for the W83782D vs. AS99127F
rev.2 detection, it matters (and I'll change that).

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
