From: Hans de Goede <hdegoede@redhat.com>
Date: Mon, 12 Apr 2010 07:25:16 +0000
Subject: Re: [lm-sensors] [RFC PATCH v3 0/2] Add sensors config tool
Message-Id: <4BC2CADC.3020105@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100331200353.GA2002@andre-laptop>
In-Reply-To: <20100331200353.GA2002@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

On 04/10/2010 11:49 PM, Andre Prendel wrote:
> On Thu, Apr 01, 2010 at 08:56:31AM +0200, Hans de Goede wrote:
>> Hi Andre,
>>
>> On 03/31/2010 10:03 PM, Andre Prendel wrote:
>>> Hi Hans,
>>>
>>> At last here is a new version of the sensors config tool.
>>>
>>>
>>> Next task is the module auto loading stuff but first, what about this
>>> here?
>>>
>>
>> I think this all looks very good! I think the module auto loading
>> is the only remaining item to do before this could actually become
>> production ready (although we will want Jean's input on this too).
>>
>> The module autoloading requires 2 questions to be answered:
>>
>> 1) How do we store which modules are needed into the configuration
>>     files on the wiki
>>
>> 2) How / where / what will these modules get loaded ? Currently we
>>     have lines like these in /etc/sysconfig/lm_sensors:
>>
>> # The format of this file is a shell script that simply defines variables:
>> # HWMON_MODULES for hardware monitoring driver modules, and optionally
>> # BUS_MODULES for any required bus driver module (for example for I2C or SPI).
>>
>> HWMON_MODULES="it87"
>>
>> # For compatibility reasons, modules are also listed individually as variables
>> #    MODULE_0, MODULE_1, MODULE_2, etc.
>> # You should use BUS_MODULES and HWMON_MODULES instead if possible.
>>
>> MODULE_0=it87
>>
>>
>> We could add new "keys" to this file, say:
>> AUTOMOBO_HWMON_MODULES
>> AUTOMOBO_BUS_MODULES
>>
>> And modify the lm_sensors initscript to recognize these too, or thinking more
>> about this, as we need the script which does the copying of the config file
>> to /etc/sensors.d/automobo.conf, to extract the modules for us anyways (to
>> insert them into /etc/sysconfig/lm_sensors for example). We might just as
>> well make that script load the modules directly.
>>
>> This also solves a problem with the HWMON_MODULES="it87" syntax, namely
>> that it does not allow specifying module parameters.
>>
>> Jean, could we have your input on this ?
>
> No reply from Jean so far. So I'd like to make a proposal.
>
> I'd suggest using the install.sh script (which installs the
> automobo.conf) to load the driver. The config file gets a "modules" tag
> specifying the module name. E.g.
>
>    # board_name: foo
>    # board_vendor: bar
>
>    # modules: tmp421
>
> Sed gives us the module name and modprobe loads the module. I've
> extended the install.sh script to do this. See the patch below
> (load_driver function).
>
> What do you think about this approach?
>

Sounds fine (and the proposed code looks good), but IMHO it would be better to have
a module statement rather then a module*s*, which specifies
a single module, and then allow having this statement multiple times.

This way we can (optionally) add module parameters. Unfortunately in some
rare cases this is necessary see, for example:
http://www.lm-sensors.org/wiki/Configurations/Abit/AN7

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
