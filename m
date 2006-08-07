From: johannes@sipsolutions.net (Johannes Berg)
Date: Mon, 07 Aug 2006 08:06:38 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <44D6F48E.9040807@sipsolutions.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> No, please. I2C is something which you should depend on, not something
> you select.
>   

Why? It's infrastructure basically. Anyway. Is it possible to have 
something like
  depends I2C=AMS || I2C=y

If we stuck that into the i2c AMS version that'd help. Though be really 
ugly for the user since she might get the AMS I2C version only after 
selecting AMS as a module then. Pretty icky, all that.

johannes

