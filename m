From: Ashish Jangam <ashish.jangam@kpitcummins.com>
Date: Tue, 21 Feb 2012 11:55:48 +0000
Subject: Re: [lm-sensors] [PATCH] HWMON: DA9052/53 hwmon driver v2
Message-Id: <1329824628.30549.187.camel@dhruva>
List-Id: <lm-sensors.vger.kernel.org>
References: <C3AE124F08223B42BC95AEB82F0F6CED2B996CD9@KCHJEXMB01.kpit.com>
In-Reply-To: <C3AE124F08223B42BC95AEB82F0F6CED2B996CD9@KCHJEXMB01.kpit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: guenter.roeck@ericsson.com
Cc: randy.dunlap@oracle.com, linaro-dev@lists.linaro.org, dchen@diasemi.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Tue, 2012-02-21 at 16:48 +0530, Ashish Jangam wrote:
> On Fri, 2012-02-10 at 07:58 -0500, Ashish Jangam wrote:
> > The DA9052 PMIC provides an Analogue to Digital Converter with 10 bits
> > resolution and 10 channels.
> > 
> > +  * Dialog Semiconductors DA9052-BC and DA9053-AA/Bx PMICs
> > +    Prefix: 'da9052'
> > +    Datasheet: Kindly visit www.dialog-semiconductor.com/product_table.php
> > +              and request for the official datasheet.
> > +
> Not really. From practical experience, the datasheet is not available
> except for Dialog Semiconductor customers - not even for me to review
> the driver (and that appears to be independent of my employer's
> relationship with Dialog Semiconductor). I think this should read "not
> publicly available". It is a bit misleading to suggest that it would be
> available if that is not the case.
Agreed.
> 
> > +static const char * const input_names[] = {
> > +       [DA9052_ADC_VDDOUT]     =       "VDDOUT",
> > +       [DA9052_ADC_ICH]        =       "CHARGING CURRENT",
> > +       [DA9052_ADC_TBAT]       =       "BATTERY TEMP",
> > +       [DA9052_ADC_VBAT]       =       "BATTERY VOLTAGE",
> > +       [DA9052_ADC_IN4]        =       "ADC IN4",
> > +       [DA9052_ADC_IN5]        =       "ADC IN5",
> > +       [DA9052_ADC_IN6]        =       "ADC IN6",
> > +       [DA9052_ADC_TJUNC]      =       "BATTERY JUNCTION TEMP",
> > +       [DA9052_ADC_VBBAT]      =       "BACK-UP BATTERY VOLTAGE",
> > +};
> > +
> Where are those defines, or, in other words, which repository/branch is
> your patch based on ? I don't see it in the current mainline kernel.
The incremental ADC patch to the da9052 mfd core takes care of all such
issues. However that patch is still under review...hoping to get it thru
soon.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
