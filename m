From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: sensors.cfg for w83697hf (Abit KR7A-133 mainboard)
Message-Id: <3CC89579.122447C1@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <E170W7N-0003Fp-00@localhost>
In-Reply-To: <E170W7N-0003Fp-00@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for the info.
There is a section in sensors.conf.eg in release 2.6.3;
perhaps you didn't see it, or don't have 2.6.3, or
didn't do the manual merge (make install won't overwrite)

Aurelien Jarno wrote:
> 
> Hello,
> 
> I have a mainboard with a w83697hf chip (w83781d driver + i2c_isa), but
> there is no data into /etc/sensors.cfg.
> I have done one (see attachement), it works for my mainboard (Abit
> KR7A-133), but it should also work for other mainboards (maybe with minor
> modifications).
> 
> Then, the w83697hf chip is noted as "support is complete but has not
> been well-tested", and I confirm it works well for me.
> 
> Moreover, I would to send you a link in the section "Hardware Monitoring
> Applications using the lm_sensors package" :
> http://ksensors.sourceforge.net
> 
> Aurelien Jarno
> 
> 
>                                 Name: sensors.cfg.abit_kr7a-133
>    sensors.cfg.abit_kr7a-133    Type: Plain Text (text/plain)
>                             Encoding: base64
