From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: dev-interface of i2c-2.8.1
Message-Id: <3FBD8DEC.DAFB9912@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200311201152.59734.lt@ncic.ac.cn>
In-Reply-To: <200311201152.59734.lt@ncic.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the user defines were removed from the kernel i2c-dev.h because
"userspace apps shouldn't include kernel headers".
The user version of i2c-dev.h is in the lm_sensors package
and should contain all the defines removed from the kernel version.


Liu Tao wrote:
> 
> Hello all,
> 
> I have noticed that "i2c_smbus_access" has been
> removed from i2c-dev.h, are there still ways to
> access SMBus through the dev interface?
> 
> --
> Regards,
> Liu Tao
