From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Fix in eeprom.c
Message-Id: <20040417192211.601cb41e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040329193435.7d9a587d.khali@linux-fr.org>
In-Reply-To: <20040329193435.7d9a587d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ralf,

> I have applied your eeprom.c patch and tested.
> Your fix is quite similar to mine and works fine for me.

A different fix was prefered, causing less changes in the drivers (so
less error-prone). I just commited the change to our CVS repository. I
would appreciate it if you could check it out and test.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
