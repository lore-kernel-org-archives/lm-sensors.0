From: Chris Moore <moore@free.fr>
Date: Mon, 18 Oct 2010 18:00:27 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <4CBC8B3B.8090201@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
In-Reply-To: <20101018160830.GB9033@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

  Hi,

Le 18/10/2010 18:08, Guenter Roeck a =E9crit :
> On Sun, Oct 17, 2010 at 11:50:11AM -0400, Simon Guinot wrote:
>
>> +static void __set_fan_ctrl(struct gpio_fan_data *fan_data, int ctrl_val)
>> +{
>> +       int i;
>> +
>> +       for (i =3D 0; i<  fan_data->num_ctrl; i++) {
>> +               int value =3D !!(ctrl_val&  (1<<  i));
>> +
> 	value =3D (ctrl_val&  (1>>  i));
>      would be much simpler and easier to understand.

IMHO you mean:

	value =3D (ctrl_val>>  i)&  1;


Cheers,
Chris

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
