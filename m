From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <20030913224007.1d03a650.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I'm sending you output in attachment. I have also tried it87 sensors
> but I'm getting weird values, and I have also tried various temp_type
> values but I could not find the right value to get "normal" results, I
> will try it again and every combination.
> 
> I will see if my friend, that has EPOX nForce2 motherboard, has lm90
> so that he can do some testing for you.

Took a look at the output, this doubtlessly is a LM90.

(Reading through the datasheet, through the driver code, datasheet
again, driver again.)

Hm. How can I say that...

My driver init code explicitely *stops* the chipset. No wonder you don't
see the values changing... Stupid me. That's fixed in CVS, if you were
kind enough to give it a try and tell me if it now works OK for you.

> Thank you very, very much for your help. I have been thinking to RMA
> my board but now I will wait to see your results.

You're welcome.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
