From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 09 Sep 2005 10:37:18 +0000
Subject: [lm-sensors] Re: ticket 2054 and ticket 2015
Message-Id: <C2H0nmZS.1126254514.3692320.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1EDSxA-0003ek-00@mendel.bio.caltech.edu>
In-Reply-To: <E1EDSxA-0003ek-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi David,

On 2005-09-08, David Mathog wrote:
> There still seems to be no "vid" voltage on the AS99127F under 2.6.11 and
> higher kernels.

Which version of lm_sensors (user-space) are you using? You need at least
2.8.8 for VID readings to work with the w83781d driver from kernels
2.6.9 and newer.

--
Jean Delvare
