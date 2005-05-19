From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030626155249.84B8.MORRIS@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ok here are the two results snipped for ITE detection....

On Wed, 25 Jun 2003 14:45:38 +0200
Jean Delvare <khali@linux-fr.org> wrote:

khali> 
khali> > Sorry for the delay, I got busy with some other work...
khali> 
khali> Same here as you can see.
khali> 
khali> > Ok they are different I attach both files... but here are the juicy
khali> > bits...
khali> > 
khali> > With UTF on..
khali> > Probing for `ITE IT8705F / IT8712F / SiS 950'
khali> >   Trying address 0x0290...
khali> > ite_isa_detect called with chip = 0 and addr = 656
khali> > val = 144
khali> > val = 88
khali> > calling outb with addr = 661 and val = 167
khali> > In the if block
khali> > Failed!
khali> > 
khali> > With UTF off...
khali> > Probing for `ITE IT8705F / IT8712F / SiS 950'
khali> >   Trying address 0x0290...
khali> > ite_isa_detect called with chip = 0 and addr = 656
khali> > val = 255
khali> > val = 79
khali> > calling outb with addr = 661 and val = 176
khali> > after return #1
khali> > after return #2
khali> > Success!
khali> >     (confidence 8, driver `it87')
khali> 
khali> All right. I think that everyone will now agree that the problem is
khali> *not* in outb but in *inb*.
khali> 
khali> Time to try another set of prints. Please grab the new sensors-detect
khali> at:
khali>   http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k2
khali> and give it a try. As usual, all the interest is to compare the output
khali> between a UTF and a non-UTF locale.
khali> 
khali> It will probably generate more noise than the previous one did. I expect
khali> to see that on your system, ord($X) and unpack("C", $X) give different
khali> results (while I think both functions should return the same value in
khali> all cases, on all systems).
khali> 
khali> -- 
khali> Jean Delvare
khali> http://www.ensicaen.ismra.fr/~delvare/
khali> 

--
Jim Morris morris@wolfman.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: probe2.utf
Type: application/octet-stream
Size: 1241 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030626/546eee79/probe2.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: probe2.noutf
Type: application/octet-stream
Size: 967 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030626/546eee79/probe2-0001.obj
