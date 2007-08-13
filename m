From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Mon, 13 Aug 2007 20:13:27 +0000
Subject: Re: [lm-sensors] FSC Scylla (and Poseidon,
Message-Id: <46C0BB67.5040603@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46AB90E6.4000801@hhs.nl>
In-Reply-To: <46AB90E6.4000801@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 30 Jul 2007 10:20:45 +0200, Hans de Goede wrote:
>> As some of you know I've been working on a unified driver for the Fujitsu
>> Siemens hwmon chip family. Attached is the resulting driver. I would be much
>> obliged if some of you could test this.
> 
> Can you please add detection of the Heimdall chip to sensors-detect?
> 

Done,

I didn't fill in the driver name yet though, naming the merged driver fscscy 
might not be such a good idea, since then lm_sensors-2.10.x expects to find the 
raw dumps of the status registers in tempX_status sysfs entries, and without 
these lm_sensors-2.10.x will not work. So I would rather pick a new driver 
name, as the intend of the new driver is to get rid of cruft like the raw 
status register dumps (and replace it by proper _fault and _alarm files).

So maybe I should name it after the newest member of the family (at this 
moment), fschmd, that name is still free, and does not contain xxx. Then I can 
write fschmd support fot lm_sensors-2.10.5 which will not expect the old files, 
and which will gracefully handle the fact that depending on the chip found the 
number of fans and temps can vary.

Regards,

Hans



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
