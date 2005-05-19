From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: [PATCH 2.6] I2C sysfs interface documentation
Message-Id: <3FB7E77F.3AE376B0@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116203250.4bce6b7e.khali@linux-fr.org>
In-Reply-To: <20031116203250.4bce6b7e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> 
>
> 
> Summary of what the patch does:
> 1* No more current hysteresis value. I don't think we ever saw a chip
>    which monitors current, and if we ever do, I would be very, very
>    surprised if it would have an hysteresis value.


current is in there because the IPMI spec includes current sensors
so I added support to bmcsensors.
Never had a report of a BMC that actually measures current, though...
