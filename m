From: linux-kernel@hansmi.ch (Michael Hanselmann)
Date: Wed, 09 Aug 2006 12:17:17 +0000
Subject: [lm-sensors] [PATCH] Apple Motion Sensor driver
Message-Id: <20060809121717.GA1539@hansmi.ch>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060802191520.GA2260@hansmi.ch>
In-Reply-To: <20060802191520.GA2260@hansmi.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Aug 07, 2006 at 10:06:38AM +0200, Johannes Berg wrote:
> Why? It's infrastructure basically. Anyway. Is it possible to have 
> something like
>  depends I2C=AMS || I2C=y

> If we stuck that into the i2c AMS version that'd help. Though be really 
> ugly for the user since she might get the AMS I2C version only after 
> selecting AMS as a module then. Pretty icky, all that.

I'm not really a fan of it. Is there anything wrong with my proposed
patch?

Thanks,
Michael

