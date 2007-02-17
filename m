From: minyard@acm.org (Corey Minyard)
Date: Sat, 17 Feb 2007 23:22:21 +0000
Subject: [lm-sensors] IPMI sysfs support for 2.6.16.x
Message-Id: <45D78E2D.7030403@acm.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1171733778.45d73d12edf0a@mail.third-rock.net>
In-Reply-To: <1171733778.45d73d12edf0a@mail.third-rock.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Paul Reilly wrote:
> Hello,
> I am trying to get IPMI Sensors working on kernel 2.6.16.33.
> I have a PenguinComputing Altus Server with inbuilt BMC, and lm-sensors
> suggests I need bmcsensors. Googling I followed the instructions here:
> http://bmcsensors-26.sourceforge.net/
>
> It appears I need to do 2 things:
>
> (A) patch my kernel for ipmi sysfs support
> (B) patch my kernel again with the IPMI sensors patch
>
> I would love to just use 2.6.17 and skip (A), but I am required to
> use 2.6.16.33 kernel only. So:
>
> Doing (A) works so far. The patchfile contains patches for 8 files, and
> worked for all except the file "ipmi_si_intf.c" which failed on several chunks:
>
> patching file drivers/char/ipmi/ipmi_si_intf.c
> Hunk #1 succeeded at 110 with fuzz 2 (offset -2 lines).
> Hunk #2 succeeded at 196 (offset -5 lines).
> Hunk #3 FAILED at 984.
> Hunk #4 succeeded at 1183 with fuzz 2 (offset 19 lines).
> Hunk #5 succeeded at 1331 with fuzz 2 (offset 59 lines).
> Hunk #6 FAILED at 1915.
> Hunk #7 succeeded at 1929 with fuzz 1 (offset 31 lines).
> Hunk #8 succeeded at 1972 (offset 31 lines).
> Hunk #9 succeeded at 1985 (offset 31 lines).
> Hunk #10 FAILED at 2088.
> Hunk #11 FAILED at 2167.
> Hunk #12 succeeded at 2329 (offset -26 lines).
> Hunk #13 FAILED at 2422.
> Hunk #14 succeeded at 2431 with fuzz 1 (offset -31 lines).
> Hunk #15 succeeded at 2552 with fuzz 1 (offset -36 lines).
> Hunk #16 FAILED at 2574.
> 6 out of 16 hunks FAILED -- saving rejects to file
> drivers/char/ipmi/ipmi_si_intf.c.rej
>
> I tried patching manually, but it was beyond me. For example chunk 3
> refers to static LIST_HEAD(smi_infos);  which is not present in my 2.6.16.33 
> ipmi_si_intf.c
>
> How can I tell which 2.6.16.X  branch these patches are meant for?
> Perhaps they apply on an earlier or later 2.6.16.x series kernel.
>   
They are critical bugfix only releases.  There's not much difference 
between 2.6.16 and 2.6.16.x.
> Can I just copy the whole drivers/char/ipmi/  dir from a 2.6.17 kernel,
> and put it in my 2.6.16.33 ?
>   
That is probably the easiest way to handle this.  There may be one or 
two things that need to be fixed, but not much.

-corey

