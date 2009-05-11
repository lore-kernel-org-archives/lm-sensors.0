From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 11 May 2009 19:37:33 +0000
Subject: Re: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.30
Message-Id: <20090511193733.GA7967@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090508205916.4478b06c@hyperion.delvare>
In-Reply-To: <20090508205916.4478b06c@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Fri, May 08, 2009 at 08:59:16PM +0200, Jean Delvare wrote:
> Hi Linus,
> 
> Please pull some hwmon subsystem fixes for Linux 2.6.30 from:
> 
> git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus
> 
>  drivers/hwmon/asus_atk0110.c |    2 ++
>  drivers/hwmon/w83781d.c      |    3 ++-
>  2 files changed, 4 insertions(+), 1 deletions(-)
> 
> ---------------
> 
> Jean Delvare (1):
>       hwmon: (w83781d) Fix W83782D support (NULL pointer dereference)
> 
> Luca Tettamanti (1):
>       hwmon: (asus_atk0110) Fix compiler warning

Hi Jean,

Hmm... is the "Support HC10 in ibmaem driver" patch queued for 2.6.31?  As I
recall you put it in your tree some time ago, but I haven't heard or seen it
since then. :)

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
