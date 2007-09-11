From: "Jean Delvare" <khali@linux-fr.org>
Date: Tue, 11 Sep 2007 13:59:31 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of IBM power meter driver
Message-Id: <QsqPsE00.1189519171.8421320.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20070911132335.GJ31992@jupiter.solarsys.private>
References: <20070828232504.GP32667@tree.beaverton.ibm.com>
In-Reply-To: <20070828232504.GP32667@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mhoffman@lightlink.com, djwong@us.ibm.com
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, haveblue@us.ibm.com


On 9/11/2007, "Mark M. Hoffman" <mhoffman@lightlink.com> wrote:
>* Darrick J. Wong <djwong@us.ibm.com> [2007-08-28 16:25:05 -0700]:
>> --- a/drivers/hwmon/Kconfig
>> +++ b/drivers/hwmon/Kconfig
>> @@ -275,6 +275,18 @@ config SENSORS_CORETEMP
>>  	  sensor inside your CPU. Supported all are all known variants
>>  	  of Intel Core family.
>>
>> +config SENSORS_IBMPEX
>> +	tristate "IBM PowerExecutive temperature/power sensors"
>> +	depends on IPMI_SI
>
> Open question: can we use "select" here?  As written, it took some hunting
> to even get this driver to show up as an option in menuconfig.

My 2 cents: I assume that people who have IPMI-capable hardware are aware
that they do. Thus, if you change the above to "select IPMI_SI", you
probably want to add "depends on IPMI_HANDLER" (not sure why it's not
just named CONFIG_IPMI).

--
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
