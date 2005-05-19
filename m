From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:42 +0000
Subject: lm_sensor on a Netvista
Message-Id: <20021125111906.3c497414.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <MEEOLGLAMCNGBPBBBFHOCEGOCDAA.guillaume@apostoly.com>
In-Reply-To: <MEEOLGLAMCNGBPBBBFHOCEGOCDAA.guillaume@apostoly.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> First thanks for your answer, I imagine, indeed, the way to force
> install lm_sensors on my system (just remove the check !) but, i'm not
> so keen about that. As you saw, I wrote to someone at gentoo who may
> help, but i'm not sure he will...
> If i've got any information or idea on how to test for the presence of
> the EEPROM i'll let you know.

In the meantime, one thing we can add to sensors-detect is a white list.
When someone reports that a given IBM model is surviving sensors-detect
and that sensors can actually be used on it with some benefit, we add
the model to the white list and don't complain about IBM systems that
are present in this white list. That's of course the wrong way to do it,
since it'll require to be maintained continuously. That's the best we
can do for now anyway.

Would you accept to do some tests on your Netvista? If I can know the
BIOS data in details, I could setup a more accurate identification
method.

What I would actually need is the output file of the following command
(as root):
dd if=/dev/mem of=/tmp/mem-netvista bsdk skip count=3

It makes an "image" of your BIOS and I can then test various
identification methods on it.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
