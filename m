From: greanie@yahoo.com (Michael Greenish)
Date: Wed, 06 Jul 2005 17:56:35 +0000
Subject: [lm-sensors] Re: asus P5GD2 Premium
Message-Id: <20050706024402.96529.qmail@web60419.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42C6BFB0.7090900@sh.cvut.cz>
In-Reply-To: <42C6BFB0.7090900@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Rudolf,

Thank you very much for your response.  I did not get
around to this tonight but hope to before the end of
the week, if not certainly before the weekend is over.

Thank you again for the reply.  I appreciate your help
very much.

Sincerely,

Mike

--- Rudolf Marek <r.marek@sh.cvut.cz> wrote:

> Michael Greenish wrote:
> > Hello,
> > 
> > I tried several times to submit this ticket but
> did
> > not get a confirmation email and could not find my
> > ticket in any of the lists.  Below, please find my
> > issue.  I have tried to include everything
> requested
> > in the FAQ section 5.1.  Thank you in advance for
> your
> > help.
> >
> 
> Hi
> 
> I will try to help.
> 
> > motherboard: asus P5GD2 Premium
> > chipsets: Intel? 915P, Intel? ICH6R
> > distribution: SuSE 9.2
> > kernel: 2.6.8-24.14-smp
> > processor: Intel P4 3.0 GHz
> > lm-sensors: 2.9.1 (trying to install)
> 
> I think you have there w83792d chip. Please can you
> confirm?
>
http://www.uac.co.jp/news/daily/040622_2/img/p5gd2pro.jpg
> 
> Look to a small chip just on the top of first
> PCI-express slot from a left.
> Manufacturer is Winbond and I think it will be
> w83792d but I cant read it.
> You dont need to do it if we get 2.9.1 working.
> 
> > My overall goal is to get my cpu temperature since
> I
> > am getting over-temperature messages.  
> > 
> > First I did a sensors-detect.
> 
> Good.
> 
> > Client found at address 0x2f
> > Probing for `National Semiconductor LM78'...
> Failed!
> > Probing for `National Semiconductor LM78-J'...
> Failed!
> > Probing for `National Semiconductor LM79'...
> Failed!
> > Probing for `National Semiconductor LM80'...
> Failed!
> > Probing for `Winbond W83781D'... Failed!
> > Probing for `Winbond W83782D'... Failed!
> > Probing for `Winbond W83791D'... Failed!
> > Probing for `Winbond W83627HF'... Failed!
> > Probing for `Asus AS99127F (rev.1)'... Failed!
> > Probing for `Asus AS99127F (rev.2)'... Failed!
> > Probing for `Asus ASB100 Bach'... Failed!
> > Probing for `Analog Devices ADM9240'... Failed!
> > Probing for `Dallas Semiconductor DS1780'...
> Failed!
> > Probing for `National Semiconductor LM81'...
> Failed!
> > Probing for `Analog Devices ADM1029'... Failed!
> > Probing for `ITE IT8705F / IT8712F / SiS 950'...
> > Failed!
> 
> I think this will be w83792d.
> 
> > Client found at address 0x48
> > Probing for `National Semiconductor LM75'...
> Success!
> >     (confidence 6, driver `lm75')
> > Probing for `Dallas Semiconductor DS1621'...
> Failed!
> > Probing for `Maxim MAX6650/MAX6651'... Failed!
> > Probing for `National Semiconductor LM92'...
> Failed!
> > Probing for `National Semiconductor LM76'...
> Failed!
> > Probing for `Maxim MAX6633/MAX6634/MAX6635'...
> Failed!
> > Client found at address 0x49
> > Probing for `National Semiconductor LM75'...
> Success!
> >     (confidence 6, driver `lm75')
> > Probing for `Dallas Semiconductor DS1621'...
> Failed!
> > Probing for `National Semiconductor LM92'...
> Failed!
> > Probing for `National Semiconductor LM76'...
> Failed!
> > Probing for `Maxim MAX6633/MAX6634/MAX6635'...
> Failed!
> 
> And this subclients of the chip...
> 
> > ****** START of make user *******
> > 
> > share:/home/greanie # cd i2c-2.9.1
> > ishare:/home/greanie/i2c-2.9.1 # make user; make
> > user_install
> 
> Hmm you dont need the i2c package when using 2.6.x
> kernels
> You need lm_sensors-2.9.1 package Bad news for you
> is that the driver is not yet in 2.6.x kernel.
> 
> So first to confirm that you have that chip please
> do:
> 
> 1) uninstall all lm-sensors suse packages
> 2) download
>
http://secure.netroedge.com/~lm78/archive/lm_sensors-2.9.1.tar.gz
> 3) unzip
> 4) make user; make user_install (second command as
> root)
> 5) run sensors-detect again
> 
> If you get w83792d detected you dont need to do
> visual check.
> 
> To get the driver working you have two possibilites
> 
> 1) Install 2.4.x kernel and install i2c-2.9.1 and
> lm-sensors-2.9.1 (make ; make install  - this time)
> 2) Patch your 2.6.x kernel source  Driver is here:
>
http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050621/8dfe2e28/patch_w83792d-2.6.12-0001.gz
> 
> I dont know your Linux skills first method should be
> more easy, second one is bit more difficult. Let us
> know when you will run to problems.
> I hope it helps.
> 
> Regards
> 
> Rudolf
> 



		
____________________________________________________
Sell on Yahoo! Auctions ? no fees. Bid on great items.  
http://auctions.yahoo.com/
