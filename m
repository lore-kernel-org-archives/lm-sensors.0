From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Wed, 23 Aug 2006 11:18:45 +0000
Subject: [lm-sensors] Flex Scanner Jammed Problem
Message-Id: <20060823111845.GA31704@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <1064332995.5787.33.camel@nils>
In-Reply-To: <1064332995.5787.33.camel@nils>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Calabro, Anthony <anthony.calabro at lmco.com> [2006-08-22 16:19:55 -0400]:
> I guess Im going to try to start over with this thread.  I have solved
> the Flex Scanner Jammed problem by going back to sensors version 2.9.0.
> When using 2.10.0 the best I could do is get label lines to parse
> correctly, but I never had any luck with the compute lines.  I also

Did you install 2.9.0 from source?  Looking back at the archives, you
actually started with 2.8.7 - it probably came with the distro.

If you were able to install 2.9.0 from source, but not 2.10.0... well
that is very strange.  The scanner didn't change between those versions.

Anyway, if you're still interested in trying to debug the scanner error:
please add the flag '-d' to the last line of the Makefile.  It should
look like this:

 	$(FLEX) -Psensors_yy -t -d $< > $@

Then 'make clean' && 'make' && 'make install'.  That flag will cause the
scanner to make a lot of noise about what it's doing.  Send some results
back to this list and I'll have a look.

> upgraded my linux kernel from 2.6.9-34 to 2.6.9-42.  In this new version
> there is an i2c sensors update.  We are running the newest version of
> RedHat Enterprise with AS 4.  Is there any support for the Winbond
> 83627HG chip, or the nVidia nForce Pro 2200 (CK804)???  
> 
> Right now I have sensors up and running using the Winbond 83627HF
> driver, and this is giving me incorrect readings.
> 
> 
> Are these chips or busses supported right now?  

The Winbond (sensor) chip is supported including access by ISA bus...
so you don't need any other bus driver to get that working.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


