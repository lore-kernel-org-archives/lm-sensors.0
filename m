From: mbm@livewiredev.com (MBM Support)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Super-I/O chips
Message-Id: <FJEPJHGHDGKMMPFFGCLOIEIMEOAA.mbm@livewiredev.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040403134242.2c50813d.khali@linux-fr.org>
In-Reply-To: <20040403134242.2c50813d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I only remember one asus board that had something there (one of their OEM
boards), and it had nothing on the 2E (returned FF)

I just did 4E because it was listed in the sheets, does not harm really

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
Sent: zaterdag 3 april 2004 13:43
To: Alex
Cc: sensors@stimpy.netroedge.com
Subject: Super-I/O chips



Hi Alex,

I noticed that MBM does search for Super-I/O (LPC) chips at addresses
$2E and $4E. For the moment we only search at $2E. $4E looks like an
alternate address, I'd say it would be used only if there were two
Super-I/O chips on a given system.

I'm considering adding $4E to our detection script. Could you tell me
whether you already found anything at this address?
And was there a Super I/O chip at $2E too in this case?
Maybe I will scan $4E if and only we already found something at $2E.

Thanks.

--
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
