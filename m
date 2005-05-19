From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:24:16 +0000
Subject: Ticket 1382 : Update
Message-Id: <3F5B6813.7C9D8F69@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
In-Reply-To: <1061487346.2223.4.camel@marla.spinning-plates.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Romain Riviere wrote:
> 
> Hi again,
> 
> 

..


> If you don't mind my bothering you some more ...
> - sensors-detect says:
> Detects correctly:
>   * Bus `SMBus Via Pro adapter at 0400' (Non-I2C SMBus adapter)
>     Busdriver `i2c-viapro', I2C address 0x2d
>     Chip `National Semiconductor LM80' (confidence: 3)
> However, I don't think I've got that chip anywhere on my PC. I wonder
> what chip could be misdetected like that, where to look ?
> 


other chips are often misdetected as LM80's.
Look at your board to see if you can identify.
You can use i2cdump as well.
See bottom of our New Drivers page and our FAQ for more info.
