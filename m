From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 01 Apr 2010 06:56:31 +0000
Subject: Re: [lm-sensors] [RFC PATCH v3 0/2] Add sensors config tool
Message-Id: <4BB4439F.8090604@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100331200353.GA2002@andre-laptop>
In-Reply-To: <20100331200353.GA2002@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andre,

On 03/31/2010 10:03 PM, Andre Prendel wrote:
> Hi Hans,
>
> At last here is a new version of the sensors config tool.
>

First of all many thanks for your continued work on this, it
is looking very good, so hopefully we will be able to soon
ship an lm_sensors with working auto-configuration of
(known) motherboards.

> Now we have a shell script doing the auto installation stuff. See
> install.sh patch 2/2. Further I removed this part of the python
> script.
>

The shell script looks good, nice and simple, great!

> As discussed, the config files from lm-sensors.org are fetched to
> vendor specific directories and links are made in the root config
> directory.

Great!

>
> This looks like this:
>
> drwxr-xr-x 2 andre andre 4096 2010-03-31 21:01 Abit
> lrwxrwxrwx 1 andre andre   16 2010-03-31 21:01 Abit_AA8-DuraMAX ->Abit/AA8-DuraMAX
> lrwxrwxrwx 1 andre andre   12 2010-03-31 21:01 Abit_AI7_1.0 ->Abit/AI7-1.0
> lrwxrwxrwx 1 andre andre    8 2010-03-31 21:01 Abit_AN7 ->  Abit/AN7
> drwxr-xr-x 2 andre andre 4096 2010-03-31 21:01 ASRock
> lrwxrwxrwx 1 andre andre   17 2010-03-31 21:01 ASRock_M2NF3-VSTA ->ASRock/M2NF3-VSTA
> drwxr-xr-x 2 andre andre 4096 2010-03-31 21:01 Fujitsu
> lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D23122A ->Fujitsu/D2312A1
> lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312A1 ->Fujitsu/D2312A1
> lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312C1 ->Fujitsu/D2312A1
> lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312C2 ->Fujitsu/D2312A1
> lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2312D2_2.0 ->Fujitsu/D2312A1
> lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2314A1 ->Fujitsu/D2314A1
> lrwxrwxrwx 1 andre andre   15 2010-03-31 21:01 Fujitsu_D2314A2 ->Fujitsu/D2314A1
>

Also looks good :)

> The fetching tool parses headers like:
>
> # board_vendor: Fujitsu
> # board_name: D2312A1
> # board_version: 1.0
>
> Board version is optional. The block can appear mutliple times.
>
> # board_vendor: Fujitsu
> # board_name: D2312A1
>
> # board_vendor: Fujitsu
> # board_name: D23122A
>
> # board_vendor: Fujitsu
> # board_name: D2312C1
>
> # board_vendor: Fujitsu
> # board_name: D2312C2
>
> The same rules apply to the product headers.
>
> # sys_vendor: Fujitsu
> # product_name: D2312D2
> # product_version: 2.0
>
> Next task is the module auto loading stuff but first, what about this
> here?
>

I think this all looks very good! I think the module auto loading
is the only remaining item to do before this could actually become
production ready (although we will want Jean's input on this too).

The module autoloading requires 2 questions to be answered:

1) How do we store which modules are needed into the configuration
    files on the wiki

2) How / where / what will these modules get loaded ? Currently we
    have lines like these in /etc/sysconfig/lm_sensors:

# The format of this file is a shell script that simply defines variables:
# HWMON_MODULES for hardware monitoring driver modules, and optionally
# BUS_MODULES for any required bus driver module (for example for I2C or SPI).

HWMON_MODULES="it87"

# For compatibility reasons, modules are also listed individually as variables
#    MODULE_0, MODULE_1, MODULE_2, etc.
# You should use BUS_MODULES and HWMON_MODULES instead if possible.

MODULE_0=it87


We could add new "keys" to this file, say:
AUTOMOBO_HWMON_MODULES
AUTOMOBO_BUS_MODULES

And modify the lm_sensors initscript to recognize these too, or thinking more
about this, as we need the script which does the copying of the config file
to /etc/sensors.d/automobo.conf, to extract the modules for us anyways (to
insert them into /etc/sysconfig/lm_sensors for example). We might just as
well make that script load the modules directly.

This also solves a problem with the HWMON_MODULES="it87" syntax, namely
that it does not allow specifying module parameters.

Jean, could we have your input on this ?

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
