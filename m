From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 07 Aug 2006 07:09:05 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <44D6E711.8000109@sipsolutions.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Michael Hanselmann wrote:
> +	depends on HWMON && PPC_PMAC && !PPC64 && INPUT && ((ADB_PMU && I2C = y) || (ADB_PMU && !I2C) || I2C) && EXPERIMENTAL
>   
Maybe we should just add "select I2C" instead. Then, if the user had I2C 
as a module and wants AMS he'll get I2C built-in. I think/hope :)

johannes

