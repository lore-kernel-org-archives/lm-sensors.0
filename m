From: Philip Edelbrock <phil_edelbrock@edgedesign.us>
Date: Sun, 01 Mar 2009 19:45:25 +0000
Subject: Re: [lm-sensors] lm-sensors 3.1.0 has been released!
Message-Id: <8FA75D21-9722-4C28-8827-332B971D803A@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090301112800.64a026cb@hyperion.delvare>
In-Reply-To: <20090301112800.64a026cb@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


On Mar 1, 2009, at 5:10 AM, Jean Delvare wrote:

> On Sun, 1 Mar 2009 11:28:00 +0100, Jean Delvare wrote:
>> Hi all,
>>
>> Yesterday evening I released lm-sensors 3.1.0 as planned. The  
>> numbering
>> reflects the presence of significant changes in this release:
>>
>> * Completely reworked sensors-detect. Support for Linux 2.4 was
>>  dropped, devices probe order was reverted (integrated sensors first,
>>  I2C/SMBus chips last), bus driver names are retrieved from sysfs,  
>> bus
>>  number prediction was fixed, modules we loaded ourselves are  
>> unloaded.
>>  The script is significantly smaller, and smarter.
>> * Improvements to libsensors. Circular dependencies in the
>>  configuration file are detected and dealt with, and more  
>> importantly,
>>  support for multiple configuration files was added. This is an  
>> important
>>  step in the direction of automatic lm-sensors configuration. Also  
>> some
>>  performance and memory usage improvements. Support for instantaneous
>>  power sensors and current sensors.
>> * The format of /etc/sysconfig/lm_sensors was changed. The new format
>>  is easier to edit, which will ease integration with external tools.
>>  Use the included script sysconfig-lm_sensors-convert to convert from
>>  the old to the new format.
>> * New default sensors.conf file. Much lighter, with only always- 
>> correct
>>  statements. Big performance boost, and hopefully less confusion for
>>  the user.
>> * And as usual, random fixes to all tools.
>
> Phil, please copy the 2 files to your mirror.


WIll do once I get the mirror server up and running again.  We had  
some power issues a couple days ago and the server failed to boot  
properly.


Phil


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
