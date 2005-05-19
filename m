From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <20030622123649.F0FC.MORRIS@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the delay, I got busy with some other work...

Ok they are different I attach both files... but here are the juicy bits...

With UTF on..
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290...
ite_isa_detect called with chip = 0 and addr = 656
val = 144
val = 88
calling outb with addr = 661 and val = 167
In the if block
Failed!

With UTF off...
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290...
ite_isa_detect called with chip = 0 and addr = 656
val = 255
val = 79
calling outb with addr = 661 and val = 176
after return #1
after return #2
Success!
    (confidence 8, driver `it87')

On Thu, 12 Jun 2003 13:33:03 +0200
Jean Delvare <khali@linux-fr.org> wrote:

khali> (quoting myself)
khali> 
khali> > OK, the next step will be to prepare a specially modified
khali> > sensors-detect script with a lot of debugging info for your particular
khali> > chipset. Then, I'll ask you to run it both with and without the UTF8
khali> > locale, and we'll see where the hell the bug is lurking.
khali> 
khali> Get it there:
khali> http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k1
khali> 
khali> Jim, please try with both non-UTF and UTF locales, and see if the
khali> outputs differ.
khali> 
khali> PS: Yes, I know, I used the barbarian way of debugging. But I'm quite
khali> confident it will work ;)
khali> 
khali> -- 
khali> Jean Delvare
khali> http://www.ensicaen.ismra.fr/~delvare/
khali> 

--
Jim Morris morris@wolfman.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: try2.utf
Type: application/octet-stream
Size: 4644 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030622/488d9d10/try2.obj
-------------- next part --------------
A non-text attachment was scrubbed...
Name: try1.nonutf
Type: application/octet-stream
Size: 4817 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030622/488d9d10/try1.obj
