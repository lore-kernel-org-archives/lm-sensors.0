From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: I2C crash - ADM1021
Message-Id: <20030919200040.3c64edb1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Now, for the adm1021 problems, I'm puzzled. The option line in
> > /etc/sensors.conf, as suggested by sensors-detect, prevents the
> > driver from using any of the three addresses at which you have
> > chipsets (0x18, 0x4c, 0x4e) so loading it shouldn't have had any
> > effect.

Now that I come to think of it again, one question: did you actually
edit /etc/modules.conf as sensors-detect told you? Having failed to do
so would explain (but not forgive) how adm1021 could cause trouble on
your system.

> The only possible thing I was thinking was that in my
> kernel config file, while no modules are loaded, there is one line
> that is strange.
> 
> CONFIG_I2C_MAINBOARD=y

I never saw that option anywhere. Grep'ing linux 2.4.22 sources for it
did not return anything. Could it be some Mandrake add-on?

> is the only thing checked off.

You mean checked *on*?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
