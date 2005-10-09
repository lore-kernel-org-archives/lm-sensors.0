From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sun, 09 Oct 2005 01:53:08 +0000
Subject: [lm-sensors] problem with ASUS P4S800
Message-Id: <emmgk15rsl6gl4g4sg90dmarkdkm7b70r9@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051008225453.GB11732@mathematik.uni-stuttgart.de>
In-Reply-To: <20051008225453.GB11732@mathematik.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 9 Oct 2005 00:54:53 +0200, "Heiko Schulz" <heiko@mathematik.uni-stuttgart.de> wrote:

>Hello,
>
>recently I upgraded a machine with ASUS P4S800 board to kernel 2.6.12
>(from kernel 2.4.27). Before the upgrade lm-sensors detected and used
>the w83781d driver and works perfectly. After the upgrade
>lm-sensors-sensors suggested the w83627hf driver, but it does not work
>(No sensors found!). I also tried w83781d, but it didn't help. I am
>using the debian package 2.9.2-3 and a vanilla kernel from kernel.org.
>Who can help me?

Hi Heiko,

Could you try latest stable kernel (2.6.13.3) and lm_sensors 2.92 from 
  http://lm-sensors.org/archive/lm_sensors-2.9.2.tar.gz

Report here what sensors-detect says and somebody may see what the 
problem is.

Cheers,
Grant.

