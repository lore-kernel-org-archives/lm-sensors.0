From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Ticket #: 786
Message-Id: <3C3BA1A0.1C1A110B@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3C3B8E68.7000403@tyrell.hu>
In-Reply-To: <3C3B8E68.7000403@tyrell.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

look at your board to identify your chip,
also see FAQ #4.21.



Akos Maroy wrote:
> 
> > if you modprobe adm1021 as sensors-detect recommends
> > then ?sensors? should give you some results.
> > If not then send us email and reference your ticket number.
> 
> sometimes sensors-detect detects lm75, sometimes lm78. If lm75, sensors
> reads:
> 
> lm75-i2c-1-4e
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> temp:       +0.0?C  (limit =  +0.0?C, hysteresis =  +0.0?C)
> 
> if lm78, sensors reads 4.0 centigrades.
> 
> Unfortunately there is no useful info returned. OTOH, BIOS displays two
> different temperature values, and two fan rotation speeds.
> 
> Any suggestions?
> 
> Akos
