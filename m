From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 13 Jan 2009 08:02:33 +0000
Subject: Re: [lm-sensors] Updated initialization script, testers wanted
Message-Id: <496C4A99.2010608@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090112140236.6b74302e@hyperion.delvare>
In-Reply-To: <20090112140236.6b74302e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:
> Hi Hans,
> 
> I have implemented and committed the sensors-detect side of ticket
> #2246. Now the lm_sensors initialization script needs to be updated as
> well, to make use of the new configuration file syntax. The
> initialization script in our repository is meant for Red Hat
> distributions but I don't have any, so I can't test my changes. The
> patch I intend to apply is attached, could you (or anyone with a Red
> Hat distribution) give it a try and confirm that it works OK?
> Beforehand, you'll need to download and run the latest version of
> sensors-detect:
> 
> http://www.lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect
> 
> and let it regenerate /etc/sysconfig/lm_sensors.
> 

Erm,

Not tested, I'm not so happy with this change. I've read the ticker trying to 
find out why we would want this change, and I must say I'm not very convinced 
with the reasoning there.

My problem with these changes is that to me it feels like changing the config 
file format without some very strong reasons, this will cause all kind of pains 
when upgrading from an lm_sensors version with the old format to that with the 
new format. Do we really have to do this?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
