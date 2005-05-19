From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: i2cdetect -l is broken
Message-Id: <20040211213013.19dccfee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

i2cdetect -l is broken on drivers which handle more than a single i2c
bus (radeonfb in my case). It'll print the same name for all busses, and
shouldn't.

I took a look at the sysfs tree and I couldn't find any way to correct
it. The fact that i2c-adapters and i2c-devs don't use the same numbering
policy doesn't give us much chance.

As far as I can tell, i2c-adapters numbering policy is to use N+1 for a
new adapter, where N is the biggest number already use at the moment,
while i2c-devs numbering policy is to use the lowest available.

Why don't we just chose one common policy for both? I have no strong
preference, both policies are OK, but having two names for the same
thing at a given moment is a real pain. Not being able to deduce the
correct i2cdetect or i2cdump command from the output of sensors will
make helping users way harder, I fear.

OK, I guess that I have been missing something. If it was that easy,
wouldn't it have already been fixed?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
