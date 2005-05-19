From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:52 +0000
Subject: lm80 default configuration
Message-Id: <20040412223144.0afa3044.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Any reason why the default lm80 configuration makes in5 and in6
dependant on in0?

     compute in5 (160/35.7)*(@ - in0) + @, (@ + in0 * 160/35.7)/ (1 + 160/35.7)
     compute in6 (36/16.2)*(@ - in0) + @,  (@ + in0 * 36/16.2) / (1 + 36/16.2)

I guess that the idea is that negative voltages depend on a reference
voltage, which would be the same value as in0? In this case, all other
chips that use a reference voltage for negative values should do the
same, but don't.

At any rate, shouldn't only the register -> real value conversion do
that? The other way is used to set limits, and the limits shouldn't
depend on measured values.

Thanks.

NB: Try "compute in0    @ + in0, @ - in0" for some fun (doesn't last
long though).

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
