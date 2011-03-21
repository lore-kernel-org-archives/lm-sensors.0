From: "Eibach, Dirk" <Eibach@gdsys.de>
Date: Mon, 21 Mar 2011 10:17:42 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ads1015) Make gain and datarate
Message-Id: <48D3D52125C49B43AE880038E2E5314BB5BE82@SRV101.gdsys.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110312081809.GB9347@angua.secretlab.ca>
	<1300269715-15819-1-git-send-email-eibach@gdsys.de>
	<20110318220240.399ade64@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>
Cc: rdunlap-/UHa2rfvQTnk1uMJSBkQmQ@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org

Hi Jean,

> Took me a little longer than I expected to review this, but here we go
> finally:

No problem, I appreciate your careful and detailed reviews very much.

> > +    1: FS = +/- 4.096 V
> > +    2: FS = +/- 2.048 V (default)
> > +    3: FS = +/- 1.024 V
> > +    4: FS = +/- 0.512 V
> > +    5: FS = +/- 0.256 V
> > + - data_rate in samples per second
> > +    0: 128
> > +    1: 250
> > +    2: 490
> > +    3: 920
> > +    4: 1600
> > +    5: 2400
> > +    6: 3300
> 
> These sample rates make me wonder if hwmon is really the 
> right subsystem for this device. hwmon is more like 2 samples 
> per second.

ADS1015 has a beautiful low energy single shot mode which makes it
pretty adorable for hwmon ;)
Sample rate adjustment is only for setting up the sigma delta
parameters.

> The duplicate documentation between 
> Documentation/hwmon/ads1015 and 
> Documentation/devicetree/bindings/hwmon/ads1015.txt is 
> somewhat unpleasant. It will be difficult to keep things in 
> sync over time. I wonder if this could be avoided.

Same here. But no ideas so far.

> >  Example:
> >  struct ads1015_platform_data data = {
> > -	.exported_channels = (1 << 2) | (1 << 4)
> > +	.channel_data = {
> > +		[2] = { .enabled = true, .pga = 1, .data_rate = 0 },
> > +		[4] = { .enabled = true, .pga = 4, .data_rate = 5 },
> > +	}
> >  };
> 
> This looks pretty good, I have to admit :)

Gorgeous ;)

> Does it really make sense to have a default configuration? 
> The chip needs proper configuration to be usable at all, I 
> would think it makes sense to make the platform or devicetree 
> data mandatory. I am particularly worried about the case 
> where the PGA is set improperly: the input voltage could be 
> over what the chip supports?

In fact it does. Default configuration reflects hardware defaults, which
hopefully reflect some default usecase.
The engineer that designed my board actually considered this, so no pga
adjustment is necessary.
Inappropriate PGA settingts can't damage the chip.

> Use of goto and label is discouraged, except for error paths. 

I am not proud of this, but I learned BASIC on a Commodore 116 ;)

Cheers
Dirk
--------------------------------------------------------------------------
Guntermann & Drunck GmbH Systementwicklung 
Dortmunder Str. 4a 
D-57234 Wilnsdorf - Germany 
Tel: +49 (0) 27 39 / 89 01 - 100  Fax: +49 (0) 27 39 / 89 01 - 120 
E-Mail: mailto:sales@gdsys.de Web: www.gdsys.de
--------------------------------------------------------------------------
Geschaeftsfuehrer: 
Udo Guntermann - Martin Drunck - Reiner Ruelmann - Klaus Tocke
HRB 2884, Amtsgericht Siegen - WEEE-Reg.-Nr. DE30763240
USt.-Id.-Nr. DE 126575222 - Steuer-Nr. 342 / 5835 / 1041
--------------------------------------------------------------------------
DQS-zertifiziert nach ISO 9001:2008
--------------------------------------------------------------------------



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
