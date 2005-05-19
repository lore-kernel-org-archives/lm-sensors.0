From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: [PATCH] I2C update for 2.6.8-rc1
Message-Id: <40F5F6C0.1030901@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10898500251206@kroah.com>
In-Reply-To: <10898500251206@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Is this right that we don't want to explicitly initialize the adm1031_id 
counter?

Why is that?
:v)

Greg KH wrote:

>diff -Nru a/drivers/i2c/chips/adm1031.c b/drivers/i2c/chips/adm1031.c
>--- a/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:33 -07:00
>+++ b/drivers/i2c/chips/adm1031.c	2004-07-14 16:59:33 -07:00
>  
>
 >  [snip]

> 
>-static int adm1031_id = 0;
>+static int adm1031_id;
>+
>  
>

-- 
Philip Pokorny, Director of Engineering
Tel: 415-954-2823   Fax: 415-954-2899   Toll Free: 888-PENGUIN
PENGUIN COMPUTING, INC.
www.penguincomputing.com
