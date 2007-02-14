From: riwright@vt.edu (Rick Wright)
Date: Wed, 14 Feb 2007 19:26:36 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <45D3626C.600@vt.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Rick Wright wrote:
> Hello list,
> 
> I have the Abit AT8 mobo described in the subject line and I'm trying to 
> get lm_sensors working properly for this board.  I see there is still 
> very recent activity concerning getting this Winbond chip fully 
> supported.  In the latest 2.10.2 release I see Dave Platt added these 
> changes relavent to my board:
> 
> Program sensord:
>                         Add w83627ehf voltage support (Dave Platt)
>                         Add k8temp support (Dave Platt)
> 
> These additions appear to be working properly OOTB as the "sensors" 
> command produces the following output:
> 

You probably do NOT have a w83627ehf, but an Abit uGuru custom sensor 
chip, most likely revision 3 of the abituguru. A couple of weeks ago 
I've posted a patch with a new kernel driver for revision 3 of the uguru 
(the current abituguru driver only supports revision 1 and 2).

If your manual/driver cd says uGuru anywhere then you really do have 
one. I've also written a userspace utility which can read from the uguru 
when run as root try dowloading:
http://people.atrpms.net/~hdegoede/openguru2.3.1.tar.gz

Compile it like this:
gcc -O2 -Wall -o oguru main2.c openGuru.c

And then as root run: ./oguru

Let me know if and how it works for you any feedback is much appreciated.

Regards,

Hans




