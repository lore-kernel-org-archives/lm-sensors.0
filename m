From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:39 +0000
Subject: emc6d102 support
Message-Id: <20050224230511.02ec5e1d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >-/* IN are scaled 1.000 = 0xc0, mag = 3 */
> >-#define IN_TO_REG(val)		(SENSORS_LIMIT((((val)*0xc0+500)/1000),0,255))
> >-#define INEXT_FROM_REG(val,ext) (((val)*1000 + (ext)*250 + 96)/0xc0)
> >-#define IN_FROM_REG(val)	(INEXT_FROM_REG(val,0))
>
> Doh.  Dead code.  Should have been removed before...  Good catch.

One reason among others to use inline functions instead of macros.

-- 
Jean Delvare
