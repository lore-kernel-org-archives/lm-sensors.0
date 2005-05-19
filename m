From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: lm_sensors2/kernel/busses i2c-viapro.c
Message-Id: <20030606105450.256818b2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Modified Files:
> 	i2c-viapro.c 
> Log Message:
> (mds) get i2c-viapro working again by backporting from
>       kernel 2.5.69 and adding new sensors_compat.h for the
>       drv_dbg(), etc. calls

Tested, works for me (one machine). I noticed three problems though:

1* Via686a doesn't load (I'm usually not using it but the machine has
one). I guess this is "normal" because this driver hasn't been fixed
yet.

2* I get unresolved symbols (i2c_inc_use_client and i2c_dec_use_client)
in another module now (zoran, used by my DC10+ capture board). It was
working with i2c-2.7.0. I need to get this working again if I want to be
able to watch Roland Garros' semi-finals this afternoon! ;)

3* I2c-elektor and i2c-pcf-epp aren't been installed anymore. As far as
I can see, they are not even being built at all. I don't need them, but
it looks like there's something broken there.

I'm now going to test i2c-CVS and lm_sensors2-CVS on other machines.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
