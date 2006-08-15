From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Tue, 15 Aug 2006 12:11:50 +0000
Subject: [lm-sensors] [PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060815121150.GE2666@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060815120610.GC2666@jupiter.solarsys.private>
In-Reply-To: <20060815120610.GC2666@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Mark M. Hoffman <mhoffman at lightlink.com> [2006-08-15 08:06:10 -0400]:
> This patch fixes up some hwmon drivers so that they no longer ignore
> return status from device_create_file().

BTW: only change from previous RFCs are to address Jean's comments and
to add 'const' to the struct attribute_group variables.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com


