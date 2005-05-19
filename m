From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: Addition to IBM whitelist
Message-Id: <1082027800.407e6f18a1f95@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082027302.6117.9.camel@viper.cam.eu.citrix.com>
In-Reply-To: <1082027302.6117.9.camel@viper.cam.eu.citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please reply to the list, not to me]

> I would like to get my IBM machine added to the whitelist. It is an
> Intellistation M-Pro tower (model 6868-6BG), the BIOS is PLKT44AUK.
> Sensors were working on this machine before the IBM blacklist came
> in and I have verified it using kernel 2.6.5.
> 
> Sensors-detect came back with the following :-
>  
> ---------------------------------------------------------------
> To make the sensors modules behave correctly, add these lines to
> /etc/modules:
>  
> #----cut here----
> # I2C adapter drivers
> i2c-i801
> i2c-isa
> # I2C chip drivers
> adm1025
> eeprom
> smsc47m1
> #----cut here----

OK, will do. Can you confirm that sensors-detect did not find anything
at addresses 0x54-0x57 not 0x5C?

BTW, neither adm1025 nor smsc47m1 have been ported to Linux 2.6 yet. I
may port the adm1025 driver soon (it has been on my TODO list for some
times now) if you agree to test it on your system. I will not port the
smsc47m1 however, but you may want to give it a try yourself (see the
w83627hf driver for an already ported, similar driver, and
Documentation/i2c/porting-clients for guidelines).

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
