From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 14 Apr 2010 07:27:05 +0000
Subject: Re: [lm-sensors] [RFC PATCH v3 0/2] Add sensors config tool
Message-Id: <4BC56E49.9040709@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100331200353.GA2002@andre-laptop>
In-Reply-To: <20100331200353.GA2002@andre-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Andre,

On 04/13/2010 09:32 PM, Andre Prendel wrote:
> On Mon, Apr 12, 2010 at 09:25:16AM +0200, Hans de Goede wrote:
>> Hi,
>
> Hello Hans,
>
>> Sounds fine (and the proposed code looks good), but IMHO it would be bet=
ter to have
>> a module statement rather then a module*s*, which specifies
>> a single module, and then allow having this statement multiple times.
>>
>> This way we can (optionally) add module parameters. Unfortunately in some
>> rare cases this is necessary see, for example:
>> http://www.lm-sensors.org/wiki/Configurations/Abit/AN7
>
> I've revised the install.sh script a bit (see patch below). Now we can
> have the module statement multiple times along with parameters.
>

Looks good!

Can you please repost the latest version of the entire set? Then I'll give =
it a
more thorough review (and run some tests). And then if Jean also acks it we=
 can
commit it to svn :)

Regards,

Hans


> Regards,
> Andre
>
> ---
> Index: sensors/prog/detect/install.sh
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D> --- /dev/null	1970-01-01 00:00:00.000000000 +0=
000
> +++ sensors/prog/detect/install.sh	2010-04-13 20:59:26.931071291 +0200
> @@ -0,0 +1,59 @@
> +#!/bin/bash
> +
> +SYSFS_PATH=3D/sys/class/dmi/id
> +CONF_PATH=3D/var/lib/sensors/conf
> +INSTALL_FILE=3D/etc/sensors.d/automobo.conf
> +
> +BOARD_VENDOR=3D`cat $SYSFS_PATH/board_vendor`
> +BOARD_NAME=3D`cat $SYSFS_PATH/board_name`
> +BOARD_VERSION=3D`cat $SYSFS_PATH/board_version`
> +SYS_VENDOR=3D`cat $SYSFS_PATH/sys_vendor`
> +PRODUCT_NAME=3D`cat $SYSFS_PATH/product_name`
> +PRODUCT_VERSION=3D`cat $SYSFS_PATH/product_version`
> +
> +# only for testing
> +#BOARD_VENDOR=3DFujitsu
> +#BOARD_NAME=D2312C1
> +#BOARD_VERSION=3D1.0
> +#SYS_VENDOR=3DFujitsu
> +#PRODUCT_NAME=D2312D2
> +#PRODUCT_VERSION=3D2.0
> +
> +SEARCH_BOARD_VERSION=3D$CONF_PATH"/"$BOARD_VENDOR"_"$BOARD_NAME"_"$BOARD=
_VERSION
> +SEARCH_BOARD=3D$CONF_PATH"/"$BOARD_VENDOR"_"$BOARD_NAME
> +SEARCH_SYS_VERSION=3D$CONF_PATH"/"$SYS_VENDOR"_"$PRODUCT_NAME"_"$PRODUCT=
_VERSION
> +SEARCH_SYS=3D$CONF_PATH"/"$SYS_VENDOR"_"$PRODUCT_NAME
> +
> +load_drivers()
> +{
> +    while read a b c; do
> +	if [ "$a" =3D "#" ]; then
> +	    if [ "$b" =3D "module:" ]; then
> +		driver=3D`echo $c | tr -d '\r'`
> +		echo "Loading driver: $driver"
> +		modprobe $driver
> +	    fi
> +	fi
> +    done<  $INSTALL_FILE
> +}
> +
> +search_config()
> +{
> +    echo "Looking for config: $1"
> +    if [ -h "$1" ]; then
> +	echo "Found suitable config"
> +	cp -f $1 $INSTALL_FILE
> +	load_drivers
> +	exit 0
> +    fi
> +}
> +
> +for search in "$SEARCH_BOARD_VERSION" "$SEARCH_BOARD" "$SEARCH_SYS_VERSI=
ON" "$SEARCH_SYS"
> +do
> +    search_config "$search"
> +done
> +
> +echo "Could not find a suitable config"
> +rm -f $INSTALL_FILE
> +
> +exit 1

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
