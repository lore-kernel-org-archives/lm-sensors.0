From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: fan2 readout on Chaintech MB
Message-Id: <20030930194010.41bb5d3f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308310230.14115.ljubo108@vip.hr>
In-Reply-To: <200308310230.14115.ljubo108@vip.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Sorry that it took me so long to reply but I just received temporary 
> replacment for my board.
> Unfortunately it is not the same and it seems that it hasn't got lm90,
> this time I've got Soltek NForce2 motherboard. It has W83627HF
> hardware monitor. Readings are OK, but when I put set fan1_div line in
> sensors.conf and run sensors -s same thing happend.
> [root@localhost etc]# sensors -s
> w83627hf-isa-0290: Can't access /proc file for writing;
> Run as root?
> 
> I did not update cvs from time of your last mail, so it is about 2
> weeks old. Maybe I should try to do a test with updated drivers?

No need to update anything, we haven't changed anything serious these
last weeks.

This at least proves that the problem is driver independant, and lies
either in i2c-core, i2c-proc or libsensors.

> I will try with vanilla kernel and see what happends.

Yes, interesting test.

> I almost forgot to answer to your previous question:
> 
> > What's inside that patchset? Anything related to either ACL or
> > GRSEC?
> 
> GRSEC is inside the patchset but it is disabled.
> 
> You can find some more info on kon kolivas patches here:
> 
> http://members.optusnet.com.au/ckolivas/kernel/

I am offline now, will take a look later. What would be interesting to
see is which differences exit between ck1 and ck2 patches, because I
remember that it was working before you updated to ck2.

> I will have to wait and see if my old board will be back, with lm90 or
> maybe I will receive some other mobo. Until then I will see if my
> friend has board with lm90 so that he can do some lm90 testing.  

Thanks a lot for your help.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
