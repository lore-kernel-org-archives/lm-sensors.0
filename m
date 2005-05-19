From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: Request for help with i2c and lm_sensors CVS
Message-Id: <20030322142106.7ce8bfa5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200303210243.41955.koshka@ihug.com.au>
In-Reply-To: <200303210243.41955.koshka@ihug.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I am having problems getting lm_sensors and the i2c CVS to work with
> my motherboard.
> 
> I have a DFI CS35-TL Motherboard, which is using a 82801BA chip for
> bus (control?) and a W83627HF for sensors. (These are the numbers on
> the ICs on the M/B)
> 
> I d/l'ed the source for Kernel 2.4.20, and succesfully compiled and
> booted my  system with it. I grabbed the CVS for the 2.4 kernel series
> for both i2c and lm-sensors and they compile without problems. (Thanks
> for the warning about dual versions of modules during 'make install'.)
> 
> On booting I see a [insmod?] error with xxx_voodoo.o, but can't seem
> to track this down in any of the log-files from /var/log/, but as I
> don't have this chip on the M/B I'm not too sure it's relevant to this
> problem.
>  
> I have tried to gather as much information as I can from the various
> utilities in prog/detect/ as well as using 'lsmod', 'lspci' and
> 'dmesg'. I have attached these in the archive 'logs.tgz'. The contents
> are: dmesg.txt
> dmidecode.txt
> i2cdetect.txt
> isadump.txt
> lsmod.txt
> lspci.txt
> sensors-detect output.txt
> 
> I'm not too certain what else I can do... can you suggest any ways
> that I can either get things working, or assist you in tracking my
> problem down further?

I took a look at the files and I cannot conclude. It seems that the bus
drivers (i810 and/or i801) won't load but I can't tell why.

Just one question: Why do you need CVS? I'd like you to try with 2.6.5
or 2.7.0 and see what happens. CVS is known to be rather unstable these
days.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
