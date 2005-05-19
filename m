From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: Question about sensors
Message-Id: <20031020204735.48eda932.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I still have a very old mainboard in use for a server (Asus 
> P55T2T4S, Intel chipset 430HX according to ASUS. Do you 
> have any tips, which modules I should use, because sendors-
> detect does not detect any sensors.

I guess you actually mean T2P4. I don't think there is hardware
monitoring on this model. I have a similar one (P55T2P4) sleeping in a
box somewhere, if I ever setup a system on it I'll give it a try - but
frankly, hardware monitoring became widely available starting with the
430TX chipset, so I don't expect sensors-detect to find anything on it.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
