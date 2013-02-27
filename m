From: "SP2148421 (at) web.de" <sp2148421@web.de>
Date: Wed, 27 Feb 2013 17:41:15 +0000
Subject: Re: [lm-sensors] problem: thresholds change to zero after some time
Message-Id: <512E453B.5010305@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130226140206.0f9b276b@endymion.delvare>
In-Reply-To: <20130226140206.0f9b276b@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


...
You're welcome. But please keep the list included in the discussion.
...

Sorry,
I pressed the reply to button on my client and didn't saw that only your 
address was listet...

> The above configuration file only sets limit for 3VCC, +5V and +12V, 
> so obviously "sensors -s" can't restore any other limit. If you want 
> to be able to restore all limits then they must all be expressed in 
> the configuration file. 
This will be a workaround for the moment...

> Hmm. The chip has banked (or indirectly accessed) registers. The 
> driver remembers the last bank that was used and only actively selects 
> a bank when it is different from the previous one. If something else 
> (e.g. IPMI) is touching the bank selection, this could cause improper 
> values to be read. Or, worse, values to be written to the wrong 
> register. I can only suppose that this is what happened there. In your 
> case, we can see an alarm was raised by 3VSB max being 0, so it's not 
> a read error, the limit has really been set to 0. 

> We could make the driver assume less and always set the bank before 
> every register read or write, however this won't help if the other 
> side (IPMI) does not. And even then, this would still leave small 
> windows for collisions. Really, the only safe approach is it either 
> use lm-sensors or IPMI but not both. 
I think it will be a god idea to change the driver to do so. This may be 
make the window much closer for collisions.
I never set values via IPMI by myself explicitly, so the problems may be 
solved after the changes...
>> (...)
>> At the moment I use BMC only for remote console access.
>> Is there a way to integrate ipmi sensors(?) in sensord I haven't much
>> knowledge about ipmi-tools?
>> I want to get syslog-entries and alarmbell  like at sensord.
> Unfortunately not. IPMI sensors are only accessible through
> IPMI-specific tools at the moment, without any integration with
> libsensors.
So understand this as feature-request... ;-)
I think support of IMPI sensor reading will expand the usability of the 
libsensors / sensord - explicitly on server-systems.




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
