From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: #1353 still error!!
Message-Id: <20030801090435.26e9b23c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F28DE38.70801@chello.hu>
In-Reply-To: <3F28DE38.70801@chello.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thanks, very nice, it works at last! No errors at the dmi_scan
> module now. Then I've run make install so it's completed now,
> thank you!

Well, it could hardly generate any error since it isn't compiling it
anymore. Still I wonder why it would failed.

> I've tried sensors-detect but it can't recognize my stupid Asus
> TUSL2-C mainboard's sensors. Sorry, but I really don't understand this
> thing... Can you please help me in this?

I don't understand either. It sees no sensor chips because the bus
driver failed to load (although it was correctly detected). Any message
in the logs?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
