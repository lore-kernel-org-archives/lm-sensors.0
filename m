From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Some very strange problems with lm-sensors
Message-Id: <20030611192046.4ed3464e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000501c32ffe$afb61410$1200a8c0@twit>
In-Reply-To: <000501c32ffe$afb61410$1200a8c0@twit>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I think I have tried just everything i could so thats why I decided to
> ask it here. I hope i gave enough info otherwise you can just mail me.
> 
> Is there any irc channel or something were a lot of lm-sensors users
> hang out ?

We actually met on IRC and solved the problem. Two problems where
actually found: old libsensors.so causing sensors to crash, and modules
loaded in the wrong order causing sensors to see no sensors at all.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
