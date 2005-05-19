From: Bruce.Lee@landesk.com (Lee, Bruce)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: Problems with w83781d module
Message-Id: <2B6C784DD3723745978C27C72801F7F8AC80F9@cba0e2k04.cba0.centerbeam.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2B6C784DD3723745978C27C72801F7F8AC80F8@cba0e2k04.cba0.centerbeam.com>
In-Reply-To: <2B6C784DD3723745978C27C72801F7F8AC80F8@cba0e2k04.cba0.centerbeam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried all of the methods below and still no success.  I have attached
a file containing the results from dmesg.

I appreciate the help.

Thanks
Bruce

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Friday, November 14, 2003 12:42 PM
To: Lee, Bruce
Cc: sensors@stimpy.netroedge.com
Subject: Re: Problems with w83781d module



> I am trying to monitor sensors on a gateway 980 with a Winbond 83791d 
> chip. I sent an earlier message and it was suggested that I download 
> the latest code from CVS.  I did this and still cannot resolve the 
> problems that I am seeing.  I have looked at the motherboard and can 
> see a Winbond 83791d chip.  The chip is detected with sensors-detect 
> and after loading the w83781d module I get no results when running 
> sensors. Looking in /proc/sys/dev/sensors, the chips file is empty and

> there are no sensor directories.

The driver fails to recognize the chip as one of its owns. I took a look
at the chipset's dump and can't understand why this happens.

I fixed a small, probabably unrelated bug in that driver. Please update
your CVS checkout and recompile the driver with DEBUG=1 (edit the
Makefile). Run "make install".

Then, try loading the driver again (don't forget to unload it before
doing so) and watch dmesg for details. See if sensors returns something.

If it doesn't help, unload the driver and reload it using force=0,0x2d.
Look at dmesg again. Check wether sensors returns the information you
are looking for.

If it still doesn't help, unload the driver once again and reload it
using force_w83791d=0x2d. Look at dmesg again. Run sensors again.

> Is it possible that the information from that chip is not available?

The chip is there at 0x2d, doubtlessly.

> Do I need to do a force of the chip and subclients?

You shouldn't, but it might help understanding where the problems
stands.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: dmesg.out
Type: application/octet-stream
Size: 8229 bytes
Desc: dmesg.out
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20031114/6818703f/dmesg.obj
