From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 14 Feb 2007 19:51:51 +0000
Subject: [lm-sensors] Abit AT8 (non-32X) / Winbond 83627EHF
Message-Id: <20070214205151.1cd5631b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45D0A4B2.6030002@vt.edu>
In-Reply-To: <45D0A4B2.6030002@vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rick,

On Wed, 14 Feb 2007 14:43:09 -0500, Rick Wright wrote:
> Thanks for the support  Hans de Goede responded to me off list 
> suggesting that, in fact, I probably have a abituguru ver3 chip, not a 
> w83627ehf chip afterall.  The problem is that this ver3 abituguru chip 
> is not fully supported by sensors, libsensors, etc.  However, he did 
> point me to a userspace utility he wrote that I was able to use to 
> successfully interrogate my uGuru chip.  All along I knew this board 
> probably used a uGuru setup.  I will forward those messages back to the 
> list under this thread for others' benefit.
> 
> On the other hand, the problem that lm_sensors still has is that it was 
> the sensors-detect script that originally reported that I had a 
> w83627ehf chip and ultimately led me down this path.  Hans suggested 
> this is not a correct identification job and that sensors-detect should 
> be fixed.

Hans is probably wrong. The Super-I/O chip detection is very reliable
and I would ve very surprised if you do not have a Winbond W83627EHF.
As a matter of fact, this hi-res picture of your motherboard:
  http://www.techpowerup.com/reviews/Abit/AT8/images/board_fullsize.jpg
clearly shows a W83627EHF in the top-left-hand corner.

But indeed there's also a uGuru chip on the board. Bad luck.

-- 
Jean Delvare

